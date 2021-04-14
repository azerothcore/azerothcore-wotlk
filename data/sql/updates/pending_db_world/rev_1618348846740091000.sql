INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1618348846740091000');

-- Shadowfang Keep
UPDATE `dungeon_access_template` SET `max_level` = 26, `min_level` = 16 WHERE `map_id` = 33;
-- Stormwind Stockade
UPDATE `dungeon_access_template` SET `max_level` = 30, `min_level` = 20 WHERE `map_id` = 34;
-- Deadmines
UPDATE `dungeon_access_template` SET `max_level` = 25, `min_level` = 15 WHERE `map_id` = 36;
-- Wailing Caverns
UPDATE `dungeon_access_template` SET `max_level` = 25, `min_level` = 15 WHERE `map_id` = 43;
-- Razorfen Kraul
UPDATE `dungeon_access_template` SET `max_level` = 32, `min_level` = 22 WHERE `map_id` = 47;
-- Blackfathom Deeps
UPDATE `dungeon_access_template` SET `max_level` = 29, `min_level` = 19 WHERE `map_id` = 48;
-- Uldaman
UPDATE `dungeon_access_template` SET `max_level` = 45, `min_level` = 35 WHERE `map_id` = 70;
-- Gnomeregan
UPDATE `dungeon_access_template` SET `max_level` = 33, `min_level` = 23 WHERE `map_id` = 90;
-- Sunken Temple
UPDATE `dungeon_access_template` SET `max_level` = 55, `min_level` = 45 WHERE `map_id` = 109;
-- Razorfen Downs
UPDATE `dungeon_access_template` SET `max_level` = 42, `min_level` = 32 WHERE `map_id` = 129;
-- Scarlet Monastery (SM) - All wings
UPDATE `dungeon_access_template` SET `max_level` = 45, `min_level` = 27 WHERE `map_id` = 189;
-- Zul'Farrak
UPDATE `dungeon_access_template` SET `max_level` = 51, `min_level` = 41 WHERE `map_id` = 209;
-- Blackrock Spire - Both Lower (LBRS) & Upper (UBRS) - 5/10man
UPDATE `dungeon_access_template` SET `max_level` = 65, `min_level` = 55 WHERE `map_id` = 229;
-- Blackrock Depths (BRD)
UPDATE `dungeon_access_template` SET `max_level` = 61, `min_level` = 47 WHERE `map_id` = 230;
-- Onyxia's Lair - 10man & Onyxia's Lair - 25man
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 80 WHERE `map_id` = 249;
-- Caverns Of Time: Black Morass/Opening the Dark Portal - Normal
UPDATE `dungeon_access_template` SET `max_level` = 75, `min_level` = 68 WHERE `map_id` = 269 AND `difficulty` = 0;
-- Caverns Of Time: Black Morass/Opening the Dark Portal - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 75, `min_level` = 70 WHERE `map_id` = 269 AND `difficulty` = 1;
-- Scholomance
UPDATE `dungeon_access_template` SET `max_level` = 65, `min_level` = 55 WHERE `map_id` = 289;
-- Zul'Gurub (ZG) - 20man
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 56 WHERE `map_id` = 309;
-- Stratholme
UPDATE `dungeon_access_template` SET `max_level` = 65, `min_level` = 55 WHERE `map_id` = 329;
-- Maraudon - All wings
UPDATE `dungeon_access_template` SET `max_level` = 53, `min_level` = 39 WHERE `map_id` = 349;
-- Ragefire Chasm (RF)
UPDATE `dungeon_access_template` SET `max_level` = 21, `min_level` = 15 WHERE `map_id` = 389;
-- Molten Core - 40man
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 60 WHERE `map_id` = 409;
-- Dire Maul - All wings
UPDATE `dungeon_access_template` SET `max_level` = 65, `min_level` = 53 WHERE `map_id` = 429;
-- Blackwing Lair (BWL) - 40man
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 60 WHERE `map_id` = 469;
-- Ahn'Qiraj Ruins (AQ20) - 20man
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 60 WHERE `map_id` = 509;
-- Ahn'Qiraj Temple (AQ40) - 40man
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 60 WHERE `map_id` = 531;
-- Karazhan - 10man
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 70 WHERE `map_id` = 532;
-- Naxxramas
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 80 WHERE `map_id` = 533;
-- Battle Of Mount Hyjal,Alliance Base
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 70 WHERE `map_id` = 534;
-- The Shattered Halls
UPDATE `dungeon_access_template` SET `max_level` = 75, `min_level` = 67 WHERE `map_id` = 540 AND `difficulty` = 0;
-- The Shattered Halls - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 75, `min_level` = 70 WHERE `map_id` = 540 AND `difficulty` = 1;
-- The Blood Furnace
UPDATE `dungeon_access_template` SET `max_level` = 68, `min_level` = 59 WHERE `map_id` = 542 AND `difficulty` = 0;
-- The Blood Furnace - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 75, `min_level` = 70 WHERE `map_id` = 542 AND `difficulty` = 1;
-- Hellfire Ramparts
UPDATE `dungeon_access_template` SET `max_level` = 67, `min_level` = 57 WHERE `map_id` = 543 AND `difficulty` = 0;
-- Hellfire Ramparts - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 75, `min_level` = 70 WHERE `map_id` = 543 AND `difficulty` = 1;
