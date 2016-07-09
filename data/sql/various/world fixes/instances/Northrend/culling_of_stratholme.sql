-- Enable Map
DELETE FROM disables WHERE sourceType=2 AND entry=595;
REPLACE INTO areatrigger_teleport VALUES(5181, "Culling of Stratholme (exit 2)", 1, -8756.87, -4459.29, -200.73, 1.32);
-- -----------------------
-- Chromie data
-- -----------------------
REPLACE INTO creature_template VALUES (26527, 0, 0, 0, 0, 0, 10008, 0, 0, 0, 'Chromie', '', '', 9586, 80, 80, 2, 35, 3, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 33536, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_cos_chromie_start', 12340);
REPLACE INTO creature_template VALUES (27915, 0, 0, 0, 0, 0, 10008, 0, 0, 0, 'Chromie', '', '', 9610, 80, 80, 2, 35, 3, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 33536, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_cos_chromie_middle', 12340);

DELETE FROM creature_text WHERE entry=27915;
INSERT INTO creature_text VALUES (27915, 0, 0, 'Good work with the crates! Come talk to me in front of Stratholme for your next assignment!', 15, 0, 0, 0, 0, 0, 0, 'Chromie - SAY_EVENT_START');
INSERT INTO creature_text VALUES (27915, 1, 0, 'Adventurers you must hurry! The Guardian of Time cannot last for much longer!', 15, 0, 0, 0, 0, 0, 0, 'Chromie - SAY_EVENT_TIME_GUARDIAN_FADING');
INSERT INTO creature_text VALUES (27915, 2, 0, 'I can barely sense the Guardian of Time! His timeline if fading quickly!', 15, 0, 0, 0, 0, 0, 0, 'Chromie - SAY_EVENT_TIME_GUARDIAN_FADING');

DELETE FROM gossip_menu WHERE text_id IN(12939, 12949, 12950, 12952, 12992, 12993, 12994, 12995, 15704);
REPLACE INTO gossip_menu VALUES(9586, 12939);
REPLACE INTO gossip_menu VALUES(9594, 12949);
REPLACE INTO gossip_menu VALUES(9595, 12950);
REPLACE INTO gossip_menu VALUES(9596, 12952);
REPLACE INTO gossip_menu VALUES(9610, 12992);
REPLACE INTO gossip_menu VALUES(9611, 12993);
REPLACE INTO gossip_menu VALUES(9612, 12994);
REPLACE INTO gossip_menu VALUES(9613, 12995);
REPLACE INTO gossip_menu VALUES(11277, 15704);
DELETE FROM npc_text WHERE ID IN(12939, 12949, 12950, 12952, 12992, 12993, 12994, 12995);
INSERT INTO npc_text VALUES (12939, "Welcome, adventurer. You've come just in the nick of time.", '', 0, 1, 0, 1, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 12340);
INSERT INTO npc_text VALUES (12949, "The Infinite Dragonflight is attempting to alter the destiny of Prince Arthas Menethil. You know him now as the Lich King, but here and now he was still a Prince of Lordaeron trying to do what was best for his kingdom. Arthas makes a very fateful choice today, leading to something we Keepers of Time call an inflection point in the timeline.", '', 0, 1, 0, 1, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 12340);
INSERT INTO npc_text VALUES (12950, "Arthas gave the order to cull Stratholme, killing every single human within its walls. He discovered evidence that the Scourge had infected the city with their insidious plague, and the disease doesn't just kill people. Those who die to this plague rise up as mindless zombies, further fueling the Scourge's war machine.", '', 0, 1, 0, 1, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 12340);
INSERT INTO npc_text VALUES (12952, "The Infinites are attempting something unusually subtle for them. They are trying to hide the evidence that will lead to Arthas deciding to cull Stratholme. Their agents have used illusionary magic on the plagued grain shipments in the nearby countryside to make them appear normal. I need you to find the hidden grain, and use this Arcane Disruptor on the shipments. Arthas' men are looking for plagued grain, and should find it quickly with the illusion gone.", '', 0, 1, 0, 1, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 12340);
INSERT INTO npc_text VALUES (12992, "Good work! Arthas now knows about the plagued grain in Stratholme, and is about to begin the culling. Something is still not quite right, though. I sense a foreign presence in this timeline besides us, and that must mean the Infinite Dragonflight are here somewhere.", '', 0, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 12340);
INSERT INTO npc_text VALUES (12993, "I don't know, and that worries me. I'll do everything I can to find the Infinites. What I need you to do now is stay close to Arthas by joining his army.", '', 0, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 12340);
INSERT INTO npc_text VALUES (12994, "Well, you're not going to sign recruitment papers or anything, but you are going to fight alongside him. You need to make sure Arthas culls Stratholme and defeats Mal'Ganis. Without Uther and Jaina around, he'll need all the help he can get. If you talk to Arthas, he'll put you to work destroying the forces of Mal'Ganis. Follow along until I can figure out what's going on with the Infinites. I'll contact you again when I know more.", '', 0, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 12340);
INSERT INTO npc_text VALUES (12995, "Good luck, and be safe. Here comes Uther and Jaina now.", '', 0, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 12340);

DELETE FROM gossip_menu_option WHERE menu_id IN(9586, 9594, 9595, 9596, 9610, 9611, 9612, 9613, 11277, 30202, 30203, 30204, 30205, 30206);
INSERT INTO gossip_menu_option VALUES (9586, 1, 0, 'Why have I been sent back to this particular place and time?', 1, 1, 9594, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (9586, 2, 0, "Chromie, you and i both know what's going to happen in this time stream. We've seen this all before. Can you just skip us ahead to all the real action?", 1, 1, 11277, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (9594, 1, 0, 'What was this decision?', 1, 1, 9595, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (9595, 1, 0, 'So how does the Infinite Dragonflight plan to interfere?', 1, 1, 9596, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (9610, 1, 0, 'What do you think they are up to?', 1, 1, 9611, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (9611, 1, 0, 'You want me to do what?', 1, 1, 9612, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (9612, 1, 0, 'Very well, Chromie.', 1, 1, 9613, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (11277, 1, 0, 'Yes, please!', 1, 1, 0, 0, 0, 0, '');

DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=9586;
INSERT INTO conditions VALUES (15, 9586, 2, 0, 0, 8, 0, 13151, 0, 0, 0, 0, 0, '', 'CoS - Event skip, requires quest rewarded');
-- -----------------------
-- Arthas
-- -----------------------
REPLACE INTO creature_template VALUES (26499, 31210, 0, 0, 0, 0, 24949, 0, 0, 0, 'Arthas', 'Prince of Lordaeron', '', 0, 80, 80, 2, 2076, 1, 1, 1.14286, 1, 1, 417, 582, 0, 608, 4, 2000, 0, 2, 32768, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 7, 4096, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 3.5, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_arthas', 12340);
REPLACE INTO creature_template VALUES (31210, 0, 0, 0, 0, 0, 24949, 0, 0, 0, 'Arthas (1)', 'Prince of Lordaeron', '', 0, 80, 80, 2, 2076, 1, 1, 1.14286, 1, 1, 417, 582, 0, 608, 8, 2000, 0, 2, 32768, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 7, 4096, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 5, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);

DELETE FROM npc_text WHERE ID IN(13076, 13125, 13126, 13177, 13179, 13287);
INSERT INTO npc_text VALUES (13076, 'Are you ready to do whatever must be done to protect Lordaeron?', '', 0, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 12340);
INSERT INTO npc_text VALUES (13125, 'You must be one of the brave soldiers who have been fighting the Scourge forces of Mal\'Ganis. Well done.', '', 0, 1, 0, 396, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 12340);
INSERT INTO npc_text VALUES (13126, 'Indeed. Mal\'Ganis is commanding the Scourge from Crusaders\' Square, but the gates leading there from the city entrance are closed. Little does he know that a small force can still reach the Square by moving through the Town Hall. Will you join me in this attack?', '', 0, 1, 0, 396, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 12340);
INSERT INTO npc_text VALUES (13177, 'Gather your senses quickly, we must press on.', '', 0, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 12340);
INSERT INTO npc_text VALUES (13179, 'This isn\'t getting any easier. Stratholme is burning. We must brave the Scourge and the flames to reach Mal\'Ganis. Prepare yourselves.', '', 0, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 12340);
INSERT INTO npc_text VALUES (13287, 'Are you ready to face Mal\'Ganis with me?', '', 0, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 12340);

-- -----------------------
-- Dispelling Illusions quest
-- -----------------------
UPDATE creature_template SET modelid1=17200, modelid2=0 WHERE entry=27827;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=49590;
INSERT INTO conditions VALUES(13, 1, 49590, 0, 0, 31, 0, 3, 27827, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 49590, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
UPDATE quest_template SET RequiredNpcOrGo1=30996 WHERE Id=13149;

-- -----------------------
-- Arthas is reached at the bridge
-- -----------------------
REPLACE INTO creature VALUES (202333, 26499, 595, 3, 1, 0, 1, 1938.05, 1289.79, 145.38, 3.18, 25, 0, 0, 44100, 7988, 0, 0, 0, 0);
UPDATE script_waypoint SET waittime=10000 WHERE entry=26499 AND pointid=3;
UPDATE script_waypoint SET waittime=0 WHERE entry=26499 AND pointid IN(2, 4);
-- -----------------------
-- Arthas moved to city
-- -----------------------
DELETE FROM creature_addon WHERE guid IN(132359, 132326);
DELETE FROM creature WHERE guid IN(132359, 132326);
UPDATE script_waypoint SET waittime=1000 WHERE entry=26499 AND pointId=10;
UPDATE creature_template SET modelid1=14501, modelid2=0 WHERE entry=20562;
REPLACE INTO creature_template VALUES (28167, 0, 0, 0, 0, 0, 25168, 25169, 25311, 25312, 'Stratholme Citizen', '', '', 0, 77, 79, 0, 190, 0, 1, 1.14286, 1, 0, 404, 564, 0, 582, 1, 2000, 0, 1, 256, 2048, 8, 0, 0, 0, 0, 0, 334, 494, 95, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 96, 1, 0, 0, 'npc_cos_stratholme_citizien', 12340);
REPLACE INTO creature_template VALUES (28169, 0, 0, 0, 0, 0, 25171, 25172, 25313, 25314, 'Stratholme Resident', '', '', 0, 78, 79, 0, 2078, 0, 1, 1.14286, 1, 0, 404, 564, 0, 582, 1, 2000, 0, 1, 256, 2048, 8, 0, 0, 0, 0, 0, 334, 494, 95, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 96, 1, 0, 0, 'npc_cos_stratholme_citizien', 12340);
REPLACE INTO creature_template VALUES (31126, 0, 0, 0, 0, 0, 25168, 25169, 0, 0, 'Agitated Stratholme Citizen', '', '', 0, 80, 80, 2, 190, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 256, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_cos_stratholme_citizien', 12340);
REPLACE INTO creature_template VALUES (31127, 0, 0, 0, 0, 0, 25313, 25314, 0, 0, 'Agitated Stratholme Resident', '', '', 0, 80, 80, 2, 190, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 256, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_cos_stratholme_citizien', 12340);
REPLACE INTO points_of_interest VALUES(1000, 2164, 1255, 7, 99, 0, "First Wave");
REPLACE INTO points_of_interest VALUES(1001, 2254, 1163, 7, 99, 0, "Second Wave");
REPLACE INTO points_of_interest VALUES(1002, 2348, 1202, 7, 99, 0, "Third Wave");
REPLACE INTO points_of_interest VALUES(1003, 2139, 1356, 7, 99, 0, "Forth Wave");
REPLACE INTO points_of_interest VALUES(1004, 2351, 1197, 7, 99, 0, "Meathook");
REPLACE INTO points_of_interest VALUES(1005, 2164, 1255, 7, 99, 0, "Sixth Wave");
REPLACE INTO points_of_interest VALUES(1006, 2349, 1188, 7, 99, 0, "Seventh Wave");
REPLACE INTO points_of_interest VALUES(1007, 2145, 1355, 7, 99, 0, "Eight Wave");
REPLACE INTO points_of_interest VALUES(1008, 2172, 1259, 7, 99, 0, "Nineth Wave");
REPLACE INTO points_of_interest VALUES(1009, 2351, 1197, 7, 99, 0, "Salramm the Fleshcrafter");
-- -----------------------
-- After city intro
-- -----------------------
REPLACE INTO creature_template VALUES (28249, 31179, 0, 0, 0, 0, 569, 0, 0, 0, 'Devouring Ghoul', '', '', 0, 77, 80, 2, 2075, 0, 0.777776, 1.14286, 1, 1, 422, 586, 0, 642, 7.5, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 8, 28249, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 4, 1, 1, 0, 42108, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (31179, 0, 0, 0, 0, 0, 569, 0, 0, 0, 'Devouring Ghoul (1)', '', '', 0, 80, 80, 2, 2075, 0, 0.777776, 1.14286, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 8, 28249, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (28200, 31184, 0, 0, 0, 0, 25200, 0, 0, 0, 'Dark Necromancer', '', '', 0, 79, 80, 2, 2075, 0, 1, 1.14286, 1, 1, 346, 499, 0, 287, 7.5, 2000, 0, 8, 32832, 2048, 8, 0, 0, 0, 0, 0, 315, 468, 69, 7, 8, 28200, 28200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 4, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (31184, 0, 0, 0, 0, 0, 25200, 0, 0, 0, 'Dark Necromancer (1)', '', '', 0, 80, 80, 2, 2075, 0, 1, 1.14286, 1, 1, 346, 499, 0, 287, 13, 2000, 0, 8, 32832, 2048, 8, 0, 0, 0, 0, 0, 315, 468, 69, 7, 8, 28200, 28200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 5, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (28199, 31188, 0, 0, 0, 0, 25199, 0, 0, 0, 'Tomb Stalker', '', '', 0, 79, 80, 2, 2075, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 7.5, 1500, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 8, 28199, 0, 70205, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 4, 1, 1, 0, 42108, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (31188, 0, 0, 0, 0, 0, 25199, 0, 0, 0, 'Tomb Stalker (1)', '', '', 0, 80, 80, 2, 2075, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 13, 1500, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 8, 28199, 0, 70205, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (27734, 31187, 0, 0, 0, 0, 9793, 0, 0, 0, 'Crypt Fiend', '', '', 0, 80, 80, 2, 2075, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 7.5, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 8, 27734, 0, 70205, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 4, 1, 1, 0, 42108, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (31187, 0, 0, 0, 0, 0, 9793, 0, 0, 0, 'Crypt Fiend (1)', '', '', 0, 80, 80, 2, 2075, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 8, 27734, 0, 70205, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (28201, 31200, 0, 0, 0, 0, 25281, 0, 0, 0, 'Bile Golem', '', '', 0, 81, 81, 2, 2075, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 8, 28201, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 8, 1, 1, 0, 42108, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (31200, 0, 0, 0, 0, 0, 25281, 0, 0, 0, 'Bile Golem (1)', '', '', 0, 81, 81, 2, 2075, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 8, 28201, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 10, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (27729, 31178, 0, 0, 0, 0, 519, 0, 0, 0, 'Enraging Ghoul', '', '', 0, 80, 80, 2, 2075, 0, 0.777776, 1.14286, 1, 1, 422, 586, 0, 642, 7.5, 1500, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 8, 27729, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 4, 1, 1, 0, 42108, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (31178, 0, 0, 0, 0, 0, 519, 0, 0, 0, 'Enraging Ghoul (1)', '', '', 0, 80, 80, 2, 2075, 0, 0.777776, 1.14286, 1, 1, 422, 586, 0, 642, 13, 1500, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 8, 27729, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (27736, 31199, 0, 0, 0, 0, 25282, 0, 0, 0, 'Patchwork Construct', '', '', 0, 80, 81, 2, 2075, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 1200, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 8, 27736, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 8, 1, 1, 0, 42108, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (31199, 0, 0, 0, 0, 0, 25282, 0, 0, 0, 'Patchwork Construct (1)', '', '', 0, 81, 81, 2, 2075, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 13, 1200, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 8, 27736, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 10, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
-- SMART SCRIPTS
-- Devouring Ghoul
DELETE FROM smart_scripts WHERE entryorguid IN(28249, 28200, 28199, 27734, 28201, 27729, 27736) AND source_type=0;
INSERT INTO smart_scripts VALUES(28249, 0, 0, 0, 0, 0, 100, 2, 15000, 20000, 15000, 20000, 11, 52352, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(28249, 0, 1, 0, 0, 0, 100, 4, 15000, 20000, 15000, 20000, 11, 58758, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Dark Necromancer
INSERT INTO smart_scripts VALUES(28200, 0, 0, 0, 0, 0, 100, 2, 0, 2000, 6000, 7000, 11, 15537, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(28200, 0, 1, 0, 0, 0, 100, 4, 0, 2000, 6000, 7000, 11, 61558, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(28200, 0, 2, 0, 0, 0, 100, 2, 14000, 18000, 15000, 21000, 11, 58772, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(28200, 0, 3, 0, 0, 0, 100, 4, 14000, 18000, 15000, 21000, 11, 58770, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(28200, 0, 4, 0, 0, 0, 100, 0, 7000, 11000, 21000, 25000, 11, 20812, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Tomb Stalker
INSERT INTO smart_scripts VALUES(28199, 0, 0, 0, 0, 0, 100, 2, 1500, 2000, 5000, 8000, 11, 52522, 0, 0, 0, 0, 0, 18, 20, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(28199, 0, 1, 0, 0, 0, 100, 4, 1500, 2000, 5000, 8000, 11, 58782, 0, 0, 0, 0, 0, 18, 20, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Crypt Fiend
INSERT INTO smart_scripts VALUES(27734, 0, 0, 0, 0, 0, 100, 0, 1000, 2000, 10000, 13000, 11, 52496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(27734, 0, 1, 0, 0, 0, 100, 0, 5000, 7000, 12000, 15000, 11, 52491, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Bile Golem
INSERT INTO smart_scripts VALUES(28201, 0, 0, 0, 0, 0, 100, 2, 5000, 12000, 21000, 27000, 11, 52527, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(28201, 0, 1, 0, 0, 0, 100, 4, 5000, 12000, 21000, 27000, 11, 58810, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Enraging Ghoul
INSERT INTO smart_scripts VALUES(27729, 0, 0, 0, 0, 0, 100, 0, 5000, 9000, 16000, 24000, 11, 52461, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Patchwork Construct
INSERT INTO smart_scripts VALUES(27736, 0, 0, 0, 25, 0, 100, 2, 0, 0, 0, 0, 11, 52525, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell Reset");
INSERT INTO smart_scripts VALUES(27736, 0, 1, 0, 25, 0, 100, 4, 0, 0, 0, 0, 11, 58808, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell Reset");

-- -----------------------
-- Town hall start
-- -----------------------
UPDATE creature_text SET text="*gurgles*", type=16 WHERE entry=26532 AND groupid=4;
UPDATE script_waypoint SET location_z=134.382 WHERE entry=26499 AND pointid = 21;
REPLACE INTO creature_template VALUES (27742, 31202, 0, 0, 0, 0, 19059, 0, 0, 0, 'Infinite Adversary', '', '', 0, 79, 80, 2, 2075, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 7.5, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 2, 8, 27742, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 4, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (31202, 0, 0, 0, 0, 0, 19059, 0, 0, 0, 'Infinite Adversary (1)', '', '', 0, 80, 80, 2, 2075, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 2, 8, 27742, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (27743, 31206, 0, 0, 0, 0, 19058, 0, 0, 0, 'Infinite Hunter', '', '', 0, 79, 80, 2, 2075, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 7.5, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 2, 8, 27743, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 4, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (31206, 0, 0, 0, 0, 0, 19058, 0, 0, 0, 'Infinite Hunter (1)', '', '', 0, 80, 80, 2, 2075, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 2, 8, 27743, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (27744, 31203, 0, 0, 0, 0, 19061, 0, 0, 0, 'Infinite Agent', '', '', 0, 79, 80, 2, 2075, 0, 1, 1.14286, 1, 1, 346, 499, 0, 287, 7.5, 2000, 0, 8, 32832, 2048, 8, 0, 0, 0, 0, 0, 315, 468, 69, 2, 8, 27744, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 4, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (31203, 0, 0, 0, 0, 0, 19061, 0, 0, 0, 'Infinite Agent (1)', '', '', 0, 80, 80, 2, 2075, 0, 1, 1.14286, 1, 1, 346, 499, 0, 287, 13, 2000, 0, 8, 32832, 2048, 8, 0, 0, 0, 0, 0, 315, 468, 69, 2, 8, 27744, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 5, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
-- SMART SCRIPTS
-- Infinite Adversary
DELETE FROM smart_scripts WHERE entryorguid IN(27742, 27743, 27744) AND source_type=0;
INSERT INTO smart_scripts VALUES(27742, 0, 0, 0, 0, 0, 100, 2, 16000, 21000, 21000, 29000, 11, 52634, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(27742, 0, 1, 0, 0, 0, 100, 4, 16000, 21000, 21000, 29000, 11, 58813, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(27742, 0, 2, 0, 0, 0, 100, 0, 5000, 6000, 9000, 13000, 11, 52633, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Infinite Hunter
INSERT INTO smart_scripts VALUES(27743, 0, 0, 0, 8, 0, 100, 2, 0, 0, 1000, 1000, 11, 52635, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell on Spell Hit");
INSERT INTO smart_scripts VALUES(27743, 0, 1, 0, 8, 0, 100, 4, 0, 0, 1000, 1000, 11, 58820, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell on Spell Hit");
-- Infinite Agent
INSERT INTO smart_scripts VALUES(27744, 0, 0, 0, 0, 0, 100, 2, 5000, 9000, 12000, 17000, 11, 52660, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(27744, 0, 1, 0, 0, 0, 100, 4, 5000, 9000, 12000, 17000, 11, 58817, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(27744, 0, 2, 0, 0, 0, 100, 2, 9000, 12000, 15000, 21000, 11, 52657, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(27744, 0, 3, 0, 0, 0, 100, 4, 9000, 12000, 15000, 21000, 11, 58816, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");



-- -----------------------
-- Bosses
-- -----------------------
-- Meathook
REPLACE INTO creature_template VALUES (26529, 31211, 0, 0, 0, 0, 26579, 0, 0, 0, 'Meathook', '', '', 0, 82, 82, 2, 2075, 0, 1, 1.14286, 1, 1, 488, 642, 0, 782, 7.5, 1600, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 6, 72, 26529, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 25, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 617299839, 0+0x200000, 'boss_meathook', 12340);
REPLACE INTO creature_template VALUES (31211, 0, 0, 0, 0, 0, 26579, 0, 0, 0, 'Meathook (1)', '', '', 0, 82, 82, 2, 2075, 0, 1, 1.14286, 1, 1, 488, 642, 0, 782, 13, 1600, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 6, 72, 31211, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 31.25, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 617299839, 1+0x200000, '', 12340);
-- Salramm
REPLACE INTO creature_template VALUES (26530, 31212, 0, 0, 0, 0, 26581, 0, 0, 0, 'Salramm the Fleshcrafter', '', '', 0, 82, 82, 2, 2075, 0, 1, 1.14286, 1, 1, 463, 640, 0, 726, 7.5, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 360, 520, 91, 7, 72, 26530, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 25, 15, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 617299839, 0+0x200000, 'boss_salramm', 12340);
REPLACE INTO creature_template VALUES (31212, 0, 0, 0, 0, 0, 26581, 0, 0, 0, 'Salramm the Fleshcrafter (1)', '', '', 0, 82, 82, 2, 2075, 0, 1, 1.14286, 1, 1, 463, 640, 0, 726, 13, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 360, 520, 91, 7, 72, 31212, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 31.25, 15, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 617299839, 1+0x200000, '', 12340);
DELETE FROM spell_script_names WHERE spell_id IN(52708);
INSERT INTO spell_script_names VALUES(52708, "spell_boss_salramm_steal_flesh");
-- Epoch
REPLACE INTO creature_template VALUES (26532, 31215, 0, 0, 0, 0, 26580, 0, 0, 0, 'Chrono-Lord Epoch', '', '', 0, 82, 82, 2, 2075, 0, 1, 1.14286, 1, 1, 463, 640, 0, 726, 7.5, 2000, 0, 2, 33600, 2048, 8, 0, 0, 0, 0, 0, 360, 520, 91, 2, 72, 26532, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 25, 10, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 617299839, 0+0x200000, 'boss_epoch', 12340);
REPLACE INTO creature_template VALUES (31215, 0, 0, 0, 0, 0, 26580, 0, 0, 0, 'Chrono-Lord Epoch (1)', '', '', 0, 82, 82, 2, 2075, 0, 1, 1.14286, 1, 1, 463, 640, 0, 726, 13, 2000, 0, 2, 33600, 2048, 8, 0, 0, 0, 0, 0, 360, 520, 91, 2, 72, 31215, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 31.25, 10, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 617299839, 1+0x200000, '', 12340);
-- Infinite Corruptor
REPLACE INTO creature_template VALUES (32281, 0, 0, 0, 0, 0, 17555, 0, 0, 0, 'Guardian of Time', '', '', 0, 80, 80, 2, 35, 0, 0.888888, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 2, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (32273, 32313, 0, 0, 0, 0, 19326, 0, 0, 0, 'Infinite Corruptor', '', '', 0, 82, 82, 2, 1720, 0, 1, 1.14286, 1, 1, 488, 642, 0, 782, 7.5, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 2, 72, 0, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 25, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 617299839, 0+0x200000, 'boss_infinite_corruptor', 12340);
REPLACE INTO creature_template VALUES (32313, 0, 0, 0, 0, 0, 19326, 0, 0, 0, 'Infinite Corruptor (1)', '', '', 0, 82, 82, 2, 1720, 0, 1, 1.14286, 1, 1, 488, 642, 0, 782, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 2, 72, 32313, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 31, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 617299839, 1+0x200000, '', 12340);

DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=60422;
INSERT INTO conditions VALUES(13, 1, 60422, 0, 0, 31, 0, 3, 32281, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 60422, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
REPLACE INTO creature_template_addon VALUES(32281, 0, 0, 0, 1, 0, "60451");
-- Mal'Ganis
REPLACE INTO creature_template VALUES (26533, 31217, 0, 0, 0, 0, 26582, 0, 0, 0, 'Mal\'Ganis', '', '', 0, 82, 82, 2, 2075, 0, 1, 1.14286, 1, 1, 463, 640, 0, 726, 7.5, 2000, 0, 2, 33600, 2048, 8, 0, 0, 0, 0, 0, 360, 520, 91, 3, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 30, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 617299839, 0+0x200000, 'boss_mal_ganis', 12340);
REPLACE INTO creature_template VALUES (31217, 0, 0, 0, 0, 0, 26582, 0, 0, 0, 'Mal\'Ganis (1)', '', '', 0, 82, 82, 2, 2075, 0, 1, 1.14286, 1, 1, 463, 640, 0, 726, 13, 2000, 0, 2, 33600, 2048, 8, 0, 0, 0, 0, 0, 360, 520, 91, 3, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 37.5, 10, 1, 0, 43697, 0, 0, 0, 0, 0, 0, 1, 617299839, 1+0x200000, '', 12340);
DELETE FROM gameobject WHERE id IN(190663, 193597);
UPDATE gameobject_template SET flags=0 WHERE entry IN(190663, 193597);

-- -----------------------
-- Achievements
-- -----------------------
-- Zombiefest! (1872)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7180);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7180);
INSERT INTO achievement_criteria_data VALUES(7180, 12, 1, 0, "");

-- The Culling of Time (1817)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7494);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7494);
INSERT INTO achievement_criteria_data VALUES(7494, 12, 1, 0, "");

-- The Culling of Stratholme (479)
DELETE FROM disables WHERE sourceType=4 AND entry IN(211, 212, 213, 6381);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(211, 212, 213, 6381);
INSERT INTO achievement_criteria_data VALUES(211, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(212, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(213, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(6381, 12, 0, 0, "");

-- Heroic: The Culling of Stratholme (500)
DELETE FROM disables WHERE sourceType=4 AND entry IN(6805, 6806, 6807, 6808);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(6805, 6806, 6807, 6808);
INSERT INTO achievement_criteria_data VALUES(6805, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(6806, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(6807, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(6808, 12, 1, 0, "");

-- -----------------------
-- Spawns
-- -----------------------
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE map=595);
DELETE FROM creature WHERE map=595;
INSERT INTO creature VALUES (NULL, 30996, 595, 3, 1, 0, 0, 1570.92, 669.933, 102.309, -1.64061, 180, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2560.9, 1150.95, 128.075, 3.895, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2566.14, 1156.29, 127.231, 1.41707, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2565.77, 1146.87, 127.616, 1.9158, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2573.88, 1147.45, 126.579, 5.64251, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27734, 595, 3, 1, 0, 0, 2555.04, 1236.94, 125.605, 5.00007, 300, 0, 0, 50400, 0, 2, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28249, 595, 3, 1, 0, 0, 2551.01, 1235.45, 125.498, 5.07468, 300, 0, 0, 50400, 0, 2, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 31126, 595, 3, 1, 0, 0, 2146.74, 1340.59, 132.63, 5.95157, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 31126, 595, 3, 1, 0, 0, 2263.93, 1145.6, 138.574, 5.96903, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 31126, 595, 3, 1, 0, 0, 2264.35, 1150.03, 138.509, 5.49779, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 31126, 595, 3, 1, 0, 0, 2269.03, 1148.83, 138.2, 4.45059, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 31126, 595, 3, 1, 0, 0, 2364.08, 1197.37, 131.802, 0.279253, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 31126, 595, 3, 1, 0, 0, 2359.56, 1193.14, 131.06, 0.541052, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 31126, 595, 3, 1, 0, 0, 2360.74, 1199.86, 131.311, 0.10472, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 31127, 595, 3, 1, 0, 0, 2265.5, 1147.49, 138.52, 5.49779, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 31127, 595, 3, 1, 0, 0, 2262.04, 1144.46, 138.574, 6.26573, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 31127, 595, 3, 1, 0, 0, 2261.13, 1148.74, 138.574, 5.75959, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 31127, 595, 3, 1, 0, 0, 2364.97, 1199.68, 132.162, 6.24828, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 31127, 595, 3, 1, 0, 0, 2363.06, 1194.18, 131.545, 0.523599, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 31127, 595, 3, 1, 0, 0, 2365.8, 1191.65, 132.187, 0.942478, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 26527, 595, 3, 1, 0, 1, 1550.08, 574.412, 92.7899, 3.82227, 300, 0, 0, 17010, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27827, 595, 3, 1, 0, 0, 1629.73, 731.369, 113.029, 5.5676, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27827, 595, 3, 1, 0, 0, 1674.44, 872.292, 120.589, 0.733038, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27827, 595, 3, 1, 0, 0, 1579.51, 621.45, 99.9192, 5.60251, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27827, 595, 3, 1, 0, 0, 1570.92, 669.919, 102.492, 2.54818, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27827, 595, 3, 1, 0, 0, 1628.98, 812.211, 120.881, 4.99164, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27876, 595, 3, 1, 0, 0, 1563.34, 671.641, 102.241, 4.2586, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27877, 595, 3, 1, 0, 0, 1561.57, 670.32, 102.244, 0.575959, 300, 0, 0, 4050, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27884, 595, 3, 1, 0, 0, 1636.7, 725.642, 113.662, 0.893359, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27885, 595, 3, 1, 0, 0, 1603.48, 749.68, 114.846, 1.3461, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28656, 595, 3, 1, 0, 0, 1547.97, 576.521, 92.79, 5.67232, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27903, 595, 3, 1, 0, 0, 1588.94, 597.98, 99.4726, 2.80998, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27907, 595, 3, 1, 0, 0, 1670.26, 872.873, 120.135, 0.418879, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28167, 595, 3, 1, 0, 0, 2190.07, 1308.66, 132.4, 5.32325, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28167, 595, 3, 1, 0, 0, 2157.32, 1260.45, 134.938, 0.610865, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28167, 595, 3, 1, 0, 0, 2166.87, 1239.08, 137.51, 2.18166, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28167, 595, 3, 1, 0, 0, 2340.44, 1190.88, 130.928, 4.11898, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28167, 595, 3, 1, 0, 0, 2165.94, 1366.51, 132.382, 3.89208, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28167, 595, 3, 1, 0, 0, 2164.57, 1339.05, 130.914, 2.58309, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27911, 595, 3, 1, 0, 0, 1676.15, 883.878, 119.783, 1.50098, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28167, 595, 3, 1, 0, 0, 2124.39, 1296.53, 136.844, 4.81711, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28167, 595, 3, 1, 0, 0, 2119.7, 1273.87, 138.337, 3.80482, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28167, 595, 3, 1, 0, 0, 2105.57, 1270.86, 140.05, 1.309, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28167, 595, 3, 1, 0, 0, 2107.38, 1274.3, 138.996, 4.01426, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28167, 595, 3, 1, 0, 0, 2252.07, 1150.73, 138.574, 0.523599, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28167, 595, 3, 1, 0, 0, 2366.37, 1184.53, 132.22, 2.9147, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28167, 595, 3, 1, 0, 0, 2152.13, 1290.85, 134.751, 4.38078, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28167, 595, 3, 1, 0, 0, 2191.38, 1306.04, 133.207, 4.2586, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2565.21, 1138.04, 127.759, 1.63305, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28167, 595, 3, 1, 0, 0, 2120.65, 1339.69, 131.547, 4.15388, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28167, 595, 3, 1, 0, 0, 2359.66, 1204.97, 131.211, 4.04916, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28167, 595, 3, 1, 0, 0, 2104.39, 1366.97, 133.172, 5.44543, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28167, 595, 3, 1, 0, 0, 2164.54, 1240.92, 137.471, 0.0174533, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28167, 595, 3, 1, 0, 0, 2231.61, 1161.02, 138.544, 1.79769, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28167, 595, 3, 1, 0, 0, 2228.91, 1163.93, 138.284, 6.12611, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28167, 595, 3, 1, 0, 0, 2269.06, 1183.91, 138.853, 3.28122, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28167, 595, 3, 1, 0, 0, 2117.78, 1338.3, 131.903, 6.03884, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28167, 595, 3, 1, 0, 0, 2207.32, 1343.56, 130.634, 3.59538, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28167, 595, 3, 1, 0, 0, 2211.96, 1316.7, 130.525, 1.8326, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27912, 595, 3, 1, 0, 0, 1674.12, 884.174, 119.789, 1.32645, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28169, 595, 3, 1, 0, 0, 2224.06, 1202.44, 136.494, 3.47321, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28169, 595, 3, 1, 0, 0, 2266.58, 1185.48, 138.855, 5.13127, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28169, 595, 3, 1, 0, 0, 2338.48, 1187.61, 130.879, 0.506145, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28169, 595, 3, 1, 0, 0, 2142.62, 1338.52, 132.753, 1.79769, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28169, 595, 3, 1, 0, 0, 2109.35, 1293.89, 136.983, 0.610865, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28169, 595, 3, 1, 0, 0, 2111.6, 1281.83, 137.261, 6.03884, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28169, 595, 3, 1, 0, 0, 2111.51, 1296.09, 136.745, 4.11898, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28169, 595, 3, 1, 0, 0, 2123.62, 1274.19, 137.496, 5.48033, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27729, 595, 3, 1, 0, 0, 2573.74, 1152.56, 126.492, 1.60792, 300, 15, 0, 50400, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28169, 595, 3, 1, 0, 0, 2115.72, 1281.11, 136.986, 3.08923, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28169, 595, 3, 1, 0, 0, 2179.53, 1354.3, 131.233, 3.66519, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28169, 595, 3, 1, 0, 0, 2132.45, 1369.3, 132.753, 5.13127, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28169, 595, 3, 1, 0, 0, 2310.54, 1160.29, 136.852, 3.00197, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28169, 595, 3, 1, 0, 0, 2178.09, 1278.78, 133.769, 2.77507, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28169, 595, 3, 1, 0, 0, 2307.87, 1159.79, 137.285, 1.20428, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28169, 595, 3, 1, 0, 0, 2136.5, 1368.51, 132.943, 2.41998, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27913, 595, 3, 1, 0, 0, 1802.89, 1188.84, 166.953, 4.32842, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28169, 595, 3, 1, 0, 0, 2125.75, 1294.59, 136.833, 2.49582, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28169, 595, 3, 1, 0, 0, 2176.69, 1354.11, 131.265, 5.48033, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28169, 595, 3, 1, 0, 0, 2287.59, 1156.98, 137.649, 1.97222, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28169, 595, 3, 1, 0, 0, 2264.96, 1143.23, 138.574, 1.74533, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28169, 595, 3, 1, 0, 0, 2289.27, 1160.08, 137.577, 3.47321, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28169, 595, 3, 1, 0, 0, 2120.56, 1336.55, 131.816, 2.58309, 300, 0, 0, 609, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 30994, 595, 3, 1, 0, 0, 2415.1, 1113.29, 147.397, 1.78836, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 31017, 595, 3, 1, 0, 0, 1560.54, 587.016, 99.9586, 1.18682, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 31018, 595, 3, 1, 0, 0, 2145.09, 1245.7, 134.643, 0.191986, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 31019, 595, 3, 1, 0, 0, 2149.56, 1339.46, 132.531, 2.35619, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 31020, 595, 3, 1, 0, 0, 2322.86, 1143.08, 135.487, 0.610865, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 31021, 595, 3, 1, 0, 0, 2223.92, 1134.74, 139.226, 6.07375, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 31022, 595, 3, 1, 0, 0, 2377.39, 1161.59, 132.983, 2.28638, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 31023, 595, 3, 1, 0, 0, 2267.86, 1144.93, 138.403, 2.33874, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 31024, 595, 3, 1, 0, 0, 1569.41, 622.151, 99.8525, 0.261799, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 31025, 595, 3, 1, 0, 0, 2296.42, 1209.46, 140.696, 6.14356, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 31027, 595, 3, 1, 0, 0, 2204.95, 1284.46, 134.313, 1.5708, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 31028, 595, 3, 1, 0, 0, 2372.27, 1199.55, 134.911, 3.38594, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 31057, 595, 3, 1, 0, 0, 2104.46, 1378.24, 133.427, 5.86431, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 30547, 595, 3, 1, 0, 0, 1556.5, 614.637, 107.664, 4.2586, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 30551, 595, 3, 1, 0, 0, 1566.55, 602.633, 99.2562, -1.97275, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 30552, 595, 3, 1, 0, 0, 1566.37, 597.473, 99.2562, 1.86697, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 30553, 595, 3, 1, 0, 0, 1562.49, 599.079, 99.2562, 0.697602, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2329.5, 1280.53, 132.744, 2.57143, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2336.01, 1258.51, 133.073, 5.1412, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2276.88, 1332.92, 124.341, 2.77098, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2292.53, 1328.92, 124.548, 0.150979, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2319.53, 1284.53, 131.669, 2.37491, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2305.03, 1326.52, 125.454, 1.88482, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2309.96, 1370.82, 128.682, 3.28122, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2570.74, 1141.07, 127.093, 3.0507, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2306.42, 1353.43, 127.095, 4.46804, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2321.17, 1296.89, 130.084, 0.726647, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2300.21, 1337.34, 124.823, 5.79717, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2291.54, 1316.46, 126.16, 4.00079, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2309.67, 1306.52, 127.604, 0.471632, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 30554, 595, 3, 1, 0, 0, 1556.6, 613.462, 99.8785, 0.549248, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 30555, 595, 3, 1, 0, 0, 1552.23, 607.222, 106.743, -0.628846, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 30556, 595, 3, 1, 0, 0, 1553.45, 608.264, 106.743, -1.33571, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 30557, 595, 3, 1, 0, 0, 1567.33, 594.131, 106.816, 6.10865, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 30561, 595, 3, 1, 0, 0, 1563.3, 592.68, 99.8856, -1.37934, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27745, 595, 3, 1, 0, 1, 1878.83, 1293.39, 144.713, 4.62512, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27745, 595, 3, 1, 0, 1, 1890.86, 1276.52, 143.972, 1.41372, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27745, 595, 3, 1, 0, 1, 1885.96, 1293.62, 144.286, 4.55531, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27745, 595, 3, 1, 0, 1, 1871.08, 1272.27, 144.368, 1.67552, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27745, 595, 3, 1, 0, 1, 1862.39, 1272.2, 144.483, 1.50098, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27745, 595, 3, 1, 0, 1, 1853.78, 1272.17, 144.605, 1.48353, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27745, 595, 3, 1, 0, 1, 1872.02, 1292.99, 145.134, 4.7822, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27745, 595, 3, 1, 0, 1, 2042.13, 1293.14, 143.336, 4.64258, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27745, 595, 3, 1, 0, 1, 2046.71, 1281.91, 143.321, 1.51844, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27745, 595, 3, 1, 0, 1, 2041.97, 1281.66, 143.554, 1.62316, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27745, 595, 3, 1, 0, 1, 2046.86, 1293.33, 143.132, 4.7822, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27745, 595, 3, 1, 0, 1, 1853.45, 1291.8, 145.002, 4.79966, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27745, 595, 3, 1, 0, 1, 1896.66, 1276.79, 144.026, 1.5708, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27745, 595, 3, 1, 0, 1, 1902.72, 1276.73, 143.809, 1.78024, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27745, 595, 3, 1, 0, 1, 1859.01, 1292.22, 145.239, 4.7473, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27745, 595, 3, 1, 0, 1, 1865.2, 1292.56, 145.297, 4.62512, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27745, 595, 3, 1, 0, 1, 1845.58, 1272.22, 144.815, 1.50098, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27746, 595, 3, 1, 0, 1, 1854.03, 1267.05, 145.5, 1.55334, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27746, 595, 3, 1, 0, 1, 1849.99, 1267.11, 145.706, 1.44862, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27746, 595, 3, 1, 0, 1, 1860.98, 1298.57, 145.97, 4.66003, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27746, 595, 3, 1, 0, 1, 1858.01, 1266.9, 145.277, 1.53589, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27746, 595, 3, 1, 0, 1, 1862.23, 1266.77, 145.008, 1.46608, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27746, 595, 3, 1, 0, 1, 1866.84, 1298.29, 146.233, 4.66003, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27747, 595, 3, 1, 0, 1, 1878.1, 1268.57, 144.42, 1.79769, 300, 0, 0, 10080, 8814, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27747, 595, 3, 1, 0, 1, 1873.36, 1268.36, 144.561, 1.55334, 300, 0, 0, 10080, 8814, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27747, 595, 3, 1, 0, 1, 2037.91, 1293.03, 143.499, 4.72984, 300, 0, 0, 10080, 8814, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27747, 595, 3, 1, 0, 1, 2037.59, 1281.81, 143.666, 1.48353, 300, 0, 0, 10080, 8814, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27747, 595, 3, 1, 0, 1, 1868.76, 1268.27, 144.655, 1.53589, 300, 0, 0, 10080, 8814, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 30565, 595, 3, 1, 0, 0, 1554.14, 572.686, 107.559, 1.09956, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27752, 595, 3, 1, 0, 0, 1873.69, 1296.88, 145.797, 4.72984, 300, 0, 0, 10080, 8814, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27752, 595, 3, 1, 0, 0, 1881.72, 1297.07, 145.265, 4.55531, 300, 0, 0, 10080, 8814, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27752, 595, 3, 1, 0, 0, 1877.77, 1297.02, 145.566, 4.62512, 300, 0, 0, 10080, 8814, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 30570, 595, 3, 1, 0, 0, 2146.79, 1257.33, 134.643, 1.01229, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 30571, 595, 3, 1, 0, 0, 1553.37, 578.078, 99.7624, 5.83105, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 30573, 595, 3, 1, 0, 0, 1565.26, 624.379, 99.8634, 4.2237, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 30574, 595, 3, 1, 0, 0, 1567.12, 623.307, 99.8189, 4.39823, 300, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 26499, 595, 3, 1, 0, 1, 1920.87, 1287.12, 142.935, 6.25562, 43200, 0, 0, 44100, 7988, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 30996, 595, 3, 1, 0, 0, 1579.42, 621.446, 99.7329, 2.9845, 180, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 30996, 595, 3, 1, 0, 0, 1674.39, 872.307, 120.394, -1.11701, 180, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 30996, 595, 3, 1, 0, 0, 1629.68, 731.367, 112.847, -0.837757, 180, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 30996, 595, 3, 1, 0, 0, 1628.98, 812.142, 120.689, 0.436332, 180, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2569.89, 1134.58, 127.375, 4.59008, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27736, 595, 3, 1, 0, 0, 2543.11, 1250.87, 126.102, 1.98415, 300, 0, 0, 104264, 0, 2, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27729, 595, 3, 1, 0, 0, 2543.83, 1262.88, 126.416, 2.69493, 300, 15, 0, 50400, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27729, 595, 3, 1, 0, 0, 2519.61, 1276.18, 128.35, 5.88365, 300, 15, 0, 50400, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27729, 595, 3, 1, 0, 0, 2556.66, 1226.42, 125.497, 4.95689, 300, 15, 0, 50400, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2562.06, 1168.8, 127.386, 4.9883, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2567.34, 1170.58, 126.65, 0.531168, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2572.79, 1177.92, 125.811, 1.3794, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2563.94, 1179.02, 126.489, 3.24865, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2559.99, 1185.87, 126.628, 2.208, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2565.92, 1184.99, 126.055, 6.17425, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2568.27, 1192.61, 125.714, 1.29693, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2560.76, 1194.61, 126.245, 2.89129, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2563.6, 1200.72, 125.797, 0.00494862, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2556.33, 1204.01, 126.818, 2.09018, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2561.41, 1208.01, 125.574, 0.0991955, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2565.35, 1211.83, 125.289, 0.613631, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2555.21, 1211.75, 126.482, 2.29438, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2559.3, 1220.38, 125.361, 1.26551, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2549.22, 1227.05, 126.336, 2.17265, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2554.92, 1228.96, 125.521, 0.0991967, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2549.28, 1239.73, 125.591, 2.23941, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2543.39, 1235.14, 126.58, 3.24864, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2541.2, 1241.22, 126.496, 1.8899, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2544.74, 1240.48, 126.089, 5.93078, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2550.58, 1248.31, 125.43, 1.32442, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2538.26, 1251.04, 126.644, 2.89522, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2545.75, 1254.85, 126.265, 0.193446, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2538.92, 1258.51, 126.381, 2.4279, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2531.93, 1260.3, 127.99, 2.58106, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2526.09, 1272.48, 128.156, 2.43968, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2533.84, 1269.37, 126.969, 5.58128, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2539.89, 1269.84, 126.773, 0.0253715, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2536.1, 1264.13, 126.581, 4.33721, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2533.27, 1276.35, 127.571, 2.31481, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2527.18, 1276.69, 127.995, 2.22056, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2530.87, 1281.67, 128.368, 0.716519, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2536.65, 1279.34, 127.852, 5.29146, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2529.77, 1288.14, 129.429, 2.47581, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2521.89, 1293.22, 130.479, 2.93134, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2515.2, 1290.37, 130.492, 3.99556, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2519.84, 1286.24, 129.577, 5.51923, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2513.27, 1284.17, 130.107, 3.33975, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2515.23, 1278.16, 128.676, 5.03228, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2521.05, 1281.06, 128.838, 0.123542, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2525.02, 1283.82, 128.926, 0.606562, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2525.6, 1289.27, 129.805, 1.58046, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2526.56, 1294.18, 130.824, 1.54276, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27729, 595, 3, 1, 0, 0, 2495.47, 1367.51, 130.708, 4.76446, 300, 15, 0, 50400, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28201, 595, 3, 1, 0, 0, 2493.34, 1365.08, 130.853, 2.02342, 300, 0, 0, 104264, 0, 2, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27734, 595, 3, 1, 0, 0, 2474.91, 1399.09, 130.32, 5.06684, 300, 0, 0, 50400, 0, 2, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 28249, 595, 3, 1, 0, 0, 2472.04, 1397.58, 130.096, 5.04721, 300, 0, 0, 50400, 0, 2, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27729, 595, 3, 1, 0, 0, 2478.84, 1387.03, 129.699, 5.10611, 300, 15, 0, 50400, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27731, 595, 3, 1, 0, 0, 2411.54, 1418.62, 130.614, 0.169881, 300, 0, 0, 15750, 7988, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27731, 595, 3, 1, 0, 0, 2412.07, 1416.05, 130.482, 0.209151, 300, 0, 0, 15750, 7988, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27731, 595, 3, 1, 0, 0, 2411.01, 1421.04, 130.829, 0.205226, 300, 0, 0, 15750, 7988, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27729, 595, 3, 1, 0, 0, 2450.87, 1426.94, 130.925, 5.37314, 300, 15, 0, 50400, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2488.33, 1359.83, 131.098, 5.75014, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2476.15, 1366.46, 130.075, 3.35074, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2482.56, 1367.24, 129.754, 0.110976, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2488.63, 1365.61, 130.433, 5.76584, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2492.14, 1372.13, 130.524, 0.939572, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2493.17, 1380.23, 130.243, 1.50506, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2487.27, 1377.97, 130.233, 3.51175, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2479.89, 1377.35, 129.53, 2.59284, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2476.38, 1383.89, 129.221, 2.03128, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2469.49, 1387.95, 129.52, 2.69494, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2476.29, 1390.39, 129.554, 0.31518, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2482.45, 1389.63, 130.066, 5.91507, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2489.98, 1388.21, 130.595, 0.0088737, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2496.36, 1389.2, 131.202, 0.48404, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2489.13, 1392.53, 130.93, 2.80096, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2486.62, 1397.4, 130.83, 1.26551, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2486.29, 1404.72, 131.51, 2.0784, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2480.25, 1399.75, 130.425, 3.86125, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2474.01, 1396.43, 130.071, 3.33896, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2468.39, 1393.1, 130.084, 3.72774, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2471.85, 1405.64, 130.779, 1.74067, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2461.39, 1403.39, 130.436, 3.62563, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2458.76, 1406.85, 130.4, 1.92917, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2465.75, 1410.3, 130.667, 6.06821, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2467.14, 1417.2, 131.253, 1.35975, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2460.55, 1413.74, 130.482, 3.33895, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2453.15, 1415.24, 129.688, 2.73812, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2452.45, 1421.36, 130.407, 0.95527, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2460.37, 1423.45, 130.95, 0.173799, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2462.13, 1430.65, 131.194, 1.59537, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2458.84, 1437.85, 131.663, 1.62286, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2452.46, 1434.03, 131.739, 3.66882, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2444.83, 1427.74, 130.938, 3.9123, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2440.87, 1421.04, 130.259, 4.47778, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2436.09, 1418.17, 130.024, 3.67667, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2436.67, 1424.69, 130.818, 1.31655, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2441.29, 1433.25, 131.38, 0.857092, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2435.44, 1430.2, 131.263, 3.64918, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2428.26, 1425.34, 131.118, 3.90836, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2421.56, 1416.47, 130.482, 4.00261, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 27737, 595, 3, 1, 0, 0, 2428.46, 1418.62, 130.591, 0.342657, 300, 10, 0, 630, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 30997, 595, 3, 1, 0, 0, 2323.69, 1499.63, 127.619, 3.26116, 600, 0, 0, 17010, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 30996, 595, 3, 1, 0, 0, 1755.69, 1290.88, 140.749, 2.2986, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 30996, 595, 3, 1, 0, 0, 1755.69, 1290.88, 141.49, 2.2986, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 30996, 595, 3, 1, 0, 0, 1755.69, 1290.88, 142.231, 2.2986, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 30996, 595, 3, 1, 0, 0, 1756.65, 1289.24, 140.47, 2.07476, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 30996, 595, 3, 1, 0, 0, 1756.65, 1289.24, 141.211, 2.07476, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 30996, 595, 3, 1, 0, 0, 1757.36, 1287.92, 140.287, 1.76846, 300, 0, 0, 1, 0, 0, 0, 0, 0);
