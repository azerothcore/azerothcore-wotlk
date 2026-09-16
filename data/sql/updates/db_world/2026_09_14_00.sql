-- DB update 2026_09_13_00 -> 2026_09_14_00
--
-- 62207's force-cast effect has no MaxAffectedTargets, so it dropped a beam under every player
-- within 100y. The script caps it the way 62450 already is.
DELETE FROM `spell_script_names` WHERE `spell_id` = 62207;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(62207, 'spell_freya_brightleaf_unstable_sun_beam');
