-- DB update 2026_06_18_03 -> 2026_06_20_00
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 64132;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (64132, 'spell_yogg_saron_constrictor_tentacle_aura');
