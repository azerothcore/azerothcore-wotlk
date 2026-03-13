-- DB update 2026_02_28_03 -> 2026_02_28_04
-- Cold Blood: Bind AuraScript to prevent charge consumption on Mutilate MH/OH,
-- so both sub-spells get the guaranteed crit.
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_rog_cold_blood';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(14177, 'spell_rog_cold_blood');

-- Mutilate (parent): remove Cold Blood in AfterCast after both sub-spells
-- have executed their crit rolls.  Negative spell_id covers all ranks.
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_rog_mutilate', 'spell_rog_mutilate_strike');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-1329, 'spell_rog_mutilate');
