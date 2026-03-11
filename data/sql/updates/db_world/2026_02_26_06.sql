-- DB update 2026_02_26_05 -> 2026_02_26_06
-- Remove duplicate spell scripts that caused handlers to fire twice
DELETE FROM `spell_script_names` WHERE `spell_id` = 54937 AND `ScriptName` = 'spell_pal_glyph_of_holy_light_proc';
DELETE FROM `spell_script_names` WHERE `spell_id` = 41404 AND `ScriptName` = 'spell_black_temple_dementia_aura';
DELETE FROM `spell_script_names` WHERE `spell_id` = 64440 AND `ScriptName` = 'spell_item_blade_ward_enchant';
DELETE FROM `spell_script_names` WHERE `spell_id` = 37594 AND `ScriptName` = 'spell_pri_item_greater_heal_refund';
DELETE FROM `spell_script_names` WHERE `spell_id` = 69483 AND `ScriptName` = 'spell_icc_dark_reckoning_aura';
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_warl_demonic_pact_aura';
DELETE FROM `spell_script_names` WHERE `spell_id` = 72176 AND `ScriptName` = 'spell_deathbringer_blood_link_blood_beast_aura';
