-- DB update 2025_06_15_02 -> 2025_06_16_00
--
DELETE FROM `spell_script_names` WHERE `spell_id`=60244 AND `ScriptName`='spell_item_bloodsail_admiral_hat';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (60244, 'spell_item_bloodsail_admiral_hat');
