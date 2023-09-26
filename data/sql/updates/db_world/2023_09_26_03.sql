-- DB update 2023_09_26_02 -> 2023_09_26_03
--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (22486, 22487);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (22091, 22486, 22487);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(22091, 0, 0, 0, 0, 0, 100, 0, 0, 0, 3000, 3000, 0, 0, 11, 38296, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Spitfire Totem - In Combat - Cast Attack'),
(22091, 0, 1, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 9, 21965, 0, 100, 1, 0, 0, 0, 0, 'Spitfire Totem - On Death - Do Action on Fathom-Guard Tidalvess'),
(22486, 0, 0, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 223, 2, 0, 0, 0, 0, 0, 9, 21965, 0, 100, 1, 0, 0, 0, 0, 'Greater Earthbind Totem - On Death - Do Action on Fathom-Guard Tidalvess'),
(22487, 0, 0, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 223, 3, 0, 0, 0, 0, 0, 9, 21965, 0, 100, 1, 0, 0, 0, 0, 'Greater Poison Cleansing Totem - On Death - Do Action on Fathom-Guard Tidalvess');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (21964, 21965, 21966) AND `source_type` = 0;

UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_fathomguard_caribdis' WHERE `entry` = 21964;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_fathomguard_tidalvess' WHERE `entry` = 21965;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_fathomguard_sharkkis' WHERE `entry` = 21966;

DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (22091, 22486, 22487);
INSERT INTO `creature_template_movement` (`CreatureId`, `Flight`, `Rooted`) VALUES
(22091, 1, 1),
(22486, 1, 1),
(22487, 1, 1);
