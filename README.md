# Concrete Ties

This is the source of Concrete Ties 0.1.0. It is not on Nexus Mods yet.

Beta. Not tested in multiplayer or in a game with Build It Yourself.
Built for Railroader 0.6.3. Data only, with no DLL, so "Allow DLL Mods" is not needed.

## What it adds
A concrete tie plant beside the Scott Tie Plant at Sylva, and the track to serve it. The plant makes a new load, Concrete Ties,
ships it to the interchange like the wood tie plant does, and sells it to your Maintenance of Way cars from the same pile.
High Speed Rail needs this mod. On its own, nothing in the base game uses Concrete Ties, so the ties are only sold.

## The plant (Scott Concrete Ties)
Inputs are all delivered to the two tie tracks and all ordered by the plant from the interchange, paid freight.
  Metal Stock (the steel), Concrete (the cement) and Ballast (the aggregate).
Each pile holds the largest car that can bring it plus a day of use, so a spotted car always unloads, and the plant orders when
a day's worth is not in stock. A full car takes about an hour or less to unload at full contract. To supply from Rock Products instead,
rebill the cars with Waybill Rebill.
Output is loaded on the same two tracks. It is Concrete Ties in gondolas and flatcars, like wood ties.
Full contract (tier 5) rates, per day
  1,000,000 lb of ties (about 1,430 ties)
  35,714 lb of Metal Stock, 142,857 lb of Concrete, 821,429 lb of Ballast
Lower tiers run at the usual share of those numbers (1/8, 1/4, 1/2, 3/4, 1). The plant keeps no contract until you sign one.
A start-up stock of a quarter of each input pile is there the first time the plant loads.
A full output pile stops the plant. Ties not sold to Maintenance of Way ship out to the interchange and are paid like any freight.
Concrete Ties can also be bought at the Sylva and Whittier interchanges, listed with the wood ties.
The seller draws from the same pile as the loader.

## Where the numbers come from (all approximate)
A tie is taken as 700 lb, which is 25 lb of steel strand, 100 lb of cement and 575 lb of aggregate. One heavy-haul concrete tie catalog lists
610 lb, so 700 is a round figure and not a measured one. The plant makes 1,000,000 lb of ties a day at full contract, which is what one
work car lays in about 6 hours of play at normal time speed. A work car builds the tie phase at 0.041 m a second (148 m an hour),
and a km of concrete track at 24 inch spacing takes about 1.15 million lb of ties.
The price is 0.0014 per lb, so a 100,000 lb car costs 140 plus the game's 30 per car handling fee, and a 700 lb tie is about 0.98, 2.4 times a wood tie of 200 lb (0.40 at the base
price of 0.002 a lb). It is set by judgment and not from a price list.

## The track
Added at the Scott tie plant
  The lower tie track extends 110 m west.
  The upper tie track extends 150 m west.
  Both loads and unloads work on either track, like the logging camps.
  The Scott Tie Plant's two tracks now run out to the new ends, so both plants share each whole track.
  Each plant works only on cars waybilled to it.
  A new 297 m siding branches off the lead and runs 5 m beside the upper tie track, empty, for MoW cars, empties and log cars.
The new switch keeps the lead's old route as its normal one, so existing moves work as before.
On a map without the Sylva and Whittier interchanges or the nodes the new track joins, the mod adds nothing and writes one warning to Player.log.
If another mod changes the Scott Tie Plant's tracks, the mod leaves them alone, writes one warning to Player.log, and the concrete plant works on the new track only.
If you use Build It Yourself, pick "Start it built" for this mod. The Scott Tie Plant's tracks now run onto the new track, and unbuilt track would stop the plant.

## Saves and removal
Adding the mod to an existing save adds the track, the plant and the load when the save loads. Removing it takes them away.
Removing it empties any car still loaded with Concrete Ties when the save loads, and waybills to the plant are rerouted. Cars standing on the new track go to the Lost & Found window to be placed.

## Not tested
Written against the game's code and checked offline. Not yet run in the game are how the new track and plant sit on the ground (no ground is
flattened, and the heightmap puts it 2 to 3 m above the ground, as the plant's own track is), the full shared tracks and the end of the siding, how the load looks in a car (it has no model of its own), how the new switch draws, which interchange sends the steel, and what a switch list calls a car standing on the shared tracks (it may name either plant).
In multiplayer every player needs it. The host runs the plant. Not tested.

## Changes
0.1.0: First public beta.
Added the Scott Concrete Ties plant and the Concrete Ties load, bought at both MoW interchanges.
Added 110 m and 150 m west extensions of the two tie tracks and a 297 m siding.
Changed the Scott Tie Plant's two tracks to run to the new ends, shared with the concrete plant.
Added a check that stands the mod down, with one warning, on a map without the Sylva and Whittier interchanges and the nodes the new track joins.

## Using this source

The mod is the `ConcreteTies` folder. It is a data pack with no DLL, so there is nothing to build. Copy the folder into
`Documents/Railroader/Mods` and tick it in Manage Mods.

## License

MIT, see LICENSE.

Made with AI assistance (Claude), every release reviewed and audited in game by a human.
