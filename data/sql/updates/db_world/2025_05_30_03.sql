-- DB update 2025_05_30_02 -> 2025_05_30_03
--
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=-61874 AND `spell_effect`=24870;
DELETE FROM `spell_script_names` WHERE `spell_id`=61874 AND `ScriptName`='spell_item_noblegarden_chocolate';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (61874, 'spell_item_noblegarden_chocolate');
