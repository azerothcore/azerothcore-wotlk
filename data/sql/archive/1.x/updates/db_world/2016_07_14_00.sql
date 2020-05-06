ALTER TABLE world_db_version CHANGE COLUMN 2016_07_10_02 2016_07_14_00 bit;

/* add spellscript for crow spell */
DELETE FROM spell_script_names WHERE spell_id = 38776;
INSERT INTO spell_script_names VALUES (38776,'spell_q9718_crow_transform');