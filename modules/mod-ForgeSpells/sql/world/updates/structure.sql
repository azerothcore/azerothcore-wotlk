-- Put only sql structure in this file (create table if exists, delete table, alter table etc...).
-- If you don't use this database, then delete this file.
-- Rogue Cleanup
DELETE FROM acore_world.spell_script_names 
WHERE ScriptName = 'spell_rog_sinister_echo'
OR ScriptName = 'spell_rog_sinister_echo'
OR ScriptName = 'spell_rog_sinister_wounds'
OR ScriptName = 'spell_rog_sinister_wounds_spell'
OR ScriptName = 'spell_rog_sinister_sting'
OR ScriptName = 'spell_rog_sinister_nimble_sin_strike'
OR ScriptName = 'spell_rog_sinister_invigorating_sin_strike'
OR ScriptName = 'spell_rog_roll_the_bones'
OR ScriptName = 'spell_rog_true_bearing'
OR ScriptName = 'spell_rog_skull_and_crossbones'
OR ScriptName = 'spell_rog_broadside'
OR ScriptName = 'spell_rog_dash_and_gash'
OR ScriptName = 'spell_rog_dash_and_gash_aura'
OR ScriptName = 'spell_rog_awe_and_inspire'
OR ScriptName = 'spell_rog_slice_and_dice'
OR ScriptName = 'spell_rog_always_ready'
OR ScriptName = 'spell_rog_pitch_correction';

-- Rogue Inserts
INSERT INTO acore_world.spell_script_names (spell_id, ScriptName) VALUES
    (1200000, 'spell_rog_sinister_echo'),
    (1200016, 'spell_rog_sinister_wounds'),
    (1200016, 'spell_rog_sinister_wounds_spell'),
    (1200040, 'spell_rog_sinister_sting'),
    (-1752, 'spell_rog_sinister_nimble_sin_strike'),
    (-1752, 'spell_rog_sinister_invigorating_sin_strike'),
    (1200000, 'spell_rog_sinister_nimble_sin_strike'),
    (1200000, 'spell_rog_sinister_invigorating_sin_strike'),
    (1200016, 'spell_rog_sinister_nimble_sin_strike'),
    (1200016, 'spell_rog_sinister_invigorating_sin_strike'),
    (1200039, 'spell_rog_sinister_nimble_sin_strike'),
    (1200039, 'spell_rog_sinister_invigorating_sin_strike'),
    (1200040, 'spell_rog_sinister_nimble_sin_strike'),
    (1200040, 'spell_rog_sinister_invigorating_sin_strike'),
    (1200051, 'spell_rog_roll_the_bones'),
    (1200087, 'spell_rog_true_bearing'),
    (1200086, 'spell_rog_skull_and_crossbones'),
    (1200060, 'spell_rog_broadside'),
    (1200092, 'spell_rog_dash_and_gash'),
    (1200092, 'spell_rog_dash_and_gash_aura'),
    (1200107, 'spell_rog_awe_and_inspire'),
    (-5171, 'spell_rog_slice_and_dice'),
    (1200051, 'spell_rog_slice_and_dice'),
    (1200092, 'spell_rog_slice_and_dice'),
    (1200107, 'spell_rog_slice_and_dice'),
    (1200119, 'spell_rog_slice_and_dice'),
    (1200140, 'spell_rog_always_ready'),
    (1200142, 'spell_rog_always_ready'),
    (1200149, 'spell_rog_pitch_correction');

-- Warrior Cleanup
DELETE FROM acore_world.spell_script_names 
WHERE ScriptName = 'spell_warr_sword_and_board'
OR ScriptName = 'spell_warr_trigger_sword_and_board'
OR ScriptName = 'spell_warr_heavy_shield_slam'
OR ScriptName = 'spell_warr_glad_shield_slam'
OR ScriptName = 'spell_warr_glad_stance'
OR ScriptName = 'spell_warr_glad_shield_slam_2'
OR ScriptName = 'spell_warrior_tearing_swipe'
OR ScriptName = 'spell_warr_devastating_reposte'
OR ScriptName = 'spell_warr_devastating_guard'
OR ScriptName = 'spell_warr_devastating_critical'
OR ScriptName = 'spell_warr_devastating_critical_aura'
OR ScriptName = 'spell_warr_attack_replacers'
OR ScriptName = 'spell_warr_devastating_resiliance'
OR ScriptName = 'spell_warr_devastate'
OR ScriptName = 'spell_warr_proc_family_flags_0'
OR ScriptName = 'spell_warr_glad_devastate'
OR ScriptName = 'spell_warr_glad_experience'
OR ScriptName = 'spell_warr_glad_focus'
OR ScriptName = 'spell_warr_fort_shield_block'
OR ScriptName = 'spell_warr_fort_shield_block_aura'
OR ScriptName = 'spell_warr_shield_strikes'
OR ScriptName = 'spell_warr_shield_strikes_aura'
OR ScriptName = 'spell_warr_shield_strike'
OR ScriptName = 'spell_warr_furious_strike'
OR ScriptName = 'spell_warr_taste_for_blood'
OR ScriptName = 'spell_warr_iron_will'
OR ScriptName = 'spell_warr_anger_management'
OR ScriptName = 'spell_warr_calculated_strikes'
OR ScriptName = 'spell_warr_weapon_specialization'
OR ScriptName = 'spell_warr_second_wind'
OR ScriptName = 'spell_warr_juggernaut'
OR ScriptName = 'spell_warr_tactician'
OR ScriptName = 'spell_sudden_death';

-- Warrior Inserts
INSERT INTO acore_world.spell_script_names (spell_id, ScriptName) VALUES
    (-46951, 'spell_warr_sword_and_board'),
    (-78, 'spell_warr_trigger_sword_and_board'),
    (-845, 'spell_warr_trigger_sword_and_board'),
    (-6343, 'spell_warr_trigger_sword_and_board'),
    (46968, 'spell_warr_trigger_sword_and_board'),
    (1120000, 'spell_warr_heavy_shield_slam'),
    (1120018, 'spell_warr_glad_shield_slam'),
    (1120038, 'spell_warr_glad_shield_slam'),
    (1120038, 'spell_warr_glad_shield_slam_2'),
    (1120042, 'spell_warrior_tearing_swipe'),
    (1120043, 'spell_warrior_tearing_swipe'),
    (1120045, 'spell_warr_devastating_reposte'),
    (1120048, 'spell_warr_devastating_guard'),
    (1120049, 'spell_warr_devastating_critical'),
    (1120051, 'spell_warr_devastating_critical'),
    (1120050, 'spell_warr_devastating_critical_aura'),
    (1120052, 'spell_warr_devastating_critical_aura'),
    (-78, 'spell_warr_attack_replacers'),
    (-845, 'spell_warr_attack_replacers'),
    (1120055, 'spell_warr_devastating_resiliance'),
    (-20243, 'spell_warr_devastate'),
    (1120070, 'spell_warr_devastate'),
    (1120047, 'spell_warr_proc_family_flags_0'),
    (1120058, 'spell_warr_proc_family_flags_0'),
    (1120060, 'spell_warr_proc_family_flags_0'),
    (1120062, 'spell_warr_proc_family_flags_0'),
    (1120072, 'spell_warr_proc_family_flags_0'),
    (1120073, 'spell_warr_proc_family_flags_0'),
    (1120074, 'spell_warr_proc_family_flags_0'),
    (1120075, 'spell_warr_proc_family_flags_0'),
    (1120076, 'spell_warr_proc_family_flags_0'),
    (1120070, 'spell_warr_glad_devastate'),
    (1120082, 'spell_warr_glad_focus'),
    (1120091, 'spell_warr_fort_shield_block'),
    (1120091, 'spell_warr_fort_shield_block_aura'),
    (1120118, 'spell_warr_shield_strikes'),
    (1120118, 'spell_warr_shield_strikes_aura'),
    (1120119, 'spell_warr_shield_strike'),
    (1120135, 'spell_warr_furious_strike'),
    (56636, 'spell_warr_taste_for_blood'),
    (-12300, 'spell_warr_iron_will'),
    (12296, 'spell_warr_anger_management'),
    (-1120158, 'spell_warr_calculated_strikes'),
    (-1120164, 'spell_warr_weapon_specialization'),
    (-29834, 'spell_warr_second_wind'),
    (-100, 'spell_warr_juggernaut'),
    (-3411, 'spell_warr_juggernaut'),
    (-20252, 'spell_warr_juggernaut'),
    (1120172, 'spell_warr_tactician'),
    (-29723, 'spell_sudden_death');
    
-- DK Cleanup
DELETE FROM acore_world.spell_script_names WHERE ScriptName LIKE '%dk_%_presence';
DELETE FROM acore_world.spell_script_names WHERE spell_id IN 
    (SELECT * FROM (SELECT spell_id FROM acore_world.spell_script_names WHERE ScriptName IN (
        'spell_dk_plague_scythe','spell_dk_deaths_embrace','spell_dk_festering_strike',
        'spell_dk_scent_of_blood_trigger','spell_dk_vengeance','spell_dk_corpse_explosion',
        'spell_dk_wandering_plague_aura','spell_dk_wandering_plague','spell_dk_scent_of_blood')) as A);

-- DK Inserts
INSERT INTO acore_world.spell_script_names
(spell_id, ScriptName)
VALUES  (-1159935, 'spell_dk_plague_scythe'), (-1159922, 'spell_dk_deaths_embrace'), (-1159900, 'spell_dk_festering_strike'), (-1150076, 'spell_dk_vengeance'),
        (-1150001, 'spell_dk_wandering_plague_aura'), (1150002, 'spell_dk_wandering_plague'), (1150081, 'spell_dk_scent_of_blood'),
        (-1150078, 'spell_dk_scent_of_blood_trigger'), (-1150078, 'spell_gen_proc_from_direct_damage'), (-1150030, 'spell_dk_corpse_explosion');