-- Channel facing is now handled by the core. Remove bindings installed by the earlier branch revision.
DELETE FROM `spell_script_names` WHERE `spell_id` IN (38153, 38971) AND `ScriptName` = 'spell_gen_acid_geyser';
