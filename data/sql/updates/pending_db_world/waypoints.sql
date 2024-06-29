--
DELETE FROM `waypoint_data` WHERE `id` IN (2357601, 2357602, 2357603);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(2357601, 1, -52.642, 1419.357, 27.31, NULL, 0, 1, 0, 100, 0),
(2357602, 1, -69.908, 1419.721, 27.31, NULL, 0, 1, 0, 100, 0),
(2357602, 2, -79.929, 1395.958, 27.31, NULL, 0, 1, 0, 100, 0),
(2357602, 3, -80.072, 1374.555, 40.87, NULL, 0, 1, 0, 100, 0),
(2357603, 1, -80.072, 1314.398, 40.87, NULL, 0, 1, 0, 100, 0),
(2357603, 2, -80.072, 1295.775, 48.60, NULL, 0, 1, 0, 100, 0);

DELETE FROM `creature_text` WHERE `CreatureID` = 23576 AND `GroupID` IN (14, 15);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(23576, 14, 0, 'Mua-ha-ha!', 14, 0, 100, 0, 0, 0, 22145, 1, 'Nalorakk - RUN AWAY'),
(23576, 15, 0, '%s transforms into a bear!', 16, 0, 100, 0, 0, 0, 24263, 1, 'Nalorakk - EMOTE BEAR');
