
-- Ravenclaw Regent (2283)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=2283;
DELETE FROM smart_scripts WHERE entryorguid=2283 AND source_type=0;
INSERT INTO smart_scripts VALUES (2283, 0, 0, 0, 0, 0, 100, 0, 2000, 4000, 14000, 20000, 11, 970, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Ravenclaw Regent - In Combat - Cast Shadow Word: Pain');
