-- DB update 2026_06_10_02 -> 2026_06_10_03
DELETE FROM `waypoint_data` WHERE `id` = 253190;
INSERT INTO `waypoint_data`
    (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`)
VALUES
    (253190, 1, 1735.393, 593.6747, 140.5267, NULL, 0, 0, 1, 1, 0, 100),
    (253190, 2, 1746.861, 621.0573, 141.2209, NULL, 0, 0, 1, 1, 0, 100),
    (253190, 3, 1734.7, 663.6804, 139.3877, NULL, 0, 0, 1, 1, 0, 100),
    (253190, 4, 1695.096, 677.7586, 139.9433, NULL, 0, 0, 1, 1, 0, 100),
    (253190, 5, 1663.575, 664.397, 139.952, NULL, 0, 0, 1, 1, 0, 100),
    (253190, 6, 1651.432, 634.5519, 140.1377, NULL, 0, 0, 1, 1, 0, 100),
    (253190, 7, 1666.394, 594.8594, 139.1098, NULL, 0, 0, 1, 1, 0, 100),
    (253190, 8, 1704.55, 579.4996, 140.3171, NULL, 0, 0, 1, 1, 0, 100);

UPDATE `creature_template` SET `speed_run` = 1.71429, `flags_extra` = `flags_extra` | 512 WHERE `entry` = 25319;
