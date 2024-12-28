-- DB update 2023_10_20_04 -> 2023_10_20_05
-- Morja
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 6227) AND (`SourceEntry` = 7401);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 6227, 7401, 0, 0, 8, 0, 7946, 0, 0, 0, 0, 0, '', 'Show gossip menu only if quest \'Spawn of Jubjub\' has been completed.');

DELETE FROM `npc_text` WHERE `ID`=7401;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`) VALUES
(7401, '', 'I\'m so happy that Jubjub returned!  I only hope that I don\'t run out of Dark Iron ale soon, or I fear my pet frog might once again escape!', 10169);

DELETE FROM `creature_text` WHERE `CreatureID`=14871;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(14871, 0, 0, 'Hi Jubjub.  I missed you!', 12, 0, 100, 0, 0, 0, 10170, 0, 'Morja - Jubjub Summon'),
(14871, 1, 0, 'Jubjub?  Where are you, Jubjub?  Oh no!  Where did you go this time!', 12, 0, 100, 0, 0, 0, 10171, 0, 'Morja - Jubjub Despawn');

DELETE FROM `gossip_menu` WHERE (`MenuID` = 6227) AND (`TextID` = 7401);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(6227, 7401);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14871;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 14871);
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1487100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14871, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Morja - On Respawn - Remove Npc Flags Questgiver'),
(14871, 0, 1, 0, 38, 0, 100, 0, 1, 1, 60000, 60000, 0, 0, 80, 1487100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Morja - On Data Set 1 1 - Run Script'),
(1487100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Morja - Actionlist - Say Line 0'),
(1487100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Morja - Actionlist - Add Npc Flags Questgiver'),
(1487100, 9, 2, 0, 0, 0, 100, 0, 60000, 60000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Morja - Actionlist - Say Line 1'),
(1487100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Morja - Actionlist - Remove Npc Flags Questgiver');

-- Dark Iron Ale
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 165578) AND (`source_type` = 1) AND (`id` IN (3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(165578, 1, 3, 0, 63, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 14871, 5, 0, 0, 0, 0, 0, 0, 'Dark Iron Ale Mug - On Just Created - Set Data to Morja');

DELETE FROM `spell_script_names` WHERE `spell_id`=23853 AND `ScriptName`='spell_gen_jubling_cooldown';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(23853, 'spell_gen_jubling_cooldown');
