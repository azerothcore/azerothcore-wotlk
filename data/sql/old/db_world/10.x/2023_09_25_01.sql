-- DB update 2023_09_25_00 -> 2023_09_25_01
--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (67486, 67489, 67487, 67490);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(67486, 'spell_item_healing_injector'),
(67489, 'spell_item_healing_injector'),
(67487, 'spell_item_mana_injector'),
(67490, 'spell_item_mana_injector');
