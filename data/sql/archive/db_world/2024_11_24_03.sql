-- DB update 2024_11_24_02 -> 2024_11_24_03
--
-- IMMUNE_TO_PC
UPDATE `creature_template` SET `unit_flags` = `unit_flags` | 256 WHERE (`entry` = 24358);

-- purge old waypoints
DELETE FROM `waypoint_data` WHERE `id`=860442;
DELETE FROM `waypoint_data` WHERE `id`=860441;
DELETE FROM `waypoint_data` WHERE `id`=860440;

-- verify model 22340
UPDATE `creature_template_model` SET `VerifiedBuild` = 53788 WHERE (`CreatureID` = 24358) AND `Idx` = 0;

-- text
-- broadcast text still says three
UPDATE `creature_text` SET `Text`='Suit yourself. At least five of you must assist me if we\'re to get inside. Follow me....' WHERE `CreatureID`=24358 AND `GroupID`=0 AND `ID`=0;

-- to gong
DELETE FROM `waypoint_data` WHERE `id` = 2435800;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`) VALUES
(2435800, 1, 123.585014, 1646.5702, 42.208447, NULL, 0, 1),
(2435800, 2, 130.58502, 1644.0702, 42.208447, NULL, 0, 1),
(2435800, 3, 131.15666, 1643.7225, 42.18348, NULL, 0, 1);

-- to door
DELETE FROM `waypoint_data` WHERE `id` = 2435801;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`) VALUES
(2435801, 1, 126.804565, 1641.6201, 42.500977),
(2435801, 2, 121.95248, 1639.0178, 42.318478),
(2435801, 3, 120.78983, 1609.0632, 43.555756);

-- stealth
DELETE FROM `waypoint_data` WHERE `id` = 2435802;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`) VALUES
(2435802, 1, 120.59397, 1587.591, 43.74926);
