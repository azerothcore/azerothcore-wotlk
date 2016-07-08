
-- Plagued Lands (2118)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=111148;
UPDATE creature_template SET minlevel=13, maxlevel=13, AIName='SmartAI', ScriptName='' WHERE entry=2164;
UPDATE creature_template SET minlevel=13, maxlevel=13, faction=35 WHERE entry=11836;
DELETE FROM smart_scripts WHERE entryorguid=2164 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=111148 AND source_type=1;
DELETE FROM smart_scripts WHERE entryorguid=2164*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (111148, 1, 0, 0, 60, 0, 100, 257, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Night Elven Bear Trap - On Update - Set Data closest Rabid Thistle Bear');
INSERT INTO smart_scripts VALUES (111148, 1, 1, 2, 60, 0, 100, 0, 500, 500, 1000, 1000, 100, 1, 0, 0, 0, 0, 0, 19, 2164, 5, 0, 0, 0, 0, 0, 'Night Elven Bear Trap - On Update - Send Target to Target');
INSERT INTO smart_scripts VALUES (111148, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 2164, 5, 0, 0, 0, 0, 0, 'Night Elven Bear Trap - On Update - Set Data closest Rabid Thistle Bear');
INSERT INTO smart_scripts VALUES (2164, 0, 1, 0, 38, 0, 100, 1, 1, 1, 0, 0, 80, 2164*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rabid Thistle Bear - On Data Set - Run Script');
INSERT INTO smart_scripts VALUES (2164*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rabid Thistle Bear - On Script - Set Home Position');
INSERT INTO smart_scripts VALUES (2164*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rabid Thistle Bear - On Script - Evade');
INSERT INTO smart_scripts VALUES (2164*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 33, 11836, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Rabid Thistle Bear - On Script - Kill Credit');
INSERT INTO smart_scripts VALUES (2164*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 29, 0, 180, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Rabid Thistle Bear - On Script - Follow Target');
INSERT INTO smart_scripts VALUES (2164*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 36, 11836, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rabid Thistle Bear - On Script - Change Entry to Captured Rabid Thistle Bear');
INSERT INTO smart_scripts VALUES (2164*100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 120000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rabid Thistle Bear - On Script - Despawn');
