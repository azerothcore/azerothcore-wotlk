-- DB update 2026_09_06_00 -> 2026_09_06_01
-- Enchanted Scarlet Thread (175966) appears at four locations in a random,
-- non-repeating order. The Stratholme instance script summons one at a time.
DELETE FROM `gameobject` WHERE `guid` = 20872 AND `id` = 175966;

DELETE FROM `gameobject_summon_groups` WHERE `summonerId` = 329 AND `summonerType` = 2 AND `groupId` IN (0, 1, 2, 3);
INSERT INTO `gameobject_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `respawnTime`, `Comment`) VALUES
(329, 2, 0, 175966, 3458.015, -3111.456, 137.434, 5.358161926269531, 0, 0, -0.4462, 0.8949, 604800, 'Enchanted Scarlet Thread - Archivist Galford room'),
(329, 2, 1, 175966, 3593.515, -3060.397, 136.482, 1.5358895063400269, 0, 0, 0.6947, 0.7193, 604800, 'Enchanted Scarlet Thread - Hall opposite Malor room'),
(329, 2, 2, 175966, 3614.640, -3124.924, 137.012, 3.438302755355835, 0, 0, -0.9890, 0.1478, 604800, 'Enchanted Scarlet Thread - Malor room table'),
(329, 2, 3, 175966, 3625.627, -3123.886, 135.665, 5.777040958404541, 0, 0, -0.2504, 0.9681, 604800, 'Enchanted Scarlet Thread - Malor room back-left crate');

UPDATE `gameobject_template` SET `ScriptName` = 'go_enchanted_scarlet_thread' WHERE `entry` = 175966;
