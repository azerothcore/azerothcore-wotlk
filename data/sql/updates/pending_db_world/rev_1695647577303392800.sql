-- #12145 midsummer add spell script spell_midsummer_ribbon_pole_visual
DELETE FROM acore_world.spell_script_names WHERE spell_id = 29172;
INSERT INTO acore_world.spell_script_names (spell_id, ScriptName) VALUES
(29172, 'spell_midsummer_ribbon_pole_visual');
