-- DB update 2025_09_23_01 -> 2025_09_23_02
--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (66050, 62062, 66052) AND `ScriptName` = 'spell_item_brewfest_hops';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(66050, 'spell_item_brewfest_hops'),
(62062, 'spell_item_brewfest_hops'),
(66052, 'spell_item_brewfest_hops');
