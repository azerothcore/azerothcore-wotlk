-- DB update 2026_06_10_01 -> 2026_06_10_02
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 62976 AND `ScriptName` = 'spell_thorim_lightning_pillar_P2';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (62976, 'spell_thorim_lightning_pillar_P2');
