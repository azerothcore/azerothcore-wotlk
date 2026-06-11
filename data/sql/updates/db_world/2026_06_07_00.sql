-- DB update 2026_06_05_00 -> 2026_06_07_00
--
-- Fixes: https://github.com/azerothcore/azerothcore-wotlk/issues/26050
-- Sanctified Retribution / Swift Retribution should only apply their bonus
-- when the Paladin has an active aura.
--
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(63531, 'spell_pal_sanctified_retribution_aura');
