
-- Chicken (620)
DELETE FROM creature_text WHERE entry=620;
INSERT INTO creature_text VALUES (620, 0, 0, '%s looks up at you quizzically. Maybe you should inspect it?', 16, 0, 100, 0, 0, 0, 0, 'cluck EMOTE_A_HELLO');
INSERT INTO creature_text VALUES (620, 1, 0, '%s looks at you unexpectadly.', 16, 0, 100, 0, 0, 0, 0, 'cluck EMOTE_H_HELLO');
INSERT INTO creature_text VALUES (620, 2, 0, '%s starts pecking at the feed.', 16, 0, 100, 0, 0, 0, 0, 'cluck EMOTE_CLUCK_TEXT2');

-- Generic Fix for mana burn spells
UPDATE smart_scripts SET target_type=5, target_param1=30, target_param3=1 WHERE action_param1 IN(22947, 13321, 8129, 14033, 2691, 11981, 15785, 17630, 17615, 34931, 15980, 22936, 54338, 28301, 8211, 34930);

-- Generic Fix for Thrash spell in SAI
UPDATE smart_scripts SET event_type=25, event_chance=100, event_flags=0, event_param1=0, event_param2=0, event_param3=0, event_param4=0, action_param1=8876, action_param2=0, target_type=1 WHERE action_type=11 AND action_param1=3391;

-- Scrapbot (29561)
UPDATE creature_template SET faction=35 WHERE entry=29561;

-- Doomguard (11859)
UPDATE creature_template SET exp=2, spell1=89, spell2=19482, spell3=15090, spell4=19474, AIName='SmartAI', ScriptName='' WHERE entry=11859;
DELETE FROM smart_scripts WHERE entryorguid=11859 AND source_type=0;
INSERT INTO smart_scripts VALUES (11859, 0, 0, 0, 0, 0, 100, 0, 1000, 10000, 30000, 30000, 11, 89, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Doomguard - In Combat - Cast Cripple');
INSERT INTO smart_scripts VALUES (11859, 0, 1, 0, 9, 0, 100, 0, 0, 5, 25000, 30000, 11, 19482, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doomguard - Within Range 0-5yd - Cast War Stomp');
INSERT INTO smart_scripts VALUES (11859, 0, 2, 0, 0, 0, 100, 0, 1000, 10000, 15000, 30000, 11, 21949, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Doomguard - In Combat - Cast Rend');
INSERT INTO smart_scripts VALUES (11859, 0, 3, 0, 0, 0, 100, 0, 8000, 15000, 15000, 30000, 11, 19474, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Doomguard - In Combat - Cast Rain of Fire');

-- Steam Burst (26043)
UPDATE creature_template SET AIName='NullCreatureAI', ScriptName='' WHERE entry=26043;
DELETE FROM smart_scripts WHERE entryorguid=26043 AND source_type=0;
