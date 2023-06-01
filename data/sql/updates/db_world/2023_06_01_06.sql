-- DB update 2023_06_01_05 -> 2023_06_01_06
--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (34246, 60779) AND `ScriptName` = 'spell_dru_idol_lifebloom';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(34246, 'spell_dru_idol_lifebloom'),
(60779, 'spell_dru_idol_lifebloom');
