-- DB update 2022_08_09_00 -> 2022_08_10_00
--
DELETE FROM `spell_target_position` WHERE `ID` IN (720, 731, 1121, 518, 25831, 25832);
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`) VALUES
(720, 0, 531, -8043.6, 1254.1, -84.3, 0),
(731, 0, 531, -8003, 1222.9, -82.1, 0),
(1121, 0, 531, -8022.3, 1149, -89.1, 0),
(518, 0, 531, -8028.5, 1050.9, -54, 0),
(25831, 0, 531, -8158.03, 1139.3, -83.95, 0),
(25832, 0, 531, -8029.25, 1237.78, -85.2285, 0);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15630) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15630, 0, 0, 0, 0, 0, 100, 3, 10000, 20000, 0, 0, 0, 11, 26662, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Spawn of Fankriss - In Combat - Cast \'Berserk\' (No Repeat) (Normal Dungeon)');

DELETE FROM `creature_formations` WHERE `memberGUID` IN (87911, 87773, 87775, 87796, 87806, 87792);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(87911, 87911, 0, 0, 3, 0, 0),
(87911, 87773, 0, 0, 3, 0, 0),
(87911, 87775, 0, 0, 3, 0, 0),
(87911, 87796, 0, 0, 3, 0, 0),
(87911, 87806, 0, 0, 3, 0, 0),
(87911, 87792, 0, 0, 3, 0, 0);

DELETE FROM `linked_respawn` WHERE `guid` IN (87773, 87775, 87796, 87806, 87792);
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(87773, 87911, 0),
(87775, 87911, 0),
(87796, 87911, 0),
(87806, 87911, 0),
(87792, 87911, 0);
