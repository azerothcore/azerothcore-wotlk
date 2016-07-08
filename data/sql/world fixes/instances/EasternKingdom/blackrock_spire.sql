
-- Blackrock Spire
-- Fix Orb of Command (179879)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=6001;
INSERT INTO conditions VALUES(15, 6001, 0, 0, 0, 8, 0, 7761, 0, 0, 0, 0, 0, '', 'Requires Quest 7761 rewarded');
REPLACE INTO gossip_menu VALUES (6001, 7155);
REPLACE INTO gossip_menu_option VALUES (6001, 0, 0, "<Place my hand on the orb.>", 1, 0, 0, 0, 0, 0, '');
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=179879;
DELETE FROM smart_scripts WHERE entryorguid=179879 AND source_type=1;
INSERT INTO smart_scripts VALUES (179879, 1, 0, 0, 62, 0, 100, 0, 6001, 0, 0, 0, 85, 23460, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Select - Invoker Cast');

-- Open blackrock spire gate (175244)
UPDATE gameobject SET state=0 WHERE id IN(175244, 175705, 164726, 175186);
UPDATE gameobject SET state=1 WHERE id IN(175153);

-- Urok Doomhowl
DELETE FROM event_scripts WHERE id=4845;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=16447;
INSERT INTO conditions VALUES(13, 2, 16447, 0, 0, 31, 0, 5, 175621, 0, 0, 0, 0, '', 'Target Urok''s Tribute Pile');
UPDATE gameobject_template SET AIName='SmartGameObjectAI' WHERE entry IN(175621, 175584);
DELETE FROM smart_scripts WHERE entryorguid IN(175621, 175584) AND source_type=1;
DELETE FROM smart_scripts WHERE entryorguid IN(175584*100) AND source_type=9;
INSERT INTO smart_scripts VALUES (175621, 1, 0, 1, 8, 0, 100, 0, 16447, 0, 0, 0, 50, 175584, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Summon GO');
INSERT INTO smart_scripts VALUES (175621, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Set Loot State');
INSERT INTO smart_scripts VALUES (175584, 1, 0, 0, 60, 0, 100, 1, 0, 0, 0, 0, 80, 175584*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Script9');
INSERT INTO smart_scripts VALUES (175584, 1, 1, 0, 70, 0, 100, 0, 2, 0, 0, 0, 11, 16452, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On State Changed - Cast Spell');
INSERT INTO smart_scripts VALUES (175584*100, 9, 0, 0, 0, 0, 100, 0, 500, 500, 0, 0, 50, 175571, 0, 0, 0, 0, 0, 8, 0, 0, 0, -14.36, -389.37, 48.78, 0, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (175584*100, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 50, 175571, 0, 0, 0, 0, 0, 8, 0, 0, 0, -27.43, -372.86, 49.36, 0, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (175584*100, 9, 2, 0, 0, 0, 100, 0, 500, 500, 0, 0, 50, 175571, 0, 0, 0, 0, 0, 8, 0, 0, 0, -19.78, -372.75, 49.25, 0, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (175584*100, 9, 3, 0, 0, 0, 100, 0, 500, 500, 0, 0, 50, 175571, 0, 0, 0, 0, 0, 8, 0, 0, 0, -31.67, -385.91, 48.65, 0, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (175584*100, 9, 4, 0, 0, 0, 100, 0, 500, 500, 0, 0, 50, 175571, 0, 0, 0, 0, 0, 8, 0, 0, 0, -37.13, -369.65, 50.63, 0, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (175584*100, 9, 5, 0, 0, 0, 100, 0, 500, 500, 0, 0, 50, 175571, 0, 0, 0, 0, 0, 8, 0, 0, 0, -46.26, -376.98, 50.51, 0, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (175584*100, 9, 6, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 10601, 4, 30000, 0, 0, 0, 8, 0, 0, 0, -19.78, -372.75, 49.25, 0, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (175584*100, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 10601, 4, 30000, 0, 0, 0, 8, 0, 0, 0, -31.67, -385.91, 48.65, 0, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (175584*100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 10602, 4, 30000, 0, 0, 0, 8, 0, 0, 0, -37.13, -369.65, 50.63, 0, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (175584*100, 9, 9, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 12, 10601, 4, 30000, 0, 0, 0, 8, 0, 0, 0, -14.36, -389.37, 48.78, 0, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (175584*100, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 10602, 4, 30000, 0, 0, 0, 8, 0, 0, 0, -27.43, -372.86, 49.36, 0, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (175584*100, 9, 11, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 12, 10602, 4, 30000, 0, 0, 0, 8, 0, 0, 0, -31.67, -385.91, 48.65, 0, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (175584*100, 9, 12, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 12, 10601, 4, 30000, 0, 0, 0, 8, 0, 0, 0, -46.26, -376.98, 50.51, 0, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (175584*100, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 10602, 4, 30000, 0, 0, 0, 8, 0, 0, 0, -37.13, -369.65, 50.63, 0, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (175584*100, 9, 14, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 12, 10601, 4, 30000, 0, 0, 0, 8, 0, 0, 0, -27.43, -372.86, 49.36, 0, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (175584*100, 9, 15, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 12, 10602, 4, 30000, 0, 0, 0, 8, 0, 0, 0, -46.26, -376.98, 50.51, 0, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (175584*100, 9, 16, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 10601, 4, 30000, 0, 0, 0, 8, 0, 0, 0, -14.36, -389.37, 48.78, 0, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (175584*100, 9, 17, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 12, 10584, 4, 30000, 0, 0, 0, 8, 0, 0, 0, -28.57, -395.78, 48.78, 1.41, 'Script9 - Summon Creature Urok');
INSERT INTO smart_scripts VALUES (175584*100, 9, 18, 0, 0, 0, 100, 0, 60000, 60000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Delete Self');
DELETE FROM smart_scripts WHERE entryorguid IN(10601, 10602) AND source_type=0 AND id IN(20, 21);
INSERT INTO smart_scripts VALUES (10601, 0, 20, 21, 60, 0, 100, 1, 0, 0, 0, 0, 11, 12980, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Cast Spell');
INSERT INTO smart_scripts VALUES (10601, 0, 21, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'On Update - Attack Nearest Player');
INSERT INTO smart_scripts VALUES (10602, 0, 20, 21, 60, 0, 100, 1, 0, 0, 0, 0, 11, 12980, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Cast Spell');
INSERT INTO smart_scripts VALUES (10602, 0, 21, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'On Update - Attack Nearest Player');
