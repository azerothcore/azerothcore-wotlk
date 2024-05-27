--
-- FORCE_GOSSIP
UPDATE `creature_template` SET `type_flags` = `type_flags` | 134217728  WHERE (`entry` = 17225);
UPDATE `creature_template` SET `movementId` = 1988 WHERE (`entry` = 17225);

-- Intro path
DELETE FROM `waypoints` WHERE `entry` = 172250;
-- INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
-- (172250, 1, -11105.76, -1875.8998, 158.97804, NULL, 0),
-- (172250, 2, -11175.097, -1857.2238, 101.00588, NULL, 0),
-- (172250, 3, -11296.927, -1764.5311, 101.00588, NULL, 0),
-- (172250, 4, -11258.901, -1722.3717, 101.00588, NULL, 0),
-- (172250, 5, -11176.764, -1809.5985, 101.00588, NULL, 0),
-- (172250, 6, -11191.107, -1889.3965, 107.89479, NULL, 0),
-- (172250, 7, -11152.18, -1863.318, 101.00588, NULL, 0),
-- (172250, 8, -11130.677, -1891.4235, 107.89634, NULL, 0),
-- (172250, 9, -11110.674, -1878.7712, 107.89686, NULL, 0);

-- Intro
DELETE FROM `waypoint_data` WHERE `id` = 172250;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(172250,  1, -11105.76,   -1875.8998,  158.97804,  NULL,  0,  2,  0,  100,  0),
(172250,  2, -11175.097,  -1857.2238,  101.00588,  NULL,  0,  2,  0,  100,  0),
(172250,  3, -11296.927,  -1764.5311,  101.00588,  NULL,  0,  2,  0,  100,  0),
(172250,  4, -11258.901,  -1722.3717,  101.00588,  NULL,  0,  2,  0,  100,  0),
(172250,  5, -11176.764,  -1809.5985,  101.00588,  NULL,  0,  2,  0,  100,  0),
(172250,  6, -11191.107,  -1889.3965,  107.89479,  NULL,  0,  2,  0,  100,  0),
(172250,  7, -11152.18,   -1863.318,   101.00588,  NULL,  0,  2,  0,  100,  0),
(172250,  8, -11130.677,  -1891.4235,  107.89634,  NULL,  0,  2,  0,  100,  0),
(172250,  9, -11110.674,  -1878.7712,  107.89686,  NULL,  0,  2,  0,  100,  0);

-- Landing East side circle and landing
DELETE FROM `waypoint_data` WHERE `id` = 172251;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(172251, 1, -11117.73, -1941.261, 127.172, NUll, 0, 2, 0, 100, 0),
(172251, 2, -11123.78, -1968.243, 125.922, NUll, 0, 2, 0, 100, 0),
(172251, 3, -11148.34, -1972.98, 116.6997, NUll, 0, 2, 0, 100, 0),
(172251, 4, -11161.62, -1945.725, 103.0886, NUll, 0, 2, 0, 100, 0),
(172251, 5, -11168.01, -1922.905, 97.39415, NUll, 0, 2, 0, 100, 0),
(172251, 6, -11162.23, -1900.329, 94.72747, NUll, 0, 2, 0, 100, 0);

-- Landing

-- Nightbane helper target
UPDATE `creature_template` SET `type_flags` = `type_flags` | 134217728, `movementId` = 1693, `ScriptName` = 'npc_nightbane_helper_target' WHERE (`entry` = 17260);

-- Remove extra helper on the roof
DELETE FROM `creature` WHERE `guid` = 135676;
