USE testdb
DELETE FROM creature_template WHERE entry = 1
INSERT INTO creature_template (entry, name, AIName, ScriptName, dynamicflags, unit_flags, type_flags) VALUES (1, 'Test', 'SmartAI', 'my_script', 123, 1, 2)
UPDATE creature_template SET AIName = 'SmartAI', ScriptName = 'my_script', dynamicflags = 123, unit_flags = 1, type_flags = 2, name = 'Test' WHERE entry = 1
CREATE TABLE creature_template (entry int, name VARCHAR(255), AIName VARCHAR(255), ScriptName VARCHAR(255), dynamicflags INT, unit_flags INT, type_flags INT, PRIMARY KEY (entry)) ENGINE=MyISAM CHARSET=latin1 ROW_FORMAT=COMPRESSED