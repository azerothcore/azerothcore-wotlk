-- DB update 2026_07_19_00 -> 2026_07_19_01
-- Mimiron Rocket Strike: spell-driven target selection (prefers ranged players)
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_mimiron_rocket_strike', 'spell_mimiron_rocket_strike_target_select');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(64402, 'spell_mimiron_rocket_strike'),
(65034, 'spell_mimiron_rocket_strike'),
(63681, 'spell_mimiron_rocket_strike_target_select');
