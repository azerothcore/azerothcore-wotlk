# BeastMaster NPC #


### Description ###
------------------------------------------------------------------------------------------------------------------
WhiteFang is a Beastmaster NPC that howls! This NPC allows any player, or only Hunters, to adopt and use beasts. He 
also teaches the player specific Hunter skills for use with their beasts. A player can adopt normal, rare, or exotic 
beasts depending on how you've configured the NPC. For each beast I use a model for a rare creature of the same type, so
they all look cool. All beasts and models are configurable from the config file, so adding or changing beasts is easy
to do. White Fang also sells a great selection of pet food for every level of pet. Hunters can access the 
stables as well. This has been a lot of fun for players on my server, and pets work great and just like they do
on a Hunter in or out of dungeons.


### Features ###
------------------------------------------------------------------------------------------------------------------
- Adds a Worgen BeastMaster NPC with sounds/emotes
- Allows all classes, or Hunters only, to adopt new pets
- Teaches Normal, Rare, and Exotic Pets
- Minimum level to adopt configurable
- Beasts are always happy and don't need to be fed
- Beasts and models can be added/changed in the config file
- Beasts are automatically sorted in the game menu for each type
- Allows Exotic Beast acquisition with or without spec
- Teaches Hunter abilities to the player
- Sells pet food For all pet levels
- Pet scale is configurable


### Data ###
------------------------------------------------------------------------------------------------------------------
- Type: NPC
- Script: BeastMaster
- Config: Yes
    - Enable Module Announce
    - Enable For Hunter Only
    - Enable Exotic Beast Adoption Without Spec (Teaches Beast Mastery)
    - Set Beast Scaling Factor
	- Set Minimum Level To Adopt
    - Enable PetAlwaysHappy
    - Enable Core Handling Mod
    - Add/Set beast ID and model for each type
- SQL: Yes
    - NPC ID: 601026


## Beasts ##
------------------------------------------------------------------------------------------------------------------
**Normal Beasts**
- Bat 			-  Shadikith The Glider
- Bear			-  Ursollok
- Boar			-  Armored Brown
- Cat			-  Shadowclaw
- Carrion Bird 		-  Zaricotl
- Crab			-  Crusty
- Crocolisk 		-  Izod Green
- Dragonhawk		-  Bloodfalcon
- Gorilla 		-  King Mukla
- Hound 		-  Darkhound - (Registers as Wolf Pre-Cata)
- Hyena			-  Snort the Heckler
- Moth			-  Aspatha the Broodmother
- Nether Ray		-  Count Ungula
- Owl			-  Olm the Wise
- Raptor		-  Lar'korwi
- Ravager		-  Rip-blade Ravager
- Scorpid		-  Krellak
- Serpent		-  Emperor Cobra
- Spider		-  Krethis the Shadowspinner
- Spore Bat		-  Sporewing
- Tallstrider	 	-  Green/Purple
- Turtle		-  Cranky Benj
- Warp Stalker 		-  Gezzarak the Huntress
- Wasp			-  Blacksting
- Wind Serpent		-  Azzere the Skyblade
- Wolf			-  Ghostpaw Alpha
- Worg			-  Oil-Stained

**Rare Beasts**
- Bird 			-  Aotona
- Chimaera    		-  Nuramoc
- Core Hound		-  Molten Lava
- Devilsaur		-  King Krush
- Jormungar Worm      	-  Rattlebore
- Rhino			-  Wooly Rhino Matriarch Brown
- Silithid     		-  Clutchmother Zavas
- Tallstrider Pink	-  Mazzranache
- The Kurken		-  Wolf Core Hound
 
**Exotic Beasts**
- Arcturis		-  Spirit Bear
- Gondria		-  Spirit Tiger
- Loque'nahak		-  Spirit Leopard
- Skoll			-  Spirit Worg


### Version ###
------------------------------------------------------------------------------------------------------------------
- v2019.01.23 - Bugfixes, Merged config options by Stoabrogga
- v2019.01.08 - Added "Better Pet Handling" & "PetAlwaysHappy" config options
- v2017.09.30 - Add pet->InitLevelupSpellsForLevel(); recommended by Alistar
- v2017.09.13 - Teaches additional hunter spells (Eagle Eye, Eyes of the Beast, Beast Lore)
- v2017.09.11
    - Added Exotic Pet: Spirit Bear
    - Added Pet: Warp Stalker
    - Added Pet: Wind Serpent
    - Added Pet: Nether Ray
    - Added Pet: Spore Bat
    - Updated pet models to rare spawn models
- v2017.09.08 - Created new Pet Food item list for all pet levels
- v2017.09.04 - Fixed Spirit Beast persistence (teaches Beast Mastery to player)
- v2017.09.03 - Release


### Credits ###
------------------------------------------------------------------------------------------------------------------
#### A module for AzerothCore by StygianTheBest ([stygianthebest.github.io](http://stygianthebest.github.io)) ####

###### Additional Credits include:
- [Blizzard Entertainment](http://blizzard.com)
- [TrinityCore](https://github.com/TrinityCore/TrinityCore/blob/3.3.5/THANKS)
- [SunwellCore](http://www.azerothcore.org/pages/sunwell.pl/)
- [AzerothCore](https://github.com/AzerothCore/azerothcore-wotlk/graphs/contributors)
- [AzerothCore Discord](https://discord.gg/gkt4y2x)
- [EMUDevs](https://youtube.com/user/EmuDevs)
- [AC-Web](http://ac-web.org/)
- [ModCraft.io](http://modcraft.io/)
- [OwnedCore](http://ownedcore.com/)
- [OregonCore](https://wiki.oregon-core.net/)
- [Wowhead.com](http://wowhead.com)
- [AoWoW](https://wotlk.evowow.com/)
- [Stoabrogga] - Read pets from config file, Enums


### License ###
------------------------------------------------------------------------------------------------------------------
- This code and content is released under the [GNU AGPL v3](https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3).