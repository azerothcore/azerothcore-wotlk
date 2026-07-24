-- DB update 2025_10_09_03 -> 2025_10_09_04
DELETE FROM `spell_script_names` WHERE `spell_id` IN (37705, 60510);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(37705, 'spell_item_healing_trance'),
(60510, 'spell_item_healing_trance');
