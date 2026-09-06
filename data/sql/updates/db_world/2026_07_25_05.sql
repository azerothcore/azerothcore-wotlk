-- DB update 2026_07_25_04 -> 2026_07_25_05
--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (63510, 63514, 63531);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(63510, 'spell_pal_improved_concentraction_aura_effect'),
(63514, 'spell_pal_improved_devotion_aura_effect'),
(63531, 'spell_pal_sanctified_retribution_effect');
