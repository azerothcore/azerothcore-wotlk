-- Remove Bone Shield spell script (double charge consumption bug)
DELETE FROM `spell_script_names` WHERE `spell_id` = 49222 AND `ScriptName` = 'spell_dk_bone_shield';
