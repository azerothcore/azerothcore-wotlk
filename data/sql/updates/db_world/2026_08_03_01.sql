-- DB update 2026_08_03_00 -> 2026_08_03_01
--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (64125, 64126) AND `ScriptName` = 'spell_yogg_saron_squeeze_aura';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(64125, 'spell_yogg_saron_squeeze_aura'),
(64126, 'spell_yogg_saron_squeeze_aura');
