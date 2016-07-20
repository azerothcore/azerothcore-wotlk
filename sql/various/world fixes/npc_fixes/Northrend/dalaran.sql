
-- Torgo the Younger (29325)
UPDATE creature SET equipment_id=1 WHERE id=29325;
REPLACE INTO creature_equip_template VALUES (29325, 1, 6256, 0, 0, 0);

-- Archmage Lan'dalock (20735)
UPDATE creature_template SET AIName='', ScriptName='npc_archmage_landalock' WHERE entry=20735;
UPDATE creature_template SET unit_flags=unit_flags|33555200, InhabitType=4 WHERE entry IN (37849, 37850, 37851, 37853, 37854, 37855, 37856, 37858, 37859, 37861, 37862, 37864);
REPLACE INTO creature_template_addon VALUES (37855, 0, 0, 50331648, 0, 0, ''); -- Malygos
REPLACE INTO creature_template_addon VALUES (37858, 0, 0, 50331648, 0, 0, ''); -- Razorscale
REPLACE INTO creature_template_addon VALUES (37849, 0, 0, 50331648, 0, 0, ''); -- Sartharion

-- Sheddle Glossgleam <Cobbler> (29703)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=194115;
DELETE FROM smart_scripts WHERE entryorguid=194115 AND source_type=1;
INSERT INTO smart_scripts VALUES (194115, 1, 0, 1, 64, 0, 100, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Hello - Store Target');
INSERT INTO smart_scripts VALUES (194115, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 29703, 10, 0, 0, 0, 0, 0, 'On Gossip Hello - Send Target to Target');
INSERT INTO smart_scripts VALUES (194115, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 29703, 10, 0, 0, 0, 0, 0, 'On Gossip Hello - Set Data');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=29703;
DELETE FROM smart_scripts WHERE entryorguid=29703 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=29703*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (29703, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Just Summoned - Set Event Phase');
INSERT INTO smart_scripts VALUES (29703, 0, 1, 0, 38, 1, 100, 0, 1, 1, 0, 0, 80, 29703*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Set Script9');
INSERT INTO smart_scripts VALUES (29703*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Npc Flag');
INSERT INTO smart_scripts VALUES (29703*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Run');
INSERT INTO smart_scripts VALUES (29703*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Event Phase');
INSERT INTO smart_scripts VALUES (29703*100, 9, 3, 0, 0, 0, 100, 0, 500, 500, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (29703*100, 9, 4, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 5809.93, 677.06, 658.03, 0, 'Script9 - Move To Pos');
INSERT INTO smart_scripts VALUES (29703*100, 9, 5, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 5810.16, 675.93, 658.03, 0, 'Script9 - Move To Pos');
INSERT INTO smart_scripts VALUES (29703*100, 9, 6, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Bytes0');
INSERT INTO smart_scripts VALUES (29703*100, 9, 7, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove Bytes0');
INSERT INTO smart_scripts VALUES (29703*100, 9, 8, 0, 0, 0, 100, 0, 500, 500, 0, 0, 11, 62089, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (29703*100, 9, 9, 0, 0, 0, 100, 0, 500, 500, 0, 0, 1, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (29703*100, 9, 10, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Event Phase');
INSERT INTO smart_scripts VALUES (29703*100, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 128+4096, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Npc Flag');
INSERT INTO smart_scripts VALUES (29703*100, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Evade');
DELETE FROM creature_text WHERE entry=29703;
INSERT INTO creature_text VALUES (29703, 0, 0, 'Need a shoeshine, $R?', 12, 0, 100, 0, 0, 0, 0, 'Sheddle Glossgleam');
INSERT INTO creature_text VALUES (29703, 1, 0, 'Shiny!', 12, 0, 100, 0, 0, 0, 0, 'Sheddle Glossgleam');
INSERT INTO creature_text VALUES (29703, 1, 1, 'Another shiny, happy person. Take care, $C!', 12, 0, 100, 0, 0, 0, 0, 'Sheddle Glossgleam');

-- Breanni (28951)
DELETE FROM creature_text WHERE entry=28951;
INSERT INTO creature_text VALUES (28951, 0, 0, 'Greetings! Please have a look around.', 12, 0, 100, 1, 0, 0, 0, 'Breanni');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=28951;
DELETE FROM smart_scripts WHERE entryorguid=28951 AND source_type=0;
INSERT INTO smart_scripts VALUES (28951, 0, 0, 0, 10, 0, 100, 0, 1, 5, 30000, 30000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Breanni - On Out of Combat LoS - Say Line 0');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=28951;
INSERT INTO conditions VALUES (22, 1, 28951, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Run Action if invoker is a player');

-- Brassbolt Mechawrench <Steam-Powered Auctioneer> (35594)
-- Reginald Arcfire <Steam-Powered Auctioneer> (35607)
UPDATE creature_addon SET auras=NULL WHERE guid IN(SELECT guid FROM creature WHERE id IN(35594, 35607));
UPDATE creature_template_addon SET auras=NULL WHERE entry IN(35594, 35607);
UPDATE creature_template SET ScriptName='npc_steam_powered_auctioneer' WHERE entry IN(35594, 35607);
DELETE FROM spell_area WHERE spell IN(60194, 60197);

-- Mei Francis (32216) and her mounts
UPDATE creature_addon SET auras=NULL WHERE guid IN(SELECT guid FROM creature WHERE id IN(32206, 32207, 32335, 32336, 31851, 31852));
UPDATE creature_template_addon SET auras=NULL WHERE entry IN(32206, 32207, 32335, 32336, 31851, 31852);
UPDATE creature_template SET ScriptName='npc_mei_francis_mount' WHERE entry IN(32206, 32207, 32335, 32336, 31851, 31852);

-- Dalaran Visitors
DELETE FROM creature WHERE Id IN(32596, 32597, 32598, 32600, 32601, 32602);
INSERT INTO creature VALUES (NULL, 32596, 571, 1, 1, 0, 0, 5866.54, 252.983, 680.473, 1.81671, 70, 0, 0, 8225, 7809, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32597, 571, 1, 1, 0, 0, 5818.53, 225.184, 678.642, 1.60465, 151, 0, 0, 8225, 7809, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32598, 571, 1, 1, 0, 0, 5729.43, 217.839, 682.97, 1.24336, 118, 0, 0, 8508, 7981, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32600, 571, 1, 1, 0, 0, 5792.87, 226.099, 681.705, 1.38473, 135, 0, 0, 10080, 8814, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32601, 571, 1, 1, 0, 0, 5684.8, 293.537, 678.417, 1.05486, 170, 0, 0, 8800, 8139, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32602, 571, 1, 1, 0, 0, 5849.65, 230.232, 672.463, 1.92272, 93, 0, 0, 9740, 8636, 0, 0, 0, 0);
UPDATE creature_template SET unit_flags=32768|768, flags_extra=2, InhabitType=3, AIName='SmartAI', ScriptName='' WHERE entry IN(32596, 32597, 32598, 32600, 32601, 32602);
DELETE FROM smart_scripts WHERE entryorguid IN(32596, 32597, 32598, 32600, 32601, 32602) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=32596*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (32596, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 60, 1, 200, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Reset - Set Can Fly');
INSERT INTO smart_scripts VALUES (32596, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 148, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Reset - No Environment Update');
INSERT INTO smart_scripts VALUES (32596, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Reset - Set Active');
INSERT INTO smart_scripts VALUES (32596, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 53, 1, 32596, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Reset - Start WP');
INSERT INTO smart_scripts VALUES (32596, 0, 4, 5, 40, 0, 100, 0, 8, 0, 0, 0, 60, 0, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On WP Reached - Set Can Fly false');
INSERT INTO smart_scripts VALUES (32596, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 32596*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On WP Reached - Run Script');
INSERT INTO smart_scripts VALUES (32596, 0, 6, 0, 36, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Corpse Removed - Set Active');
INSERT INTO smart_scripts VALUES (32596, 0, 7, 0, 11, 0, 100, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Respawn - Set Visible False');
INSERT INTO smart_scripts VALUES (32596, 0, 8, 0, 60, 0, 100, 1, 300, 300, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Corpse Removed - Set Visible True');
INSERT INTO smart_scripts VALUES (32597, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 60, 1, 200, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Reset - Set Can Fly');
INSERT INTO smart_scripts VALUES (32597, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 148, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Reset - No Environment Update');
INSERT INTO smart_scripts VALUES (32597, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Reset - Set Active');
INSERT INTO smart_scripts VALUES (32597, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 53, 1, 32597, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Reset - Start WP');
INSERT INTO smart_scripts VALUES (32597, 0, 4, 5, 40, 0, 100, 0, 8, 0, 0, 0, 60, 0, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On WP Reached - Set Can Fly false');
INSERT INTO smart_scripts VALUES (32597, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 32596*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On WP Reached - Run Script');
INSERT INTO smart_scripts VALUES (32597, 0, 6, 0, 36, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Corpse Removed - Set Active');
INSERT INTO smart_scripts VALUES (32597, 0, 7, 0, 11, 0, 100, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Respawn- Set Visible False');
INSERT INTO smart_scripts VALUES (32597, 0, 8, 0, 60, 0, 100, 1, 300, 300, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Corpse Removed - Set Visible True');
INSERT INTO smart_scripts VALUES (32598, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 60, 1, 200, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Reset - Set Can Fly');
INSERT INTO smart_scripts VALUES (32598, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 148, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Reset - No Environment Update');
INSERT INTO smart_scripts VALUES (32598, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Reset - Set Active');
INSERT INTO smart_scripts VALUES (32598, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 53, 1, 32598, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Reset - Start WP');
INSERT INTO smart_scripts VALUES (32598, 0, 4, 5, 40, 0, 100, 0, 8, 0, 0, 0, 60, 0, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On WP Reached - Set Can Fly false');
INSERT INTO smart_scripts VALUES (32598, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 32596*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On WP Reached - Run Script');
INSERT INTO smart_scripts VALUES (32598, 0, 6, 0, 36, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Corpse Removed - Set Active');
INSERT INTO smart_scripts VALUES (32598, 0, 7, 0, 11, 0, 100, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Respawn - Set Visible False');
INSERT INTO smart_scripts VALUES (32598, 0, 8, 0, 60, 0, 100, 1, 300, 300, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Corpse Removed - Set Visible True');
INSERT INTO smart_scripts VALUES (32600, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 60, 1, 200, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Reset - Set Can Fly');
INSERT INTO smart_scripts VALUES (32600, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 148, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Reset - No Environment Update');
INSERT INTO smart_scripts VALUES (32600, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Reset - Set Active');
INSERT INTO smart_scripts VALUES (32600, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 53, 1, 32600, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Reset - Start WP');
INSERT INTO smart_scripts VALUES (32600, 0, 4, 5, 40, 0, 100, 0, 7, 0, 0, 0, 60, 0, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On WP Reached - Set Can Fly false');
INSERT INTO smart_scripts VALUES (32600, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 32596*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On WP Reached - Run Script');
INSERT INTO smart_scripts VALUES (32600, 0, 6, 0, 36, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Corpse Removed - Set Active');
INSERT INTO smart_scripts VALUES (32600, 0, 7, 0, 11, 0, 100, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Respawn - Set Visible False');
INSERT INTO smart_scripts VALUES (32600, 0, 8, 0, 60, 0, 100, 1, 300, 300, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Corpse Removed - Set Visible True');
INSERT INTO smart_scripts VALUES (32601, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 60, 1, 200, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Reset - Set Can Fly');
INSERT INTO smart_scripts VALUES (32601, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 148, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Reset - No Environment Update');
INSERT INTO smart_scripts VALUES (32601, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Reset - Set Active');
INSERT INTO smart_scripts VALUES (32601, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 53, 1, 32601, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Reset - Start WP');
INSERT INTO smart_scripts VALUES (32601, 0, 4, 5, 40, 0, 100, 0, 8, 0, 0, 0, 60, 0, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On WP Reached - Set Can Fly false');
INSERT INTO smart_scripts VALUES (32601, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 32596*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On WP Reached - Run Script');
INSERT INTO smart_scripts VALUES (32601, 0, 6, 0, 36, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Corpse Removed - Set Active');
INSERT INTO smart_scripts VALUES (32601, 0, 7, 0, 11, 0, 100, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Respawn - Set Visible False');
INSERT INTO smart_scripts VALUES (32601, 0, 8, 0, 60, 0, 100, 1, 300, 300, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Corpse Removed - Set Visible True');
INSERT INTO smart_scripts VALUES (32602, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 60, 1, 200, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Reset - Set Can Fly');
INSERT INTO smart_scripts VALUES (32602, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 148, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Reset - No Environment Update');
INSERT INTO smart_scripts VALUES (32602, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Reset - Set Active');
INSERT INTO smart_scripts VALUES (32602, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 53, 1, 32602, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Reset - Start WP');
INSERT INTO smart_scripts VALUES (32602, 0, 4, 5, 40, 0, 100, 0, 6, 0, 0, 0, 60, 0, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On WP Reached - Set Can Fly false');
INSERT INTO smart_scripts VALUES (32602, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 32596*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On WP Reached - Run Script');
INSERT INTO smart_scripts VALUES (32602, 0, 6, 0, 36, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Corpse Removed - Set Active');
INSERT INTO smart_scripts VALUES (32602, 0, 7, 0, 11, 0, 100, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Respawn - Set Visible False');
INSERT INTO smart_scripts VALUES (32602, 0, 8, 0, 60, 0, 100, 1, 300, 300, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Corpse Removed - Set Visible True');
INSERT INTO smart_scripts VALUES (32596*100, 9, 0, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 43, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Script - Dismount');
INSERT INTO smart_scripts VALUES (32596*100, 9, 1, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 5830.49, 513.89, 657.75, 0, 'Dalaran Visitor - On Script - Move To Position');
INSERT INTO smart_scripts VALUES (32596*100, 9, 2, 0, 0, 0, 100, 0, 11000, 11000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dalaran Visitor - On Script - Despawn');
DELETE FROM waypoints WHERE entry IN(32596, 32597, 32598, 32600, 32601, 32602);
INSERT INTO waypoints VALUES (32596, 1, 5863.84, 263.72, 679.786, 'Dalaran Visitor'),(32596, 2, 5849.81, 297.062, 679.055, 'Dalaran Visitor'),(32596, 3, 5838.59, 326.429, 677.155, 'Dalaran Visitor'),(32596, 4, 5825.01, 353.455, 675.249, 'Dalaran Visitor'),(32596, 5, 5811.08, 379.017, 673.138, 'Dalaran Visitor'),(32596, 6, 5803.46, 400.867, 670.357, 'Dalaran Visitor'),(32596, 7, 5800.55, 423.251, 664.603, 'Dalaran Visitor'),(32596, 8, 5800.01, 437.574, 658.823, 'Dalaran Visitor'),(32597, 1, 5817.67, 250.508, 680.734, 'Dalaran Visitor'),(32597, 2, 5816.19, 285.423, 678.864, 'Dalaran Visitor'),(32597, 3, 5815.88, 294.706, 678.238, 'Dalaran Visitor'),(32597, 4, 5818.04, 328.345, 675.613, 'Dalaran Visitor'),(32597, 5, 5822.43, 386.194, 669.118, 'Dalaran Visitor'),(32597, 6, 5823.11, 404.667, 666.354, 'Dalaran Visitor'),(32597, 7, 5823.56, 417.179, 663.648, 'Dalaran Visitor'),(32597, 8, 5823.93, 427.31, 658.912, 'Dalaran Visitor'),(32598, 1, 5729.43, 217.839, 682.97, 'Dalaran Visitor'),(32598, 2, 5740.12, 251.148, 681.958, 'Dalaran Visitor'),(32598, 3, 5755.97, 293.67, 679.579, 'Dalaran Visitor'),(32598, 4, 5798.92, 349.589, 674.791, 'Dalaran Visitor'),(32598, 5, 5813.64, 373.246, 672.24, 'Dalaran Visitor'),(32598, 6, 5822.62, 398.153, 668.902, 'Dalaran Visitor'),(32598, 7, 5820.71, 418.575, 664.116, 'Dalaran Visitor'),(32598, 8, 5811.2, 432.381, 658.771, 'Dalaran Visitor'),(32600, 1, 5792.87, 226.099, 681.705, 'Dalaran Visitor'),(32600, 2, 5797.38, 291.058, 676.097, 'Dalaran Visitor'),(32600, 3, 5795.82, 326.001, 674.99, 'Dalaran Visitor'),(32600, 4, 5792.52, 360.816, 673.748, 'Dalaran Visitor'),(32600, 5, 5798.06, 412.453, 668.894, 'Dalaran Visitor'),(32600, 6, 5806.63, 424.174, 664.422, 'Dalaran Visitor'),(32600, 7, 5819.52, 434.388, 658.769, 'Dalaran Visitor'),(32601, 1, 5684.8, 293.537, 678.417, 'Dalaran Visitor'),(32601, 2, 5684.8, 293.537, 678.417, 'Dalaran Visitor'),(32601, 3, 5747.12, 324.974, 673.387, 'Dalaran Visitor'),(32601, 4, 5789.12, 356.173, 672.099, 'Dalaran Visitor'),(32601, 5, 5802.1, 371.188, 671.09, 'Dalaran Visitor'),(32601, 6, 5823.94, 406.387, 666.15, 'Dalaran Visitor'),(32601, 7, 5829.2, 430.961, 660.949, 'Dalaran Visitor'),(32601, 8, 5827.39, 436.338, 659.402, 'Dalaran Visitor'),(32602, 1, 5843.6, 249.131, 671.836, 'Dalaran Visitor'),(32602, 2, 5834.95, 283.034, 670.949, 'Dalaran Visitor'),(32602, 3, 5826.04, 316.863, 669.909, 'Dalaran Visitor'),(32602, 4, 5816.48, 350.5, 668.479, 'Dalaran Visitor'),(32602, 5, 5802.57, 402.222, 664.969, 'Dalaran Visitor'),(32602, 6, 5804.38, 425.957, 658.787, 'Dalaran Visitor');
