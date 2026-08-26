--
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` = 34120;

DELETE FROM `creature_summon_groups` WHERE `summonerId` = 603 AND `summonerType` = 2 AND `groupId` = 3;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`, `Comment`) VALUES
    (603, 2, 3, 34120, 163.25363, -298.22842, 499.2952, 1.42811, 8, 0, 'Flame Leviathan outro - Brann''s Flying Machine (flying in)');

DELETE FROM `waypoint_data` WHERE `id` = 341200;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`) VALUES
    (341200, 1, 187.4006, -142.13303, 499.75803, NULL, 0, 2),
    (341200, 2, 216.5235, -102.91764, 475.61917, NULL, 0, 2),
    (341200, 3, 207.2646, -0.70204, 460.2581, NULL, 0, 2),
    (341200, 4, 201.75299, 29.980198, 465.31372, NULL, 0, 2),
    (341200, 5, 231.98503, 47.572918, 459.28592, NULL, 0, 2),
    (341200, 6, 247.23238, 44.02615, 459.17484, NULL, 0, 2),
    (341200, 7, 253.05849, 22.741266, 446.11926, NULL, 0, 2),
    (341200, 8, 255.55441, -23.08404, 431.00824, NULL, 0, 2),
    (341200, 9, 260.49127, -54.526966, 421.7027, NULL, 0, 2),
    (341200, 10, 246.4216, -80.037926, 416.2025, NULL, 0, 2);
