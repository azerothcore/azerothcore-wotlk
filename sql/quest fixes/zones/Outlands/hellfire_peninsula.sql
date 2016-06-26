
-- The Seer's Relic (9545)
DELETE FROM creature_text WHERE entry IN(17417, 17404, 17405);
INSERT INTO creature_text VALUES (17417, 0, 0, 'Do not return, draenei scum.  Next time we won''t spare your life, unarmed or not!', 12, 0, 100, 0, 0, 0, 0, 'Mag''har Escort');
INSERT INTO creature_text VALUES (17404, 0, 0, 'I''ve failed... peace is impossible.', 12, 0, 100, 0, 0, 0, 0, 'Vindicator Sedai');
INSERT INTO creature_text VALUES (17404, 1, 0, 'What in the Light''s name...?', 12, 0, 100, 0, 0, 0, 0, 'Vindicator Sedai');
INSERT INTO creature_text VALUES (17404, 2, 0, 'Fel orcs!', 12, 0, 100, 0, 0, 0, 0, 'Vindicator Sedai');
INSERT INTO creature_text VALUES (17404, 3, 0, 'The cycle of bloodshed is unending... Is there nothing I can do?', 12, 0, 100, 0, 0, 0, 0, 'Vindicator Sedai');
INSERT INTO creature_text VALUES (17405, 0, 0, 'You can die!', 12, 0, 100, 0, 0, 0, 0, 'Krun Spinebreaker');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=30489;
INSERT INTO conditions VALUES (17, 0, 30489, 0, 0, 29, 0, 17404, 100, 0, 1, 0, 0, '', 'Require No Vindicator Sedai Nearby');
DELETE FROM event_scripts WHERE Id=10745;
INSERT INTO event_scripts VALUES (10745, 0, 10, 17404, 180000, 0, 211.41, 4128.27, 78.88, 2.23);
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(17404, 17417);
DELETE FROM smart_scripts WHERE entryorguid IN(17404, 17417) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(17404*100+0, 17404*100+1, 17404*100+2, 17404*100+3) AND source_type=9;
INSERT INTO smart_scripts VALUES (17404, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 80, 17404*100+0, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - On AI Init - Run Script');
INSERT INTO smart_scripts VALUES (17404, 0, 1, 0, 17, 0, 100, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - On Just Summoned Unit - Store Target');
INSERT INTO smart_scripts VALUES (17404, 0, 2, 0, 34, 0, 100, 0, 8, 1, 0, 0, 80, 17404*100+1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - Movement Inform - Run Script');
INSERT INTO smart_scripts VALUES (17404, 0, 3, 0, 34, 0, 100, 0, 8, 2, 0, 0, 80, 17404*100+2, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - Movement Inform - Run Script');
INSERT INTO smart_scripts VALUES (17404, 0, 4, 0, 21, 0, 100, 0, 0, 0, 0, 0, 80, 17404*100+3, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - Just Reached Home - Run Script');
INSERT INTO smart_scripts VALUES (17404, 0, 5, 0, 0, 0, 100, 0, 3000, 5000, 7000, 9000, 11, 27176, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - In Combat - Cast Holy Shock');
INSERT INTO smart_scripts VALUES (17404*100+0, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 17417, 4, 120000, 0, 0, 0, 8, 0, 0, 0, 213.51, 4123.88, 79.47, 2.34, 'Vindicator Sedai - On Script - Summon Mag''har Escort');
INSERT INTO smart_scripts VALUES (17404*100+0, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - On Script - Set Walk');
INSERT INTO smart_scripts VALUES (17404*100+0, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 64, 2, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - On Script - Store Target');
INSERT INTO smart_scripts VALUES (17404*100+0, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 195.83, 4139.96, 74.13, 0, 'Vindicator Sedai - On Script - Move Target To Position');
INSERT INTO smart_scripts VALUES (17404*100+0, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 17417, 4, 120000, 0, 0, 0, 8, 0, 0, 0, 217.85, 4127.76, 80.64, 2.46, 'Vindicator Sedai - Script - Summon Mag''har Escort');
INSERT INTO smart_scripts VALUES (17404*100+0, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - On Script - Set Walk');
INSERT INTO smart_scripts VALUES (17404*100+0, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 198.45, 4142.20, 74.84, 0, 'Vindicator Sedai - On Script - Move Target To Position');
INSERT INTO smart_scripts VALUES (17404*100+0, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - On Script - Set Walk');
INSERT INTO smart_scripts VALUES (17404*100+0, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 194.80, 4144.18, 73.84, 0, 'Vindicator Sedai - On Script - Move To Position');
INSERT INTO smart_scripts VALUES (17404*100+0, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - On Script - Set React Defensive');
INSERT INTO smart_scripts VALUES (17404*100+1, 9, 0, 0, 0, 0, 100, 0, 500, 500, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 5.61, 'Vindicator Sedai - On Script - Set Orientation');
INSERT INTO smart_scripts VALUES (17404*100+1, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 2.27, 'Vindicator Sedai - On Script - Set Orientation');
INSERT INTO smart_scripts VALUES (17404*100+1, 9, 2, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 86, 30460, 0, 12, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - On Script - Cross Cast Kick');
INSERT INTO smart_scripts VALUES (17404*100+1, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - On Script - Say Line 0');
INSERT INTO smart_scripts VALUES (17404*100+1, 9, 4, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - On Script - Set Bytes0');
INSERT INTO smart_scripts VALUES (17404*100+1, 9, 5, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 130, 2, 0, 0, 0, 0, 0, 12, 2, 0, 0, 213.51, 4123.88, 79.47, 0, 'Vindicator Sedai - On Script - Move To Position Target');
INSERT INTO smart_scripts VALUES (17404*100+1, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 2, 0, 0, 0, 0, 0, 12, 1, 0, 0, 217.85, 4127.76, 80.64, 0, 'Vindicator Sedai - On Script - Move To Position Target');
INSERT INTO smart_scripts VALUES (17404*100+1, 9, 7, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - On Script - Say Line 0');
INSERT INTO smart_scripts VALUES (17404*100+1, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 17418, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 248.76, 4114.57, 88.57, 2.58, 'Vindicator Sedai - On Script - Summon Laughing Skull Ambusher');
INSERT INTO smart_scripts VALUES (17404*100+1, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 211.41, 4128.27, 78.88, 0, 'Vindicator Sedai - On Script - Move Target To Position');
INSERT INTO smart_scripts VALUES (17404*100+1, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 17418, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 247.61, 4112.5, 87.64, 2.63, 'Vindicator Sedai - On Script - Summon Laughing Skull Ambusher');
INSERT INTO smart_scripts VALUES (17404*100+1, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 211.41, 4128.27, 78.88, 0, 'Vindicator Sedai - On Script - Move Target To Position');
INSERT INTO smart_scripts VALUES (17404*100+1, 9, 12, 0, 0, 0, 100, 0, 21000, 21000, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - On Script - Remove Bytes0');
INSERT INTO smart_scripts VALUES (17404*100+1, 9, 13, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 69, 2, 0, 0, 0, 0, 0, 8, 0, 0, 0, 200.97, 4136.99, 75.69, 0, 'Vindicator Sedai - On Script - Move To Position');
INSERT INTO smart_scripts VALUES (17404*100+1, 9, 14, 0, 0, 0, 100, 0, 500, 500, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - On Script - Say Line 1');
INSERT INTO smart_scripts VALUES (17404*100+2, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 5.72, 'Vindicator Sedai - On Script - Set Orientation');
INSERT INTO smart_scripts VALUES (17404*100+2, 9, 1, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - On Script - Say Line 2');
INSERT INTO smart_scripts VALUES (17404*100+2, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - On Script - Set Home Position');
INSERT INTO smart_scripts VALUES (17404*100+2, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - On Script - Set Run');
INSERT INTO smart_scripts VALUES (17404*100+2, 9, 4, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 69, 3, 0, 0, 0, 0, 0, 8, 0, 0, 0, 247.61, 4112.5, 87.64, 0, 'Vindicator Sedai - On Script - Move To Position');
INSERT INTO smart_scripts VALUES (17404*100+3, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - On Script - Set Walk');
INSERT INTO smart_scripts VALUES (17404*100+3, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 69, 4, 0, 0, 0, 0, 0, 8, 0, 0, 0, 192.14, 4150.54, 73.67, 0, 'Vindicator Sedai - On Script - Move To Position');
INSERT INTO smart_scripts VALUES (17404*100+3, 9, 2, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - On Script - Set Bytes0');
INSERT INTO smart_scripts VALUES (17404*100+3, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - On Script - Set React Passive');
INSERT INTO smart_scripts VALUES (17404*100+3, 9, 4, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 17405, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 214.83, 4123.14, 79.83, 2.28, 'Vindicator Sedai - On Script - Summon Krun');
INSERT INTO smart_scripts VALUES (17404*100+3, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 201.78, 4138.13, 75.88, 0, 'Vindicator Sedai - On Script - Move Target To Position');
INSERT INTO smart_scripts VALUES (17404*100+3, 9, 6, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - On Script - Say Line 3');
INSERT INTO smart_scripts VALUES (17404*100+3, 9, 7, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 59, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - On Script - Set Walk');
INSERT INTO smart_scripts VALUES (17404*100+3, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 193.14, 4148.78, 73.63, 0, 'Vindicator Sedai - On Script - Move Target To Position');
INSERT INTO smart_scripts VALUES (17404*100+3, 9, 9, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - On Script - Say Line 0 Target');
INSERT INTO smart_scripts VALUES (17404*100+3, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 86, 30462, 0, 12, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - On Script - Cross Cast Execute Sedai');
INSERT INTO smart_scripts VALUES (17404*100+3, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 33, 17413, 0, 0, 0, 0, 0, 18, 40, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - On Script - Kill Credit');
INSERT INTO smart_scripts VALUES (17404*100+3, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - On Script - Despawn Target');
INSERT INTO smart_scripts VALUES (17404*100+3, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vindicator Sedai - On Script - Despawn');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(30460, 30462);
INSERT INTO conditions VALUES (13, 1, 30460, 0, 0, 31, 0, 3, 17404, 0, 0, 0, 0, '', 'Target Vindicator Sedai');
INSERT INTO conditions VALUES (13, 1, 30462, 0, 0, 31, 0, 3, 17404, 0, 0, 0, 0, '', 'Target Vindicator Sedai');

-- Burn It Up... For the Horde! (10087)
UPDATE gameobject SET spawntimesecs=60 WHERE id IN(183122, 185122);
DELETE FROM smart_scripts WHERE entryorguid IN(18849, 19008) AND source_type=0;
INSERT INTO smart_scripts VALUES (18849, 0, 0, 1, 8, 0, 100, 0, 33067, 0, 0, 0, 33, 18849, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Invis Alliance Siege Engine - East - On Spellhit Ignite Alliance Siege Engine - Quest Credit Burn It Up... For the Horde!');
INSERT INTO smart_scripts VALUES (18849, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 15, 182817, 30, 0, 0, 0, 0, 0, 'Invis Alliance Siege Engine - East - On Spellhit Ignite Alliance Siege Engine - Despawn Flames');
INSERT INTO smart_scripts VALUES (18849, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 50, 182817, 60, 0, 0, 0, 0, 20, 183122, 40, 0, 0, 0, 5, 0, 'Invis Alliance Siege Engine - East - On Spellhit Ignite Alliance Siege Engine - Summon Game Object');
INSERT INTO smart_scripts VALUES (19008, 0, 0, 1, 8, 0, 100, 0, 33067, 0, 0, 0, 33, 19008, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Invis Alliance Siege Engine - West - On Spellhit Ignite Alliance Siege Engine - Quest Credit Burn It Up... For the Horde!');
INSERT INTO smart_scripts VALUES (19008, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 15, 182817, 30, 0, 0, 0, 0, 0, 'Invis Alliance Siege Engine - East - On Spellhit Ignite Alliance Siege Engine - Despawn Flames');
INSERT INTO smart_scripts VALUES (19008, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 50, 182817, 60, 0, 0, 0, 0, 20, 185122, 40, 0, 0, 0, 5, 0, 'Invis Alliance Siege Engine - East - On Spellhit Ignite Alliance Siege Engine - Summon Game Object');

-- Zeth'Gor Must Burn! (10792)
UPDATE gameobject_template SET data1=14 WHERE entry=185144;
DELETE FROM gameobject WHERE id=183816 AND guid IN(32137, 32138, 32139);
UPDATE creature_template SET flags_extra=130, InhabitType=4, AIName='SmartAI', ScriptName='' WHERE entry IN(20813, 20814, 20815, 20816);
DELETE FROM smart_scripts WHERE entryorguid IN(20813, 20814, 20815, 20816) AND source_type=0;
INSERT INTO smart_scripts VALUES (20813, 0, 0, 1, 8, 0, 100, 0, 35724, 0, 0, 0, 33, 20813, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Zeth''Gor Quest Credit Marker, Barracks - On Spellhit Throw Torch - Kill Credit');
INSERT INTO smart_scripts VALUES (20813, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 15, 183816, 75, 0, 0, 0, 0, 0, 'Zeth''Gor Quest Credit Marker, Barracks - On Spellhit Throw Torch - Despawn Flames');
INSERT INTO smart_scripts VALUES (20813, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 50, 183816, 60, 0, 0, 0, 0, 11, 20813, 75, 0, 0, 0, 0, 0, 'Zeth''Gor Quest Credit Marker, Barracks - On Spellhit Throw Torch - Spawn Game Object');
INSERT INTO smart_scripts VALUES (20813, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 50, 183816, 60, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Zeth''Gor Quest Credit Marker, Barracks - On Spellhit Throw Torch - Spawn Game Object');
INSERT INTO smart_scripts VALUES (20814, 0, 0, 1, 8, 0, 100, 0, 35724, 0, 0, 0, 33, 20814, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Zeth''Gor Quest Credit Marker, Stable - On Spellhit Throw Torch - Kill Credit');
INSERT INTO smart_scripts VALUES (20814, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 15, 183816, 20, 0, 0, 0, 0, 0, 'Zeth''Gor Quest Credit Marker, Stable - On Spellhit Throw Torch - Despawn Flames');
INSERT INTO smart_scripts VALUES (20814, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 50, 183816, 60, 0, 0, 0, 0, 11, 20814, 20, 0, 0, 0, 0, 0, 'Zeth''Gor Quest Credit Marker, Stable - On Spellhit Throw Torch - Spawn Game Object');
INSERT INTO smart_scripts VALUES (20814, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 50, 183816, 60, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Zeth''Gor Quest Credit Marker, Stable - On Spellhit Throw Torch - Spawn Game Object');
INSERT INTO smart_scripts VALUES (20815, 0, 0, 1, 8, 0, 100, 0, 35724, 0, 0, 0, 33, 20815, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Zeth''Gor Quest Credit Marker, East Hovel - On Spellhit Throw Torch - Kill Credit');
INSERT INTO smart_scripts VALUES (20815, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 15, 183816, 20, 0, 0, 0, 0, 0, 'Zeth''Gor Quest Credit Marker, East Hovel - On Spellhit Throw Torch - Despawn Flames');
INSERT INTO smart_scripts VALUES (20815, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 50, 183816, 60, 0, 0, 0, 0, 11, 20815, 20, 0, 0, 0, 0, 0, 'Zeth''Gor Quest Credit Marker, East Hovel - On Spellhit Throw Torch - Spawn Game Object');
INSERT INTO smart_scripts VALUES (20815, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 50, 183816, 60, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Zeth''Gor Quest Credit Marker, East Hovel - On Spellhit Throw Torch - Spawn Game Object');
INSERT INTO smart_scripts VALUES (20816, 0, 0, 1, 8, 0, 100, 0, 35724, 0, 0, 0, 33, 20816, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Zeth''Gor Quest Credit Marker, West Hovel - On Spellhit Throw Torch - Kill Credit');
INSERT INTO smart_scripts VALUES (20816, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 15, 183816, 20, 0, 0, 0, 0, 0, 'Zeth''Gor Quest Credit Marker, West Hovel - On Spellhit Throw Torch - Despawn Flames');
INSERT INTO smart_scripts VALUES (20816, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 50, 183816, 60, 0, 0, 0, 0, 11, 20816, 20, 0, 0, 0, 0, 0, 'Zeth''Gor Quest Credit Marker, West Hovel - On Spellhit Throw Torch - Spawn Game Object');
INSERT INTO smart_scripts VALUES (20816, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 50, 183816, 60, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Zeth''Gor Quest Credit Marker, West Hovel - On Spellhit Throw Torch - Spawn Game Object');

-- The Warp Rifts (10278)
UPDATE creature_template SET flags_extra=130 WHERE entry=20143;

-- Doorway to the Abyss (10392)
UPDATE gameobject_template set data11=1 WHERE entry=184656;
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=182935;
DELETE FROM smart_scripts WHERE entryorguid=182935 AND source_type=1;
INSERT INTO smart_scripts VALUES (182935, 1, 0, 1, 8, 0, 100, 0, 35739, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 20, 184656, 10, 0, 0, 0, 0, 0, 'Rune of Spite - On Spell Hit - Set Loot State');
INSERT INTO smart_scripts VALUES (182935, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 20, 185190, 10, 0, 0, 0, 0, 0, 'Rune of Spite - On Spell Hit - Set Loot State');

-- Apothecary Zelana (10449)
DELETE FROM creature_text WHERE entry=21257;
INSERT INTO creature_text VALUES (21257, 0, 0, 'Thank you, $n.  Now, to perform the test...', 12, 0, 100, 1, 0, 0, 0, 'Apothecary Zelana');
INSERT INTO creature_text VALUES (21257, 1, 0, 'Ah, I see...', 12, 0, 100, 0, 0, 0, 0, 'Apothecary Zelana');
INSERT INTO creature_text VALUES (21257, 2, 0, 'Yes, this is unfortunate.', 12, 0, 100, 0, 0, 0, 0, 'Apothecary Zelana');
INSERT INTO creature_text VALUES (21257, 3, 0, '$n, I have confirmed that this blood is from the Bonechewer clan of orcs, tainted with demonic power.  I''m afraid, however, that my current equipment can delve no deeper into this mystery...', 12, 0, 100, 1, 0, 0, 0, 'Apothecary Zelana');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=21257;
DELETE FROM smart_scripts WHERE entryorguid=21257 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=21257*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (21257, 0, 0, 1, 20, 0, 100, 0, 10449, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Zelana - On Quest Reward (Apothecary Zelana) - Store Target');
INSERT INTO smart_scripts VALUES (21257, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 21257*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Zelana - On Quest Reward (Apothecary Zelana) - Run Script');
INSERT INTO smart_scripts VALUES (21257*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Zelana - On Script - Set Active');
INSERT INTO smart_scripts VALUES (21257*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Zelana - On Script - Set NPC Flags');
INSERT INTO smart_scripts VALUES (21257*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Zelana - On Script - Say');
INSERT INTO smart_scripts VALUES (21257*100, 9, 3, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 6.04, 'Apothecary Zelana - On Script - Set Orientation');
INSERT INTO smart_scripts VALUES (21257*100, 9, 4, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 17, 69, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Zelana - On Script - Set Emote State');
INSERT INTO smart_scripts VALUES (21257*100, 9, 5, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Zelana - On Script - Say');
INSERT INTO smart_scripts VALUES (21257*100, 9, 6, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Zelana - On Script - Say');
INSERT INTO smart_scripts VALUES (21257*100, 9, 7, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Zelana - On Script - Set Emote State');
INSERT INTO smart_scripts VALUES (21257*100, 9, 8, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 3.1765, 'Apothecary Zelana - On Script - Set Orientation');
INSERT INTO smart_scripts VALUES (21257*100, 9, 9, 0, 0, 0, 100, 0, 500, 500, 0, 0, 1, 3, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Zelana - On Script - Say');
INSERT INTO smart_scripts VALUES (21257*100, 9, 10, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 81, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Zelana - On Script - Set NPC Flags');

-- How to Serve Goblins (10238)
DELETE FROM creature_text WHERE entry IN(19766, 19763, 19764);
INSERT INTO creature_text VALUES (19766, 0, 0, 'I don''t know which is worse, getting eaten by fel orcs or working for that slave master Razelcraz! Oh well, thanks anyways!', 12, 0, 100, 4, 0, 0, 0, 'Jakk');
INSERT INTO creature_text VALUES (19763, 0, 0, 'Thank goodness you got here, it was almost dinner time!', 12, 0, 100, 4, 0, 0, 0, 'Manni');
INSERT INTO creature_text VALUES (19764, 0, 0, 'I thought I was a goner for sure.', 12, 0, 100, 4, 0, 0, 0, 'Moh');
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry IN(183941, 183936, 183940);
DELETE FROM smart_scripts WHERE entryorguid IN(183941, 183936, 183940) AND source_type=1;
INSERT INTO smart_scripts VALUES (183941, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 67, 1, 5000, 5000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Jakk''s Cage - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (183941, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 19, 19766, 10, 0, -122.09, 3087.50, 3.10, 0, 'Jakk''s Cage - On Gossip Hello - Move Target To Position');
INSERT INTO smart_scripts VALUES (183941, 1, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 19, 19766, 10, 0, 0, 0, 0, 0, 'Jakk''s Cage - On Gossip Hello - Set Walk');
INSERT INTO smart_scripts VALUES (183941, 1, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 19, 19766, 10, 0, 0, 0, 0, 0, 'Jakk''s Cage - On Gossip Hello - Despawn');
INSERT INTO smart_scripts VALUES (183941, 1, 4, 0, 59, 0, 100, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 19766, 10, 0, 0, 0, 0, 0, 'Jakk''s Cage - On Gossip Hello - Say Line 0');
INSERT INTO smart_scripts VALUES (183936, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 67, 1, 5000, 5000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Manni''s Cage - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (183936, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 19, 19763, 10, 0, 70.07, 3209.50, 32.15, 0, 'Manni''s Cage - On Gossip Hello - Move Target To Position');
INSERT INTO smart_scripts VALUES (183936, 1, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 19, 19763, 10, 0, 0, 0, 0, 0, 'Manni''s Cage - On Gossip Hello - Set Walk');
INSERT INTO smart_scripts VALUES (183936, 1, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 19, 19763, 10, 0, 0, 0, 0, 0, 'Manni''s Cage - On Gossip Hello - Despawn');
INSERT INTO smart_scripts VALUES (183936, 1, 4, 0, 59, 0, 100, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 19763, 10, 0, 0, 0, 0, 0, 'Manni''s Cage - On Gossip Hello - Say Line 0');
INSERT INTO smart_scripts VALUES (183940, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 67, 1, 5000, 5000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Moh''s Cage - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (183940, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 19, 19764, 10, 0, -72.39, 3137.89, -4.40, 0, 'Moh''s Cage - On Gossip Hello - Move Target To Position');
INSERT INTO smart_scripts VALUES (183940, 1, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 19, 19764, 10, 0, 0, 0, 0, 0, 'Moh''s Cage - On Gossip Hello - Set Walk');
INSERT INTO smart_scripts VALUES (183940, 1, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 19, 19764, 10, 0, 0, 0, 0, 0, 'Moh''s Cage - On Gossip Hello - Despawn');
INSERT INTO smart_scripts VALUES (183940, 1, 4, 0, 59, 0, 100, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 19764, 10, 0, 0, 0, 0, 0, 'Moh''s Cage - On Gossip Hello - Say Line 0');

-- The Foot of the Citadel (10876)
DELETE FROM creature_text WHERE entry=22374;
INSERT INTO creature_text VALUES (22374, 0, 0, 'Who dares slay one of my Kargath''s commanders?  You will pay for this... in flesh!', 14, 0, 100, 0, 0, 0, 0, 'Hand of Kargath');
DELETE FROM smart_scripts WHERE entryorguid=22374 AND source_type=0;
INSERT INTO smart_scripts VALUES (22374, 0, 0, 1, 4, 0, 100, 1, 0, 0, 0, 0, 11, 33962, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hand of Kargath - On Aggro - Cast Toughen');
INSERT INTO smart_scripts VALUES (22374, 0, 1, 0, 60, 0, 100, 257, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hand of Kargath - On Update - Say Line 0');
INSERT INTO smart_scripts VALUES (22374, 0, 2, 0, 1, 0, 100, 257, 4000, 4000, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Hand of Kargath - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (22374, 0, 3, 0, 0, 0, 100, 0, 2600, 2600, 3800, 6400, 11, 9080, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hand of Kargath - In Combat - Cast Hamstring');
INSERT INTO smart_scripts VALUES (22374, 0, 4, 0, 0, 0, 100, 0, 5200, 5200, 30000, 45000, 11, 33735, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hand of Kargath - In Combat - Cast Blade Flurry');
INSERT INTO smart_scripts VALUES (22374, 0, 5, 0, 0, 0, 100, 0, 15400, 15400, 12000, 16000, 11, 24193, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Hand of Kargath - In Combat - Cast Charge');
INSERT INTO smart_scripts VALUES (22374, 0, 6, 0, 2, 0, 100, 1, 0, 90, 0, 0, 11, 33962, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hand of Kargath - Between 0-90% Health - Cast Toughen');
INSERT INTO smart_scripts VALUES (22374, 0, 7, 0, 2, 0, 100, 1, 0, 80, 0, 0, 11, 33962, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hand of Kargath - Between 0-80% Health - Cast Toughen');
INSERT INTO smart_scripts VALUES (22374, 0, 8, 0, 2, 0, 100, 1, 0, 70, 0, 0, 11, 33962, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hand of Kargath - Between 0-70% Health - Cast Toughen');
INSERT INTO smart_scripts VALUES (22374, 0, 9, 0, 2, 0, 100, 1, 0, 60, 0, 0, 11, 33962, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hand of Kargath - Between 0-60% Health - Cast Toughen');
INSERT INTO smart_scripts VALUES (22374, 0, 10, 0, 2, 0, 100, 1, 0, 50, 0, 0, 11, 33962, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hand of Kargath - Between 0-50% Health - Cast Toughen');
INSERT INTO smart_scripts VALUES (22374, 0, 11, 0, 2, 0, 100, 1, 0, 40, 0, 0, 11, 33962, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hand of Kargath - Between 0-40% Health - Cast Toughen');
INSERT INTO smart_scripts VALUES (22374, 0, 12, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 33962, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hand of Kargath - Between 0-30% Health - Cast Toughen');
INSERT INTO smart_scripts VALUES (22374, 0, 13, 0, 2, 0, 100, 1, 0, 20, 0, 0, 11, 33962, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hand of Kargath - Between 0-20% Health - Cast Toughen');
INSERT INTO smart_scripts VALUES (22374, 0, 14, 0, 2, 0, 100, 1, 0, 10, 0, 0, 11, 33962, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hand of Kargath - Between 0-10% Health - Cast Toughen');

-- Bloody Vengeance (10250)
DELETE FROM event_scripts WHERE id=12823;
INSERT INTO event_scripts VALUES (12823, 0, 10, 19862, 120000, 0, -1175.41, 2264.59, 53.1733, 3.15905);
INSERT INTO event_scripts VALUES (12823, 3, 10, 20137, 120000, 0, -1190.11, 2258.2, 46.6871, 1.36136);
INSERT INTO event_scripts VALUES (12823, 3, 10, 20137, 120000, 0, -1196.75, 2264.76, 47.9826, 6.19592);
INSERT INTO event_scripts VALUES (12823, 3, 10, 20137, 120000, 0, -1193.53, 2259.04, 47.484, 0.820305);
INSERT INTO event_scripts VALUES (12823, 3, 10, 20137, 120000, 0, -1190.24, 2269.2, 46.0973, 4.97419);
INSERT INTO event_scripts VALUES (12823, 3, 10, 19864, 120000, 0, -1194.89, 2267.52, 47.29, 5.36);
DELETE FROM creature_text WHERE entry IN(19864, 20137, 19862);
INSERT INTO creature_text VALUES (19864, 0, 0, 'Vengeance is ours! Attack my brothers!', 12, 0, 100, 0, 0, 0, 0, 'Vengeful Unyielding Captain');
INSERT INTO creature_text VALUES (19862, 0, 0, 'Urtrak kill you!', 12, 0, 100, 0, 0, 0, 0, 'Urtrak');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(19864, 20137, 19862);
DELETE FROM smart_scripts WHERE entryorguid IN(19864, 20137, 19862) AND source_type=0;
INSERT INTO smart_scripts VALUES (19864, 0, 0, 0, 60, 0, 100, 257, 500, 500, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vengeful Unyielding Captain - On Update - Say Line 0');
INSERT INTO smart_scripts VALUES (19864, 0, 1, 0, 1, 0, 100, 257, 2500, 2500, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 19862, 30, 0, 0, 0, 0, 0, 'Vengeful Unyielding Captain - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (19864, 0, 2, 0, 1, 0, 100, 257, 10000, 10000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vengeful Unyielding Captain - Out of Combat - Despawn');
INSERT INTO smart_scripts VALUES (20137, 0, 0, 0, 1, 0, 100, 257, 2500, 2500, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 19862, 30, 0, 0, 0, 0, 0, 'Vengeful Unyielding Footman - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (20137, 0, 1, 0, 1, 0, 100, 257, 10000, 10000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vengeful Unyielding Footman - Out of Combat - Despawn');
INSERT INTO smart_scripts VALUES (19862, 0, 0, 0, 60, 0, 100, 257, 1000, 1000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Urtrak - On Update - Say Line 0');
INSERT INTO smart_scripts VALUES (19862, 0, 1, 0, 1, 0, 100, 257, 2000, 2000, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Urtrak - Out of Combat - Attack Start');

-- From the Abyss (10295)
DELETE FROM event_scripts WHERE id=13037;
INSERT INTO event_scripts VALUES (13037, 0, 10, 16939, 3000000, 0, -1243.23, 1312.41, 3.55, 1.34);
UPDATE creature_template SET InhabitType=7, AIName='SmartAI', ScriptName='' WHERE entry=16939;
DELETE FROM smart_scripts WHERE entryorguid=16939 AND source_type=0;
INSERT INTO smart_scripts VALUES (16939, 0, 0, 0, 1, 0, 100, 257, 0, 0, 0, 0, 11, 34302, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Void Baron Galaxis - Out of Combat - Cast Coalesce');
INSERT INTO smart_scripts VALUES (16939, 0, 1, 0, 1, 0, 100, 257, 2000, 2000, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, -1232.90, 1355.956, 5.23, 0, 'Void Baron Galaxis - Out of Combat - Move To Position');
INSERT INTO smart_scripts VALUES (16939, 0, 2, 0, 60, 0, 100, 257, 9000, 9000, 0, 0, 11, 34236, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Void Baron Galaxis - On Update - Cast Baron''s Summons');
INSERT INTO smart_scripts VALUES (16939, 0, 3, 0, 0, 0, 100, 0, 12000, 15000, 15000, 20000, 11, 34239, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Void Baron Galaxis - In Combat - Cast Absorb Life');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=34239;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=34239;
INSERT INTO conditions VALUES(13, 1, 34239, 0, 0, 31, 0, 3, 19599, 0, 0, 0, 0, '', 'Target Void Servant');
INSERT INTO conditions VALUES(17, 0, 34239, 0, 0, 29, 0, 19599, 15, 0, 0, 0, 0, '', 'Requires Void Servant in 15yd');

-- Honor the Fallen (10258)
DELETE FROM smart_scripts WHERE entryorguid=19863 AND source_type=0;
INSERT INTO smart_scripts VALUES (19863, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 41, 15000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vengeful Unyielding - On Just Summoned - Despawn In 15000 ms');
INSERT INTO smart_scripts VALUES (19863, 0, 1, 0, 1, 0, 100, 0, 1000, 3000, 10000, 20000, 5, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vengeful Unyielding - On Just Summoned - Play Emote Kneel');

-- Testing the Antidote (10255)
DELETE FROM creature_text WHERE entry IN(16880, 16992);
INSERT INTO creature_text VALUES (16880, 0, 0, '%s begins to grow stronger', 16, 0, 100, 0, 0, 0, 0, 'Hulking Helboar');
INSERT INTO creature_text VALUES (16992, 0, 0, '%s begins to grow stronger', 16, 0, 100, 0, 0, 0, 0, 'Dreadtusk');
DELETE FROM spell_script_names WHERE spell_id=34665;
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=16880;
DELETE FROM smart_scripts WHERE entryorguid=16880 AND source_type=0;
INSERT INTO smart_scripts VALUES (16880, 0, 0, 1, 2, 0, 100, 1, 0, 60, 0, 0, 11, 33909, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hulking Helboar - Between Health 0-60% - Cast Hulk');
INSERT INTO smart_scripts VALUES (16880, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hulking Helboar - Between Health 0-60% - Say Line 0');
INSERT INTO smart_scripts VALUES (16880, 0, 2, 3, 8, 0, 100, 1, 34665, 0, 0, 0, 36, 16992, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hulking Helboar - On Spell Hit - Update Entry');
INSERT INTO smart_scripts VALUES (16880, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Hulking Helboar - On Spell Hit - Attack Start');
INSERT INTO smart_scripts VALUES (16880, 0, 4, 0, 7, 0, 100, 0, 0, 0, 0, 0, 36, 16880, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hulking Helboar - On Evade - Update Entry');

-- Arzeth's Demise (10369)
DELETE FROM creature_text WHERE entry IN(19354, 20680);
INSERT INTO creature_text VALUES (19354, 0, 0, 'Work these Broken wretches to the bones, Illidari!  If there''s anything of value in this forsaken place we shall find it!', 14, 0, 100, 1, 0, 0, 0, 'Arzeth the Merciless');
INSERT INTO creature_text VALUES (19354, 0, 1, 'Do not allow these wretches a moment of rest! If there''s an Ata''mal crystal here then we shall find it!', 14, 0, 100, 1, 0, 0, 0, 'Arzeth the Merciless');
INSERT INTO creature_text VALUES (19354, 0, 2, 'Keep a close eye on this Broken scum! Far too many have escaped from us!', 14, 0, 100, 1, 0, 0, 0, 'Arzeth the Merciless');
INSERT INTO creature_text VALUES (19354, 0, 3, 'We will find what the Master is looking for! Failure is not an option!', 14, 0, 100, 1, 0, 0, 0, 'Arzeth the Merciless');
INSERT INTO creature_text VALUES (20680, 0, 0, 'That Broken worm gave you that staff, didn''t he?  Did he also tell you he''s the one that sold out his tribe?  No matter, you will both pay for this!', 14, 0, 100, 0, 0, 0, 0, 'Arzeth the Powerless');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=19354;
DELETE FROM smart_scripts WHERE entryorguid=19354 AND source_type=0;
INSERT INTO smart_scripts VALUES (19354, 0, 0, 0, 0, 0, 100, 0, 8000, 12000, 8000, 14000, 11, 16856, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Arzeth the Merciless - In Combat - Cast Mortal Strike');
INSERT INTO smart_scripts VALUES (19354, 0, 1, 0, 9, 0, 100, 0, 0, 30, 12000, 14000, 11, 15245, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Arzeth the Merciless - Within 0-30 Range - Cast Shadow Bolt Volley');
INSERT INTO smart_scripts VALUES (19354, 0, 2, 3, 8, 0, 100, 1, 35460, 0, 0, 0, 36, 20680, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Arzeth the Merciless - On Spell Hit - Update Template');
INSERT INTO smart_scripts VALUES (19354, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Arzeth the Merciless - Link - Say Line 0');
INSERT INTO smart_scripts VALUES (19354, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Arzeth the Merciless - Link - Attack Start');
INSERT INTO smart_scripts VALUES (19354, 0, 5, 0, 1, 0, 100, 0, 35000, 45000, 40000, 90000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Arzeth the Merciless - OOC - Say Line 0');
INSERT INTO smart_scripts VALUES (19354, 0, 6, 0, 7, 0, 100, 0, 0, 0, 0, 0, 36, 19354, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Arzeth the Merciless - On Evade - Update Template');

-- The Cleansing Must Be Stopped (9370)
DELETE FROM event_scripts WHERE id=10346;
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=181447;
DELETE FROM smart_scripts WHERE entryorguid=181447 AND source_type=1;
INSERT INTO smart_scripts VALUES (181447, 1, 0, 1, 60, 0, 100, 257, 10000, 15000, 0, 0, 12, 16994, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 88.50, 3553.64, 63.80, 5.0, 'Signaling Gem - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (181447, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 12, 16996, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 89.81, 3557.59, 64.30, 5.0, 'Signaling Gem - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (181447, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 12, 16996, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 84.21, 3555.82, 64.17, 5.0, 'Signaling Gem - On Update - Summon Creature');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=16994;
DELETE FROM smart_scripts WHERE entryorguid=16994 AND source_type=0;
INSERT INTO smart_scripts VALUES (16994, 0, 0, 0, 0, 0, 100, 0, 4000, 9000, 10000, 16000, 11, 16994, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Draenei Anchorite - In Combat - Cast Holy Fire');
INSERT INTO smart_scripts VALUES (16994, 0, 1, 0, 1, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Draenei Anchorite - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (16994, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Draenei Anchorite - On Aggro - Call For Help');
