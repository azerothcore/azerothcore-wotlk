-- DB update 2023_01_29_01 -> 2023_01_29_02
--
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_rog_pickpocket';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(921,'spell_rog_pickpocket');
