-- DB update 2022_09_21_02 -> 2022_09_21_03
--
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_item_freeze_rookery_egg';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(15748, 'spell_item_freeze_rookery_egg'), -- item
(16028, 'spell_item_freeze_rookery_egg'); -- quest
