-- DB update 2023_10_08_06 -> 2023_10_08_07
-- 64930 - Electrified | Shaman T8 Elemental 4P Bonus
DELETE FROM `spell_script_names` WHERE `spell_id` = 64928;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (64928, 'spell_sha_t8_electrified');
