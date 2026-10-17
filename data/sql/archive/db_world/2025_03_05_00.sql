-- DB update 2025_03_03_01 -> 2025_03_05_00
--
DELETE FROM `spell_script_names` WHERE `spell_id`=63342;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (63342, 'spell_kologarn_focused_eyebeam');
