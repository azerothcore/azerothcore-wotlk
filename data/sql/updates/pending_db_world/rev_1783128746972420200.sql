DELETE FROM `spell_script_names`
WHERE `spell_id` IN (28697, 28443);

INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`)
VALUES
    (28697, 'spell_forgiveess_dummy_visual'),
    (28443, 'spell_transform_ghost_visual');