-- Add Call of Beast SpellScript
DELETE FROM spell_script_names WHERE spell_id = 43359;
INSERT INTO spell_script_names (spell_id, ScriptName) VALUES (43359, 'spell_gen_call_of_the_beast');
