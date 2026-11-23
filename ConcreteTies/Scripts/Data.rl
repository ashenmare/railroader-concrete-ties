// Concrete Ties: merges Data/Map.json into the map at load (Data.rl modifyMap), if the map has the Sylva and Whittier
// interchanges and the three nodes the new track joins (else nothing is added, with one warning). The merge adds track at the Scott tie
// plant (a west extension of each of its two tracks and a spare siding) and one industry beside it that makes concrete
// ties. It changes no existing segment or node.
//
// Then one edit, only if the map is exactly as expected: the Scott Tie Plant's two track spans t1 and t2 end at the far end
// of the new extensions instead of at the old dead ends, and the concrete plant's "in" and "out" spans become those same
// two spans, so both plants work on each whole track. Each industry's components act only on cars waybilled to them
// (IndustryComponent.EnumerateCars), so sharing track mixes no cars. If anything differs (a span other than the base
// map's, a missing segment), the edit is skipped with one warning and each plant keeps its own track: the concrete plant
// works on the extensions alone, as the merge left it.

import json
import log

let t1Lower = "Sggv|a|45.56357"
let t1Old = "S505|b|1.372604"
let t2Lower = "Svh2|a|48.97194"
let t2Old = "Sqx6|b|1.633168"
let t1End = "ctw1s|b|1.5"
let t2End = "ctw2s|b|1.5"

func spanIs(spans, id, lower, upper) {
    if !spans.has(id) { return false }
    var s = spans[id]
    return s.count == 2 && s[0] == lower && s[1] == upper
}

// "" when the map is as expected, else the first thing that is not.
func problem(areas, segs) {
    if !areas.has("sylva") || !areas["sylva"].has("industries") { return "no sylva area" }
    var inds = areas["sylva"]["industries"]
    if !inds.has("sylva-ties") || !inds.has("sylva-concrete-ties") { return "a plant is missing" }
    if !inds["sylva-ties"].has("trackSpans") || !inds["sylva-concrete-ties"].has("trackSpans") { return "a plant has no spans" }
    if !segs.has("ctw1s") || !segs.has("ctw2s") { return "an extension is missing" }
    var wood = inds["sylva-ties"]["trackSpans"]
    var conc = inds["sylva-concrete-ties"]["trackSpans"]
    if !spanIs(wood, "t1", t1Lower, t1Old) || !spanIs(wood, "t2", t2Lower, t2Old) { return "Scott spans differ from the base map" }
    if !spanIs(conc, "in", "ctw1s|a|1.5", t1End) || !spanIs(conc, "out", "ctw2s|a|1.5", t2End) { return "concrete spans differ" }
    return ""
}

// "" when the map has what the merge builds on (the Sylva and Whittier interchanges, and the three nodes the new track hangs from), else the first thing missing.
// On another map the merge would leave an interchange with no base or track on nodes that are not there, so it is skipped.
func baseProblem(data) {
    if !data.has("ops") || !data["ops"].has("areas") { return "no areas" }
    var areas = data["ops"]["areas"]
    if !areas.has("sylva") || !areas.has("whittier") { return "no sylva or whittier area" }
    if !areas["sylva"].has("industries") || !areas["whittier"].has("industries") { return "an area has no industries" }
    if !areas["sylva"]["industries"].has("sylva-interchange") || !areas["whittier"]["industries"].has("ewh-interchange") { return "an interchange is missing" }
    if !areas["sylva"]["industries"]["sylva-interchange"].has("components") || !areas["whittier"]["industries"]["ewh-interchange"].has("components") { return "an interchange has no components" }
    if !data.has("graph") || !data["graph"].has("nodes") { return "no track" }
    var nodes = data["graph"]["nodes"]
    if !nodes.has("Ni0t") || !nodes.has("N9kl") || !nodes.has("N4oh") { return "a node the new track joins is missing" }
    return ""
}

func modifyMap(map) {
    var missing = ""
    map.modify((data) => { missing = baseProblem(data) })
    if missing != "" {
        log.warning("[concrete-ties] not added, this map lacks what it builds on (\(missing))")
        return
    }
    map.merge(json.load("Data/Map.json"))
    map.modify((data) => {
        if !data.has("ops") || !data["ops"].has("areas") { return }
        var segs = (data.has("graph") && data["graph"].has("segments")) ? data["graph"]["segments"] : {}
        var why = problem(data["ops"]["areas"], segs)
        if why != "" {
            log.warning("[concrete-ties] Scott Tie Plant tracks not joined to the new track (\(why)); each plant keeps its own track")
            return
        }
        data["ops"]["areas"]["sylva"]["industries"]["sylva-ties"]["trackSpans"]["t1"] = [t1Lower, t1End]
        data["ops"]["areas"]["sylva"]["industries"]["sylva-ties"]["trackSpans"]["t2"] = [t2Lower, t2End]
        data["ops"]["areas"]["sylva"]["industries"]["sylva-concrete-ties"]["trackSpans"]["in"] = [t1Lower, t1End]
        data["ops"]["areas"]["sylva"]["industries"]["sylva-concrete-ties"]["trackSpans"]["out"] = [t2Lower, t2End]
        log.info("[concrete-ties] Scott Tie Plant tracks t1 and t2 run to the new west ends and Scott Concrete Ties shares them")
    })
}
