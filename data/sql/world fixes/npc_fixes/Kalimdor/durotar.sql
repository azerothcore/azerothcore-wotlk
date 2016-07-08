
-- Orgrimmar Grunt (3296)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3296;
DELETE FROM smart_scripts WHERE entryorguid=3296 AND source_type=0;
INSERT INTO smart_scripts VALUES (3296, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 18950, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Grunt - On Reset - Cast Invisibility and Stealth Detection');
INSERT INTO smart_scripts VALUES (3296, 0, 2, 0, 0, 0, 100, 0, 3000, 13000, 9000, 15000, 11, 40505, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Grunt - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (3296, 0, 3, 10, 22, 1, 100, 0, 58, 0, 0, 0, 5, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Grunt - On Emote Received Kiss - Play Emote Bow');
INSERT INTO smart_scripts VALUES (3296, 0, 4, 10, 22, 1, 100, 0, 101, 0, 0, 0, 5, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Grunt - On Emote Received Wave - Play Emote Wave');
INSERT INTO smart_scripts VALUES (3296, 0, 5, 10, 22, 1, 100, 0, 78, 0, 0, 0, 5, 66, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Grunt - On Emote Received Salute - Play Emote Salute');
INSERT INTO smart_scripts VALUES (3296, 0, 6, 10, 22, 1, 100, 0, 84, 0, 0, 0, 5, 23, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Grunt - On Emote Received Shy - Play Emote Flex');
INSERT INTO smart_scripts VALUES (3296, 0, 7, 10, 22, 1, 100, 0, 77, 0, 0, 0, 5, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Grunt - On Emote Received Rude - Play Emote Point');
INSERT INTO smart_scripts VALUES (3296, 0, 8, 10, 22, 1, 100, 0, 22, 0, 0, 0, 5, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Grunt - On Emote Received Chicken - Play Emote Point');
INSERT INTO smart_scripts VALUES (3296, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Grunt - On Emote Received - Set Event Phase');
INSERT INTO smart_scripts VALUES (3296, 0, 11, 0, 60, 0, 100, 0, 5000, 5000, 5000, 5000, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Grunt - On Update - Set Event Phase');
INSERT INTO smart_scripts VALUES (3296, 0, 12, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Grunt - Between Health 0-30% - Cast Enrage');
INSERT INTO smart_scripts VALUES (3296, 0, 13, 0, 6, 0, 100, 0, 0, 0, 0, 0, 149, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Grunt - On Death - Send Zone Under Attack');
