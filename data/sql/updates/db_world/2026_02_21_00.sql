-- DB update 2026_02_20_07 -> 2026_02_21_00
--
UPDATE `spell_script_names` SET `ScriptName` = 'spell_gluth_decimate' WHERE `spell_id` = 28374 AND `ScriptName` = 'spell_item_mad_alchemists_potion';

DELETE FROM `spell_script_names` WHERE `spell_id` = 45051;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(45051, 'spell_item_mad_alchemists_potion');
