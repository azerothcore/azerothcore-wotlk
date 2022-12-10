-- DB update 2022_10_17_01 -> 2022_10_17_02
--
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_anubisath_mortal_strike', 'spell_mana_burn_area');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(9347, 'spell_anubisath_mortal_strike'),
(26626, 'spell_mana_burn_area');
