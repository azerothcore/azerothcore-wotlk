-- DB update 2025_09_14_01 -> 2025_09_14_02

-- Remove WD and MT (Gjalerbron Prisoner)
UPDATE `creature` SET `wander_distance` = 0, `MovementType` = 0 WHERE (`id1` = 24035) AND (`guid` IN (117664, 117670, 117671, 117672, 117677, 117707));

-- Remove Wrong Movement Flag (Gjalerbron Prisoner)
UPDATE `creature_template_movement` SET `Swim` = 0 WHERE (`CreatureId` = 24035);

-- Set Emote State_Drowned and aura (Gjalerbron Prisoner)
DELETE FROM `creature_addon` WHERE (`guid` IN (117664, 117670, 117671, 117672, 117677));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(117664, 0, 0, 0, 0, 383, 0, '32566'),
(117670, 0, 0, 0, 0, 383, 0, '32566'),
(117671, 0, 0, 0, 0, 383, 0, '32566'),
(117672, 0, 0, 0, 0, 383, 0, '32566'),
(117677, 0, 0, 0, 0, 383, 0, '32566');

-- Add Extra Flag (Necrolords)
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |134217728 WHERE (`entry` = 24014);

-- Set Comments (Necrolords)
UPDATE `creature` SET `Comment` = 'Has Specific Guid SAI' WHERE (`id1` = 24014) AND (`guid` IN (115239, 115235, 115236, 115238));

-- Add missing spells (Necrolords)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24014;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24014);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24014, 0, 7, 0, 4, 0, 50, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Necrolord - On Aggro - Say Line 0 (No Repeat)'),
(24014, 0, 8, 0, 0, 0, 100, 0, 4000, 6000, 8000, 12000, 0, 0, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Necrolord - In Combat - Cast \'Shadow Bolt\''),
(24014, 0, 9, 0, 0, 0, 100, 0, 5000, 8000, 25000, 35000, 0, 0, 11, 18267, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Necrolord - In Combat - Cast \'Curse of Weakness\''),
(24014, 0, 10, 0, 0, 0, 100, 0, 8000, 12000, 8000, 12000, 0, 0, 11, 17173, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Necrolord - In Combat - Cast \'Drain Life\'');

-- Set Personal SmartAI (Necrolords)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (-115239, -115235, -115236, -115238));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-115239, 0, 0, 0, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 43151, 0, 0, 0, 0, 0, 10, 117664, 24035, 0, 0, 0, 0, 0, 0, 'Necrolord - Out of Combat - Cast \'Necrolord: Purple Beam\''),
(-115235, 0, 0, 0, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 43151, 0, 0, 0, 0, 0, 10, 117671, 24035, 0, 0, 0, 0, 0, 0, 'Necrolord - Out of Combat - Cast \'Necrolord: Purple Beam\''),
(-115236, 0, 0, 0, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 43151, 0, 0, 0, 0, 0, 10, 117672, 24035, 0, 0, 0, 0, 0, 0, 'Necrolord - Out of Combat - Cast \'Necrolord: Purple Beam\''),
(-115238, 0, 0, 0, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 43151, 0, 0, 0, 0, 0, 10, 117677, 24035, 0, 0, 0, 0, 0, 0, 'Necrolord - Out of Combat - Cast \'Necrolord: Purple Beam\'');
