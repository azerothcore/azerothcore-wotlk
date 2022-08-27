-- DB update 2022_07_26_01 -> 2022_07_26_02
--
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_moam_mana_drain_filter';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(25676, 'spell_moam_mana_drain_filter');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_moam_summon_mana_fiends';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(25684, 'spell_moam_summon_mana_fiends');

DELETE FROM `creature_text` WHERE `CreatureID` = 15340 AND `GroupID` = 2;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(15340, 2, 0, '%s drains your mana and turns to stone.', 16, 0, 100, 0, 0, 0, 11474, 0, 'moam EMOTE_STONE_PHASE');
