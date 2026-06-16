-- Fixes: https://github.com/azerothcore/azerothcore-wotlk/issues/26050
-- Sanctified Retribution / Swift Retribution should only apply their bonus
-- when the Paladin has an active aura.
DELETE FROM `spell_script_names` WHERE `spell_id` = 63531 AND `ScriptName` = 'spell_pal_sanctified_retribution_aura';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(63531, 'spell_pal_sanctified_retribution_aura');
