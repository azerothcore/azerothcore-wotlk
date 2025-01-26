-- Add spellscript for Vexallus Overload
DELETE FROM spell_script_names WHERE spell_id = 44352;
INSERT INTO spell_script_names (spell_id, ScriptName) VALUES 
(44352, 'spell_vexallus_overload');
