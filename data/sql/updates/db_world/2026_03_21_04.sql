-- DB update 2026_03_21_03 -> 2026_03_21_04
DELETE FROM `spell_script_names` WHERE `spell_id` = 55002;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (55002, 'spell_item_flexweave_underlay');
