-- DB update 2026_03_26_01 -> 2026_03_27_00
-- Move Flexweave Underlay script from enchant application spell (55002) to parachute use-spell (55001)
DELETE FROM `spell_script_names` WHERE `spell_id` IN (55001, 55002) AND `ScriptName` = 'spell_item_flexweave_underlay';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (55001, 'spell_item_flexweave_underlay');
