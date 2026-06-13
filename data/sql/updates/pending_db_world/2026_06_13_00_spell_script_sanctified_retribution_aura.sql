-- DB update 2026_06_12_02 -> 2026_06_13_00
--
-- Fixes: https://github.com/azerothcore/azerothcore-wotlk/issues/26050
-- Sanctified Retribution / Swift Retribution (spell 63531) should only apply
-- their bonus to nearby allies when the Paladin has Retribution Aura active.
DELETE FROM `spell_script_names` WHERE `spell_id` = 63531 AND `ScriptName` = 'spell_pal_sanctified_retribution_aura';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(63531, 'spell_pal_sanctified_retribution_aura');
