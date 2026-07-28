--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (63036, 64064) AND `ScriptName` IN ('spell_mimiron_summon_rocket_strike', 'spell_mimiron_rocket_strike_aura');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(63036, 'spell_mimiron_summon_rocket_strike'),
(64064, 'spell_mimiron_rocket_strike_aura');
