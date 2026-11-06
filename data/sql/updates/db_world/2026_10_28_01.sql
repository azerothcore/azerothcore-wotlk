-- DB update 2026_10_28_00 -> 2026_10_28_01
--
-- Drop the `spell_war_sudden_death_aura` binding: its only handler was bound to the removed
-- `DoAfterCheckProc` hook, so the script no longer exists. `spell_warr_extra_proc` keeps its
-- own row on the same spell.
DELETE FROM `spell_script_names` WHERE `spell_id` = -29723 AND `ScriptName` = 'spell_war_sudden_death_aura';
