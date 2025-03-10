-- DB update 2025_02_19_00 -> 2025_02_19_01
-- Bjorn Halgurdsson - Set position
UPDATE `creature` SET `position_x` = 1518.61, `position_y` = -5249.85, `position_z` = 215.38, `orientation` = 5.41052, `VerifiedBuild` = 59069 WHERE `guid` = 112513 AND `id1` = 24238;

-- Bjorn Halgurdsson - Set speed_run
UPDATE `creature_template` SET `speed_run` = 1.7435 WHERE (`entry` = 24238);

-- Bjorn Halgurdsson - Set mount
DELETE FROM `creature_addon` WHERE (`guid` IN (112513));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(112513, 0, 22657, 0, 0, 0, 0, NULL);

-- Bjorn Halgurdsson - Set movement
UPDATE `creature_template_movement` SET `Swim` = 0, `Flight` = 0 WHERE (`CreatureId` = 24238);

-- Bjorn Halgurdsson - SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24238;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24238);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24238, 0, 0, 0, 1, 0, 100, 0, 10000, 15000, 45000, 60000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - Out of Combat - Say Line 2'),
(24238, 0, 1, 2, 8, 0, 100, 0, 43315, 0, 0, 0, 0, 0, 84, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On Spellhit \'Vrykul Insult\' - Say Line 0'),
(24238, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On Spellhit \'Vrykul Insult\' - Say Line 1'),
(24238, 0, 3, 4, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 43, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On Spellhit \'Vrykul Insult\' - Dismount'),
(24238, 0, 4, 5, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 207, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On Spellhit \'Vrykul Insult\' - Set hover 0'),
(24238, 0, 5, 6, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On Spellhit \'Vrykul Insult\' - Set Fly Off'),
(24238, 0, 6, 7, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On Spellhit \'Vrykul Insult\' - Set Reactstate Aggressive'),
(24238, 0, 7, 8, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 19, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On Spellhit \'Vrykul Insult\' - Remove Flags Not Attackable'),
(24238, 0, 8, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On Spellhit \'Vrykul Insult\' - Start Attacking'),
(24238, 0, 9, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 43371, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On Just Died - Cast \'Bjorn Kill Credit\''),
(24238, 0, 10, 0, 0, 0, 100, 0, 5000, 10000, 10000, 15000, 0, 0, 11, 32736, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - In Combat - Cast \'Mortal Strike\''),
(24238, 0, 11, 0, 0, 0, 100, 0, 0, 5000, 10000, 15000, 0, 0, 11, 33661, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - In Combat - Cast \'Crush Armor\''),
(24238, 0, 12, 13, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 60, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On Reset - Set Fly On'),
(24238, 0, 13, 14, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 207, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On Reset - Set hover 1'),
(24238, 0, 14, 15, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On Reset - Set Reactstate Passive'),
(24238, 0, 15, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 18, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On Reset - Set Flags Not Attackable');
