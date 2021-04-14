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
-- Hellfire Citadel: Magtheridon's Lair - 25man
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 70 WHERE `map_id` = 544;
-- The Steamvault
UPDATE `dungeon_access_template` SET `max_level` = 75, `min_level` = 67 WHERE `map_id` = 545 AND `difficulty` = 0;
-- The Steamvault - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 75, `min_level` = 70 WHERE `map_id` = 545 AND `difficulty` = 1;
-- The Underbog
UPDATE `dungeon_access_template` SET `max_level` = 70, `min_level` = 61 WHERE `map_id` = 546 AND `difficulty` = 0;
-- The Underbog - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 75, `min_level` = 70 WHERE `map_id` = 546 AND `difficulty` = 1;
-- The Slave Pens
UPDATE `dungeon_access_template` SET `max_level` = 69, `min_level` = 60 WHERE `map_id` = 547 AND `difficulty` = 0;
-- The Slave Pens - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 75, `min_level` = 70 WHERE `map_id` = 547 AND `difficulty` = 1;
-- Coilfang Reservoir: Serpentshrine Cavern - 25man
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 70 WHERE `map_id` = 548;
-- The Eye
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 70 WHERE `map_id` = 550;
-- The Arcatraz
UPDATE `dungeon_access_template` SET `max_level` = 75, `min_level` = 68 WHERE `map_id` = 552 AND `difficulty` = 0;
-- The Arcatraz - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 75, `min_level` = 70 WHERE `map_id` = 552 AND `difficulty` = 1;
-- The Botanica
UPDATE `dungeon_access_template` SET `max_level` = 75, `min_level` = 67 WHERE `map_id` = 553 AND `difficulty` = 0;
-- The Botanica - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 75, `min_level` = 70 WHERE `map_id` = 553 AND `difficulty` = 1;
-- The Mechanar
UPDATE `dungeon_access_template` SET `max_level` = 75, `min_level` = 67 WHERE `map_id` = 554 AND `difficulty` = 0;
-- The Mechanar - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 75, `min_level` = 70 WHERE `map_id` = 554 AND `difficulty` = 1;
-- Shadow Labyrinth
UPDATE `dungeon_access_template` SET `max_level` = 75, `min_level` = 67 WHERE `map_id` = 555 AND `difficulty` = 0;
-- Shadow Labyrinth - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 75, `min_level` = 70 WHERE `map_id` = 555 AND `difficulty` = 1;
-- Sethekk Halls
UPDATE `dungeon_access_template` SET `max_level` = 73, `min_level` = 65 WHERE `map_id` = 556 AND `difficulty` = 0;
-- Sethekk Halls - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 75, `min_level` = 70 WHERE `map_id` = 556 AND `difficulty` = 1;
-- Mana Tombs
UPDATE `dungeon_access_template` SET `max_level` = 71, `min_level` = 62 WHERE `map_id` = 557 AND `difficulty` = 0;
-- Mana Tombs - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 75, `min_level` = 70 WHERE `map_id` = 557 AND `difficulty` = 1;
-- Auchenai Crypts
UPDATE `dungeon_access_template` SET `max_level` = 72, `min_level` = 63 WHERE `map_id` = 558 AND `difficulty` = 0;
-- Auchenai Crypts - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 75, `min_level` = 70 WHERE `map_id` = 558 AND `difficulty` = 1;
-- Caverns Of Time: Old Hillsbrad Foothills/Escape from Durnholde - Normal
UPDATE `dungeon_access_template` SET `max_level` = 73, `min_level` = 64 WHERE `map_id` = 560 AND `difficulty` = 0;
-- Caverns Of Time: Old Hillsbrad Foothills/Escape from Durnholde - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 75, `min_level` = 70 WHERE `map_id` = 560 AND `difficulty` = 1;
-- Black Temple
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 70 WHERE `map_id` = 564;
-- Gruul's Lair
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 70 WHERE `map_id` = 565;
-- Zul'Aman
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 70 WHERE `map_id` = 568;
-- Utgarde Keep
UPDATE `dungeon_access_template` SET `max_level` = 80, `min_level` = 68 WHERE `map_id` = 574 AND `difficulty` = 0;
-- Utgarde Keep - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 80 WHERE `map_id` = 574 AND `difficulty` = 1;
-- Utgarde Pinnacle
UPDATE `dungeon_access_template` SET `max_level` = 80, `min_level` = 77 WHERE `map_id` = 575 AND `difficulty` = 0;
-- Utgarde Pinnacle - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 80 WHERE `map_id` = 575 AND `difficulty` = 1;
-- The Nexus
UPDATE `dungeon_access_template` SET `max_level` = 80, `min_level` = 69 WHERE `map_id` = 576 AND `difficulty` = 0;
-- The Nexus - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 80 WHERE `map_id` = 576 AND `difficulty` = 1;
-- The Oculus
UPDATE `dungeon_access_template` SET `max_level` = 80, `min_level` = 77 WHERE `map_id` = 578 AND `difficulty` = 0;
-- The Oculus - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 80 WHERE `map_id` = 578 AND `difficulty` = 1;
-- Sunwell Plateau
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 70 WHERE `map_id` = 580;
-- Magisters' Terrace - Normal
UPDATE `dungeon_access_template` SET `max_level` = 75, `min_level` = 68 WHERE `map_id` = 585 AND `difficulty` = 0;
-- Magisters' Terrace - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 75, `min_level` = 70 WHERE `map_id` = 585 AND `difficulty` = 1;
-- Culling of Stratholme
UPDATE `dungeon_access_template` SET `max_level` = 80, `min_level` = 77 WHERE `map_id` = 595 AND `difficulty` = 0;
-- Culling of Stratholme - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 80 WHERE `map_id` = 595 AND `difficulty` = 1;
-- Ulduar,Halls of Stone
UPDATE `dungeon_access_template` SET `max_level` = 80, `min_level` = 75 WHERE `map_id` = 599 AND `difficulty` = 0;
-- Ulduar,Halls of Stone - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 80 WHERE `map_id` = 599 AND `difficulty` = 1;
-- Drak'Tharon Keep
UPDATE `dungeon_access_template` SET `max_level` = 80, `min_level` = 72 WHERE `map_id` = 600 AND `difficulty` = 0;
-- Drak'Tharon Keep - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 80 WHERE `map_id` = 600 AND `difficulty` = 1;
-- Azjol-Nerub
UPDATE `dungeon_access_template` SET `max_level` = 80, `min_level` = 70 WHERE `map_id` = 601 AND `difficulty` = 0;
-- Azjol-Nerub - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 80 WHERE `map_id` = 601 AND `difficulty` = 1;
-- Ulduar,Halls of Lightning
UPDATE `dungeon_access_template` SET `max_level` = 80, `min_level` = 77 WHERE `map_id` = 602 AND `difficulty` = 0;
-- Ulduar,Halls of Lightning - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 80 WHERE `map_id` = 602 AND `difficulty` = 1;
-- Ulduar - 10man
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 80 WHERE `map_id` = 603;
-- Gundrak (North entrance)
UPDATE `dungeon_access_template` SET `max_level` = 80, `min_level` = 74 WHERE `map_id` = 604 AND `difficulty` = 0;
-- Gundrak (North entrance) - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 80 WHERE `map_id` = 604 AND `difficulty` = 1;
-- Violet Hold
UPDATE `dungeon_access_template` SET `max_level` = 80, `min_level` = 73 WHERE `map_id` = 608 AND `difficulty` = 0;
-- Violet Hold - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 80 WHERE `map_id` = 608 AND `difficulty` = 1;
-- The Obsidian Sanctum
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 80 WHERE `map_id` = 615;
-- The Eye of Eternity
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 80 WHERE `map_id` = 616;
-- Ahn'Kahet
UPDATE `dungeon_access_template` SET `max_level` = 80, `min_level` = 71 WHERE `map_id` = 619 AND `difficulty` = 0;
-- Ahn'Kahet - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 80 WHERE `map_id` = 619 AND `difficulty` = 1;
-- Vault of Archavon
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 80 WHERE `map_id` = 624;
-- Icecrown Citadel
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 80 WHERE `map_id` = 631;
-- Forge of Souls
UPDATE `dungeon_access_template` SET `max_level` = 80, `min_level` = 80 WHERE `map_id` = 632 AND `difficulty` = 0;
-- Forge of Souls - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 80 WHERE `map_id` = 632 AND `difficulty` = 1;
-- Trial of the Crusader
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 80 WHERE `map_id` = 649;
-- Trial of the Champion
UPDATE `dungeon_access_template` SET `max_level` = 80, `min_level` = 80 WHERE `map_id` = 650 AND `difficulty` = 0;
-- Trial of the Champion - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 80 WHERE `map_id` = 650 AND `difficulty` = 1;
-- Pit of Saron
UPDATE `dungeon_access_template` SET `max_level` = 80, `min_level` = 80 WHERE `map_id` = 658 AND `difficulty` = 0;
-- Pit of Saron - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 80 WHERE `map_id` = 658 AND `difficulty` = 1;
-- Halls of Reflection
UPDATE `dungeon_access_template` SET `max_level` = 80, `min_level` = 80 WHERE `map_id` = 668 AND `difficulty` = 0;
-- Halls of Reflection - Heroic
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 80 WHERE `map_id` = 668 AND `difficulty` = 1;
-- The Ruby Sanctum
UPDATE `dungeon_access_template` SET `max_level` = 83, `min_level` = 80 WHERE `map_id` = 724;
