-- DB update 2023_01_07_00 -> 2023_01_07_01
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 47776 AND `ScriptName` = 'spell_item_worn_troll_dice';
INSERT INTO `spell_script_names` VALUES
(47776, 'spell_item_worn_troll_dice');
