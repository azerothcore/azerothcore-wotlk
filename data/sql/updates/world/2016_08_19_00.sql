/*
Reference some issues: one problem #96
Fixing worldserver.exe errors

Server: Local (Repo AzerothCore)
Last commit hash tested: 3761e9d8433f4d031b3477b787134a1d868a8971
O.S.: Windows 10
Compiler: MS Visual Studio 2013
*/

ALTER TABLE world_db_version CHANGE COLUMN 2016_08_14_02 2016_08_19_00 BIT;

/*
2016-08-16 00:44:35 ERROR: Table 'creature_loot_template' entry 1 isn't creature entry and not referenced from loot, 
and then useless.

Removed, items inside are lootable from no one mobs.
*/
DELETE FROM creature_loot_template WHERE entry = 1;

/*
2016-08-16 00:44:35 ERROR: Table 'skinning_loot_template' entry 80102 isn't creature skinning id and not referenced from loot, 
and then useless.

Adjust values of entry and loot % for the real NPC
*/
DELETE FROM skinning_loot_template WHERE entry IN (80102,18343);
INSERT INTO `skinning_loot_template` VALUES
(18343,21929,0,1,1,1,2),(18343,23077,0,1,1,1,2),
(18343,23079,0,1,1,1,2),(18343,23107,0,1,1,1,2),
(18343,23112,0,1,1,1,2),(18343,23117,0,1,1,1,2),
(18343,23425,92,1,0,4,11),(18343,23436,1,1,2,1,1),
(18343,23437,1,1,2,1,1),(18343,23438,1,1,2,1,1),
(18343,23439,1,1,2,1,1),(18343,23440,1,1,2,1,1),
(18343,23441,1,1,2,1,1);
