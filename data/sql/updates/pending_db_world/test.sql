USE testdb;
DELETE FROM creature_template WHERE entry = 1
INSERT INTO creature_template (entry, name, AIName, ScriptName, dynamicflags, unit_flags, type_flags, float_col, int_col, bool_col, mediumint_col) VALUES (1, 'Test', 'SmartAI', 'my_script', 123, 1, 2, 1.0 UNSIGNED, 1234567890, TRUE, 123);
UPDATE creature_template SET AIName = 'SmartAI', ScriptName = 'my_script', dynamicflags = 123, unit_flags = 1, type_flags = 2, name = 'Test', float_col = 1.0 UNSIGNED, int_col = 1234567890, bool_col = TRUE, mediumint_col = 123 WHERE entry = 1;;
CREATE TABLE creature_template (entry int(11), name VARCHAR(255) COLLATE latin1_swedish_ci, bool_col BOOL, mediumint_col MEDIUMINT, float_col FLOAT UNSIGNED, int_col INT(11), PRIMARY KEY (entry)) ENGINE=MyISAM CHARSET=latin1 ROW_FORMAT=COMPRESSED;