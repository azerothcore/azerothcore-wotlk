-- DB update 2023_09_25_08 -> 2023_09_26_00
--
DELETE FROM `spell_script_names` WHERE `spell_id`= -24604 AND `ScriptName` = 'spell_hun_furious_howl';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(-24604, 'spell_hun_furious_howl');

DELETE FROM `spell_dbc` WHERE `ID` IN (24604, 64491, 64492, 64493, 64494, 64495, 53434);
