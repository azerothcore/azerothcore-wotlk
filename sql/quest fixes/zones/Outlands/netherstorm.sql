
-- Dr. Boom! (10221)
UPDATE creature_template SET unit_flags=unit_flags|4, AIName='SmartAI', ScriptName=''WHERE entry=20284;
DELETE FROM smart_scripts WHERE entryorguid=20284 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(20284*100+0, 20284*100+1) AND source_type=9;
INSERT INTO smart_scripts VALUES (20284, 0, 0, 0, 60, 0, 100, 0, 0, 0, 500, 1000, 87, 20284*100+0, 20284*100+1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dr. Boom - On Update - Run Script');
INSERT INTO smart_scripts VALUES (20284, 0, 1, 0, 9, 0, 100, 0, 0, 15, 3000, 3000, 11, 35276, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dr. Boom - Within Range 0-15yd - Throw Dynamite');
INSERT INTO smart_scripts VALUES (20284*100+0, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 35128, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dr. Boom - On Script - Cast Summon Boom Bot');
INSERT INTO smart_scripts VALUES (20284*100+1, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 35130, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dr. Boom - On Script - Cast Summon Boom Bot');
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=19692);
DELETE FROM creature WHERE id=19692;
UPDATE creature_template SET unit_flags=unit_flags|131072, AIName='SmartAI', ScriptName=''WHERE entry=19692;
DELETE FROM smart_scripts WHERE entryorguid=19692 AND source_type=0;
INSERT INTO smart_scripts VALUES (19692, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Boom Bot - On AI Init - Set React Passive');
INSERT INTO smart_scripts VALUES (19692, 0, 1, 0, 60, 0, 100, 257, 3000, 3000, 0, 0, 69, 1, 0, 0, 0, 0, 0, 11, 20392, 30, 0, 0, 0, 0, 0, 'Boom Bot - On Update - Move To Position');
INSERT INTO smart_scripts VALUES (19692, 0, 2, 0, 60, 0, 100, 0, 0, 0, 500, 500, 49, 1, 0, 0, 0, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 'Boom Bot - On Update - Attack Start');
INSERT INTO smart_scripts VALUES (19692, 0, 3, 5, 0, 0, 100, 1, 0, 0, 0, 0, 11, 35132, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Boom Bot - In Combat - Cast Boom');
INSERT INTO smart_scripts VALUES (19692, 0, 4, 5, 34, 0, 100, 1, 8, 1, 0, 0, 11, 35132, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Boom Bot - Movement Inform - Cast Boom');
INSERT INTO smart_scripts VALUES (19692, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 400, 400, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Boom Bot - Linked - Create Timed Event');
INSERT INTO smart_scripts VALUES (19692, 0, 6, 7, 59, 0, 100, 0, 1, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Boom Bot - On Timed Event - Die');
INSERT INTO smart_scripts VALUES (19692, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Boom Bot - On Timed Event - Despawn');

-- Fel Reavers, No Thanks! (10855)
DELETE FROM creature_text WHERE entry=22293;
INSERT INTO creature_text VALUES(22293, 0, 0, '%s begins to sputter as its engine malfunctions.', 16, 0, 100, 0, 0, 0, 0, 'Inactive Fel Reaver');
UPDATE creature_template SET AIName='SmartAI', ScriptName=''WHERE entry=22293;
DELETE FROM smart_scripts WHERE entryorguid=22293 AND source_type=0;
REPLACE INTO smart_scripts VALUES (22293, 0, 0, 1, 20, 0, 100, 0, 10850, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Inactive Fel Reaver - On Quest Reward - Store Target');
REPLACE INTO smart_scripts VALUES (22293, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Inactive Fel Reaver - On Quest Reward - Say Line 0');
REPLACE INTO smart_scripts VALUES (22293, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 89, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Inactive Fel Reaver - On Quest Reward - Move Random');
REPLACE INTO smart_scripts VALUES (22293, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 8000, 8000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Inactive Fel Reaver - On Quest Reward - Create Timed Event');
REPLACE INTO smart_scripts VALUES (22293, 0, 4, 5, 59, 0, 100, 0, 1, 0, 0, 0, 15, 10855, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Inactive Fel Reaver - On Timed Event - Quest Complete');
REPLACE INTO smart_scripts VALUES (22293, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 33, 22293, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Inactive Fel Reaver - On Timed Event - Kill Credit');
REPLACE INTO smart_scripts VALUES (22293, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Inactive Fel Reaver - On Timed Event - Die');

-- Creatures of the Eco-Domes (10427)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=35771;
INSERT INTO conditions VALUES (17, 0, 35771, 0, 0, 31, 1, 3, 20610, 0, 0, 0, 0, '', 'Requires Talbuk Doe');
INSERT INTO conditions VALUES (17, 0, 35771, 0, 0, 1, 1, 42386, 0, 0, 1, 0, 0, '', 'Requires No Sleeping Aura');
INSERT INTO conditions VALUES (17, 0, 35771, 0, 1, 31, 1, 3, 20777, 0, 0, 0, 0, '', 'Requires Talbuk Sire');
INSERT INTO conditions VALUES (17, 0, 35771, 0, 1, 1, 1, 42386, 0, 0, 1, 0, 0, '', 'Requires No Sleeping Aura');
DELETE FROM creature_text WHERE entry IN(20610, 20777);
INSERT INTO creature_text VALUES(20610, 0, 0, '%s seams to have weakened.', 16, 0, 100, 0, 0, 0, 0, 'Talbuk Doe');
INSERT INTO creature_text VALUES(20777, 0, 0, '%s seams to have weakened.', 16, 0, 100, 0, 0, 0, 0, 'Talbuk Sire');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(20610, 20777);
DELETE FROM smart_scripts WHERE entryorguid IN(20610, 20777) AND source_type=0;
INSERT INTO smart_scripts VALUES (20610, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 19, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - On Reset - Remove Unit Flags');
INSERT INTO smart_scripts VALUES (20610, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - On Reset - Remove Bytes0');
INSERT INTO smart_scripts VALUES (20610, 0, 2, 0, 0, 0, 100, 0, 2000, 6000, 15000, 22000, 11, 32019, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - In Combat - Cast Gore');
INSERT INTO smart_scripts VALUES (20610, 0, 3, 0, 2, 0, 100, 1, 0, 20, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - Between Health 0-20% - Say Line 0');
INSERT INTO smart_scripts VALUES (20610, 0, 4, 5, 8, 0, 100, 0, 35771, 0, 0, 0, 33, 20982, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - On Spell Hit - Kill Credit');
INSERT INTO smart_scripts VALUES (20610, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 11, 42386, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - On Spell Hit - Cast Sleeping Sleep');
INSERT INTO smart_scripts VALUES (20610, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - On Spell Hit - Despawn');
INSERT INTO smart_scripts VALUES (20610, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 18, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - On Spell Hit - Set Unit Flags');
INSERT INTO smart_scripts VALUES (20610, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - On Spell Hit - Set Bytes0');
INSERT INTO smart_scripts VALUES (20777, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 19, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Sire - On Reset - Remove Unit Flags');
INSERT INTO smart_scripts VALUES (20777, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Sire - On Reset - Remove Bytes0');
INSERT INTO smart_scripts VALUES (20777, 0, 2, 0, 0, 0, 100, 0, 2000, 9000, 12000, 17000, 11, 32023, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Sire - In Combat - Cast Hoof Stomp');
INSERT INTO smart_scripts VALUES (20777, 0, 3, 0, 2, 0, 100, 1, 0, 20, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Sire - Between Health 0-20% - Say Line 0');
INSERT INTO smart_scripts VALUES (20777, 0, 4, 5, 8, 0, 100, 0, 35771, 0, 0, 0, 33, 20982, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Sire - On Spell Hit - Kill Credit');
INSERT INTO smart_scripts VALUES (20777, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 11, 42386, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Sire - On Spell Hit - Cast Sleeping Sleep');
INSERT INTO smart_scripts VALUES (20777, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Sire - On Spell Hit - Despawn');
INSERT INTO smart_scripts VALUES (20777, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 18, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Sire - On Spell Hit - Set Unit Flags');
INSERT INTO smart_scripts VALUES (20777, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Sire - On Spell Hit - Set Bytes0');

-- When the Cows Come Home (10337)
DELETE FROM creature_text WHERE entry=20415;
INSERT INTO creature_text VALUES(20415, 0, 0, 'Mooooo...', 12, 0, 100, 0, 0, 0, 0, 'Bessy');
INSERT INTO creature_text VALUES(20415, 1, 0, 'Moooooooooo!', 12, 0, 100, 0, 0, 0, 0, 'Bessy');

-- Building a Perimeter (10240)
DELETE FROM smart_scripts WHERE entryorguid IN(19866, 19867, 19868) AND source_type=0;
INSERT INTO smart_scripts VALUES (19866, 0, 0, 1, 8, 0, 100, 0, 34646, 0, 0, 0, 33, 19866, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Invis East KV Rune - On Spell Hit - Kill Monster Credit');
INSERT INTO smart_scripts VALUES (19866, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 20, 183947, 10, 0, 0, 0, 0, 0, 'Invis East KV Rune - On Spell Hit - Set Loot State');
INSERT INTO smart_scripts VALUES (19866, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 50, 183948, 180, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Invis East KV Rune - On Spell Hit - Summon Gameobject');
INSERT INTO smart_scripts VALUES (19867, 0, 0, 1, 8, 0, 100, 0, 34646, 0, 0, 0, 33, 19867, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Invis NE KV Rune - On Spell Hit - Kill Monster Credit');
INSERT INTO smart_scripts VALUES (19867, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 20, 183947, 10, 0, 0, 0, 0, 0, 'Invis NE KV Rune - On Spell Hit - Set Loot State');
INSERT INTO smart_scripts VALUES (19867, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 50, 183948, 180, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Invis NE KV Rune - On Spell Hit - Summon Gameobject');
INSERT INTO smart_scripts VALUES (19868, 0, 0, 1, 8, 0, 100, 0, 34646, 0, 0, 0, 33, 19868, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Invis West KV Rune - On Spell Hit - Kill Monster Credit');
INSERT INTO smart_scripts VALUES (19868, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 20, 183947, 10, 0, 0, 0, 0, 0, 'Invis West KV Rune - On Spell Hit - Set Loot State');
INSERT INTO smart_scripts VALUES (19868, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 50, 183948, 180, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Invis West KV Rune - On Spell Hit - Summon Gameobject');

-- Electro-Shock Goodness! (10411)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=35686;
INSERT INTO conditions VALUES (17, 0, 35686, 0, 0, 31, 1, 3, 20778, 0, 0, 0, 0, '', 'Requires Void Waste');
INSERT INTO conditions VALUES (17, 0, 35686, 0, 1, 31, 1, 3, 20501, 0, 0, 0, 0, '', 'Requires Seeping Sludge');
DELETE FROM creature_text WHERE entry IN(20778, 20501);
INSERT INTO creature_text VALUES(20778, 0, 0, '%s breaks down into globules!', 16, 0, 100, 0, 0, 0, 0, 'Void Waste');
INSERT INTO creature_text VALUES(20501, 0, 0, '%s breaks down into globules!', 16, 0, 100, 0, 0, 0, 0, 'Seeping Sludge');
INSERT INTO creature_text VALUES(20501, 1, 0, '%s attempts to split in two!', 16, 0, 100, 0, 0, 0, 0, 'Seeping Sludge');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(20778, 20501, 20805, 20806, 21264);
DELETE FROM smart_scripts WHERE entryorguid IN(20778, 20501, 20805, 20806, 21264) AND source_type=0;
INSERT INTO smart_scripts VALUES (20778, 0, 0, 0, 0, 0, 100, 0, 3000, 10000, 19000, 30000, 11, 36519, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Void Waste - In Combat - Cast Toxic Burst');
INSERT INTO smart_scripts VALUES (20778, 0, 1, 2, 8, 0, 100, 0, 35686, 0, 0, 0, 11, 35688, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Void Waste - On Spell Hit - Cast Summon Void Waste Globule');
INSERT INTO smart_scripts VALUES (20778, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Void Waste - On Spell Hit - Say Line 0');
INSERT INTO smart_scripts VALUES (20778, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Void Waste - On Spell Hit - Die');
INSERT INTO smart_scripts VALUES (20501, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, 35242, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Seeping Sludge - On Respawn - Cast Darkstalker Birth');
INSERT INTO smart_scripts VALUES (20501, 0, 1, 2, 2, 0, 50, 1, 0, 30, 0, 0, 11, 36465, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Seeping Sludge - Between Health 0-30% - Cast Seeping Split');
INSERT INTO smart_scripts VALUES (20501, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Seeping Sludge - Between Health 0-30% - Say Line 1');
INSERT INTO smart_scripts VALUES (20501, 0, 3, 0, 17, 0, 100, 1, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Seeping Sludge - Just Summoned - Despawn');
INSERT INTO smart_scripts VALUES (20501, 0, 4, 5, 8, 0, 100, 0, 35686, 0, 0, 0, 11, 35687, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Seeping Sludge - On Spell Hit - Cast Summon Seeping Sludge Globule');
INSERT INTO smart_scripts VALUES (20501, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Seeping Sludge - On Spell Hit - Say Line 0');
INSERT INTO smart_scripts VALUES (20501, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Seeping Sludge - On Spell Hit - Die');
INSERT INTO smart_scripts VALUES (21264, 0, 0, 0, 1, 0, 100, 257, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Seeping Ooze - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (21264, 0, 1, 0, 1, 0, 100, 257, 10000, 10000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Seeping Ooze - Out of Combat - Despawn');
INSERT INTO smart_scripts VALUES (20805, 0, 0, 0, 1, 0, 100, 257, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Void Waste Globule - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (20805, 0, 1, 0, 1, 0, 100, 257, 10000, 10000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Void Waste Globule - Out of Combat - Despawn');
INSERT INTO smart_scripts VALUES (20806, 0, 0, 0, 1, 0, 100, 257, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Seeping Sludge Globule - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (20806, 0, 1, 0, 1, 0, 100, 257, 10000, 10000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Seeping Sludge Globule - Out of Combat - Despawn');

-- On Nethery Wings (10438)
UPDATE gameobject_template SET data1=90 WHERE entry=184643;
UPDATE creature_template SET unit_flags=unit_flags|4, AIName='SmartAI', ScriptName='' WHERE entry=20899;
DELETE FROM smart_scripts WHERE entryorguid=20899 AND source_type=0;
INSERT INTO smart_scripts VALUES (20899, 0, 0, 1, 8, 0, 100, 0, 35734, 0, 0, 0, 33, 20899, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Void Conduit - On Spell Hit - Kill Credit');
INSERT INTO smart_scripts VALUES (20899, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 10, 69964, 19554, 1, 0, 0, 0, 0, 'Void Conduit - On Spell Hit - Say Line 0 Target');
INSERT INTO smart_scripts VALUES (20899, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Void Conduit - On Spell Hit - Die');

-- Dimensius the All-Devouring (10439)
DELETE FROM creature_text WHERE entry IN(19554, 20985, 21780);
INSERT INTO creature_text VALUES(19554, 0, 0, 'You only hasten the inevitable. In time, all will be devoured!', 14, 0, 100, 0, 0, 0, 1, 'Dimensius the All-Devouring');
INSERT INTO creature_text VALUES(19554, 1, 0, 'Time only has meaning to mortals, insect. Dimensius is infinite!', 14, 0, 100, 0, 0, 0, 0, 'Dimensius the All-Devouring');
INSERT INTO creature_text VALUES(20985, 0, 0, 'You heard the fleshling! MOVE OUT!', 12, 0, 100, 15, 0, 0, 0, 'Captain Saeed');
INSERT INTO creature_text VALUES(20985, 1, 0, 'Tell me when you are ready. We will attack on your command.', 12, 0, 100, 0, 0, 0, 0, 'Captain Saeed');
INSERT INTO creature_text VALUES(20985, 2, 0, 'It''s now or never, soldiers! Let''s do this! For K''aresh! For the Protectorate!', 12, 0, 100, 0, 0, 0, 0, 'Captain Saeed');
INSERT INTO creature_text VALUES(20985, 3, 0, 'The time for your destruction has finally come, Dimensius!', 12, 0, 100, 0, 0, 0, 0, 'Captain Saeed');
INSERT INTO creature_text VALUES(21780, 0, 0, '%s begins channeling power into Dimensius.', 16, 0, 100, 0, 0, 0, 0, 'Spawn of Dimensius');
DELETE FROM spell_script_names WHERE spell_id=36500;
INSERT INTO spell_script_names VALUES(36500, 'spell_gen_throw_back');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(21805, 20984);
UPDATE creature_template SET unit_flags=unit_flags|4, AIName='SmartAI', ScriptName='' WHERE entry=21780;
DELETE FROM smart_scripts WHERE entryorguid IN(21805, 20984, 21780) AND source_type=0;
INSERT INTO smart_scripts VALUES(21805, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 3000, 4000, 11, 36500, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Protectorate Avenger - In Combat - Cast Glaive');
INSERT INTO smart_scripts VALUES(20984, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 3000, 4000, 11, 36500, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Protectorate Defender - In Combat - Cast Glaive');
INSERT INTO smart_scripts VALUES(20984, 0, 1, 0, 0, 0, 100, 0, 5000, 10000, 10000, 20000, 11, 31553, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Protectorate Defender - In Combat - Cast Hamstring');
INSERT INTO smart_scripts VALUES(21780, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spawn of Dimensius - On AI Init - Set React Passive');
INSERT INTO smart_scripts VALUES(21780, 0, 1, 2, 60, 0, 100, 257, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 100, 0, 0, 0, 0, 0, 0, 'Spawn of Dimensius - On Update - Attack Start');
INSERT INTO smart_scripts VALUES(21780, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 11, 37450, 2, 0, 0, 0, 0, 19, 19554, 50, 0, 0, 0, 0, 0, 'Spawn of Dimensius - On Update - Cast Dimensius Feeding');
INSERT INTO smart_scripts VALUES(21780, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spawn of Dimensius - On Update - Say Line 0');
UPDATE creature_model_info SET combat_reach=7 WHERE modelid=18988;
UPDATE creature SET id=19554 WHERE id=21035;
UPDATE creature_template SET unit_flags=unit_flags|4, AIName='NullCreatureAI', ScriptName='' WHERE entry=21035;
UPDATE creature_template SET unit_flags=unit_flags|4, AIName='SmartAI', ScriptName='' WHERE entry=19554;
UPDATE creature_template SET AIName='', ScriptName='npc_captain_saeed' WHERE entry=20985;
DELETE FROM smart_scripts WHERE entryorguid IN(19554, 21035) AND source_type=0;
INSERT INTO smart_scripts VALUES(19554, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 35939, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dimensius the All-Devouring - On Reset - Cast Dimensius Transform');
INSERT INTO smart_scripts VALUES(19554, 0, 1, 0, 0, 0, 100, 0, 3000, 4000, 7000, 10000, 11, 37500, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dimensius the All-Devouring - In Combat - Cast Shadow Spiral');
INSERT INTO smart_scripts VALUES(19554, 0, 2, 0, 0, 0, 100, 0, 5000, 7000, 10000, 16000, 11, 37412, 0, 0, 0, 0, 0, 5, 50, 1, 0, 0, 0, 0, 0, 'Dimensius the All-Devouring - In Combat - Cast Shadow Vault');
INSERT INTO smart_scripts VALUES(19554, 0, 3, 4, 2, 0, 100, 1, 0, 75, 0, 0, 12, 21780, 4, 30000, 0, 0, 0, 1, 0, 0, 0, 28, 0, 0, 0, 'Dimensius the All-Devouring - Between Health 0-75% - Summon Creature');
INSERT INTO smart_scripts VALUES(19554, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 12, 21780, 4, 30000, 0, 0, 0, 1, 0, 0, 0, -28, 0, 0, 0, 'Dimensius the All-Devouring - Between Health 0-75% - Summon Creature');
INSERT INTO smart_scripts VALUES(19554, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 12, 21780, 4, 30000, 0, 0, 0, 1, 0, 0, 0, 0, 28, 0, 0, 'Dimensius the All-Devouring - Between Health 0-75% - Summon Creature');
INSERT INTO smart_scripts VALUES(19554, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 12, 21780, 4, 30000, 0, 0, 0, 1, 0, 0, 0, 0, -28, 0, 0, 'Dimensius the All-Devouring - Between Health 0-75% - Summon Creature');
DELETE FROM script_waypoint WHERE entry=20985;
INSERT INTO script_waypoint VALUES (20985, 1, 4254.23, 2108.69, 144.247, 0, "");
INSERT INTO script_waypoint VALUES (20985, 2, 4239.06, 2114.86, 146.952, 0, "");
INSERT INTO script_waypoint VALUES (20985, 3, 4225.45, 2118.14, 152.244, 0, "");
INSERT INTO script_waypoint VALUES (20985, 4, 4211.32, 2107.93, 156.698, 0, "");
INSERT INTO script_waypoint VALUES (20985, 5, 4206.56, 2104.48, 160.319, 0, "");
INSERT INTO script_waypoint VALUES (20985, 6, 4178.02, 2075.21, 163.157, 0, "");
INSERT INTO script_waypoint VALUES (20985, 7, 4175.38, 2061.21, 167.984, 0, "");
INSERT INTO script_waypoint VALUES (20985, 8, 4188.63, 2023.8, 184.663, 0, "");
INSERT INTO script_waypoint VALUES (20985, 9, 4173.8, 1993.33, 204.116, 0, "");
INSERT INTO script_waypoint VALUES (20985, 10, 4142.52, 1973.01, 218.002, 0, "");
INSERT INTO script_waypoint VALUES (20985, 11, 4101.52, 2007.56, 230.967, 0, "");
INSERT INTO script_waypoint VALUES (20985, 12, 4092.63, 2026.51, 236.429, 0, "");
INSERT INTO script_waypoint VALUES (20985, 13, 4059.49, 2060.78, 250.161, 0, "");
INSERT INTO script_waypoint VALUES (20985, 14, 4032.52, 2077.06, 254.449, 0, "");
INSERT INTO script_waypoint VALUES (20985, 15, 4001.34, 2099.2, 254.212, 0, "");
INSERT INTO script_waypoint VALUES (20985, 16, 3993.95, 2090.21, 254.32, 0, "");
INSERT INTO script_waypoint VALUES (20985, 17, 3989.37, 2083.43, 256.391, 0, "");
INSERT INTO script_waypoint VALUES (20985, 18, 3951.24, 2024.99, 257.005, 0, "");
INSERT INTO script_waypoint VALUES (20985, 19, 3936.40, 2003.0, 255.68, 0, "");

-- Shutting Down Manaforge Ara (10365)
DELETE FROM creature_text WHERE entry=20460;
INSERT INTO creature_text VALUES(20460, 0, 0, 'You will not shut my manaforge down, scum!', 14, 0, 100, 0, 0, 0, 0, 'Chief Engineer Gork lonn');
DELETE FROM smart_scripts WHERE entryorguid=20460 AND source_type=0;
INSERT INTO smart_scripts VALUES (20460, 0, 0, 0, 38, 2, 100, 0, 1, 1, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Chief Engineer Gork lonn - On Data Set - Attack Stored Target');
INSERT INTO smart_scripts VALUES (20460, 0, 1, 2, 7, 2, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 20, 184312, 0, 0, 0, 0, 0, 0, 'Chief Engineer Gork lonn - On Evade - Set Data');
INSERT INTO smart_scripts VALUES (20460, 0, 2, 0, 61, 2, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chief Engineer Gork lonn - On Evade - Despawn');
INSERT INTO smart_scripts VALUES (20460, 0, 3, 0, 54, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chief Engineer Gork lonn - On Just Summoned - Set Phase 2');
INSERT INTO smart_scripts VALUES (20460, 0, 4, 0, 1, 2, 100, 0, 1000, 1000, 1000, 1000, 49, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Chief Engineer Gork lonn - OOC - Attack');
INSERT INTO smart_scripts VALUES (20460, 0, 5, 0, 60, 0, 100, 257, 1000, 1000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chief Engineer Gork lonn - On Update - Say Line 0');

-- Triangulation Point One (10269)
REPLACE INTO creature_template_addon VALUES (20086, 0, 0, 0, 0, 0, '34840 34832');

-- Triangulation Point Two (10275)
REPLACE INTO creature_template_addon VALUES (20114, 0, 0, 0, 0, 0, '34858 34832');
DELETE FROM creature WHERE id=20114;
INSERT INTO creature VALUES (NULL, 20114, 530, 1, 1, 0, 0, 3928.46, 3878.84, 177.011, 5.79697, 300, 0, 0, 6722, 0, 0, 0, 0, 0);

-- Securing the Celestial Ridge (10274)
DELETE FROM event_scripts WHERE id=12925;
INSERT INTO event_scripts VALUES (12925, 0, 10, 18544, 3000000, 0, 3780.22, 1458.31, -149.97, 0.0);
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18544;
DELETE FROM smart_scripts WHERE entryorguid=18544 AND source_type=0;
INSERT INTO smart_scripts VALUES (18544, 0, 0, 0, 1, 0, 100, 257, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 3832.74, 1448.12, -138.4, 0, 'Veraku - Out of Combat - Move To Position');

-- Troublesome Distractions (10273)
DELETE FROM creature_text WHERE entry IN(20071, 20101);
INSERT INTO creature_text VALUES(20071, 0, 0, 'Let us hold our discussion in a more... private place. Follow me, $N.', 12, 0, 100, 0, 0, 0, 0, 'Wind Trader Marid');
INSERT INTO creature_text VALUES(20071, 1, 0, 'You didn''t really think I''d do business with you again, did you? Sometimes, the best way to return to profitability is to know when to cut your losses.', 12, 0, 100, 0, 0, 0, 0, 'Wind Trader Marid');
INSERT INTO creature_text VALUES(20101, 0, 0, 'What have the netherwinds brought us?', 12, 0, 100, 0, 0, 0, 0, 'Nether-Stalker');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=8071;
INSERT INTO conditions VALUES (15, 8071, 0, 0, 0, 9, 0, 10273, 0, 0, 0, 0, 0, '', 'Troublesome Distractions');
UPDATE creature_template SET faction=14, AIName='SmartAI', ScriptName='' WHERE entry=20101;
UPDATE creature_template SET speed_walk=1.5, gossip_menu_id=8071, AIName="SmartAI" WHERE entry=20071;
DELETE FROM gossip_menu_option WHERE menu_id=8071;
INSERT INTO gossip_menu_option VALUES(8071, 0, 0, 'Wind Trader Marid, I''ve returned with more information on the nether drakes. I''m prepared to be your business partner, and for an extra sum, I''ll take care of that troublesome elf and her human friend.', 1, 1, 0, 0, 0, 0, '');
DELETE FROM smart_scripts WHERE entryorguid IN(20071, 20101) AND source_type=0;
INSERT INTO smart_scripts VALUES (20071, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wind Trader Marid - On Reset - Set Unit Flags');
INSERT INTO smart_scripts VALUES (20071, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 81, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wind Trader Marid - On Reset - Set NPC Flags');
INSERT INTO smart_scripts VALUES (20071, 0, 2, 3, 62, 0, 100, 0, 8071, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Wind Trader Marid - On Gossip Select - Say Line 0');
INSERT INTO smart_scripts VALUES (20071, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Wind Trader Marid - On Gossip Select - Close Gossip');
INSERT INTO smart_scripts VALUES (20071, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Wind Trader Marid - On Gossip Select - Store Target');
INSERT INTO smart_scripts VALUES (20071, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wind Trader Marid - On Gossip Select - Set NPC Flags');
INSERT INTO smart_scripts VALUES (20071, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 3000, 3000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Wind Trader Marid - On Gossip Select - Create Timed Event');
INSERT INTO smart_scripts VALUES (20071, 0, 7, 0, 59, 0, 100, 0, 1, 0, 0, 0, 53, 0, 20071, 0, 0, 0, 1, 12, 1, 0, 0, 0, 0, 0, 0, 'Wind Trader Marid - On Timed Event - Start WP');
INSERT INTO smart_scripts VALUES (20071, 0, 8, 9, 40, 0, 100, 0, 15, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0.0, 'Wind Trader Marid - WP Reached - Set Orientation');
INSERT INTO smart_scripts VALUES (20071, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wind Trader Marid - WP Reached - Say Line 1');
INSERT INTO smart_scripts VALUES (20071, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 2, 4000, 4000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Wind Trader Marid - WP Reached - Create Timed Event');
INSERT INTO smart_scripts VALUES (20071, 0, 11, 12, 59, 0, 100, 0, 2, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wind Trader Marid - On Timed Event - Set Faction');
INSERT INTO smart_scripts VALUES (20071, 0, 12, 13, 61, 0, 100, 0, 0, 0, 0, 0, 12, 20101, 4, 10000, 0, 0, 0, 8, 0, 0, 0, 4327.28, 2133.79, 126.42, 2.88, 'Wind Trader Marid - On Timed Event - Summon Creature');
INSERT INTO smart_scripts VALUES (20071, 0, 13, 14, 61, 0, 100, 0, 0, 0, 0, 0, 12, 20101, 4, 10000, 0, 0, 0, 8, 0, 0, 0, 4328.97, 2140.08, 124.66, 2.88, 'Wind Trader Marid - On Timed Event - Summon Creature');
INSERT INTO smart_scripts VALUES (20071, 0, 14, 15, 61, 0, 100, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wind Trader Marid - On Timed Event - Remove Unit Flags');
INSERT INTO smart_scripts VALUES (20071, 0, 15, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 20, 0, 0, 0, 0, 0, 0, 'Wind Trader Marid - On Timed Event - Attack Start');
INSERT INTO smart_scripts VALUES (20071, 0, 16, 0, 17, 0, 100, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Wind Trader Marid - Just Summoned - Say Line 0 Target');
INSERT INTO smart_scripts VALUES (20101, 0, 0, 0, 1, 0, 100, 1, 2000, 2000, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Nether-Stalker - Out of Combat - Attack Start');
DELETE FROM waypoints WHERE entry=20071;
INSERT INTO waypoints VALUES (20071, 1, 4283.52, 2226.99, 124.217, 'Wind Trader Marid'),(20071, 2, 4289.39, 2217.21, 124.098, 'Wind Trader Marid'),(20071, 3, 4291.87, 2212.83, 121.275, 'Wind Trader Marid'),(20071, 4, 4295.08, 2207.17, 119.304, 'Wind Trader Marid'),(20071, 5, 4302.43, 2205.13, 120.59, 'Wind Trader Marid'),(20071, 6, 4307.42, 2196.81, 119.483, 'Wind Trader Marid'),(20071, 7, 4313.26, 2192.73, 117.658, 'Wind Trader Marid'),(20071, 8, 4316.16, 2187.62, 114.884, 'Wind Trader Marid'),(20071, 9, 4318.19, 2181.1, 116.967, 'Wind Trader Marid'),(20071, 10, 4315.18, 2173.19, 118.304, 'Wind Trader Marid'),(20071, 11, 4313.72, 2167.93, 118.03, 'Wind Trader Marid'),(20071, 12, 4316.97, 2162.18, 120.626, 'Wind Trader Marid'),(20071, 13, 4316.23, 2156.77, 123.907, 'Wind Trader Marid'),(20071, 14, 4310.42, 2147.52, 127.422, 'Wind Trader Marid'),(20071, 15, 4307.3, 2140.1, 129.336, 'Wind Trader Marid');

-- Delivering the Message (10406)
REPLACE INTO creature_template_addon VALUES(20755, 0, 0, 0, 0, 0, '35681');
DELETE FROM creature_text WHERE entry IN(20802, 20474);
INSERT INTO creature_text VALUES (20802, 0, 0, 'Let''s do this... Just keep me covered and I''ll deliver the package.', 12, 0, 100, 0, 0, 0, 0, 'Protectorate Demolitionist');
INSERT INTO creature_text VALUES (20802, 1, 0, 'I''m under attack! I repeat, I am under attack!', 12, 0, 100, 0, 0, 0, 0, 'Protectorate Demolitionist');
INSERT INTO creature_text VALUES (20802, 2, 0, 'By the second sun of K''aresh, look at this place! I can only imagine what Salhadaar is planning. Come on, let''s keep going.', 12, 0, 100, 5, 0, 0, 0, 'Protectorate Demolitionist');
INSERT INTO creature_text VALUES (20802, 3, 0, 'Look there, fleshling! Salhadaar''s conduits! He''s keeping well fed...', 12, 0, 100, 25, 0, 0, 0, 'Protectorate Demolitionist');
INSERT INTO creature_text VALUES (20802, 4, 0, 'Alright, keep me protected while I plant this disruptor. This shouldn''t take very long...', 12, 0, 100, 0, 0, 0, 0, 'Protectorate Demolitionist');
INSERT INTO creature_text VALUES (20802, 5, 0, 'Done! Back up! Back up!', 12, 0, 100, 0, 0, 0, 0, 'Protectorate Demolitionist');
INSERT INTO creature_text VALUES (20802, 6, 0, 'Looks like my work here is done. Report to the holo-image of Ameer over at the transporter.', 12, 0, 100, 0, 0, 0, 0, 'Protectorate Demolitionist');
INSERT INTO creature_text VALUES (20474, 0, 0, 'Protect the conduit! Stop the intruders!', 12, 0, 100, 0, 0, 0, 0, 'Ethereum Nexus-Stalker');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(20482, 20802, 20755);
UPDATE creature_template SET speed_walk=1.5, speed_run=1, RegenHealth=0 WHERE entry=20802;
UPDATE creature_template SET scale=2 WHERE entry=20755;
DELETE FROM smart_scripts WHERE entryorguid IN(20482, 20802, 20755) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=20802*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (20482, 0, 0, 0, 19, 0, 100, 0, 10406, 0, 0, 0, 85, 35679, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Protectorate Demolitionist - On Quest Accept - Invoker Cast');
INSERT INTO smart_scripts VALUES (20802, 0, 0, 1, 37, 0, 100, 0, 0, 0, 0, 0, 53, 0, 20802, 0, 10406, 5000, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Protectorate Demolitionist - On AI Init - Start WP');
INSERT INTO smart_scripts VALUES (20802, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Protectorate Demolitionist - On AI Init - Talk');
INSERT INTO smart_scripts VALUES (20802, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Protectorate Demolitionist - On Aggro - Talk');
INSERT INTO smart_scripts VALUES (20802, 0, 3, 0, 40, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Protectorate Demolitionist - On WP Reach - Set Home Pos');
INSERT INTO smart_scripts VALUES (20802, 0, 4, 5, 40, 0, 100, 0, 6, 0, 0, 0, 54, 6000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Protectorate Demolitionist - On WP Reached - WP Pause');
INSERT INTO smart_scripts VALUES (20802, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Protectorate Demolitionist - On WP Reached - Talk');
INSERT INTO smart_scripts VALUES (20802, 0, 6, 7, 40, 0, 100, 0, 11, 0, 0, 0, 54, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Protectorate Demolitionist - On WP Reached - WP Pause');
INSERT INTO smart_scripts VALUES (20802, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Protectorate Demolitionist - On WP Reached - Talk');
INSERT INTO smart_scripts VALUES (20802, 0, 8, 9, 40, 0, 100, 0, 14, 0, 0, 0, 54, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Protectorate Demolitionist - On WP Reached - WP Pause');
INSERT INTO smart_scripts VALUES (20802, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 20802*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Protectorate Demolitionist - On WP Reached - Script9');
INSERT INTO smart_scripts VALUES (20802, 0, 10, 11, 56, 0, 100, 0, 14, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Protectorate Demolitionist - On WP Resume - Talk');
INSERT INTO smart_scripts VALUES (20802, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Protectorate Demolitionist - On WP Resume - Remove Emote State');
INSERT INTO smart_scripts VALUES (20802, 0, 12, 13, 40, 0, 100, 0, 15, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Protectorate Demolitionist - On WP Reached - Talk');
INSERT INTO smart_scripts VALUES (20802, 0, 13, 14, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 20755, 50, 0, 0, 0, 0, 0, 'Protectorate Demolitionist - On WP Reached - Set Data');
INSERT INTO smart_scripts VALUES (20802, 0, 14, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 35682, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Protectorate Demolitionist - On WP Reached - Cast Spell');
INSERT INTO smart_scripts VALUES (20802*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 17, 469, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Protectorate Demolitionist - Script9 - Set Emote State');
INSERT INTO smart_scripts VALUES (20802*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Protectorate Demolitionist - Script9 - Talk');
INSERT INTO smart_scripts VALUES (20802*100, 9, 2, 0, 0, 0, 100, 1, 2000, 2000, 0, 0, 12, 20474, 4, 40000, 0, 1, 0, 8, 0, 0, 0, 3864, 2341.1, 115.4, 4.9, 'Protectorate Demolitionist - Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (20802*100, 9, 3, 0, 0, 0, 100, 1, 1000, 1000, 0, 0, 12, 20474, 4, 40000, 0, 1, 0, 8, 0, 0, 0, 3867, 2341.1, 115.4, 4.9, 'Protectorate Demolitionist - Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (20802*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 20474, 50, 0, 0, 0, 0, 0, 'Protectorate Demolitionist - Script9 - Talk');
INSERT INTO smart_scripts VALUES (20802*100, 9, 5, 0, 0, 0, 100, 1, 1000, 1000, 0, 0, 12, 20474, 4, 40000, 0, 1, 0, 8, 0, 0, 0, 3870, 2341.1, 115.4, 4.9, 'Protectorate Demolitionist - Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (20755, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 11, 40799, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Protectorate Demolitionist - On Spell Hit - Cast Spell');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=20482;
INSERT INTO conditions VALUES (22, 1, 20482, 0, 0, 1, 0, 35679, 1, 0, 1, 0, 0, '', 'Requires Player without aura');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=35682;
INSERT INTO conditions VALUES (13, 1, 35682, 0, 0, 31, 0, 3, 20755, 0, 0, 0, 0, '', 'Target Ethereum Energy Cell');
INSERT INTO conditions VALUES (13, 1, 35682, 0, 1, 31, 0, 3, 20769, 0, 0, 0, 0, '', 'Target Salaadin Energy Ball');
DELETE FROM waypoints WHERE entry=20802;
INSERT INTO waypoints VALUES (20802, 1, 4015.68, 2322.49, 113.825, 'Protectorate Demolitionist'),(20802, 2, 4007.63, 2323.53, 111.428, 'Protectorate Demolitionist'),(20802, 3, 3998.41, 2324.73, 113.084, 'Protectorate Demolitionist'),(20802, 4, 3973, 2328.02, 114.082, 'Protectorate Demolitionist'),(20802, 5, 3951.87, 2328.36, 113.983, 'Protectorate Demolitionist'),(20802, 6, 3939.16, 2330.01, 112.224, 'Protectorate Demolitionist'),(20802, 7, 3931.58, 2332.9, 110.878, 'Protectorate Demolitionist'),(20802, 8, 3922.88, 2336.22, 112.603, 'Protectorate Demolitionist'),(20802, 9, 3910.8, 2345.43, 114.132, 'Protectorate Demolitionist'),(20802, 10, 3885.74, 2364.52, 114.827, 'Protectorate Demolitionist'),
(20802, 11, 3874.4, 2383.68, 113.784, 'Protectorate Demolitionist'),(20802, 12, 3871.9, 2360.65, 114.97, 'Protectorate Demolitionist'),(20802, 13, 3866.8, 2341.7, 115.65, 'Protectorate Demolitionist'),(20802, 14, 3872.97, 2321.61, 114.52, 'Protectorate Demolitionist'),(20802, 15, 3866.8, 2341.7, 115.65, 'Protectorate Demolitionist');

-- You, Robot (10248)
DELETE FROM creature_text WHERE entry IN(19832, 19851);
INSERT INTO creature_text VALUES (19832, 0, 0, 'Oh no! What''s that? Quickly, defend us with the Scrap Reaver X6000!!!', 12, 0, 100, 0, 0, 0, 0, 'Doctor Vomisa, Ph.T.');
INSERT INTO creature_text VALUES (19851, 0, 0, 'I AM DEATH! PREPARE YOUR TOWN FOR ANNIHILATION!', 14, 0, 100, 0, 0, 0, 0, 'Negatron');
UPDATE creature_template SET unit_flags=0 WHERE entry=19849;
UPDATE creature_template SET unit_flags=32768+256+512 WHERE entry=19851;
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=19832;
DELETE FROM smart_scripts WHERE entryorguid=19832 AND source_type=0;
INSERT INTO smart_scripts VALUES (19832, 0, 0, 1, 19, 0, 100, 0, 10248, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 19, 19851, 200, 0, 0, 0, 0, 0, 'Doctor Vomisa, Ph.T. - On Quest Accept - Set Data');
INSERT INTO smart_scripts VALUES (19832, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 6000, 6000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Doctor Vomisa, Ph.T. - On Quest Accept - Create Timed Event');
INSERT INTO smart_scripts VALUES (19832, 0, 2, 0, 59, 0, 100, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doctor Vomisa, Ph.T. - On Timed Event - Say Line 0');
DELETE FROM smart_scripts WHERE entryorguid=19851 AND source_type=0;
INSERT INTO smart_scripts VALUES (19851, 0, 0, 0, 9, 0, 100, 0, 8, 25, 15000, 21000, 11, 35570, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Within 8-25 Range - Cast Charge');
INSERT INTO smart_scripts VALUES (19851, 0, 1, 0, 9, 0, 100, 0, 0, 5, 15000, 21000, 11, 34625, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Within 0-5 Range - Cast Demolish');
INSERT INTO smart_scripts VALUES (19851, 0, 2, 0, 0, 0, 100, 0, 15000, 19000, 21000, 25000, 11, 35565, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Negatron - In Combat - Cast Earthquake');
INSERT INTO smart_scripts VALUES (19851, 0, 3, 0, 2, 0, 100, 0, 0, 50, 16000, 22000, 11, 34624, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Between 0-50% Health - Cast Frenzy');
INSERT INTO smart_scripts VALUES (19851, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 15, 10248, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Negatron - On Just Died - Quest Credit You, Robot');
INSERT INTO smart_scripts VALUES (19851, 0, 5, 6, 38, 0, 100, 0, 1, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Negatron - On Data Set - Set Active on');
INSERT INTO smart_scripts VALUES (19851, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 3097.43, 3385.81, 105.36, 0, 'Negatron - On Data Set - Move To Pos');
INSERT INTO smart_scripts VALUES (19851, 0, 7, 8, 34, 0, 100, 0, 8, 1, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Movement Inform - Remove Unit Flags');
INSERT INTO smart_scripts VALUES (19851, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Movement Inform - Say Line 0');
INSERT INTO smart_scripts VALUES (19851, 0, 9, 0, 25, 0, 100, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Negatron - On Reset - Set Active off');

-- It's a Fel Reaver, But with Heart (10309)
DELETE FROM creature_text WHERE entry=20243;
INSERT INTO creature_text VALUES (20243, 0, 0, 'The %s''s mechanical heart begins to beat softly.', 16, 0, 100, 0, 0, 0, 0, 'Scrapped Fel Reaver');
REPLACE INTO creature_template_addon VALUES(20243, 0, 0, 7, 4097, 0, '');
UPDATE creature_template SET modelid1=18671, modelid2=0, unit_flags=0, flags_extra=0x200040, mechanic_immune_mask=650854271, AIName='SmartAI', ScriptName='' WHERE entry=20243;
DELETE FROM smart_scripts WHERE entryorguid=20243 AND source_type=0;
INSERT INTO smart_scripts VALUES (20243, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scrapped Fel Reaver - On Reset - Set React Passive');
INSERT INTO smart_scripts VALUES (20243, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scrapped Fel Reaver - On Reset - Add Unit Flag');
INSERT INTO smart_scripts VALUES (20243, 0, 2, 3, 8, 0, 100, 0, 35282, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scrapped Fel Reaver - On Spell Hit - Say Line 0');
INSERT INTO smart_scripts VALUES (20243, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scrapped Fel Reaver - On Spell Hit - Remove Unit Flag');
