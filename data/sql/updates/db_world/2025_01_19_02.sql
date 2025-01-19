-- DB update 2025_01_19_01 -> 2025_01_19_02
-- Ashbringer is buff
DELETE
FROM `spell_custom_attr`
WHERE `spell_id` = 28282;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (28282, 67108864);

-- It takes time to open the door with a key in Blizzard servers
UPDATE `gameobject_template_addon` SET `flags` = `flags`|2|32
WHERE (`entry` = 104591);

-- Clientside area trigger 4089 smart ai
SET @ENTRY := 4089;
DELETE FROM `areatrigger_scripts` WHERE `entry` = @ENTRY;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (@ENTRY, 'SmartTrigger');
DELETE FROM `smart_scripts` WHERE `source_type` = 2 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 2, 0, 1, 46, 0, 100, 1, 0, 0, 0, 0, 0, 0, 64, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On trigger - Self: storedTarget[0] = Triggering player'),
(@ENTRY, 2, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 34, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On trigger - Set instance data #2 to 1'),
(@ENTRY, 2, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 10, 40029, 3976, 0, 0, 0, 0, 0, 'On trigger - Send stored target storedTarget[0] to Creature Scarlet Commander Mograine (3976) with guid 40029 (fetching)'),
(@ENTRY, 2, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, 40029, 3976, 0, 0, 0, 0, 0, 'On trigger - Creature Scarlet Commander Mograine (3976) with guid 40029 (fetching): Set creature data #0 to 1');
-- smart conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = @ENTRY AND `SourceId` = 2;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(22, 1, @ENTRY, 2, 0, 1, 0, 28282, 0, 0, 0, 'Action invoker has aura of spell Ashbringer (28282), effect EFFECT_0'),
(22, 1, @ENTRY, 2, 0, 13, 0, 2, 0, 0, 0, 'instance data 2 equals 0');

-- Scarlet Commander Mograine smart ai

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 3976;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 3976);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3976, 0, 0, 0, 38, 0, 100, 0, 0, 1, 0, 0, 0, 0, 1, 6, 0, 1, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Data Set 0 1 - Say Line 6'),
(3976, 0, 1, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 11, 8990, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - In Combat - Cast \'Retribution Aura\' (No Repeat)'),
(3976, 0, 2, 0, 0, 0, 100, 1, 1000, 1000, 0, 0, 0, 0, 34, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - In Combat - Set Instance Data 1 to 1 (No Repeat)'),
(3976, 0, 3, 0, 0, 0, 100, 0, 1000, 5000, 10000, 10000, 0, 0, 11, 14518, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - In Combat - Cast \'Crusader Strike\''),
(3976, 0, 4, 0, 0, 0, 100, 0, 6000, 11000, 60000, 60000, 0, 0, 11, 5589, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - In Combat - Cast \'Hammer of Justice\''),
(3976, 0, 5, 6, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Respawn - Set Active Off'),
(3976, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Respawn - Remove Flags Not Selectable'),
(3976, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Respawn - Set Reactstate Aggressive'),
(3976, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Respawn - Remove FlagStandstate Dead'),
(3976, 0, 9, 10, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Aggro - Set Invincibility Hp 1'),
(3976, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Aggro - Say Line 0'),
(3976, 0, 11, 12, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 212, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Evade - Stop motion (StopMoving: 0, MovementExpired: 0)'),
(3976, 0, 12, 13, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 96, 32, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Evade - Remove Dynamic Flags Dead'),
(3976, 0, 13, 14, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 34, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Evade - Set Instance Data 1 to 2'),
(3976, 0, 14, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Evade - Remove Flags Not Selectable'),
(3976, 0, 15, 0, 5, 0, 100, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Killed Unit - Say Line 1'),
(3976, 0, 16, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 34, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Just Died - Set Instance Data 1 to 3'),
(3976, 0, 17, 0, 2, 0, 100, 1, 0, 1, 0, 0, 0, 0, 80, 397600, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - Between 0-1% Health - Run Script (No Repeat)'),
(3976, 0, 18, 0, 8, 1, 100, 512, 9232, 0, 0, 0, 0, 0, 80, 397601, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Spellhit \'Scarlet Resurrection\' - Run Script (Phase 1)'),
(3976, 0, 19, 20, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 42, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Reached Point 1 - Reset Invincibility Hp'),
(3976, 0, 20, 21, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Reached Point 1 - Remove Flags Not Selectable'),
(3976, 0, 21, 22, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Reached Point 1 - Set Reactstate Aggressive'),
(3976, 0, 22, 23, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 8990, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Reached Point 1 - Cast \'Retribution Aura\''),
(3976, 0, 23, 24, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 20, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Reached Point 1 - Start Attacking'),
(3976, 0, 24, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Reached Point 1 - Start Attacking'),
(3976, 0, 25, 0, 8, 0, 100, 1, 28441, 0, 0, 0, 0, 0, 80, 397602, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Spellhit \'AB Effect 000\' - Run Script (No Repeat)'),
(3976, 0, 26, 0, 8, 0, 100, 1, 28441, 0, 0, 0, 0, 0, 67, 1, 20, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Spellhit \'AB Effect 000\' - Create Timed Event (No Repeat)'),
(3976, 0, 27, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 12, 16062, 8, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1033.46, 1399.1, 27.3374, 6.25796, 'Scarlet Commander Mograine - On Timed Event 1 Triggered - Summon Creature \'Highlord Mograine\''),
(3976, 0, 28, 0, 8, 0, 100, 0, 28697, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Spellhit \'Forgiveness\' - Kill Self');

-- Scarlet Commander Mograine suspended animation
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 397600);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(397600, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 224, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - Actionlist - Stop Attack'),
(397600, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, 39946, 3977, 0, 0, 0, 0, 0, 0, 'Creature High Inquisitor Whitemane (3977) with guid 39946 (fetching): Set creature data #0 to 1'),
(397600, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 212, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - Actionlist - Stop motion (StopMoving: 0, MovementExpired: 1)'),
(397600, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 89, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - Actionlist - Start Random Movement'),
(397600, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 4, 1326, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - Actionlist - Play Sound 1326'),
(397600, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 8990, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - Actionlist - Remove Aura \'Retribution Aura\''),
(397600, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - Actionlist - Set Flag Standstate Dead'),
(397600, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - Actionlist - Set Flags Not Selectable'),
(397600, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - Actionlist - Set Reactstate Passive'),
(397600, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - Actionlist - Set Event Phase 1');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 397601);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(397601, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - Actionlist - Set Reactstate Passive'),
(397601, 9, 1, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - Actionlist - Remove FlagStandstate Dead'),
(397601, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 9257, 0, 0, 0, 0, 0, 10, 39946, 3977, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - Actionlist - Cast \'Lay on Hands\''),
(397601, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 1, 2, 0, 1, 0, 0, 0, 10, 39946, 3977, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - Actionlist - Say Line 2'),
(397601, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 10, 39946, 3977, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - Actionlist - Move To Closest Creature \'High Inquisitor Whitemane\'');

-- Scarlet Commander Mograine Ashbringer Event
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 397602);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(397602, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - Actionlist - Set Active On'),
(397602, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - Actionlist - Set Faction 35'),
(397602, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 89, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - Actionlist - Start Random Movement'),
(397602, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - Actionlist - Set Orientation Invoker'),
(397602, 9, 4, 0, 0, 0, 100, 0, 1000, 3000, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - Actionlist - Set Flag Standstate Kneel'),
(397602, 9, 5, 0, 0, 0, 100, 0, 1000, 2000, 0, 0, 0, 0, 1, 3, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - Actionlist - Say Line 3');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 3976 AND `SourceId` = 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(22, 1, 3976, 0, 0, 21, 1, 16384, 0, 0, 1, 'Object doesn\'t have unit state UNIT_STATE_ATTACK_PLAYER'),
(22, 1, 3976, 0, 0, 36, 1, 0, 0, 0, 0, 'Object is alive'),
(22, 3, 3976, 0, 0, 4, 1, 796, 0, 0, 0, 'Object in zone (796)'),
(22, 18, 3976, 0, 0, 4, 1, 796, 0, 0, 0, 'Object in zone (796)'),
(22, 19, 3976, 0, 0, 4, 1, 796, 0, 0, 0, 'Object in zone (796)'),
(22, 26, 3976, 0, 0, 4, 1, 796, 0, 0, 0, 'Object in zone (796)'),
(22, 26, 3976, 0, 0, 36, 1, 0, 0, 0, 0, 'Object is alive'),
(22, 27, 3976, 0, 0, 4, 1, 796, 0, 0, 0, 'Object in zone (796)'),
(22, 27, 3976, 0, 0, 36, 1, 0, 0, 0, 0, 'Object is alive');

-- Scarlet Commander Mograine say
DELETE FROM `creature_text` WHERE `CreatureID` = 3976;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(3976, 0, 0, 'Infidels! They must be purified!', 14, 0, 100, 0, 0, 5835, 2847, 0, 'Scarlet Commander Mograine // mograine SAY_MO_AGGRO'),
(3976, 1, 0, 'Unworthy.', 14, 0, 100, 0, 0, 5836, 6197, 0, 'Scarlet Commander Mograine // mograine SAY_MO_KILL'),
(3976, 2, 0, 'At your side, milady!', 14, 0, 100, 15, 0, 5837, 18026, 0, 'Scarlet Commander Mograine // mograine SAY_MO_RESSURECTED'),
(3976, 3, 0, 'You hold my father\'s blade, $n. My soldiers are yours TO control, my $g Lord:Lady;. Take them... LEAD them... The impure must be purged. They must be cleansed of their taint.', 12, 0, 100, 1, 0, 0, 12390, 0, 'Scarlet Commander Mograine // mograine SAY_ASHBRINGER_ONE'),
(3976, 4, 0, 'Father... But... How?', 12, 0, 100, 6, 0, 0, 12470, 0, 'Scarlet Commander Mograine // mograine SAY_ASHBRINGER_TWO'),
(3976, 5, 0, 'Forgive me, father! Please...', 12, 0, 100, 20, 0, 0, 12472, 0, 'Scarlet Commander Mograine // mograine SAY_ASHBRINGER_THREE'),
(3976, 6, 0, 'Bow down! Kneel BEFORE the Ashbringer! A NEW dawn approaches, brothers AND sisters! Our message will be delivered TO the filth of this world through the chosen one!', 14, 0, 100, 0, 0, 0, 12389, 3, 'Scarlet Commander Mograine // Ashbringer EVENT intro yell');

-- Highlord Mograine smart_scripts

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 16062;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 16062);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16062, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Mograine - On Just Summoned - Set Active On'),
(16062, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Mograine - On Just Summoned - Set Faction 35'),
(16062, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 71, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Mograine - On Just Summoned - Change Equipment'),
(16062, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 0, 16180, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Mograine - On Just Summoned - Morph To Model 16180'),
(16062, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 28688, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Mograine - On Just Summoned - Cast \'Mograine Cometh DND\''),
(16062, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 16062, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Mograine - On Just Summoned - Start Waypoint Path 16062'),
(16062, 0, 6, 7, 40, 0, 100, 0, 12, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 3976, 0, 0, 0, 0, 0, 0, 0, 'Highlord Mograine - On Point 12 of Path Any Reached - Set Orientation Closest Creature \'Scarlet Commander Mograine\''),
(16062, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 1606200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Mograine - On Point 12 of Path Any Reached - Run Script');

-- Highlord Mograine Ashbringer Event

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1606200);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1606200, 9, 0, 0, 0, 0, 100, 0, 200, 200, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Mograine - Actionlist - Say Line 0'),
(1606200, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 231, 2, 0, 0, 0, 0, 0, 19, 3976, 5, 0, 0, 0, 0, 0, 0, 'Closest alive creature Scarlet Commander Mograine (3976) in 5 yards: - Actionlist - Set Target Orientation'),
(1606200, 9, 2, 0, 0, 0, 100, 0, 400, 400, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 19, 3976, 5, 0, 0, 0, 0, 0, 0, 'Closest alive creature Scarlet Commander Mograine (3976) in 5 yards: - Actionlist - Remove FlagStandstate Kneel'),
(1606200, 9, 3, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 19, 3976, 5, 0, 0, 0, 0, 0, 0, 'Highlord Mograine - Actionlist - Say Line 4'),
(1606200, 9, 4, 0, 0, 0, 100, 0, 4600, 4600, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Mograine - Actionlist - Say Line 1'),
(1606200, 9, 5, 0, 0, 0, 100, 0, 3400, 3400, 0, 0, 0, 0, 5, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Mograine - Actionlist - Play Emote 6'),
(1606200, 9, 6, 0, 0, 0, 100, 0, 3200, 3200, 0, 0, 0, 0, 5, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Mograine - Actionlist - Play Emote 25'),
(1606200, 9, 7, 0, 0, 0, 100, 0, 3200, 3200, 0, 0, 0, 0, 5, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Mograine - Actionlist - Play Emote 15'),
(1606200, 9, 8, 0, 0, 0, 100, 0, 3200, 3200, 0, 0, 0, 0, 231, 2, 0, 0, 0, 0, 0, 19, 3976, 5, 0, 0, 0, 0, 0, 0, 'Closest alive creature Scarlet Commander Mograine (3976) in 5 yards: - Actionlist - Set Target Orientation'),
(1606200, 9, 9, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 19, 3976, 5, 0, 0, 0, 0, 0, 0, 'Closest alive creature Scarlet Commander Mograine (3976) in 5 yards: - Actionlist - Say Line 5'),
(1606200, 9, 10, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 11, 28697, 0, 0, 0, 0, 0, 19, 3976, 10, 0, 0, 0, 0, 0, 0, 'Highlord Mograine - Actionlist - Cast \'Forgiveness\''),
(1606200, 9, 11, 0, 0, 0, 100, 0, 3700, 3700, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Mograine - Actionlist - Say Line 2'),
(1606200, 9, 12, 0, 0, 0, 100, 0, 3400, 3400, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Mograine - Actionlist - Despawn Instant');

-- Highlord Mograine Say
DELETE FROM `creature_text` WHERE `CreatureID`=16062;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `Type`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(16062, 0, 0, 'Renault...', 0, 100, 25, 0, 0, 12, 12469, 0, 'mograine MOGRAINE_ONE'),
(16062, 1, 0, 'Did you think that your betrayal would be forgotten? Lost in the carefully planned cover up of my death? Blood of my blood, the blade felt your cruelty long after my heart had stopped beating. And in death, I knew what you had done. But now, the chains of Kel\'thuzad hold me NO more. I come TO serve justice. I AM ASHBRINGER.', 0, 100, 6, 0, 0, 12, 12471, 0, 'mograine MOGRAINE_TWO'),
(16062, 2, 0, 'You are forgiven...', 0, 100, 0, 0, 0, 12, 12473, 0, 'mograine MOGRAINE_THREE');

DELETE
FROM `waypoints`
WHERE `entry`=16062;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(16062, 1, 1033.4642, 1399.1022, 27.337427, NULL, 0, 'Ashbringer Event Move Points'),
(16062, 2, 1034.9252, 1399.0653, 27.393204, NULL, 0, 'Ashbringer Event Move Points'),
(16062, 3, 1036.3861, 1399.0284, 27.44898, NULL, 0, 'Ashbringer Event Move Points'),
(16062, 4, 1045.484, 1398.7991, 27.448977, NULL, 0, 'Ashbringer Event Move Points'),
(16062, 5, 1059.524, 1399.0273, 28.271557, NULL, 0, 'Ashbringer Event Move Points'),
(16062, 6, 1068.8096, 1399.2064, 30.7867, NULL, 0, 'Ashbringer Event Move Points'),
(16062, 7, 1086.6564, 1399.2048, 30.44898, NULL, 0, 'Ashbringer Event Move Points'),
(16062, 8, 1101.5681, 1399.3694, 30.485447, NULL, 0, 'Ashbringer Event Move Points'),
(16062, 9, 1116.6019, 1399.4752, 30.485447, NULL, 0, 'Ashbringer Event Move Points'),
(16062, 10, 1129.5881, 1399.2926, 30.524086, NULL, 0, 'Ashbringer Event Move Points'),
(16062, 11, 1149.4045, 1399.0231, 32.528877, NULL, 0, 'Ashbringer Event Move Points'),
(16062, 12, 1150.3911, 1398.723, 32.54613, NULL, 0, 'Ashbringer Event Move Points');

-- Highlord Mograine Condition
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 8990) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 16062) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 8990, 0, 0, 31, 0, 3, 16062, 0, 1, 0, 0, '', 'Potential target of the spell is not creature, entry is 16062');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 1) AND (`SourceEntry` = 16062) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 4) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 796) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 16062, 0, 0, 4, 1, 796, 0, 0, 0, 0, 0, '', 'Object in zone (796)');

-- High Inquisitor Whitemane Smart ai
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 3977;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 3977);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3977, 0, 0, 1, 38, 0, 100, 0, 0, 1, 0, 0, 0, 0, 118, 2, 0, 0, 0, 0, 0, 14, 11877, 104600, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - On Data Set 0 1 - Set GO State To 2'),
(3977, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - On Data Set 0 1 - Say Line 0'),
(3977, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 10, 40029, 3976, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - On Data Set 0 1 - Move To Closest Creature \'Scarlet Commander Mograine\''),
(3977, 0, 3, 4, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - On Aggro - Set Invincibility Hp 1'),
(3977, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - On Aggro - Set Event Phase 1'),
(3977, 0, 5, 0, 0, 3, 100, 0, 1000, 1000, 2600, 4000, 0, 0, 11, 9481, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - In Combat - Cast \'Holy Smite\' (Phases 1 & 2)'),
(3977, 0, 6, 0, 16, 3, 100, 0, 22187, 40, 5000, 10000, 1, 0, 11, 22187, 32, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - On Friendly Unit Missing Buff \'Power Word: Shield\' - Cast \'Power Word: Shield\' (Phases 1 & 2)'),
(3977, 0, 7, 0, 0, 2, 100, 0, 45000, 45000, 20000, 30000, 0, 0, 11, 14515, 64, 0, 0, 0, 0, 6, 20, 1, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - In Combat - Cast \'Dominate Mind\' (Phase 2)'),
(3977, 0, 8, 0, 74, 2, 100, 0, 5000, 15000, 5000, 15000, 75, 40, 11, 12039, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - On Friendly Below 75% Health - Cast \'Heal\' (Phase 2)'),
(3977, 0, 9, 0, 5, 0, 100, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - On Killed Unit - Say Line 1'),
(3977, 0, 10, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 118, 1, 0, 0, 0, 0, 0, 14, 11877, 104600, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - On Respawn - Set GO State To 1'),
(3977, 0, 11, 12, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - On Evade - Set Reactstate Aggressive'),
(3977, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 34, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - On Evade - Set Instance Data 1 to 2'),
(3977, 0, 13, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 34, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - On Just Died - Set Instance Data 1 to 3'),
(3977, 0, 14, 15, 2, 0, 100, 513, 0, 50, 0, 0, 0, 0, 80, 397700, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - Between 0-50% Health - Run Script (No Repeat)'),
(3977, 0, 15, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - Between 0-50% Health - Set Event Phase 1 (No Repeat)'),
(3977, 0, 16, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 67, 1, 200, 200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - On Data Set 1 1 - Create Timed Event'),
(3977, 0, 17, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 80, 397701, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - On Timed Event 1 Triggered - Run Script'),
(3977, 0, 18, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 69, 2, 0, 0, 2, 0, 0, 10, 40029, 3976, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - On Data Set 1 1 - Move To Closest Creature \'Scarlet Commander Mograine\''),
(3977, 0, 19, 0, 34, 0, 100, 512, 8, 2, 0, 0, 0, 0, 80, 397701, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - On Reached Point 2 - Run Script');

-- Health less than 50% Hypnotize the player
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 397700);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(397700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 224, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - Actionlist - Stop Attack'),
(397700, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - Actionlist - Set Event Phase 0'),
(397700, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - Actionlist - Set Reactstate Passive'),
(397700, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 9256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - Actionlist - Cast \'Deep Sleep\''),
(397700, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'After 0 seconds - Self: Set data[1] to 1');

-- Resurrect Mograini
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 397701);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(397701, 9, 0, 0, 0, 0, 100, 0, 4500, 4500, 0, 0, 0, 0, 11, 9232, 0, 0, 0, 0, 0, 19, 3976, 50, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - Actionlist - Cast \'Scarlet Resurrection\''),
(397701, 9, 1, 0, 0, 0, 100, 0, 1900, 1900, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - Actionlist - Say Line 2'),
(397701, 9, 2, 0, 0, 0, 100, 0, 1400, 1400, 0, 0, 0, 0, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - Actionlist - Set Sheath Unarmed'),
(397701, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 5, 66, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - Actionlist - Play Emote 66'),
(397701, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 42, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - Actionlist - Reset Invincibility Hp'),
(397701, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - Actionlist - Set Reactstate Aggressive'),
(397701, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - Actionlist - Set Event Phase 2'),
(397701, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - Actionlist - Start Attacking');

-- High Inquisitor Whitemane say

DELETE FROM `creature_text` WHERE `CreatureID` = 3977;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(3977, 0, 0, 'Mograine has fallen! You shall pay for this treachery! Arise, my champion! Arise!', 14, 0, 100, 0, 0, 5838, 18023, 0, 'High Inquisitor Whitemane // whitemane SAY_WH_INTRO'),
(3977, 1, 0, 'The Light has spoken!', 14, 0, 100, 0, 0, 5839, 6198, 0, 'High Inquisitor Whitemane // whitemane SAY_WH_KILL'),
(3977, 2, 0, 'Arise, my champion!', 14, 0, 100, 0, 0, 5840, 6532, 0, 'High Inquisitor Whitemane // whitemane SAY_WH_RESSURECT');

-- High Inquisitor Whitemane Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 3977 AND `SourceId` = 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(22, 17, 3977, 0, 0, 29, 1, 3976, 5, 0, 0, 'There is creature Scarlet Commander Mograine (3976) within range 5 yards to Object'),
(22, 19, 3977, 0, 0, 29, 1, 3976, 5, 0, 1, 'There is no creature Scarlet Commander Mograine (3976) within range 5 yards to Object');

-- High Inquisitor Fairbanks smart ai

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 4542;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 4542) AND (`source_type` = 0) AND (`id` IN (11));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4542, 0, 11, 0, 8, 0, 100, 1, 28441, 0, 0, 0, 0, 0, 80, 454205, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Fairbanks - On Spellhit \'AB Effect 000\' - Run Script (No Repeat)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 454205);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(454205, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Fairbanks - Actionlist - Set Faction 35'),
(454205, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Fairbanks - Actionlist - Set Orientation Invoker'),
(454205, 9, 2, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 11, 28443, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Fairbanks - Actionlist - Cast \'Transform Ghost\''),
(454205, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 0, 16179, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Fairbanks - Actionlist - Morph To Model 16179'),
(454205, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Fairbanks - Actionlist - Add Npc Flags Gossip');
