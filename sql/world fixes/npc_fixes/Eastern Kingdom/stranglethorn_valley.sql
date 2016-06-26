
-- Booty Bay Bruiser (4624)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4624;
DELETE FROM smart_scripts WHERE entryorguid=4624 AND source_type=0;
INSERT INTO smart_scripts VALUES (4624, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 18950, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Booty Bay Bruiser - On Reset - Cast Invisibility and Stealth Detection');
INSERT INTO smart_scripts VALUES (4624, 0, 1, 0, 0, 0, 100, 0, 0, 3000, 15000, 20000, 11, 12024, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Booty Bay Bruiser - In Combat - Cast Net');
INSERT INTO smart_scripts VALUES (4624, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 149, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Booty Bay Bruiser - On Death - Send Zone Under Attack');
