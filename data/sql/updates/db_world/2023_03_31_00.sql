-- DB update 2023_03_30_07 -> 2023_03_31_00
--
UPDATE `spell_dbc` SET `Effect_1` = 28, `EffectMiscValueB_1` = 64, `EffectBasePoints_1` = -1 WHERE `ID` IN (
14802 -- Idol Room Spawn B
);

UPDATE `spell_dbc` SET `Effect_1` = 28, `EffectMiscValueB_1` = 64, `EffectBasePoints_1` = 0 WHERE `ID` IN (
12694, -- Idol Room Spawn A
12949, -- Idol Room Spawn End Boss
14801, -- Idol Room Spawn C
19826, -- Summon Blackwing Legionnaire
19827, -- Summon Blackwing Mage
19828, -- Summon Death Talon Dragonspawn
20172, -- Summon Onyxian Whelp
21287, -- Conjure Lokholar the Usurper DND
23118, -- Conjure Scourge Footsoldier DND
23209, -- Terrordale Haunting Spirit #2
23253, -- Terrordale Haunting Spirit #3
23361, -- Raise Undead Drakonid
24215, -- Create Heart of Hakkar Explosion
24250, -- Summon Zulian Stalker
24349, -- Summon Bloodlord's Raptor
25151, -- Summon Vekniss Drone
26140, -- Summon Hook Tentacle
26144, -- Summon Eye Tentacle
26145, -- Summon Eye Tentacle
26146, -- Summon Eye Tentacle
26147, -- Summon Eye Tentacle
26148, -- Summon Eye Tentacle
26149, -- Summon Eye Tentacle
26150, -- Summon Eye Tentacle
26151, -- Summon Eye Tentacle
26191, -- Teleport Giant Hook Tentacle
26216, -- Summon Giant Hook Tentacles
26396, -- Summon Portal Ground State
26477, -- Summon Giant Portal Ground State
26564, -- Summon Viscidus Trigger
26617, -- Summon Ouro Mound
26768, -- Summon Giant Eye Tentacles
26837, -- Summon InCombat Trigger
27178, -- Defile
27643, -- Summon Spirit of Jarien
27644, -- Summon Spirit of Sothos
27884, -- Summon Trainee
27921, -- Summon Spectral Trainee
27932, -- Summon Spectral Knight
27939, -- Summon Spectral Rivendare
28008, -- Summon Knight
28010, -- Summon Mounted Knight
28175, -- (DND) Summon Crystal Minion, Ghost
28177, -- (DND) Summon Crystal Minion, Skeleton
28179, -- (DND) Summon Crystal Minion, Ghoul
28217, -- Summon Zombie Chow
28218, -- Summon Fallout Slime
28227, -- (DND) Summon Crystal Minion, finder
28289, -- (DND) Summon Crystal Minion, Ghoul Uncommon
28290, -- (DND) Summon Crystal Minion, Ghost Uncommon
28291, -- (DND) Summon Crystal Minion, Skeleton Uncommon
28421, -- Summon Type A
28422, -- Summon Type B
28423, -- Summon Type C
28454, -- Summon Type D
28561, -- Summon Blizzard
28627, -- Summon Web Wrap
29141, -- Marauding Crust Borer
29218, -- Summon Flame Ring
29329, -- Summon Sapphiron's Wing Buffet
29508, -- Summon Crypt Guard
29869, -- Fished Up Murloc
30083, -- Summon Root Thresher
30445, -- Stillpine Ancestor Yor
30630, -- Debris
30737, -- Summon Heathen
30785, -- Summon Reaver
30786, -- Summon Sharpshooter
30954, -- Free Webbed Creature
30955, -- Free Webbed Creature
30956, -- Free Webbed Creature
30957, -- Free Webbed Creature
30958, -- Free Webbed Creature
30959, -- Free Webbed Creature
30960, -- Free Webbed Creature
30961, -- Free Webbed Creature
30962, -- Free Webbed Creature
30963, -- Free Webbed Creature
31010, -- Free Webbed Creature
31318, -- Summon Infinite Assassin
31321, -- Summon Black Morass Rift Lord
31391, -- Summon Black Morass Chrono Lord Deja
31392, -- Summon Black Morass Temporus
31393, -- Summon Black Morass Rift End Boss
31421, -- Summon Infinite Chronomancer
31528, -- Summon Gnome
31529, -- Summon Gnome
31530, -- Summon Gnome
31544, -- Summon Distiller
31545, -- Summon Distiller
31593, -- Summon Greater Manawraith
32114, -- Summon Wisp
32151, -- Infernal
32283, -- Focus Fire
32360, -- Summon Stolen Soul
32579, -- Portal Beam
32632, -- Summon Overrun Target
33121, -- A Vision of the Forgotten
33229, -- Wrath of the Astromancer
33242, -- Infernal
33363, -- Summon Infinite Executioner
33364, -- Summon Infinite Vanquisher
33367, -- Summon Astromancer Priest
33567, -- Summon Void Portal D
33677, -- Incite Chaos
33680, -- Incite Chaos
33681, -- Incite Chaos
33682, -- Incite Chaos
33683, -- Incite Chaos
33901, -- Summon Crystalhide Crumbler
33927, -- Summon Void Summoner
34064, -- Soul Split
34125, -- Spotlight
34175, -- Arcane Orb Primer
35127, -- Summon Boom Bot Target
35136, -- Summon Captured Critter
35142, -- Drijya Summon Imp
35145, -- Drijya Summon Doomguard
35146, -- Drijya Summon Terrorguard
35256, -- Summon Unstable Mushroom
35430, -- Infernal
35861, -- Summon Nether Vapor
35862, -- Summon Nether Vapor
35863, -- Summon Nether Vapor
35864, -- Summon Nether Vapor
36026, -- Conjure Elemental Soul: Earth
36036, -- Summon Netherstorm Target
36042, -- Summon Farahlon Crumbler
36043, -- Summon Farahlon Crumbler
36044, -- Summon Farahlon Crumbler
36045, -- Summon Farahlon Shardling
36046, -- Summon Farahlon Shardling
36047, -- Summon Farahlon Shardling
36048, -- Summon Motherlode Shardling
36049, -- Summon Motherlode Shardling
36050, -- Summon Motherlode Shardling
36112, -- Conjure Elemental Soul: Fire
36168, -- Conjure Elemental Soul: Water
36180, -- Conjure Elemental Soul: Air
36221, -- Summon  Eye of the Citadel
36229, -- Summon Infinite Assassin
36231, -- Summon Infinite Chronomancer
36232, -- Summon Infinite Executioner
36233, -- Summon Infinite Vanquisher
36234, -- Summon Black Morass Rift Lord Alt
36235, -- Summon Black Morass Rift Keeper
36236, -- Summon Black Morass Rift Keeper
36521, -- Summon Arcane Explosion
36579, -- Summon Netherock Crumbler
36584, -- Summon Netherock Crumbler
36585, -- Summon Netherock Crumbler
36595, -- Summon Apex Crumbler
36596, -- Summon Apex Crumbler
36597, -- Summon Apex Crumbler
36724, -- Summon Phoenix Egg
36818, -- Attacking Infernal
36865, -- Summon Gnome Cannon Channel Target (DND)
37177, -- Summon Black Morass Infinite Chrono-Lord
37178, -- Summon Black Morass Infinite Timereaver
37457, -- Windsor Dismisses Horse DND
37606, -- Summon Infinite Assassin
37758, -- Bone Wastes - Summon Auchenai Spirit
37766, -- Summon Murloc A1
37772, -- Summon Murloc B1
37773, -- Summon Elemental A1
37774, -- Summon Elemental B1
37911, -- Summon Elemental A2
37912, -- Summon Elemental A3
37914, -- Summon Elemental B2
37916, -- Summon Elemental B3
37923, -- Summon Murloc A2
37925, -- Summon Murloc A3
37926, -- Summon Murloc A4
37927, -- Summon Murloc A5
37928, -- Summon Murloc B2
37929, -- Summon Murloc B3
37931, -- Summon Murloc B4
37932, -- Summon Murloc B5
38111, -- Summon Horde Bat Rider Guard
38114, -- Summon Horde Rooftop Alarm Sensor
38118, -- Summon Area 52 Death Machine Guard
38124, -- Summon Horde Ground Alarm Sensor
38137, -- Summon Sky Marker
38179, -- Summon Alliance Ground Alarm Sensor
38180, -- Summon Alliance Rooftop Alarm Sensor
38181, -- Summon Alliance Gryphon Guard
38261, -- Summon Area 52 Rooftop Alarm Sensor
38266, -- Summon Stormspire Ethereal Guard
38268, -- Summon Scryer Dragonhawk Guard
38270, -- Summon Stormspire Rooftop Alarm Sensor
38271, -- Summon Scryer Rooftop Alarm Sensor
38278, -- Summon Aldor Gryphon Guard
38283, -- Summon Aldor Rooftop Alarm Sensor
38286, -- Summon Sporeggar Sporebat Guard
38287, -- Summon Sporeggar Rooftop Alarm Sensor
38288, -- Summon Toshley Guard
38291, -- Summon Toshley Rooftop Alarm Sensor
38402, -- Summon Cenarion Storm Crow Guard
38403, -- Summon Cenarion Expedition Rooftop Alarm Sensor
38512, -- Fiery Boulder
38587, -- Summon Spirit of Redemption
38854, -- Hatch Arakkoa
38865, -- Hatch Bad Arakkoa
39080, -- Summon Mountain Shardling
39081, -- Summon Vortex Shardling
39186, -- Summon Random Tractor
39191, -- Sha'tari Flames
39302, -- Quest - The Exorcism, Summon Foul Purge
39305  -- Summon Flying Skull
);

UPDATE `spell_dbc` SET `Effect_1` = 28, `EffectMiscValueB_1` = 64, `EffectBasePoints_1` = 1 WHERE `ID` IN (
20734, -- Black Arrow
30792, -- Summon Ravager Ambusher
30825, -- Summon Siltfin Ambusher
30826, -- Summon Wildkin Ambusher
30976, -- Summon Gauntlet Guards
31995, -- Shattered Rumbler
39110  -- Summon Phoenix Adds
);

UPDATE `spell_dbc` SET `Effect_1` = 28, `EffectMiscValueB_1` = 64, `EffectBasePoints_1` = 2 WHERE `ID` IN (
30076, -- Summon Maexxna Spiderling
30827, -- Summon Bristlelimb Ambusher
36379  -- Call Skitterers
);

UPDATE `spell_dbc` SET `Effect_1` = 28, `EffectMiscValueB_1` = 64, `EffectBasePoints_1` = 3 WHERE `ID` IN (
26630, -- Spawn Vekniss Hatchlings
26631, -- Spawn Vekniss Hatchlings
26632, -- Spawn Vekniss Hatchlings
30828  -- Summon Sunhawk Ambushers
);

UPDATE `spell_dbc` SET `Effect_1` = 28, `EffectMiscValueB_1` = 64, `EffectBasePoints_1` = 4 WHERE `ID` IN (
33362 -- Summon Astromancer Adds
);

UPDATE `spell_dbc` SET `Effect_1` = 28, `EffectMiscValueB_1` = 64, `EffectBasePoints_1` = 5 WHERE `ID` IN (
23119, -- Conjure Peasant DND
23121  -- Conjure Peasant DND
);

UPDATE `spell_dbc` SET `Effect_1` = 28, `EffectMiscValueB_1` = 64, `EffectBasePoints_1` = 9 WHERE `ID` IN (
25789, -- Summon Yauj Brood
29434  -- Summon Maexxna Spiderling
);

UPDATE `spell_dbc` SET `Effect_2` = 28, `EffectMiscValueB_2` = 64, `EffectBasePoints_2` = 1 WHERE `ID` IN (
21883  -- Summon Healed Celebrian Vine
);

UPDATE `spell_dbc` SET `Effect_2` = 28, `EffectMiscValueB_2` = 64, `EffectBasePoints_2` = 0 WHERE `ID` IN (
23201, -- Hunter Epic Anti-Cheat DND
27939, -- Summon Spectral Rivendare
29110, -- Summon Enraged Mounts
30774, -- Summon Elekk
33614, -- Summon Void Portal B
33616, -- Summon Void Portal E
36616, -- Veneratus Spawn
39074, -- [DND]Rexxars Bird Effect
69868  -- Carrying Beer Barrels [TEST]
);

UPDATE `spell_dbc` SET `Effect_2` = 28, `EffectMiscValueB_2` = 496, `EffectBasePoints_2` = 0 WHERE `ID` IN (
74125  -- Summon Creator Spell Test
);

UPDATE `spell_dbc` SET `Effect_3` = 28, `EffectMiscValueB_3` = 496, `EffectBasePoints_3` = 0 WHERE `ID` IN (
33615  -- Summon Void Portal C
);
