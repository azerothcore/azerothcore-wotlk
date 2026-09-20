-- Dark Rune Sentinel - Heroic Strike: use the unscaled weapon damage bonus
DELETE FROM `spell_script_names` WHERE `spell_id` = 45026 AND `ScriptName` = 'spell_razorscale_dark_rune_sentinel_heroic_strike';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(45026, 'spell_razorscale_dark_rune_sentinel_heroic_strike');
