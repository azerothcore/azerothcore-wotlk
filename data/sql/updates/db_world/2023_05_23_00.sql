-- DB update 2023_05_21_02 -> 2023_05_23_00
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 30738 AND `ScriptName` = 'spell_blade_dance_targeting';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(30738, 'spell_blade_dance_targeting');

UPDATE `creature_template` SET `ScriptName` = 'npc_warchief_portal' WHERE `entry` = 17611;

DELETE FROM `creature_text` WHERE `CreatureID` = 16808 AND `GroupID` = 5;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(16808, 5, 0, 'Cowards! You\'ll never draw me into the shadows!', 14, 0, 100, 0, 0, 0, 18367, 0, 'kargath SAY_EVADE');
