-- DB update 2025_09_22_02 -> 2025_09_22_03
--
UPDATE `creature_template` SET `AIName` = 'SmartAI', `RegenHealth` = 0 WHERE `entry` = 30035;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 30035) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30035, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 142, 30, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fallen Earthen Defender - On Reset - Set HP to 30%');

DELETE FROM `creature_text` WHERE `CreatureID` = 30035;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(30035, 0, 0, 'Let me fight by your side.', 12, 0, 100, 0, 0, 30722, 0, 'Fallen Earthen Defender'),
(30035, 0, 1, 'Let us fight the irons together!', 12, 0, 100, 0, 0, 30723, 0, 'Fallen Earthen Defender'),
(30035, 0, 2, 'Thank you. I thought I was doomed.', 12, 0, 100, 0, 0, 30720, 0, 'Fallen Earthen Defender'),
(30035, 0, 3, 'I was certain I was going to die out here.', 12, 0, 100, 0, 0, 30721, 0, 'Fallen Earthen Defender');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_q12937_relief_for_the_fallen';
INSERT INTO `spell_script_names` VALUES
(59557, 'spell_q12937_relief_for_the_fallen');
