-- DB update 2026_07_24_00 -> 2026_07_24_01
--
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_ulduar_random_aggro_periodic', 'spell_auriaya_feral_essence_removal', 'spell_auriaya_feral_rush');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(61906, 'spell_ulduar_random_aggro_periodic'),
(64456, 'spell_auriaya_feral_essence_removal'),
(64496, 'spell_auriaya_feral_rush'),
(64674, 'spell_auriaya_feral_rush');
