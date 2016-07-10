
-- -------------------------------------------
-- DRAGONBLIGHT
-- -------------------------------------------
-- Conversing With the Depths (12032)
UPDATE creature_template SET AIName="", ScriptName="" WHERE entry=26648;
DELETE FROM smart_scripts WHERE entryorguid=26648 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=2664800 AND source_type=9;
REPLACE INTO creature_template VALUES (70100, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Conversing With the Depths Trigger', '', '', 0, 1, 1, 0, 35, 0, 1, 1.14286, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 6, 2048, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 130, 'npc_conversing_with_the_depths_trigger', 1);
DELETE FROM creature WHERE id=70100;
INSERT INTO creature VALUES(NULL, 70100, 571, 1, 1, 0, 0, 2452.56, 1721.64, 61, 0, 300, 0, 0, 1, 0, 0, 0, 0, 0);
UPDATE gameobject_template SET data0=1691, data1=12032, data2=0, data14=0, ScriptName="go_the_pearl_of_the_depths" WHERE entry=188422;
DELETE FROM event_scripts WHERE id=17612;
UPDATE quest_template SET EndText='', ObjectiveText1='Oacha\'noa\'s compulsion obeyed' WHERE Id=12032;

-- The End of the Line (12110)
-- The End of the Line (12107)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=26887);
DELETE FROM creature WHERE id=26887;
INSERT INTO creature VALUES (NULL, 26887, 571, 1, 1, 0, 0, 3056.53, 1400.98, 121.901, 3.79364, 300, 0, 0, 42, 0, 0, 0, 0, 0);
UPDATE creature_template SET AIName="SmartAI", InhabitType=7 WHERE entry=26887;
DELETE FROM smart_scripts WHERE entryorguid IN(26887) AND source_type=0;
INSERT INTO smart_scripts VALUES(26887, 0, 0, 0, 8, 0, 100, 0, 50548, 0, 0, 0, 33, 26887, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Spell Hit - Kill Monster Credit");
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13, 17) AND SourceEntry IN(47634, 50548);
INSERT INTO conditions VALUES(13, 1, 47634, 0, 0, 31, 0, 3, 26887, 0, 0, 0, 0, '', 'Ley Line Focus Control Ring');
INSERT INTO conditions VALUES(13, 1, 50548, 0, 0, 31, 0, 3, 26887, 0, 0, 0, 0, '', 'Ley Line Focus Control Ring');
UPDATE creature_template SET AIName="SmartAI" WHERE entry=26889;
DELETE FROM smart_scripts WHERE entryorguid IN(26889) AND source_type=0;
INSERT INTO smart_scripts VALUES(26889, 0, 0, 0, 60, 0, 100, 0, 0, 0, 8000, 8000, 33, 26889, 0, 0, 0, 0, 0, 18, 30, 0, 0, 0, 0, 0, 0, "On Update - Kill Monster Credit");
UPDATE quest_template SET OfferRewardText="WHAT?!$B$B<The image before you distorts for a moment as the archmage attempts to regain his composure.>$B$BOf course, we should have guessed that this was what they were up to all along. Quickly, there's no time to waste.$B$BWyrmrest must be warned!" WHERE Id IN(12107, 12110);

-- Atop the Woodlands (12084)
-- Atop the Woodlands (12083)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=26831);
DELETE FROM creature WHERE id=26831;
INSERT INTO creature VALUES(NULL, 26831, 571, 1, 1, 0, 0, 2896.58, 1817.61, 135.334, 1.61517, 600, 0, 0, 1, 0, 0, 0, 0, 0);
UPDATE creature_template SET AIName="SmartAI", InhabitType=7 WHERE entry=26831;
DELETE FROM smart_scripts WHERE entryorguid IN(26831) AND source_type=0;
INSERT INTO smart_scripts VALUES(26831, 0, 0, 0, 8, 0, 100, 0, 50547, 0, 0, 0, 33, 26831, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Spell Hit - Kill Monster Credit");
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13, 17) AND SourceEntry IN(47469, 50547);
INSERT INTO conditions VALUES(13, 1, 47469, 0, 0, 31, 0, 3, 26831, 0, 0, 0, 0, '', 'Atop the woodlands');
INSERT INTO conditions VALUES(13, 1, 50547, 0, 0, 31, 0, 3, 26831, 0, 0, 0, 0, '', 'Atop the woodlands');

-- The Forgotten Tale (12291)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(48143, -48143, 48814, -48814);
INSERT INTO spell_linked_spell VALUES(48143, 48814, 2, 'Forgottens aura');
DELETE FROM smart_scripts WHERE entryorguid IN(27226, 27225, 27224, 27229) AND id IN (0, 1) AND source_type=0;
UPDATE creature_template SET AIName='SmartAI' WHERE entry IN(27226, 27225, 27224, 27229);
INSERT INTO smart_scripts VALUES (27226, 0, 0, 1, 62, 0, 100, 0, 9541, 0, 0, 0, 33, 27472, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Forgotten Peasant - On Gossip Select - Give Kill Credit');
INSERT INTO smart_scripts VALUES (27226, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Forgotten Peasant - On Gossip Select - Close Gossip');
INSERT INTO smart_scripts VALUES (27225, 0, 0, 1, 62, 0, 100, 0, 9543, 0, 0, 0, 33, 27471, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Forgotten Rifleman - On Gossip Select - Give Kill Credit');
INSERT INTO smart_scripts VALUES (27225, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Forgotten Rifleman - On Gossip Select - Close Gossip');
INSERT INTO smart_scripts VALUES (27224, 0, 0, 1, 62, 0, 100, 0, 9544, 0, 0, 0, 33, 27473, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Forgotten Knight - On Gossip Select - Give Kill Credit');
INSERT INTO smart_scripts VALUES (27224, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Forgotten Knight - On Gossip Select - Close Gossip');
INSERT INTO smart_scripts VALUES (27229, 0, 0, 1, 62, 0, 100, 0, 9545, 0, 0, 0, 33, 27474, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Forgotten Footman - On Gossip Select - Give Kill Credit');
INSERT INTO smart_scripts VALUES (27229, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Forgotten Footman - On Gossip Select - Close Gossip');

-- The Truth Shall Set Us Free (12301)
DELETE FROM creature_text WHERE entry IN(27224, 27225);
INSERT INTO creature_text VALUES(27224, 0, 0, 'But why?', 12, 0, 100, 0, 0, 0, 0, 'Forgotten Knight');
INSERT INTO creature_text VALUES(27224, 0, 1, 'It was all lies...', 12, 0, 100, 0, 0, 0, 0, 'Forgotten Knight');
INSERT INTO creature_text VALUES(27224, 0, 2, 'You gave us your word, betrayer!', 12, 0, 100, 0, 0, 0, 0, 'Forgotten Knight');
INSERT INTO creature_text VALUES(27224, 0, 3, 'Our prince has forsaken us! All is lost!', 12, 0, 100, 0, 0, 0, 0, 'Forgotten Knight');
INSERT INTO creature_text VALUES(27224, 0, 4, 'You lying wretch, Arthas! You doomed us all!', 12, 0, 100, 0, 0, 0, 0, 'Forgotten Knight');
INSERT INTO creature_text VALUES(27224, 0, 5, 'Our lives were worth far more than your blood feud...', 12, 0, 100, 0, 0, 0, 0, 'Forgotten Knight');
INSERT INTO creature_text VALUES(27225, 0, 0, 'But why?', 12, 0, 100, 0, 0, 0, 0, 'Forgotten Rifleman');
INSERT INTO creature_text VALUES(27225, 0, 1, 'It was all lies...', 12, 0, 100, 0, 0, 0, 0, 'Forgotten Rifleman');
INSERT INTO creature_text VALUES(27225, 0, 2, 'You gave us your word, betrayer!', 12, 0, 100, 0, 0, 0, 0, 'Forgotten Rifleman');
INSERT INTO creature_text VALUES(27225, 0, 3, 'Our prince has forsaken us! All is lost!', 12, 0, 100, 0, 0, 0, 0, 'Forgotten Rifleman');
INSERT INTO creature_text VALUES(27225, 0, 4, 'You lying wretch, Arthas! You doomed us all!', 12, 0, 100, 0, 0, 0, 0, 'Forgotten Rifleman');
INSERT INTO creature_text VALUES(27225, 0, 5, 'Our lives were worth far more than your blood feud...', 12, 0, 100, 0, 0, 0, 0, 'Forgotten Rifleman');
-- captain luc: 27476
DELETE FROM creature_text WHERE entry=27476;
INSERT INTO creature_text VALUES(27476, 0, 0, "I apologize, emissary, but the prince is away on an errand. What brings you to this desolate place?", 12, 0, 100, 0, 0, 12719, 0, "Captain Luc Valonforth");
INSERT INTO creature_text VALUES(27476, 1, 0, "We're to just pick up and leave?", 12, 0, 100, 0, 0, 12720, 0, "Captain Luc Valonforth");
INSERT INTO creature_text VALUES(27476, 2, 0, "To hell with the undead! We'll cut our way through the woods, men!", 12, 0, 100, 0, 0, 12721, 0, "Captain Luc Valonforth");
INSERT INTO creature_text VALUES(27476, 3, 0, "Well, milord, your father had our troops recalled at Lord Uther's request.", 12, 0, 100, 0, 0, 12722, 0, "Captain Luc Valonforth");
-- emissary: 27492
DELETE FROM creature_text WHERE entry=27492;
INSERT INTO creature_text VALUES(27492, 0, 0, "By royal edict, you men are to return to Lordaeron immediately. Lord Uther has convinced the king to recall this expedition.", 12, 0, 100, 0, 0, 12723, 0, "Alliance Emissary");
INSERT INTO creature_text VALUES(27492, 1, 0, "That's correct. My men report that the roads from here to the shore are held by the undead. You'll need to find an alternate route back to your ships.", 12, 0, 100, 0, 0, 12724, 0, "Alliance Emissary");
-- prince arthas: 27455
DELETE FROM creature_text WHERE entry=27455 AND groupid<4;
INSERT INTO creature_text VALUES(27455, 0, 0, "Captain, why are the guards not at their posts?", 12, 0, 100, 0, 0, 12725, 0, "Prince Arthas");
INSERT INTO creature_text VALUES(27455, 1, 0, "Uther had my troops recalled? Damn it! If my warriors abandon me, I'll never defeat Mal'Ganis. The ships must be burned before the men reach the shore!", 12, 0, 100, 0, 0, 12726, 0, "Prince Arthas");
INSERT INTO creature_text VALUES(27455, 2, 0, "Burned down to their frames! No one goes home until our job here is done!", 12, 0, 100, 0, 0, 12727, 0, "Prince Arthas");
INSERT INTO creature_text VALUES(27455, 3, 0, "Spare me, Muradin. You weren't there to see what Mal'Ganis did to my homeland.", 12, 0, 100, 0, 0, 12728, 0, "Prince Arthas");
-- muradin: 27480
DELETE FROM creature_text WHERE entry=27480 AND groupid<2;
INSERT INTO creature_text VALUES(27480, 0, 0, "Isn't that a bit much, lad?", 12, 0, 100, 0, 0, 12733, 0, "Muradin");
INSERT INTO creature_text VALUES(27480, 1, 0, "You lied to your men and betrayed the mercenaries who fought for you. What's happening to you, Arthas? Is vengeance all that's important to you?", 12, 0, 100, 0, 0, 12734, 0, "Muradin");
REPLACE INTO creature_template_addon VALUES(27224, 0, 2410, 0, 0, 0, ""); -- knight mount
DELETE FROM event_scripts WHERE id=18014;
INSERT INTO event_scripts VALUES(18014, 0, 10, 27476, 600000, 1, 3098.40, -1253.4, 11.44, 2.21);
UPDATE creature_template SET AIName="SmartAI" WHERE entry=27476;
DELETE FROM smart_scripts WHERE entryorguid IN(27476) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(27476*100) AND source_type=9;
INSERT INTO smart_scripts VALUES(27476, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 12, 27229, 4, 600000, 0, 0, 0, 8, 0, 0, 0, 3085.27, -1240.3, 10.5, 0.1, "Run summon list on reset");
INSERT INTO smart_scripts VALUES(27476, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 12, 27229, 4, 600000, 0, 0, 0, 8, 0, 0, 0, 3085.27, -1243.3, 10.5, 0.1, "Spawn npc linked");
INSERT INTO smart_scripts VALUES(27476, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 12, 27229, 4, 600000, 0, 0, 0, 8, 0, 0, 0, 3085.27, -1246.3, 10.5, 0.1, "Spawn npc linked");
INSERT INTO smart_scripts VALUES(27476, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 12, 27229, 4, 600000, 0, 0, 0, 8, 0, 0, 0, 3085.27, -1249.3, 10.5, 0.1, "Spawn npc linked");
INSERT INTO smart_scripts VALUES(27476, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 12, 27229, 4, 600000, 0, 0, 0, 8, 0, 0, 0, 3085.27, -1252.3, 10.5, 0.1, "Spawn npc linked");
INSERT INTO smart_scripts VALUES(27476, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 12, 27229, 4, 600000, 0, 0, 0, 8, 0, 0, 0, 3085.27, -1255.3, 10.5, 0.1, "Spawn npc linked");
INSERT INTO smart_scripts VALUES(27476, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 12, 27229, 4, 600000, 0, 0, 0, 8, 0, 0, 0, 3080.27, -1241.8, 10.5, 0.1, "Spawn npc linked");
INSERT INTO smart_scripts VALUES(27476, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 12, 27229, 4, 600000, 0, 0, 0, 8, 0, 0, 0, 3080.27, -1244.8, 10.5, 0.1, "Spawn npc linked");
INSERT INTO smart_scripts VALUES(27476, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 12, 27229, 4, 600000, 0, 0, 0, 8, 0, 0, 0, 3080.27, -1247.8, 10.5, 0.1, "Spawn npc linked");
INSERT INTO smart_scripts VALUES(27476, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 12, 27229, 4, 600000, 0, 0, 0, 8, 0, 0, 0, 3080.27, -1250.8, 10.5, 0.1, "Spawn npc linked");
INSERT INTO smart_scripts VALUES(27476, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 12, 27229, 4, 600000, 0, 0, 0, 8, 0, 0, 0, 3080.27, -1253.8, 10.5, 0.1, "Spawn npc linked");
INSERT INTO smart_scripts VALUES(27476, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 12, 27492, 4, 600000, 0, 0, 0, 8, 0, 0, 0, 3095.9, -1242.9, 10.48, 5.02, "Spawn npc linked");
INSERT INTO smart_scripts VALUES(27476, 0, 12, 13, 61, 0, 100, 0, 0, 0, 0, 0, 12, 27224, 4, 600000, 0, 0, 0, 8, 0, 0, 0, 3090.35, -1237.3, 10.4, 5.1, "Spawn npc linked");
INSERT INTO smart_scripts VALUES(27476, 0, 13, 14, 61, 0, 100, 0, 0, 0, 0, 0, 12, 27224, 4, 600000, 0, 0, 0, 8, 0, 0, 0, 3102.8, -1235.1, 10.47, 4.5, "Spawn npc linked");
INSERT INTO smart_scripts VALUES(27476, 0, 14, 15, 61, 0, 100, 0, 0, 0, 0, 0, 12, 27225, 4, 600000, 0, 0, 0, 8, 0, 0, 0, 3106.25, -1235.9, 10.92, 4.35, "Spawn npc linked");
INSERT INTO smart_scripts VALUES(27476, 0, 15, 16, 61, 0, 100, 0, 0, 0, 0, 0, 12, 27225, 4, 600000, 0, 0, 0, 8, 0, 0, 0, 3097.0, -1235.6, 10.1, 4.78, "Spawn npc linked");
INSERT INTO smart_scripts VALUES(27476, 0, 16, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 27476*100, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "run timed actionlist linked");
INSERT INTO smart_scripts VALUES(27476*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(27476*100, 9, 1, 0, 0, 0, 100, 0, 6500, 6500, 0, 0, 1, 0, 0, 0, 0, 0, 0, 11, 27492, 20, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(27476*100, 9, 2, 0, 0, 0, 100, 0, 11000, 11000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(27476*100, 9, 3, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 11, 27492, 20, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(27476*100, 9, 4, 0, 0, 0, 100, 0, 11000, 11000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(27476*100, 9, 5, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 41, 4000, 0, 0, 0, 0, 0, 11, 27492, 20, 0, 0, 0, 0, 0, "force despawn target");
INSERT INTO smart_scripts VALUES(27476*100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 0, 0, 0, 0, 0, 0, 11, 27492, 20, 0, 3090, -1212, 12.2, 0, "move to pos target");
INSERT INTO smart_scripts VALUES(27476*100, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 5, 66, 0, 0, 0, 0, 0, 11, 27229, 50, 0, 0, 0, 0, 0, "play emote");
INSERT INTO smart_scripts VALUES(27476*100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 4000, 0, 0, 0, 0, 0, 11, 27229, 50, 0, 0, 0, 0, 0, "force despawn target");
INSERT INTO smart_scripts VALUES(27476*100, 9, 9, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 130, 1, 0, 0, 0, 0, 0, 11, 27229, 50, 0, 3053, -1249, 11.4, 0, "move to pos target");
INSERT INTO smart_scripts VALUES(27476*100, 9, 10, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 27455, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 3093.39, -1248.5, 10.74, 5.5, "summon npc");
INSERT INTO smart_scripts VALUES(27476*100, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 27480, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 3098.93, -1246.46, 10.88, 4.48, "summon npc");
INSERT INTO smart_scripts VALUES(27476*100, 9, 12, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 11, 27455, 20, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(27476*100, 9, 13, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(27476*100, 9, 14, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 11, 27455, 20, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(27476*100, 9, 15, 0, 0, 0, 100, 0, 14000, 14000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 11, 27480, 20, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(27476*100, 9, 16, 0, 0, 0, 100, 0, 3500, 3500, 0, 0, 1, 2, 0, 0, 0, 0, 0, 11, 27455, 20, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(27476*100, 9, 17, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 11, 27480, 20, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(27476*100, 9, 18, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 11, 27455, 20, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(27476*100, 9, 19, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 86, 48882, 2, 19, 27455, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spirits Redeemed");
INSERT INTO smart_scripts VALUES(27476*100, 9, 20, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 11, 27224, 50, 0, 0, 0, 0, 0, "force despawn target");
INSERT INTO smart_scripts VALUES(27476*100, 9, 21, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 11, 27225, 50, 0, 0, 0, 0, 0, "force despawn target");
INSERT INTO smart_scripts VALUES(27476*100, 9, 22, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 6000, 0, 0, 0, 0, 0, 11, 27455, 50, 0, 0, 0, 0, 0, "force despawn target");
INSERT INTO smart_scripts VALUES(27476*100, 9, 23, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 6000, 0, 0, 0, 0, 0, 11, 27480, 50, 0, 0, 0, 0, 0, "force despawn target");
INSERT INTO smart_scripts VALUES(27476*100, 9, 24, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 27224, 30, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(27476*100, 9, 25, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 27225, 30, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(27476*100, 9, 26, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 3, 27465, 0, 0, 0, 0, 0, 11, 27224, 30, 0, 0, 0, 0, 0, "Morph");
INSERT INTO smart_scripts VALUES(27476*100, 9, 27, 0, 0, 0, 100, 0, 0, 0, 0, 0, 3, 27465, 0, 0, 0, 0, 0, 11, 27225, 30, 0, 0, 0, 0, 0, "Morph");
INSERT INTO smart_scripts VALUES(27476*100, 9, 28, 0, 0, 0, 100, 0, 0, 0, 0, 0, 43, 0, 0, 0, 0, 0, 0, 11, 27224, 30, 0, 0, 0, 0, 0, "Dismount");
INSERT INTO smart_scripts VALUES(27476*100, 9, 29, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "force despawn");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=48882;
INSERT INTO conditions VALUES(13, 1, 48882, 0, 0, 31, 0, 3, 27476, 0, 0, 0, 0, '', 'Target Ghosts');
INSERT INTO conditions VALUES(13, 1, 48882, 0, 1, 31, 0, 3, 27224, 0, 0, 0, 0, '', 'Target Ghosts');
INSERT INTO conditions VALUES(13, 1, 48882, 0, 2, 31, 0, 3, 27225, 0, 0, 0, 0, '', 'Target Ghosts');
INSERT INTO conditions VALUES(13, 1, 48882, 0, 3, 31, 0, 3, 27480, 0, 0, 0, 0, '', 'Target Ghosts');
INSERT INTO conditions VALUES(13, 1, 48882, 0, 4, 31, 0, 3, 27455, 0, 0, 0, 0, '', 'Target Ghosts');
INSERT INTO conditions VALUES(13, 1, 48882, 0, 5, 31, 0, 3, 27226, 0, 0, 0, 0, '', 'Target Ghosts');
INSERT INTO conditions VALUES(13, 2, 48882, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Target Players');

-- Slim Pickings (12075)
UPDATE creature_template SET IconName="LootAll", npcflag=1, AIName="SmartAI" WHERE entry=26809;
DELETE FROM smart_scripts WHERE entryorguid=26809 AND source_type=0;
INSERT INTO smart_scripts VALUES(26809, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 31261, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ravaged Crystalline Ice Giant - On Spawn - Cast Permanent Feign Death (Root) on self');
INSERT INTO smart_scripts VALUES(26809, 0, 1, 2, 64, 0, 100, 0, 0, 0, 0, 0, 56, 36765, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Ravaged Crystalline Ice Giant - On Gossip Hello - Add Item");
INSERT INTO smart_scripts VALUES(26809, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Ravaged Crystalline Ice Giant - On Gossip Hello - Close Gossip");

-- No Place To Run (12261)
UPDATE creature_template SET AIName="SmartAI" WHERE entry IN(33016, 33017);
DELETE FROM smart_scripts WHERE entryorguid IN(33016, 33017) AND source_type=0;
INSERT INTO smart_scripts VALUES (33016, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 51437, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Smoldering Skeleton - On Aggro - Cast 'Smoldering Bones'");
INSERT INTO smart_scripts VALUES (33016, 0, 1, 0, 54, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Smoldering Skeleton - On Summoned - Attack Start");
INSERT INTO smart_scripts VALUES (33017, 0, 0, 0, 0, 0, 100, 0, 4000, 9000, 14000, 17000, 11, 51439, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Smoldering Construct - In Combat - Cast 'Backlash'");
INSERT INTO smart_scripts VALUES (33017, 0, 1, 0, 54, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Smoldering Construct - On Summoned - Attack Start");
UPDATE creature_template SET unit_flags=4, AIName="SmartAI" WHERE entry=27430;
DELETE FROM smart_scripts WHERE entryorguid=27430 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=2743000 AND source_type=9;
INSERT INTO smart_scripts VALUES (27430, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 80, 2743000, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Destructive Ward - On Respawn - Run Script");
INSERT INTO smart_scripts VALUES (2743000, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 11, 48715, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Destructive Ward - On Script - Cast 'Summon Smoldering Skeleton'");
INSERT INTO smart_scripts VALUES (2743000, 9, 1, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 11, 48715, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Destructive Ward - On Script - Cast 'Summon Smoldering Skeleton'");
INSERT INTO smart_scripts VALUES (2743000, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 11, 48735, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Destructive Ward - On Script - Cast 'Destructive Ward Powerup'");
INSERT INTO smart_scripts VALUES (2743000, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Destructive Ward - On Script - Say Line 0");
INSERT INTO smart_scripts VALUES (2743000, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 48733, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Destructive Ward - On Script - Cast 'Destructive Pulse'");
INSERT INTO smart_scripts VALUES (2743000, 9, 5, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 11, 48718, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Destructive Ward - On Script - Cast 'Summon Smoldering Construct'");
INSERT INTO smart_scripts VALUES (2743000, 9, 6, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 11, 48718, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Destructive Ward - On Script - Cast 'Summon Smoldering Construct'");
INSERT INTO smart_scripts VALUES (2743000, 9, 7, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 11, 48735, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Destructive Ward - On Script - Cast 'Destructive Ward Powerup'");
INSERT INTO smart_scripts VALUES (2743000, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Destructive Ward - On Script - Say Line 0");
INSERT INTO smart_scripts VALUES (2743000, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 48733, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Destructive Ward - On Script - Cast 'Destructive Pulse'");
INSERT INTO smart_scripts VALUES (2743000, 9, 10, 0, 0, 0, 100, 0, 25000, 25000, 0, 0, 11, 48715, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Destructive Ward - On Script - Cast 'Summon Smoldering Skeleton'");
INSERT INTO smart_scripts VALUES (2743000, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 48715, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Destructive Ward - On Script - Cast 'Summon Smoldering Skeleton'");
INSERT INTO smart_scripts VALUES (2743000, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 48718, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Destructive Ward - On Script - Cast 'Summon Smoldering Construct'");
INSERT INTO smart_scripts VALUES (2743000, 9, 13, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 11, 48735, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Destructive Ward - On Script - Cast 'Destructive Ward Powerup'");
INSERT INTO smart_scripts VALUES (2743000, 9, 14, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Destructive Ward - On Script - Say Line 1");
INSERT INTO smart_scripts VALUES (2743000, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 48734, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Destructive Ward - On Script - Cast 'Destructive Barrage'");
INSERT INTO smart_scripts VALUES (2743000, 9, 16, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 11, 48734, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Destructive Ward - On Script - Cast 'Destructive Barrage'");
INSERT INTO smart_scripts VALUES (2743000, 9, 17, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 11, 48734, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Destructive Ward - On Script - Cast 'Destructive Barrage'");
INSERT INTO smart_scripts VALUES (2743000, 9, 18, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 52409, 2, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, "Destructive Ward - Destructive Ward Kill Credit");
INSERT INTO smart_scripts VALUES (2743000, 9, 19, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Destructive Ward - Despawn");

-- Mystery of the Infinite (12470)
UPDATE creature_template SET minlevel=80, maxlevel=80, ScriptName="npc_hourglass_of_eternity", unit_flags=4 WHERE entry=27840;
UPDATE creature_template SET minlevel=80, maxlevel=80, faction=35, ScriptName="npc_future_you" WHERE entry=27899;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=49889;
INSERT INTO conditions VALUES(13, 7, 49889, 0, 0, 31, 0, 3, 27899, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 7, 49889, 0, 1, 31, 0, 3, 32331, 0, 0, 0, 0, '', ''); -- past you
UPDATE creature_template SET faction=2111 WHERE entry IN(27897, 27898, 27896, 27900);

-- Mystery of the Infinite, Redux (13343)
UPDATE creature_template SET minlevel=80, maxlevel=80, ScriptName="npc_hourglass_of_eternity", unit_flags=4 WHERE entry=32327;
UPDATE creature_template SET minlevel=80, maxlevel=80, faction=35, ScriptName="npc_future_you" WHERE entry=32331; -- past you, use same script

-- Defending Wyrmrest Temple (12372)
REPLACE INTO gossip_menu_option VALUES(9568, 0, 0, 'We need to get into the fight. Are you ready?', 1, 1, 0, 0, 0, 0, '');
DELETE FROM spell_script_names WHERE spell_id IN(49213, 49370);
UPDATE creature_template SET speed_run=3.5, faction=2067, unit_flags=0, HoverHeight=4, InhabitType=5, ScriptName='', AIName='SmartAI', spell1=49161, spell2=49243, spell3=49263, spell4=49264, spell5=49367 WHERE entry=27629; -- Wyrmrest Defender
REPLACE INTO creature_template_addon VALUES(27629, 0, 0, 50331648, 1, 0, ""); -- Wyrmrest Defender
UPDATE creature_template SET InhabitType=4, AIName="SmartAI" WHERE entry=27698;
DELETE FROM smart_scripts WHERE entryorguid IN(27698) AND source_type=0;
INSERT INTO smart_scripts VALUES (27698, 0, 0, 0, 8, 0, 100, 0, 49370, 0, 0, 0, 33, 27698, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Kill credit on spell hit');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(49367, 49370);
INSERT INTO conditions VALUES(13, 1, 49367, 0, 0, 31, 0, 3, 27698, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 49370, 0, 0, 31, 0, 3, 27698, 0, 0, 0, 0, '', '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup IN(9568);
INSERT INTO conditions VALUES(15, 9568, 0, 0, 0, 9, 0, 12372, 0, 0, 0, 0, 0, '', 'Show gossip option if player has quest');
DELETE FROM smart_scripts WHERE entryorguid IN(27629) AND source_type=0;
INSERT INTO smart_scripts VALUES (27629, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 60, 1, 350, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set Flight');
INSERT INTO smart_scripts VALUES (27629, 0, 1, 2, 62, 0, 100, 0, 9568, 0, 0, 0, 85, 49207, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Gossip Select - Invoker cast');
INSERT INTO smart_scripts VALUES (27629, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Linked - Close gossip');
INSERT INTO smart_scripts VALUES (27629, 0, 3, 0, 29, 0, 100, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Combat Move On Charmed');
-- TC script remove
DELETE FROM spell_script_names WHERE spell_id=50287;

-- A Means to an End (12240)
DELETE FROM event_scripts WHERE id=17868;
UPDATE creature_template SET flags_extra=flags_extra|128 WHERE entry=27353;
UPDATE creature_template SET faction=67 WHERE entry=27238;

-- The Cleansing Of Jintha'kalar (12545)
UPDATE creature_template SET unit_flags=32768 WHERE entry=26965;
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(26943));
DELETE FROM creature WHERE id IN(26943);
INSERT INTO creature VALUES (NULL, 26943, 571, 1, 1, 0, 0, 4795.55, -1166.66, 170.544, 4.68933, 600, 0, 0, 10282, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 26943, 571, 1, 1, 0, 0, 4519.6, -1377.45, 156.684, 6.27583, 600, 0, 0, 10282, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 26943, 571, 1, 1, 0, 0, 4843.07, -1252.74, 168.051, 3.57407, 600, 0, 0, 10282, 0, 0, 0, 0, 0);

-- An End And A Beginning (12473)
UPDATE quest_template SET PrevQuestId=12472 WHERE Id=12473;

-- High Commander Halford Wyrmbane (12174)
UPDATE creature_template SET npcflag=8195, gossip_menu_id=30211 WHERE entry=26881;
REPLACE INTO gossip_menu_option VALUES(30211, 0, 2, 'Show me where I can fly.', 4, 8192, 0, 0, 0, 0, '');
REPLACE INTO gossip_menu_option VALUES(30211, 1, 0, "I Need a ride to Wintergarde keep.", 1, 1, 0, 0, 0, 0, "");
REPLACE INTO smart_scripts VALUES(26881, 0, 3, 0, 62, 0, 100, 0, 30211, 1, 0, 0, 11, 48013, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Select - Cast at Invoker');
DELETE FROM conditions WHERE SourceGroup=30211 AND SourceTypeOrReferenceId=15;
INSERT INTO conditions VALUES(15, 30211, 1, 0, 0, 28, 0, 12174, 0, 0, 0, 0, 0, '', 'Show gossip option if player has quest');

-- The Chain Gun And You (12457)
UPDATE creature SET curhealth=8982 WHERE id=27714;
UPDATE creature_template SET unit_flags=2+4, spell1=49190, spell2=49550, AIName='NullCreatureAI', ScriptName='' WHERE entry=27714;
DELETE FROM creature WHERE id=27712;
INSERT INTO creature VALUES (133301, 27712, 571, 1, 1, 24993, 0, 3657.45, -1229.03, 98.3436, 2.25148, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133284, 27712, 571, 1, 1, 24993, 0, 3661.91, -1228.71, 98.0911, 2.87594, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133283, 27712, 571, 1, 1, 24994, 0, 3658.86, -1242.07, 98.0911, 1.67054, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133282, 27712, 571, 1, 1, 24993, 0, 3650.95, -1227.94, 98.26, 1.0164, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133281, 27712, 571, 1, 1, 24995, 0, 3662.97, -1233.61, 98.0911, 1.91605, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133280, 27712, 571, 1, 1, 24993, 0, 3691.74, -1169.81, 98.0913, 4.3188, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133279, 27712, 571, 1, 1, 24994, 0, 3640.73, -1226.3, 98.0911, 0.934767, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133278, 27712, 571, 1, 1, 24995, 0, 3639.22, -1232.48, 98.0911, 4.50294, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133277, 27712, 571, 1, 1, 24994, 0, 3662.98, -1230.15, 98.0911, 1.34507, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133276, 27712, 571, 1, 1, 24995, 0, 3641.21, -1248.71, 98.26, 0.858347, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133275, 27712, 571, 1, 1, 24995, 0, 3694.21, -1131.96, 97.6497, 1.28324, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133274, 27712, 571, 1, 1, 24993, 0, 3700.21, -1129.71, 97.6494, 4.65467, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133285, 27712, 571, 1, 1, 24992, 0, 3695.77, -1144.35, 97.6498, 1.29109, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133286, 27712, 571, 1, 1, 24993, 0, 3669.51, -1217.07, 98.9089, 0.659359, 8, 5, 0, 399, 0, 1, 0, 0, 0),
(133300, 27712, 571, 1, 1, 24995, 0, 3651.97, -1226.94, 98.3436, 4.36332, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133299, 27712, 571, 1, 1, 24995, 0, 3701.54, -1140.65, 97.6496, 4.33361, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133298, 27712, 571, 1, 1, 24993, 0, 3694.7, -1158.48, 97.733, 2.04204, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133297, 27712, 571, 1, 1, 24993, 0, 3676.08, -1161.85, 98.1747, 5.91667, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133295, 27712, 571, 1, 1, 24994, 0, 3662.68, -1220.91, 98.1747, 1.69297, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133294, 27712, 571, 1, 1, 24995, 0, 3664.91, -1226.92, 98.1747, 2.58309, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133293, 27712, 571, 1, 1, 24995, 0, 3681.92, -1166.77, 98.1747, 2.04204, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133291, 27712, 571, 1, 1, 24993, 0, 3684.38, -1159.51, 97.733, 3.00197, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133290, 27712, 571, 1, 1, 24992, 0, 3690.39, -1166.51, 98.1747, 3.33358, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133288, 27712, 571, 1, 1, 24994, 0, 3657.7, -1221.01, 98.2548, 4.11898, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133287, 27712, 571, 1, 1, 24995, 0, 3689.03, -1140.65, 97.6495, 4.33361, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133273, 27712, 571, 1, 1, 24992, 0, 3699.32, -1130.5, 97.6494, 1.13592, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133272, 27712, 571, 1, 1, 24993, 0, 3701.15, -1130.6, 97.6494, 1.79381, 8, 5, 0, 399, 0, 1, 0, 0, 0),
(133258, 27712, 571, 1, 1, 24994, 0, 3673.33, -1138.08, 98.0911, 2.29077, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133257, 27712, 571, 1, 1, 24992, 0, 3689.55, -1126.04, 98.0911, 4.35486, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133256, 27712, 571, 1, 1, 24994, 0, 3711.31, -1156.57, 98.0911, 6.22378, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133255, 27712, 571, 1, 1, 24992, 0, 3674.84, -1139.19, 98.0911, 2.37743, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133254, 27712, 571, 1, 1, 24993, 0, 3682.59, -1122.67, 98.0911, 3.01946, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133253, 27712, 571, 1, 1, 24994, 0, 3683.98, -1123.27, 98.0911, 2.94569, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133252, 27712, 571, 1, 1, 24993, 0, 3717.33, -1142.87, 98.0911, 3.63761, 8, 5, 0, 399, 0, 1, 0, 0, 0),(101977, 27712, 571, 1, 1, 24994, 0, 3655.57, -1216.23, 98.1747, 0.017453, 8, 5, 0, 399, 0, 1, 0, 0, 0),(101976, 27712, 571, 1, 1, 24995, 0, 3650.91, -1219.34, 98.1747, 0.349066, 8, 5, 0, 399, 0, 1, 0, 0, 0),(101975, 27712, 571, 1, 1, 24994, 0, 3649.39, -1213.72, 98.1747, 5.84685, 8, 5, 0, 399, 0, 1, 0, 0, 0),(101973, 27712, 571, 1, 1, 24993, 0, 3656.28, -1262.44, 98.0912, 1.12122, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133259, 27712, 571, 1, 1, 24992, 0, 3701.25, -1129.27, 97.8784, 0.590263, 8, 5, 0, 399, 0, 1, 0, 0, 0),
(133260, 27712, 571, 1, 1, 24993, 0, 3650.1, -1259.2, 98.0911, 2.80981, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133271, 27712, 571, 1, 1, 24993, 0, 3635.19, -1256.17, 98.0911, 4.22659, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133270, 27712, 571, 1, 1, 24993, 0, 3636.81, -1241.15, 98.0911, 4.84643, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133269, 27712, 571, 1, 1, 24993, 0, 3681.24, -1156.84, 97.6495, 4.27953, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133268, 27712, 571, 1, 1, 24993, 0, 3644.47, -1246.31, 98.26, 2.87991, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133267, 27712, 571, 1, 1, 24992, 0, 3699.48, -1157.94, 98.0914, 4.08621, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133266, 27712, 571, 1, 1, 24993, 0, 3637.64, -1254.92, 98.0911, 2.2441, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133265, 27712, 571, 1, 1, 24994, 0, 3640.11, -1239.35, 98.0911, 4.02738, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133264, 27712, 571, 1, 1, 24992, 0, 3698.48, -1153.14, 97.9028, 4.27953, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133263, 27712, 571, 1, 1, 24995, 0, 3651, -1260.85, 98.0911, 4.19283, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133262, 27712, 571, 1, 1, 24995, 0, 3658.88, -1249.62, 98.0911, 0.746046, 8, 5, 0, 399, 0, 1, 0, 0, 0),(133261, 27712, 571, 1, 1, 24992, 0, 3690.16, -1144.33, 97.6508, 4.33844, 8, 5, 0, 399, 0, 1, 0, 0, 0),(101972, 27712, 571, 1, 1, 24994, 0, 3653.13, -1262.09, 98.0912, 5.43792, 8, 5, 0, 399, 0, 1, 0, 0, 0);
UPDATE creature_template SET minlevel=70, maxlevel=70, AIName='', ScriptName='npc_mindless_ghoul' WHERE entry=27712;
UPDATE creature_template SET AIName='SmartAI' WHERE entry=27788;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=49554;
INSERT INTO conditions VALUES (13, 1, 49554, 0, 0, 31, 0, 3, 27795, 0, 0, 0, 0, '', 'Summon Injured Soldier - Target summon point');
UPDATE creature_template SET speed_walk=1.8, speed_run=1.2, AIName='', ScriptName='npc_injured_7th_legion_soldier' WHERE entry=27788;
DELETE FROM creature_text WHERE entry=27788;
INSERT INTO creature_text VALUES(27788, 0, 0, "It's a good thing you came along, ally! We were done for!", 12, 0, 100, 0, 0, 0, 0, 'Injured 7th Legion Soldier');
INSERT INTO creature_text VALUES(27788, 0, 1, "I was almost ghoul bait! Thanks for the rescue!", 12, 0, 100, 0, 0, 0, 0, 'Injured 7th Legion Soldier');
INSERT INTO creature_text VALUES(27788, 0, 2, "Thanks for the cover fire! It's a MADHOUSE down there!", 12, 0, 100, 0, 0, 0, 0, 'Injured 7th Legion Soldier');
INSERT INTO creature_text VALUES(27788, 0, 3, "Wow, I thought I was a goner! Thanks, friend!", 12, 0, 100, 0, 0, 0, 0, 'Injured 7th Legion Soldier');
DELETE FROM waypoint_data WHERE id BETWEEN 277880 AND 277889;
INSERT INTO `waypoint_data` VALUES (277880, 1, 3650.24, -1257.28, 98.0921, 0, 0, 0, 0, 100, 0),(277880, 2, 3640.95, -1241.38, 98.0911, 0, 0, 0, 0, 100, 0),(277880, 3, 3644.72, -1235.74, 98.0911, 0, 0, 0, 0, 100, 0),(277880, 4, 3662.96, -1231.7, 98.0914, 0, 0, 0, 0, 100, 0),(277880, 5, 3666, -1224.47, 98.0914, 0, 0, 0, 0, 100, 0),(277880, 6, 3651.83, -1209.43, 98.0912, 0, 0, 0, 0, 100, 0),(277880, 7, 3654.49, -1204.83, 102.337, 0, 0, 0, 0, 100, 0),(277880, 8, 3656.83, -1200.76, 102.337, 0, 0, 0, 0, 100, 0),(277880, 9, 3666.77, -1203.91, 102.337, 0, 0, 0, 0, 100, 0),(277881, 1, 3639.36, -1253.07, 98.2604, 0, 0, 0, 0, 100, 0),(277881, 2, 3648.61, -1249.43, 98.2604, 0, 0, 0, 0, 100, 0),
(277881, 3, 3652.38, -1242.8, 98.1897, 0, 0, 0, 0, 100, 0),(277881, 4, 3645.7, -1230.41, 98.0914, 0, 0, 0, 0, 100, 0),(277881, 5, 3648.69, -1220.64, 98.0914, 0, 0, 0, 0, 100, 0),(277881, 6, 3662.47, -1222.67, 98.0912, 0, 0, 0, 0, 100, 0),(277881, 7, 3669.98, -1217.53, 98.2395, 0, 0, 0, 0, 100, 0),(277881, 8, 3672.45, -1213.6, 102.337, 0, 0, 0, 0, 100, 0),(277881, 9, 3668.84, -1203.87, 102.337, 0, 0, 0, 0, 100, 0),(277882, 1, 3640.23, -1252.51, 98.2602, 0, 0, 0, 0, 100, 0),(277882, 2, 3638.81, -1244.45, 98.0913, 0, 0, 0, 0, 100, 0),(277882, 3, 3652.51, -1245.33, 98.0916, 0, 0, 0, 0, 100, 0),(277882, 4, 3645.81, -1228.79, 98.0911, 0, 0, 0, 0, 100, 0),
(277882, 5, 3646.91, -1221.16, 98.0911, 0, 0, 0, 0, 100, 0),(277882, 6, 3651.19, -1208.85, 98.0912, 0, 0, 0, 0, 100, 0),(277882, 7, 3653.69, -1204.3, 102.337, 0, 0, 0, 0, 100, 0),(277882, 8, 3666.73, -1198.93, 102.337, 0, 0, 0, 0, 100, 0),(277882, 9, 3669.05, -1194.85, 102.337, 0, 0, 0, 0, 100, 0),(277883, 1, 3644.8, -1255.66, 98.2601, 0, 0, 0, 0, 100, 0),(277883, 2, 3653.37, -1252.38, 98.0913, 0, 0, 0, 0, 100, 0),(277883, 3, 3656.01, -1244.34, 98.0913, 0, 0, 0, 0, 100, 0),(277883, 4, 3648.36, -1239.15, 98.2601, 0, 0, 0, 0, 100, 0),(277883, 5, 3651.54, -1233.95, 98.2601, 0, 0, 0, 0, 100, 0),(277883, 6, 3659.05, -1231.06, 98.0912, 0, 0, 0, 0, 100, 0),(277883, 7, 3670, -1217.95, 98.0914, 0, 0, 0, 0, 100, 0),
(277883, 8, 3672.56, -1213.75, 102.337, 0, 0, 0, 0, 100, 0),(277883, 9, 3669.64, -1203.59, 102.337, 0, 0, 0, 0, 100, 0),(277884, 1, 3635.4, -1254.41, 98.0913, 0, 0, 0, 0, 100, 0),(277884, 2, 3640.49, -1250.57, 98.2604, 0, 0, 0, 0, 100, 0),(277884, 3, 3651.34, -1245.51, 98.1506, 0, 0, 0, 0, 100, 0),(277884, 4, 3658.83, -1234.1, 98.0914, 0, 0, 0, 0, 100, 0),(277884, 5, 3655.83, -1225.59, 98.2603, 0, 0, 0, 0, 100, 0),(277884, 6, 3649.74, -1220.32, 98.0913, 0, 0, 0, 0, 100, 0),(277884, 7, 3652.36, -1209.57, 98.0913, 0, 0, 0, 0, 100, 0),(277884, 8, 3654.66, -1204.91, 102.337, 0, 0, 0, 0, 100, 0),(277884, 9, 3662.08, -1199.17, 102.337, 0, 0, 0, 0, 100, 0),
(277885, 1, 3695.43, -1130.72, 97.6496, 0, 0, 0, 0, 100, 0),(277885, 2, 3704.19, -1139.78, 97.7463, 0, 0, 0, 0, 100, 0),(277885, 3, 3685.87, -1142.25, 98.0361, 0, 0, 0, 0, 100, 0),(277885, 4, 3678.45, -1153.53, 98.0913, 0, 0, 0, 0, 100, 0),(277885, 5, 3688.78, -1162.77, 97.6495, 0, 0, 0, 0, 100, 0),(277885, 6, 3690.45, -1174.84, 98.0913, 0, 0, 0, 0, 100, 0),(277885, 7, 3688.7, -1179.5, 102.337, 0, 0, 0, 0, 100, 0),(277885, 8, 3681.29, -1183, 102.337, 0, 0, 0, 0, 100, 0),(277885, 9, 3675.84, -1181.45, 102.337, 0, 0, 0, 0, 100, 0),(277886, 1, 3691.22, -1129.49, 98.0914, 0, 0, 0, 0, 100, 0),
(277886, 2, 3693.41, -1134.87, 97.6496, 0, 0, 0, 0, 100, 0),(277886, 3, 3685.94, -1137.45, 98.0913, 0, 0, 0, 0, 100, 0),(277886, 4, 3699.29, -1150.32, 97.7789, 0, 0, 0, 0, 100, 0),(277886, 5, 3698.13, -1161.11, 98.0913, 0, 0, 0, 0, 100, 0),(277886, 6, 3682.01, -1159.89, 97.6496, 0, 0, 0, 0, 100, 0),(277886, 7, 3671.81, -1166.09, 98.0914, 0, 0, 0, 0, 100, 0),(277886, 8, 3670.26, -1170.47, 102.337, 0, 0, 0, 0, 100, 0),(277886, 9, 3675.32, -1183.14, 102.337, 0, 0, 0, 0, 100, 0),(277887, 1, 3704.6, -1129.81, 98.0898, 0, 0, 0, 0, 100, 0),(277887, 2, 3704.27, -1136.94, 97.6496, 0, 0, 0, 0, 100, 0),(277887, 3, 3690.61, -1138.77, 97.6496, 0, 0, 0, 0, 100, 0),
(277887, 4, 3686.72, -1145.66, 97.6496, 0, 0, 0, 0, 100, 0),(277887, 5, 3694.59, -1157.06, 97.6496, 0, 0, 0, 0, 100, 0),(277887, 6, 3681.53, -1160.79, 97.6496, 0, 0, 0, 0, 100, 0),(277887, 7, 3672.6, -1166.6, 98.0935, 0, 0, 0, 0, 100, 0),(277887, 8, 3670.62, -1170.74, 102.337, 0, 0, 0, 0, 100, 0),(277887, 9, 3673.96, -1182.89, 102.337, 0, 0, 0, 0, 100, 0),(277888, 1, 3710.12, -1132.58, 98.0911, 0, 0, 0, 0, 100, 0),(277888, 2, 3706.55, -1139.87, 98.0911, 0, 0, 0, 0, 100, 0),(277888, 3, 3692.69, -1139.61, 97.6497, 0, 0, 0, 0, 100, 0),(277888, 4, 3691.47, -1147.42, 97.6497, 0, 0, 0, 0, 100, 0),(277888, 5, 3683.41, -1151.16, 97.7241, 0, 0, 0, 0, 100, 0),
(277888, 6, 3688.16, -1164.25, 97.6498, 0, 0, 0, 0, 100, 0),(277888, 7, 3691.1, -1175.42, 98.0946, 0, 0, 0, 0, 100, 0),(277888, 8, 3688.95, -1179.22, 102.336, 0, 0, 0, 0, 100, 0),(277888, 9, 3677.87, -1185.36, 102.336, 0, 0, 0, 0, 100, 0),(277889, 1, 3701.55, -1129.69, 97.7581, 0, 0, 0, 0, 100, 0),(277889, 2, 3696.77, -1136.25, 97.6496, 0, 0, 0, 0, 100, 0),(277889, 3, 3696.65, -1143.11, 97.6496, 0, 0, 0, 0, 100, 0),(277889, 4, 3688.99, -1148.67, 97.6496, 0, 0, 0, 0, 100, 0),(277889, 5, 3681.69, -1152.23, 97.8987, 0, 0, 0, 0, 100, 0),(277889, 6, 3687.9, -1160.7, 97.6496, 0, 0, 0, 0, 100, 0),
(277889, 7, 3690.91, -1175.33, 98.0913, 0, 0, 0, 0, 100, 0),(277889, 8, 3688.86, -1179.52, 102.337, 0, 0, 0, 0, 100, 0),(277889, 9, 3677.89, -1183.37, 102.337, 0, 0, 0, 0, 100, 0);
-- fix riflemans
DELETE FROM smart_scripts WHERE entryorguid=27791 AND source_type=0 AND event_type=4;
REPLACE INTO smart_scripts VALUES (27791, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Disable Combat Move');

-- Return to the Earth (12417)
-- Return to the Earth (12449)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=27530 AND position_z > 100);
DELETE FROM creature WHERE id=27530 AND position_z > 100;
REPLACE INTO creature_template_addon VALUES (27530, 0, 0, 0, 0, 0, '49132 55795 61204 49334');
UPDATE creature_template SET AIName='SmartAI' WHERE entry=27530;
DELETE FROM smart_scripts WHERE entryorguid=27530 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=27530*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (27530, 0, 0, 1, 8, 0, 100, 0, 49349, 0, 0, 0, 11, 49364, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On spell hit - Cast Spell');
INSERT INTO smart_scripts VALUES (27530, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Linked - Despawn');
INSERT INTO smart_scripts VALUES (27530, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 27530*100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Linked - Script9');
INSERT INTO smart_scripts VALUES (27530, 0, 3, 0, 60, 0, 100, 0, 5000, 5000, 30000, 30000, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Set Visible');
INSERT INTO smart_scripts VALUES (27530*100, 9, 0, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - hide');
DELETE FROM conditions WHERE SourceEntry=49349 AND SourceTypeOrReferenceId IN(17);
INSERT INTO conditions VALUES(17, 0, 49349, 0, 0, 31, 1, 3, 27530, 0, 0, 0, 0, '', 'Target Ruby Keeper');
INSERT INTO conditions VALUES(17, 0, 49349, 0, 0, 1, 1, 49364, 0, 0, 1, 0, 0, '', 'Target without aura');

DELETE FROM creature_text WHERE entry=27539;
INSERT INTO creature_text VALUES(27539, 0, 0, "Every warrior that falls is one more for our mighty army. There is no victory against us.", 14, 0, 100, 0, 0, 0, 0, 'Frigid Necromancer');
INSERT INTO creature_text VALUES(27539, 0, 1, "Rise... rise and feast on their flesh!", 14, 0, 100, 0, 0, 0, 0, 'Frigid Necromancer');
INSERT INTO creature_text VALUES(27539, 0, 2, "The time of the dragons is over...", 14, 0, 100, 0, 0, 0, 0, 'Frigid Necromancer');
INSERT INTO creature_text VALUES(27539, 0, 3, "There is no hope. You will fail.", 14, 0, 100, 0, 0, 0, 0, 'Frigid Necromancer');
INSERT INTO creature_text VALUES(27539, 0, 4, "You will find no peace in death, wyrms!", 14, 0, 100, 0, 0, 0, 0, 'Frigid Necromancer');
INSERT INTO creature_text VALUES(27539, 0, 5, "Your struggle is meaningless. You will all fall before the endless Scourge!", 14, 0, 100, 0, 0, 0, 0, 'Frigid Necromancer');
UPDATE creature_template SET AIName='SmartAI' WHERE entry=27539;
DELETE FROM smart_scripts WHERE entryorguid=27539 AND source_type=0;
INSERT INTO smart_scripts VALUES (27539, 0, 0, 0, 0, 0, 100, 0, 0, 0, 3500, 3500, 11, 9613, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'On IC Update - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (27539, 0, 1, 0, 0, 0, 100, 0, 10000, 10000, 60000, 60000, 11, 50324, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On IC Update - Cast Bone Armor');
INSERT INTO smart_scripts VALUES (27539, 0, 2, 0, 4, 0, 50, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Aggro - Say text 0');
INSERT INTO smart_scripts VALUES (27539, 0, 3, 0, 1, 0, 100, 1, 5000, 5000, 0, 0, 11, 49292, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On OOC Update - Cast Ruby Corrupt');
DELETE FROM conditions WHERE SourceEntry=49292 AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 49292, 0, 0, 31, 0, 3, 27369, 0, 0, 0, 0, '', 'Target Necromantic Rune Bunny');
UPDATE creature_template SET flags_extra=130, InhabitType=4 WHERE entry=27369;

-- Chasing Icestorm: Thel'zan's Phylactery (12467)
UPDATE creature SET spawntimesecs=50 WHERE id=27843;
UPDATE creature SET curhealth=8982 WHERE id=27839;
UPDATE creature_template SET AIName='NullCreatureAI' WHERE entry=27839;
DELETE FROM creature_text WHERE entry=27843;
INSERT INTO creature_text VALUES(27843, 0, 0, "I'll flush her out, $N! You just be ready for her when she comes in!", 12, 0, 100, 0, 0, 0, 0, 'Wyrmbait');
DELETE FROM creature_text WHERE entry=27844;
INSERT INTO creature_text VALUES(27844, 0, 0, "FIRE! FIRE! BRING HER DOWN!", 14, 0, 100, 0, 0, 0, 0, 'Legion Commander Tyralion');
DELETE FROM creature_text WHERE entry=26287;
INSERT INTO creature_text VALUES(26287, 0, 0, "Thel'zan's Phylactery drops to the ground benath Icestorm.", 41, 0, 100, 0, 0, 0, 0, 'Icestorm');
DELETE FROM gossip_menu_option WHERE menu_id=9603;
INSERT INTO gossip_menu_option VALUES(9603, 0, 0, 'Wyrmbait, em? Help, go fetch in Icestorm!', 1, 1, 0, 0, 0, 0, '');
DELETE FROM conditions WHERE SourceGroup=9603 AND SourceTypeOrReferenceId=15;
INSERT INTO conditions VALUES(15, 9603, 0, 0, 0, 9, 0, 12467, 0, 0, 0, 0, 0, '', 'Show gossip option if player has quest active');
UPDATE creature_template SET InhabitType=5, AIName='SmartAI', ScriptName='' WHERE entry=27843;
DELETE FROM smart_scripts WHERE entryorguid=27843 AND source_type=0;
INSERT INTO smart_scripts VALUES (27843, 0, 0, 1, 62, 0, 100, 0, 9603, 0, 0, 0, 60, 1, 250, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Select - Set Fly');
INSERT INTO smart_scripts VALUES (27843, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Select - Close Gossip');
INSERT INTO smart_scripts VALUES (27843, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 53, 1, 27843, 0, 0, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Select - Start WP');
INSERT INTO smart_scripts VALUES (27843, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Select - Talk');
INSERT INTO smart_scripts VALUES (27843, 0, 4, 0, 40, 0, 100, 0, 5, 0, 0, 0, 12, 26287, 4, 60000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Summon Creature');
INSERT INTO smart_scripts VALUES (27843, 0, 5, 0, 40, 0, 100, 0, 11, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Fly false');
INSERT INTO smart_scripts VALUES (27843, 0, 6, 0, 25, 0, 100, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set Fly false');
DELETE FROM waypoints WHERE entry=27843;
INSERT INTO waypoints VALUES (27843, 1, 4545.27, 5.279, 75.2562, 'Wyrmbait'),(27843, 2, 4529.72, 21.8506, 88.5466, 'Wyrmbait'),(27843, 3, 4529.1, 48.2449, 104.161, 'Wyrmbait'),(27843, 4, 4528.12, 74.043, 103.328, 'Wyrmbait'),(27843, 5, 4535.11, 132.119, 106.071, 'Wyrmbait'),(27843, 6, 4541, 90.9399, 101.793, 'Wyrmbait'),(27843, 7, 4538.4, 49.1769, 95.3332, 'Wyrmbait'),
(27843, 8, 4537.15, 21.3384, 86.0038, 'Wyrmbait'),(27843, 9, 4532.23, 0.128148, 82.1963, 'Wyrmbait'),(27843, 10, 4546.23, -4.9997, 75.5355, 'Wyrmbait'),(27843, 11, 4548.17, 4.67055, 70.4695, 'Wyrmbait');
REPLACE INTO creature_template_addon VALUES(26287, 0, 0, 50331648, 0, 0, '');
UPDATE creature_template SET speed_run=2, unit_flags=768, InhabitType=5, AIName='SmartAI', ScriptName='' WHERE entry=26287;
DELETE FROM smart_scripts WHERE entryorguid=26287 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=26287*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (26287, 0, 0, 1, 37, 0, 100, 0, 0, 0, 0, 0, 53, 1, 26287, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - WP Start');
INSERT INTO smart_scripts VALUES (26287, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 60, 1, 200, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Set Fly');
INSERT INTO smart_scripts VALUES (26287, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Set React State');
INSERT INTO smart_scripts VALUES (26287, 0, 3, 4, 1, 0, 100, 0, 2000, 2000, 2000, 2000, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Set Home Pos');
INSERT INTO smart_scripts VALUES (26287, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 86, 49679, 0, 11, 27839, 50, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Cross Cast');
INSERT INTO smart_scripts VALUES (26287, 0, 5, 6, 40, 0, 100, 0, 1, 0, 0, 0, 54, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Pause WP');
INSERT INTO smart_scripts VALUES (26287, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 27844, 80, 0, 0, 0, 0, 0, 'On WP Reach - Talk');
INSERT INTO smart_scripts VALUES (26287, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 60, 1, 200, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Hover');
INSERT INTO smart_scripts VALUES (26287, 0, 8, 9, 40, 0, 100, 0, 2, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Combat Movement');
INSERT INTO smart_scripts VALUES (26287, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Remove Unit Flag');
INSERT INTO smart_scripts VALUES (26287, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set React State');
INSERT INTO smart_scripts VALUES (26287, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Fly false');
INSERT INTO smart_scripts VALUES (26287, 0, 12, 13, 61, 0, 100, 0, 0, 0, 0, 0, 91, 3, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Remove Byte 0');
INSERT INTO smart_scripts VALUES (26287, 0, 13, 14, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 60, 0, 0, 0, 0, 0, 0, 'On WP Reach - Attack Start');
INSERT INTO smart_scripts VALUES (26287, 0, 14, 0, 61, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 11, 26779, 60, 0, 4539, 45, 80.6, 0, 'On WP Reach - Move To Pos Target');
INSERT INTO smart_scripts VALUES (26287, 0, 15, 0, 0, 0, 100, 0, 3000, 3000, 8000, 8000, 11, 47425, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'OOC Update - Cast Spell');
INSERT INTO smart_scripts VALUES (26287, 0, 16, 17, 6, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Death - Talk');
INSERT INTO smart_scripts VALUES (26287, 0, 17, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 49695, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Death - Cast Spell');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=49679 AND ElseGroup=1;
INSERT INTO conditions VALUES (13, 1, 49679, 0, 1, 31, 0, 3, 26287, 0, 0, 0, 0, '', 'Target icestorm');
DELETE FROM waypoints WHERE entry=26287;
INSERT INTO waypoints VALUES (26287, 1, 4539, 45, 100, 'Icestorm'),(26287, 2, 4539, 45, 80.6, 'Icestorm');

-- To Fordragon Hold! (12474)
-- Audience With The Dragon Queen (12495)
DELETE FROM creature_questender WHERE quest=12474;
INSERT INTO creature_questender VALUES(27872, 12474);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=27872);

-- Return To Angrathar (12499)
-- Return To Angrathar (12500)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(27872, 25257);
DELETE FROM smart_scripts WHERE entryorguid IN(27872, 25257) AND source_type=0;
INSERT INTO smart_scripts VALUES (27872, 0, 0, 0, 20, 0, 100, 0, 12499, 0, 0, 0, 68, 14, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Send Movie');
INSERT INTO smart_scripts VALUES (25257, 0, 0, 0, 20, 0, 100, 0, 12500, 0, 0, 0, 68, 14, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Send Movie');

-- A Fall From Grace (12274)
DELETE FROM spell_script_names WHERE spell_id=48762;
INSERT INTO spell_script_names VALUES(48762, 'spell_q12274_a_fall_from_grace_costume');
UPDATE creature_template SET gossip_menu_id=9501, AIName='SmartAI' WHERE entry=27350;
DELETE FROM smart_scripts WHERE entryorguid=27350 AND source_type=0;
INSERT INTO smart_scripts VALUES (27350, 0, 0, 1, 62, 0, 100, 0, 9501, 0, 0, 0, 85, 48762, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Agent Skully - Offer cover renewal during A Fall from Grace');
INSERT INTO smart_scripts VALUES (27350, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Agent Skully - Close Gossip');
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=188713;
DELETE FROM smart_scripts WHERE entryorguid=188713 AND source_type=1;
INSERT INTO smart_scripts VALUES (188713, 1, 0, 1, 70, 0, 100, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 10, 102082, 27202, 0, 0, 0, 0, 0, 'On Just Deactivated - Talk');
INSERT INTO smart_scripts VALUES (188713, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 106200, 27247, 0, 0, 0, 0, 0, 'On Just Deactivated - Set Data');
INSERT INTO smart_scripts VALUES (188713, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 106201, 27247, 0, 0, 0, 0, 0, 'On Just Deactivated - Set Data');
UPDATE creature_template SET speed_walk=1.7, AIName='SmartAI' WHERE entry=27247;
DELETE FROM smart_scripts WHERE entryorguid=27247 AND source_type=0;
INSERT INTO smart_scripts VALUES (27247, 0, 0, 0, 0, 0, 100, 0, 4000, 7000, 10000, 15000, 11, 38256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Devout Bodyguard - Cast Piercing Howl');
INSERT INTO smart_scripts VALUES (27247, 0, 1, 0, 38, 0, 100, 0, 1, 1, 0, 0, 53, 0, 27247, 0, 0, 1000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Devout Bodyguard - On data set - Start WP');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=9532;
INSERT INTO conditions VALUES (15, 9532, 0, 0, 0, 29, 0, 27247, 10, 0, 1, 0, 0, '', 'A Fall from Grace - Show gossip if no guards around');
INSERT INTO conditions VALUES (15, 9532, 0, 0, 0, 1, 0, 48756, 0, 0, 1, 0, 0, '', 'A Fall from Grace - No Kiss Aura');
UPDATE creature_template SET gossip_menu_id=9532, AIName='SmartAI', ScriptName='' WHERE entry=27245;
DELETE FROM smart_scripts WHERE entryorguid=27245 AND source_type=0;
INSERT INTO smart_scripts VALUES (27245, 0, 0, 0, 62, 0, 100, 0, 9536, 0, 0, 0, 11, 48756, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Select - Cast Spell');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=27445;
INSERT INTO conditions VALUES (22, 1, 27445, 0, 0, 1, 0, 48756, 0, 0, 0, 0, 0, '', 'Unit must have aura 48756 to execute smart event');
DELETE FROM creature WHERE id=27445;
INSERT INTO creature VALUES(NULL, 27445, 571, 1, 1, 0, 0, 2827.53, -425.556, 119.887, 4.70432, 300, 0, 0, 42, 0, 0, 0, 0, 0);
UPDATE creature_template SET unit_flags=33554432|256|512, modelid1=17612, modelid2=0, AIName='SmartAI' WHERE entry=27445;
DELETE FROM smart_scripts WHERE entryorguid=27445 AND source_type=0;
INSERT INTO smart_scripts VALUES (27445, 0, 0, 1, 10, 0, 100, 0, 1, 5, 1000, 1000, 28, 48756, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On OOC Los - Remove aura');
INSERT INTO smart_scripts VALUES (27445, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 48759, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On OOC Los - Cast Spell');
INSERT INTO smart_scripts VALUES (27445, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set React State');
DELETE FROM creature_text WHERE entry=27439;
INSERT INTO creature_text VALUES(27439, 0, 0, 'I know a place nearby where we can speak in private, my child. Follow me.', 12, 0, 100, 0, 0, 0, 0, 'High Abbot Landgren');
INSERT INTO creature_text VALUES(27439, 1, 0, 'Did you think that I could not see through your flimsy disguise, $N?', 12, 0, 100, 0, 0, 0, 0, 'High Abbot Landgren');
INSERT INTO creature_text VALUES(27439, 2, 0, 'There is much that you do not understand, $r. The master sees all.', 12, 0, 100, 0, 0, 0, 0, 'High Abbot Landgren');
INSERT INTO creature_text VALUES(27439, 3, 0, "He told me that you would come for me. I won't die by your hand though. I have seen what you have done to my compatriots.", 12, 0, 100, 0, 0, 0, 0, 'High Abbot Landgren');
INSERT INTO creature_text VALUES(27439, 4, 0, "No. I will leave this world in a manner of my own choosing. And I will return, the grand admiral's will permitting.", 12, 0, 100, 0, 0, 0, 0, 'High Abbot Landgren');
INSERT INTO creature_text VALUES(27439, 5, 0, "AAAEEEEIIIiiiiiiiiiiiiiiiii.........................", 12, 0, 100, 0, 0, 0, 0, 'High Abbot Landgren');
UPDATE creature_template SET faction=35, exp=2, minlevel=74, maxlevel=74, speed_walk=2, AIName='SmartAI', ScriptName='' WHERE entry=27439;
DELETE FROM smart_scripts WHERE entryorguid=27439 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=27439*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (27439, 0, 0, 0, 60, 0, 100, 1, 1000, 1000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Talk');
INSERT INTO smart_scripts VALUES (27439, 0, 1, 0, 60, 0, 100, 1, 4000, 4000, 0, 0, 53, 0, 27439, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Start WP');
INSERT INTO smart_scripts VALUES (27439, 0, 2, 0, 40, 0, 100, 1, 13, 0, 0, 0, 80, 27439*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Script9');
INSERT INTO smart_scripts VALUES (27439*100, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1.05, 'Script9 - Set Orientation');
INSERT INTO smart_scripts VALUES (27439*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (27439*100, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (27439*100, 9, 3, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (27439*100, 9, 4, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (27439*100, 9, 5, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (27439*100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 48771, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (27439*100, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Despawn');
INSERT INTO smart_scripts VALUES (27439*100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 97, 20, 20, 0, 0, 0, 0, 1, 0, 0, 0, 2711, -562, 15, 4.1, 'Script9 - Jump to pos');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=48771;
INSERT INTO conditions VALUES (13, 1, 48771, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Quest 12274 Kill Credit');
DELETE FROM waypoints WHERE entry IN(27247, 27439);
INSERT INTO waypoints VALUES (27247, 1, 2791.19, -489.913, 119.618, 'Devout Bodyguard'),(27247, 2, 2790.89, -486.461, 119.618, 'Devout Bodyguard'),(27247, 3, 2795.3, -483.051, 119.79, 'Devout Bodyguard'),(27247, 4, 2802.81, -476.778, 119.617, 'Devout Bodyguard'),(27247, 5, 2810.49, -469.102, 119.617, 'Devout Bodyguard'),(27247, 6, 2815.06, -465.838, 119.616, 'Devout Bodyguard'),(27247, 7, 2818.89, -469.552, 119.842, 'Devout Bodyguard'),(27247, 8, 2823, -471.411, 124.312, 'Devout Bodyguard'),(27247, 9, 2827.5, -472.139, 128.524, 'Devout Bodyguard'),(27247, 10, 2830.89, -471.426, 131.574, 'Devout Bodyguard'),(27247, 11, 2834.82, -469.685, 135.201, 'Devout Bodyguard'),(27247, 12, 2839.76, -462.89, 135.363, 'Devout Bodyguard'),(27247, 13, 2838.14, -452.877, 135.363, 'Devout Bodyguard'),
(27247, 14, 2831.41, -448.48, 135.363, 'Devout Bodyguard'),(27247, 15, 2823.73, -448.069, 135.363, 'Devout Bodyguard'),(27247, 16, 2817.5, -453.122, 135.363, 'Devout Bodyguard'),(27247, 17, 2815.11, -460.489, 135.363, 'Devout Bodyguard'),(27247, 18, 2818.25, -470.07, 135.402, 'Devout Bodyguard'),(27247, 19, 2822.93, -471.575, 140.076, 'Devout Bodyguard'),(27247, 20, 2824.93, -472.218, 142.183, 'Devout Bodyguard'),(27247, 21, 2828.06, -472.535, 145.044, 'Devout Bodyguard'),(27247, 22, 2830.79, -471.943, 147.541, 'Devout Bodyguard'),(27247, 23, 2834.41, -470.538, 150.757, 'Devout Bodyguard'),(27247, 24, 2837.1, -467.819, 150.837, 'Devout Bodyguard'),(27247, 25, 2832.85, -462.689, 150.835, 'Devout Bodyguard');
INSERT INTO waypoints VALUES (27439, 1, 2827.21, -424.453, 119.893, 'High Abbot Landgren'),(27439, 2, 2827.16, -419.978, 118.196, 'High Abbot Landgren'),(27439, 3, 2828.83, -412.829, 118.196, 'High Abbot Landgren'),(27439, 4, 2812.67, -412.411, 118.196, 'High Abbot Landgren'),(27439, 5, 2800.29, -424.385, 118.196, 'High Abbot Landgren'),(27439, 6, 2785.86, -439.541, 118.196, 'High Abbot Landgren'),(27439, 7, 2782.81, -448.413, 118.196, 'High Abbot Landgren'),(27439, 8, 2776.84, -465.826, 116.141, 'High Abbot Landgren'),
(27439, 9, 2771.2, -482.246, 115.963, 'High Abbot Landgren'),(27439, 10, 2765.42, -489.182, 113.692, 'High Abbot Landgren'),(27439, 11, 2758.69, -497.246, 109.831, 'High Abbot Landgren'),(27439, 12, 2742.53, -515.063, 103.642, 'High Abbot Landgren'),(27439, 13, 2736.68, -524.16, 102.781, 'High Abbot Landgren');

-- Heated Battle (12416)
-- Heated Battle (12448)
UPDATE creature SET spawntimesecs=20 WHERE id IN(27531, 27685, 27686);
UPDATE creature_template SET spell1=40504, AIName='', ScriptName='npc_heated_battle', flags_extra = flags_extra|64 WHERE entry=27531;
UPDATE creature_template SET spell1=50361, AIName='', ScriptName='npc_heated_battle', flags_extra = flags_extra|64 WHERE entry=27685;
UPDATE creature_template SET AIName='', ScriptName='npc_heated_battle', flags_extra = flags_extra|64 WHERE entry=27686;
DELETE FROM smart_scripts WHERE entryorguid IN(27531, 27685, 27686) AND source_type=0;

-- Signs of Big Watery Trouble (12011)
UPDATE gameobject_template SET flags=0 WHERE entry=188364;

-- Frostmourne Cavern (12478)
DELETE FROM spell_script_names WHERE spell_id=49817;
INSERT INTO spell_script_names VALUES(49817, 'spell_q12478_frostmourne_cavern');
DELETE FROM gameobject WHERE id IN(201937, 190332, 190191, 192064, 192065, 192066);
INSERT INTO gameobject VALUES(NULL, 190332, 571, 1, 1, 4819.37, -583.699, 163.506, 1.50098, 0, 0, 0.681997, 0.731355, 180, 255, 1, 0);
INSERT INTO gameobject VALUES(NULL, 190191, 571, 1, 1, 4819.28, -583.566, 163.564, 1.3439, 0, 0, 0.622513, 0.782609, 180, 255, 1, 0);
INSERT INTO gameobject VALUES(NULL, 192064, 571, 1, 1, 4823.09, -581.729, 164.163, 2.40835, 0, 0, 0.933544, 0.358463, 180, 255, 1, 0);
INSERT INTO gameobject VALUES(NULL, 192065, 571, 1, 1, 4816.55, -581.285, 163.062, 1.04309, 0, 0, 0.49822, 0.86705, 180, 255, 1, 0);
INSERT INTO gameobject VALUES(NULL, 192066, 571, 1, 1, 4816.64, -582.227, 163.187, -1.24098, 0, 0, -0.581434, 0.813594, 180, 255, 1, 0);
DELETE FROM creature_text WHERE entry=27455 AND groupid>=4;
DELETE FROM creature_text WHERE entry=27480 AND groupid>=2;
INSERT INTO creature_text VALUES(27455, 4, 0, 'The walls of Frostmourne Cavern shudder and shake.', 41, 0, 100, 0, 0, 0, 0, 'Prince Arthas');
INSERT INTO creature_text VALUES(27455, 5, 0, 'Behold, Muradin, our salvation, Frostmourne.', 12, 0, 100, 25, 0, 12729, 0, 'Prince Arthas');
INSERT INTO creature_text VALUES(27455, 6, 0, 'I would gladly bear any curse to save my homeland.', 12, 0, 100, 0, 0, 12730, 0, 'Prince Arthas');
INSERT INTO creature_text VALUES(27455, 7, 0, 'Damn the men! Nothing shall prevent me from having my revenge, old friend. Not even you.', 12, 0, 100, 0, 0, 12731, 0, 'Prince Arthas');
INSERT INTO creature_text VALUES(27455, 8, 0, 'Now, I call out to the spirits of this place. I will give anything or pay any price, if only you will help me save my people.', 12, 0, 100, 0, 0, 12732, 0, 'Prince Arthas');
INSERT INTO creature_text VALUES(27480, 2, 0, "Hold, lad. There's an inscription on the dais. It's a warning. It says, \"Whomsoever takes up this blade shall wield power eternal. Just as the blade rends flesh, so must power scar the spirit.\" Oh, I should've known. The blade is cursed! Let's get the hell out of here!", 12, 0, 100, 0, 0, 12735, 0, 'Muradin');
INSERT INTO creature_text VALUES(27480, 3, 0, "Leave it be, Arthas. Forget this business and lead your men home.", 12, 0, 100, 0, 0, 12736, 0, 'Muradin');
INSERT INTO creature_text VALUES(27480, 4, 0, "O' my head... Wh... Where am I?", 12, 0, 100, 0, 0, 0, 0, 'Muradin');
INSERT INTO creature_text VALUES(27480, 5, 0, "Who... Who am I?", 12, 0, 100, 0, 0, 0, 0, 'Muradin');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(27455, 27480);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry IN(27455, 27480);
INSERT INTO conditions VALUES (22, 1, 27455, 0, 0, 23, 1, 4192, 0, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES (22, 1, 27480, 0, 0, 23, 1, 4192, 0, 0, 0, 0, 0, '', '');
DELETE FROM smart_scripts WHERE entryorguid IN(27455, 27480) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(27455*100, 27480*100) AND source_type=9;
INSERT INTO smart_scripts VALUES (27455, 0, 0, 1, 37, 0, 100, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Set Visible');
INSERT INTO smart_scripts VALUES (27455, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 27455*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Script9');
INSERT INTO smart_scripts VALUES (27455*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (27455*100, 9, 1, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Visible');
INSERT INTO smart_scripts VALUES (27455*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 15, 190332, 20, 0, 0, 0, 0, 0, 'Script9 - Set GO State');
INSERT INTO smart_scripts VALUES (27455*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 27480, 8, 0, 0, 0, 0, 8, 0, 0, 0, 4816.75, -580.34, 162.99, 5.37, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (27455*100, 9, 4, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (27455*100, 9, 5, 0, 0, 0, 100, 0, 36000, 36000, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (27455*100, 9, 6, 0, 0, 0, 100, 0, 16000, 16000, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (27455*100, 9, 7, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (27455*100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4820.36, -582.3, 163.8, 4.0, 'Script9 - Move Point');
INSERT INTO smart_scripts VALUES (27455*100, 9, 9, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 11, 49824, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (27455*100, 9, 10, 0, 0, 0, 100, 0, 11000, 11000, 0, 0, 131, 1, 0, 0, 0, 0, 0, 15, 190332, 20, 0, 0, 0, 0, 0, 'Script9 - Set GO State');
INSERT INTO smart_scripts VALUES (27455*100, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 71, 0, 1, 36942, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Equip');
INSERT INTO smart_scripts VALUES (27455*100, 9, 12, 0, 0, 0, 100, 0, 500, 500, 0, 0, 5, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Play Emote');
INSERT INTO smart_scripts VALUES (27455*100, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Run');
INSERT INTO smart_scripts VALUES (27455*100, 9, 14, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4809.08, -574.8, 160.91, 2.9, 'Script9 - Move Point');
INSERT INTO smart_scripts VALUES (27455*100, 9, 15, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 5, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Play Emote');
INSERT INTO smart_scripts VALUES (27455*100, 9, 16, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4767, -567, 163, 3, 'Script9 - Move Point');
INSERT INTO smart_scripts VALUES (27455*100, 9, 17, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Despawn');
INSERT INTO smart_scripts VALUES (27480, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 80, 27480*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Script9');
INSERT INTO smart_scripts VALUES (27480*100, 9, 0, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4818.63, -582.84, 163.54, 5.2, 'Script9 - Move Point');
INSERT INTO smart_scripts VALUES (27480*100, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (27480*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 68442, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (27480*100, 9, 3, 0, 0, 0, 100, 0, 16000, 16000, 0, 0, 28, 68442, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove Aura');
INSERT INTO smart_scripts VALUES (27480*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0.7, 'Script9 - Set Orientation');
INSERT INTO smart_scripts VALUES (27480*100, 9, 5, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 5, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Play Emote');
INSERT INTO smart_scripts VALUES (27480*100, 9, 6, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4816.75, -580.34, 162.99, 5.37, 'Script9 - Move Point');
INSERT INTO smart_scripts VALUES (27480*100, 9, 7, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 6.13, 'Script9 - Set Orientation');
INSERT INTO smart_scripts VALUES (27480*100, 9, 8, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (27480*100, 9, 9, 0, 0, 0, 100, 0, 35000, 35000, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Bytes0');
INSERT INTO smart_scripts VALUES (27480*100, 9, 11, 0, 0, 0, 100, 0, 20000, 20000, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove Bytes0');
INSERT INTO smart_scripts VALUES (27480*100, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 49829, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (27480*100, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 18970, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (27480*100, 9, 14, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (27480*100, 9, 15, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (27480*100, 9, 16, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Despawn');

-- Fire Upon the Waters (12243)
REPLACE INTO smart_scripts VALUES (28013, 0, 1, 0, 8, 0, 100, 0, 48455, 0, 0, 0, 75, 48522, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Add Aura');
DELETE FROM spell_script_names WHERE spell_id=48522;
INSERT INTO spell_script_names VALUES(48522, 'spell_q12243_fire_upon_the_waters');

-- Blood Oath of the Horde (11983)
DELETE FROM npc_text WHERE ID IN (12611, 12618, 12619, 12620);
INSERT INTO npc_text VALUES (12611, "There is nothing left for us here.",  "There is nothing left for us here.", 1, 1, 0, 0, 0, 0, 0, 0, "My family was slaughtered without mercy. Even the young.", "My family was slaughtered without mercy. Even the young.", 1, 1, 0, 0, 0, 0, 0, 0, "May the Lich King burn in hellfire for what he has called down upon this land.", "May the Lich King burn in hellfire for what he has called down upon this land.", 1, 1, 0, 0, 0, 0, 0, 0, "We are a people without a home to call our own now.", "We are a people without a home to call our own now.", 1, 1, 0, 0, 0, 0, 0, 0, "The Scourge are a fearless machine set to bring about the end of all life on this world.", "The Scourge are a fearless machine set to bring about the end of all life on this world.", 1, 1, 0, 0, 0, 0, 0, 0, "The one that they call Hellscream might be our only hope.", "The one that they call Hellscream might be our only hope.", 1, 1, 0, 0, 0, 0, 0, 0, "Only the Horde can save us now.",  "Only the Horde can save us now.", 1, 1, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 12340);
INSERT INTO npc_text VALUES (12618, "Will the Horde grant me the chance to battle the Scourge?", "Will the Horde grant me the chance to battle the Scourge?", 0, 1, 0, 6, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 12340);
INSERT INTO npc_text VALUES (12619, "To avenge my people,  to drive out the blight that has engulfed our land - I will take your oath. I will pledge all that I have and all that I am to the Horde.", "To avenge my people,  to drive out the blight that has engulfed our land - I will take your oath. I will pledge all that I have and all that I am to the Horde.", 0, 1, 0, 1, 0, 1, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 12340);
INSERT INTO npc_text VALUES (12620, "Lok'tar ogar! Victory or death - it is these words that bind me to the Horde. For they are the most sacred and fundamental of truths to any warrior of the Horde.$B$BI give my flesh and blood freely to the Warchief. I am the instrument of my Warchief's desire. I am a weapon of my Warchief's command.$B$BFrom this moment until the end of days I live and die - FOR THE HORDE!", "Lok'tar ogar! Victory or death - it is these words that bind me to the Horde. For they are the most sacred and fundamental of truths to any warrior of the Horde.$B$BI give my flesh and blood freely to the Warchief. I am the instrument of my Warchief's desire. I am a weapon of my Warchief's command.$B$BFrom this moment until the end of days I live and die - FOR THE HORDE!", 1, 1, 0, 5, 0, 1, 0, 66, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, "", "", 0, 0, 0, 0, 0, 0, 0, 0, 12340);
DELETE FROM gossip_menu WHERE text_id IN (12611, 12618, 12619, 12620);
INSERT INTO gossip_menu VALUES (9302, 12611),(9305, 12618),(9304, 12619),(9303, 12620);
DELETE FROM gossip_menu_option WHERE menu_id IN (9302, 9305, 9304, 9303);
INSERT INTO gossip_menu_option VALUES (9302, 0, 0, "Worry no more,  taunka. The Horde will save and protect you and your people,  but first you must swear allegiance to the Warchief by taking the blood oath of the Horde.", 1, 1, 9305, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (9305, 0, 0, "Yes,  taunka. Retribution is a given right of all members of the Horde.", 1, 1, 9304, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (9304, 0, 0, "Then repeat after me: Lok'tar ogar! Victory or death - it is these words that bind me to the Horde. For they are the most sacred and fundamental of truths to any warrior of the Horde. I give my flesh and blood freely to the Warchief. I am the instrument of my Warchief's desire. I am a weapon of my Warchief's command. From this moment until the end of days I live and die - For the Horde!", 1, 1, 9303, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (9303, 0, 0, "For the Horde! Arm yourself from the crates that surround us and report to Agmar's Hammer,  east of here. Your first trial as a member of the Horde is to survive the journey. Lok'tar ogar!", 1, 1, 0, 0, 0, 0, '');
UPDATE creature_template SET AIName='SmartAI', gossip_menu_id=9302, npcflag=npcflag|1 WHERE entry IN (26179, 26184);
DELETE FROM smart_scripts WHERE entryorguid IN (26179, 26184) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN (26179*100, 26184*100) AND source_type=9;
INSERT INTO smart_scripts VALUES (26179, 0, 0, 0, 62, 0, 100, 0, 9303, 0, 0, 0, 80, 26179*100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Taunka'le Refugee - on gossip select - start script");
INSERT INTO smart_scripts VALUES (26179*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "turn off gossip & set npcflag 0");
INSERT INTO smart_scripts VALUES (26179*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 33, 26179, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "give kill credit");
INSERT INTO smart_scripts VALUES (26179*100, 9, 2, 0, 0, 0, 100, 0, 60000, 60000, 60000, 60000, 81, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "after 60sec - turn on gossip & set npcflag 1");
INSERT INTO smart_scripts VALUES (26184, 0, 0, 0, 62, 0, 100, 0, 9303, 0, 0, 0, 80, 26184*100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Taunka'le Refugee - on gossip select - start script");
INSERT INTO smart_scripts VALUES (26184*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "turn off gossip & set npcflag 0");
INSERT INTO smart_scripts VALUES (26184*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 33, 26179, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "give kill credit");
INSERT INTO smart_scripts VALUES (26184*100, 9, 2, 0, 0, 0, 100, 0, 60000, 60000, 60000, 60000, 81, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "after 60sec - turn on gossip & set npcflag 1");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=9302;
INSERT INTO conditions VALUES (15, 9302, 0, 0, 0, 9, 0, 11983, 0, 0, 0, 0, 0, '', 'show gossip option if player has quest 11983 taken');
INSERT INTO conditions VALUES (15, 9302, 0, 0, 0, 2, 0, 35784, 1, 0, 0, 0, 0, '', 'show gossip option if player has Item: Blood Oath of the Horde');

-- Sarathstra, Scourge of the North (12097)
REPLACE INTO creature_text VALUES(26859, 0, 0, "Don't ya worry, man. Just leave it to Rokhan. She be comin'.", 12, 0, 100, 0, 0, 0, 0, "");
DELETE FROM conditions WHERE SourceGroup=9434 AND SourceTypeOrReferenceId=15;
INSERT INTO conditions VALUES(15, 9434, 0, 0, 0, 9, 0, 12097, 0, 0, 0, 0, 0, "", "Player must have quest active to see gossip");
DELETE FROM gossip_menu_option WHERE menu_id=9434;
INSERT INTO gossip_menu_option VALUES(9434, 0, 0, "This brings Frostwyrm to the ground and put an end to her.", 1, 1, 0, 0, 0, 0, '');
UPDATE creature_template SET AIName="SmartAI" WHERE entry=26859;
REPLACE INTO creature_template_addon VALUES(26858, 0, 0, 50331648, 0, 0, '');
UPDATE creature_template SET InhabitType=5, AIName="SmartAI" WHERE entry=26858;
DELETE FROM smart_scripts WHERE entryorguid IN(26858, 26859) AND source_type=0;
INSERT INTO smart_scripts VALUES(26859, 0, 0, 1, 62, 1, 100, 0, 9434, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Gossip Select - Close Gossip");
INSERT INTO smart_scripts VALUES(26859, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Gossip Select - Talk");
INSERT INTO smart_scripts VALUES(26859, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 12, 26858, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 4413.97, 904.4, 125, 2.3, "On Gossip Select - Summon Creature");
INSERT INTO smart_scripts VALUES(26859, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 26858, 150, 0, 0, 0, 0, 0, "On Gossip Select - Set Data");
INSERT INTO smart_scripts VALUES(26859, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Gossip Select - Set Phase");
INSERT INTO smart_scripts VALUES(26859, 0, 5, 0, 25, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Reset - Set Phase");
INSERT INTO smart_scripts VALUES(26859, 0, 6, 0, 60, 2, 100, 0, 60000, 60000, 60000, 60000, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Update - Set Phase");
INSERT INTO smart_scripts VALUES(26858, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4374.88, 943.2, 88.7, 0, "On Data Set - Move To Pos");
INSERT INTO smart_scripts VALUES(26858, 0, 1, 7, 34, 0, 100, 0, 8, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Movement Inform - Set Phase");
INSERT INTO smart_scripts VALUES(26858, 0, 2, 3, 60, 1, 100, 1, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Update - Set Fly false");
INSERT INTO smart_scripts VALUES(26858, 0, 3, 4, 61, 1, 100, 0, 0, 0, 0, 0, 91, 3, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Update - Remove Byte 0");
INSERT INTO smart_scripts VALUES(26858, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 100, 0, 0, 0, 0, 0, 0, "On Update - Attack Start");
INSERT INTO smart_scripts VALUES(26858, 0, 5, 6, 25, 0, 100, 0, 0, 0, 0, 0, 60, 1, 150, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Reset - Set Fly true");
INSERT INTO smart_scripts VALUES(26858, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 90, 3, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Reset - Set Byte 0");
INSERT INTO smart_scripts VALUES(26858, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Movement Inform - Set Home Position");

-- Blightbeasts be Damned! (12072)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=16 AND SourceEntry=26813;
INSERT INTO conditions VALUES (16, 0, 26813, 0, 0, 23, 0, 4163, 0, 0, 0, 0, 0, '', 'Dismount player when not in intended zone');
REPLACE INTO creature_template_addon VALUES (26607, 0, 0, 50331648, 0, 0, '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(47438, 47441);
INSERT INTO conditions VALUES (13, 1, 47438, 0, 0, 31, 0, 3, 26607, 0, 0, 0, 0, '', 'Target Anub''ar Blightbeast');
INSERT INTO conditions VALUES (13, 1, 47441, 0, 0, 31, 0, 3, 26607, 0, 0, 0, 0, '', 'Target Anub''ar Blightbeast');

-- Messy Business (12076)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=47435;
INSERT INTO conditions VALUES (17, 0, 47435, 0, 0, 1, 0, 47447, 1, 0, 0, 22, 0, '', 'Requires aura to cast spell');
DELETE FROM spell_linked_spell WHERE spell_trigger=47435;
REPLACE INTO spell_linked_spell VALUES(47435, -47447, 1, 'Messy Business - Remove Spit');

-- The Best of Intentions (12263)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=9537;
INSERT INTO conditions VALUES (15, 9537, 0, 0, 0, 9, 0, 12263, 0, 0, 0, 0, 0, '', 'show gossip option if player has quest 12263 taken');
UPDATE creature_template SET AIName="SmartAI" WHERE entry=26593;
DELETE FROM smart_scripts WHERE entryorguid=26593 AND source_type=0;
INSERT INTO smart_scripts VALUES (26593, 0, 0, 1, 62, 0, 100, 0, 9537, 0, 0, 0, 11, 48750, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Gossip Select - Cast Spell Burning Depths Necrolyte");
INSERT INTO smart_scripts VALUES (26593, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Gossip Select - Close gossip");
INSERT INTO smart_scripts VALUES (26593, 0, 2, 0, 19, 0, 100, 0, 12263, 0, 0, 0, 11, 48750, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Quest Accept - Cast Spell Burning Depths Necrolyte");

-- The Forsaken Blight and You: How Not to Die (12188)
UPDATE quest_template SET ExclusiveGroup=0 WHERE NextQuestId=12188;

-- Hell Hath a Fury (12674)
DELETE FROM spell_script_names WHERE spell_id IN(52249, 52278);
INSERT INTO spell_script_names VALUES(52249, "spell_gen_visual_dummy_stun");
INSERT INTO spell_script_names VALUES(52278, "spell_gen_visual_dummy_stun");
DELETE FROM spell_linked_spell WHERE spell_trigger IN(-52249, 52249, -41909, 41909, -52278, 52278, -52279, 52279, -52287, 52287, -52303, 52303);
INSERT INTO spell_linked_spell VALUES (-52249, 41909, 0, 'Hell Hath a Fury: Hex of Air Knockback');
INSERT INTO spell_linked_spell VALUES (-52278, 52279, 0, 'Hell Hath a Fury: High Priestess Tua-Tua on Burn');
INSERT INTO spell_linked_spell VALUES (52279, 45254, 1, 'On spellhit Tua-Tua on Burn - Spellcast Suicide');
INSERT INTO spell_linked_spell VALUES (52303, 45254, 1, 'On spellhit Hawinni on Frozen - Spellcast Suicide');
DELETE FROM smart_scripts WHERE entryorguid IN(28752, 28754, 28756) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(28752*100, 28754*100, 28756*100) AND source_type=9;
INSERT INTO smart_scripts VALUES (28752, 0, 0, 2, 11, 0, 100, 0, 0, 0, 0, 0, 11, 51733, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priest Mu''funu - On Respawn - Cast Shadow Channelling');
INSERT INTO smart_scripts VALUES (28752, 0, 1, 2, 21, 0, 100, 0, 0, 0, 0, 0, 11, 51733, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priest Mu''funu - On Reached Home - Cast Shadow Channelling');
INSERT INTO smart_scripts VALUES (28752, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 42, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priest Mu''funu - Linked - Reset Invincibility Hp');
INSERT INTO smart_scripts VALUES (28752, 0, 3, 0, 0, 0, 100, 0, 0, 0, 2500, 2500, 11, 20820, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'High Priest Mu''funu - In Combat - Cast Holy Smite');
INSERT INTO smart_scripts VALUES (28752, 0, 4, 0, 0, 0, 100, 0, 0, 0, 30000, 30000, 11, 11974, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priest Mu''funu - In Combat - Cast Power Word: Shield');
INSERT INTO smart_scripts VALUES (28752, 0, 5, 0, 0, 0, 100, 0, 50, 50, 15000, 20000, 11, 11640, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priest Mu''funu - In Combat - Cast Renew');
INSERT INTO smart_scripts VALUES (28752, 0, 6, 0, 8, 0, 100, 0, 52250, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priest Mu''funu - On Spellhit Quetz''lun''s Hex - Set Invincibility Hp 1');
INSERT INTO smart_scripts VALUES (28752, 0, 7, 8, 2, 0, 100, 1, 0, 0, 0, 0, 33, 28753, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 'High Priest Mu''funu - Between 0-0% Health - Quest Credit Hell Hath a Fury');
INSERT INTO smart_scripts VALUES (28752, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priest Mu''funu - Between 0-0% Health - Say Line 0');
INSERT INTO smart_scripts VALUES (28752, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 11, 52249, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priest Mu''funu - Between 0-0% Health - Cast Quetz''lun''s Hex of Air');
INSERT INTO smart_scripts VALUES (28752, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 13500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priest Mu''funu - Between 0-0% Health - Despawn');
INSERT INTO smart_scripts VALUES (28754, 0, 0, 2, 11, 0, 100, 0, 0, 0, 0, 0, 11, 51733, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priestess Tua-Tua - On Respawn - Cast Shadow Channelling');
INSERT INTO smart_scripts VALUES (28754, 0, 1, 2, 21, 0, 100, 0, 0, 0, 0, 0, 11, 51733, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priestess Tua-Tua - On Reached Home - Cast Shadow Channelling');
INSERT INTO smart_scripts VALUES (28754, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 42, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priestess Tua-Tua - Linked - Reset Invincibility Hp');
INSERT INTO smart_scripts VALUES (28754, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 29406, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priestess Tua-Tua - On Aggro - Cast Shadowform');
INSERT INTO smart_scripts VALUES (28754, 0, 4, 0, 0, 0, 100, 0, 2000, 3000, 15000, 20000, 11, 51818, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'High Priestess Tua-Tua - In Combat - Cast Shadow Word: Death');
INSERT INTO smart_scripts VALUES (28754, 0, 5, 0, 0, 0, 100, 0, 4000, 5000, 3000, 5000, 11, 13860, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'High Priestess Tua-Tua - In Combat - Cast Mind Blast');
INSERT INTO smart_scripts VALUES (28754, 0, 6, 0, 8, 0, 100, 0, 52250, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priestess Tua-Tua - On Spellhit Quetz''lun''s Hex - Set Invincibility Hp 1');
INSERT INTO smart_scripts VALUES (28754, 0, 7, 8, 2, 0, 100, 1, 0, 0, 0, 0, 33, 28755, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 'High Priestess Tua-Tua - Between 0-0% Health - Quest Credit Hell Hath a Fury');
INSERT INTO smart_scripts VALUES (28754, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priestess Tua-Tua - Between 0-0% Health - Say Line 0');
INSERT INTO smart_scripts VALUES (28754, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 52278, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priestess Tua-Tua - Between 0-0% Health - Cast Quetz''lun''s Hex of Fire');
INSERT INTO smart_scripts VALUES (28754, 0, 10, 0, 8, 0, 100, 0, 52279, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priestess Tua-Tua - On Spellhit Hell Hath a Fury: High Priestess Tua-Tua on Burn - Say Line 1');
INSERT INTO smart_scripts VALUES (28756, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 42, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priestess Tua-Tua - On Reset - Reset Invincibility Hp');
INSERT INTO smart_scripts VALUES (28756, 0, 1, 0, 0, 0, 100, 0, 2000, 3000, 10000, 15000, 11, 54603, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priest Hawinni - In Combat - Cast Serpent''s Agility');
INSERT INTO smart_scripts VALUES (28756, 0, 2, 3, 2, 0, 100, 1, 0, 40, 0, 0, 11, 50420, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priest Hawinni - Between 0-40% Health - Cast Enrage');
INSERT INTO smart_scripts VALUES (28756, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'High Priest Hawinni - Between 0-40% Health - Say Line 0');
INSERT INTO smart_scripts VALUES (28756, 0, 4, 0, 8, 0, 100, 0, 52250, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priest Hawinni - On Spellhit Quetz''lun''s Hex - Set Invincibility Hp 1');
INSERT INTO smart_scripts VALUES (28756, 0, 5, 6, 2, 0, 100, 1, 0, 0, 0, 0, 33, 28757, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 'High Priest Hawinni - Between 0-0% Health - Quest Credit Hell Hath a Fury');
INSERT INTO smart_scripts VALUES (28756, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 2875600, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priest Hawinni - Between 0-0% Health - Run Script');
INSERT INTO smart_scripts VALUES (2875600, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 52287, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priest Hawinni - On Script - Cast Quetz''lun''s Hex of Frost');
INSERT INTO smart_scripts VALUES (2875600, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priest Hawinni - On Script - Say Line 1');
INSERT INTO smart_scripts VALUES (2875600, 9, 2, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 11, 42267, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priest Hawinni - On Script - Cast Random Circumference Point Bone');
INSERT INTO smart_scripts VALUES (2875600, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 42274, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priest Hawinni - On Script - Cast Random Circumference Point Bone 2');
INSERT INTO smart_scripts VALUES (2875600, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 42267, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priest Hawinni - On Script - Cast Random Circumference Point Bone');
INSERT INTO smart_scripts VALUES (2875600, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 42274, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priest Hawinni - On Script - Cast Random Circumference Point Bone 2');
INSERT INTO smart_scripts VALUES (2875600, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 52320, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priest Hawinni - On Script - Cast Hell Hath a Fury: Random Circumference Point Ice Chunk');
INSERT INTO smart_scripts VALUES (2875600, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 42267, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priest Hawinni - On Script - Cast Random Circumference Point Bone');
INSERT INTO smart_scripts VALUES (2875600, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 42274, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priest Hawinni - On Script - Cast Random Circumference Point Bone 2');
INSERT INTO smart_scripts VALUES (2875600, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 52320, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priest Hawinni - On Script - Cast Hell Hath a Fury: Random Circumference Point Ice Chunk');
INSERT INTO smart_scripts VALUES (2875600, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 52320, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priest Hawinni - On Script - Cast Hell Hath a Fury: Random Circumference Point Ice Chunk');
INSERT INTO smart_scripts VALUES (2875600, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 52320, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priest Hawinni - On Script - Cast Hell Hath a Fury: Random Circumference Point Ice Chunk');
INSERT INTO smart_scripts VALUES (2875600, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 52320, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priest Hawinni - On Script - Cast Hell Hath a Fury: Random Circumference Point Ice Chunk');
INSERT INTO smart_scripts VALUES (2875600, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'High Priest Hawinni - On Script - Say Line 2');
INSERT INTO smart_scripts VALUES (2875600, 9, 14, 0, 0, 0, 100, 0, 50, 50, 0, 0, 11, 52303, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priest Hawinni - On Script - Cast Hell Hath a Fury: High Priest Hawinni on Frozen');

-- The Kor'kron Vanguard! (12224)
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(19, 20) AND SourceEntry=12224;
INSERT INTO conditions VALUES (19, 0, 12224, 0, 0, 8, 0, 12008, 0, 0, 0, 0, 0, '', 'Requires quest rewarded');
INSERT INTO conditions VALUES (19, 0, 12224, 0, 0, 8, 0, 12072, 0, 0, 0, 0, 0, '', 'Requires quest rewarded');
INSERT INTO conditions VALUES (19, 0, 12224, 0, 0, 8, 0, 12140, 0, 0, 0, 0, 0, '', 'Requires quest rewarded');
INSERT INTO conditions VALUES (19, 0, 12224, 0, 0, 8, 0, 12221, 0, 0, 0, 0, 0, '', 'Requires quest rewarded');
INSERT INTO conditions VALUES (20, 0, 12224, 0, 0, 8, 0, 12008, 0, 0, 0, 0, 0, '', 'Requires quest rewarded');
INSERT INTO conditions VALUES (20, 0, 12224, 0, 0, 8, 0, 12072, 0, 0, 0, 0, 0, '', 'Requires quest rewarded');
INSERT INTO conditions VALUES (20, 0, 12224, 0, 0, 8, 0, 12140, 0, 0, 0, 0, 0, '', 'Requires quest rewarded');
INSERT INTO conditions VALUES (20, 0, 12224, 0, 0, 8, 0, 12221, 0, 0, 0, 0, 0, '', 'Requires quest rewarded');

-- Into the Fold (11978)
UPDATE quest_template SET PrevQuestId=0 WHERE Id=11978;
UPDATE quest_template SET NextQuestId=11978 WHERE Id IN(11977, 11979);

-- A Strange Device (12055)
-- A Strange Device (12059)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=1 AND SourceEntry IN(36742, 36746);
INSERT INTO conditions VALUES (1, 26349, 36742, 0, 0, 14, 0, 12004, 0, 0, 1, 0, 0, '', 'Requires quest status');
INSERT INTO conditions VALUES (1, 26349, 36746, 0, 0, 14, 0, 12005, 0, 0, 1, 0, 0, '', 'Requires quest status');

-- Attunement to Dalaran (12172)
-- Attunement to Dalaran (12173)
UPDATE smart_scripts SET event_flags=0 WHERE entryorguid=27135 AND source_type=0;

-- Strengthen the Ancients (12092)
-- Strengthen the Ancients (12096)
UPDATE smart_scripts SET event_flags=0 WHERE entryorguid=26321 AND source_type=0;

-- Spiritual Insight (12028)
UPDATE creature_template SET flags_extra=130, AIName='', ScriptName='npc_spiritual_insight' WHERE entry=26594;
DELETE FROM spell_linked_spell WHERE spell_trigger=47190;
INSERT INTO spell_linked_spell VALUES(47190, 47189, 1, "Toalu'u's Spiritual Incense");
DELETE FROM event_scripts WHERE id IN(17604, 17605, 17606, 17607, 17608, 17609);
INSERT INTO event_scripts VALUES (17604, 0, 10, 26594, 1, 0, 2686, 934, 18, 0);
INSERT INTO event_scripts VALUES (17605, 0, 10, 26594, 1, 0, 3097, 1037, 128, 0);
INSERT INTO event_scripts VALUES (17606, 0, 10, 26594, 1, 0, 3014, 1321, 168, 0);
INSERT INTO event_scripts VALUES (17607, 0, 10, 26594, 1, 0, 2854, 1514, 167, 0);
INSERT INTO event_scripts VALUES (17608, 0, 10, 26594, 1, 0, 3129, 1556, 178, 0);
INSERT INTO event_scripts VALUES (17609, 0, 10, 26594, 1, 0, 3117, 1288, 173, 0);
INSERT INTO event_scripts VALUES (17609, 0, 7, 12028, 0, 0, 0, 0, 0, 0);
DELETE FROM creature_text WHERE entry=26594;
INSERT INTO creature_text VALUES(26594, 0, 0, "You've successfully freed your spirit! You can serve as my eyes. Together we'll get to the bottom of this.", 15, 0, 100, 0, 0, 0, 0, "Spiritual Insight");
INSERT INTO creature_text VALUES(26594, 1, 0, "You're coming up on the village now. Keep your eyes peeled.", 15, 0, 100, 0, 0, 0, 0, "Spiritual Insight");
INSERT INTO creature_text VALUES(26594, 2, 0, "What's happened to the lake bed? Strange power is pouring out of it.", 15, 0, 100, 0, 0, 0, 0, "Spiritual Insight");
INSERT INTO creature_text VALUES(26594, 3, 0, "No... no! My people are all dead spirits or deranged!", 15, 0, 100, 0, 0, 0, 0, "Spiritual Insight");
INSERT INTO creature_text VALUES(26594, 4, 0, "Elder Mana'loa, the statue there, sees you. This is a good sign!", 15, 0, 100, 0, 0, 0, 0, "Spiritual Insight");
INSERT INTO creature_text VALUES(26594, 5, 0, "Come back, $N. If you're out of your body for too long, you run the risk of not being able to return. We have much to discuss.", 15, 0, 100, 0, 0, 0, 0, "Spiritual Insight");

-- Rifle the Bodies (11999)
-- Rifle the Bodies (12000)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=18 AND SourceGroup=26477;
INSERT INTO conditions VALUES (18, 26477, 61832, 0, 0, 9, 0, 11999, 0, 0, 0, 0, 0, '', 'Required quest active for spellclick');
INSERT INTO conditions VALUES (18, 26477, 61832, 0, 1, 9, 0, 12000, 0, 0, 0, 0, 0, '', 'Required quest active for spellclick');
UPDATE creature_template SET modelid2=0, flags_extra=2 WHERE entry=26477;
DELETE FROM npc_spellclick_spells WHERE npc_entry=26477;
INSERT INTO npc_spellclick_spells VALUES (26477, 61832, 1, 0);
DELETE FROM smart_scripts WHERE entryorguid=26477 AND source_type=0;
INSERT INTO smart_scripts VALUES (26477, 0, 0, 1, 8, 0, 100, 0, 61832, 0, 0, 0, 11, 47096, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Dead Mage Hunter - On Spellhit 'Rifle the Bodies: Create Magehunter Personal Effects Cover' - Cast Spell");
INSERT INTO smart_scripts VALUES (26477, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dead Mage Hunter - On Spellhit 'Rifle the Bodies: Create Magehunter Personal Effects Cover' - Despawn Instant (No Repeat)");

-- That Which Creates Can Also Destroy (12459)
UPDATE creature_template SET InhabitType=4 WHERE entry=27821;

-- Containing the Rot (12100)
UPDATE creature_loot_template SET ChanceOrQuestChance=-15 WHERE item=36800;

-- The Twilight Destroyer (26034)
UPDATE quest_template SET OfferRewardText="<Krasus listens intently as you relate your battle with Halion, and then his eyes go wide at the mention of Deathwing.>$N$NWe owe you a debt of gratitude, mortal, for driving the invaders from the Sanctum. But this news of the Destroyer is troubling beyond words. I have much to discuss with the other members of the Accord.$N$NTake these as a token of my thanks, as you gird yourselves for the coming storm." WHERE Id=26034;

-- Perfect Dissemblance (12260)
DELETE FROM creature_text WHERE entry IN(27202, 27405, 27406);
INSERT INTO creature_text VALUES (27202, 0, 0, 'Abbendis will see you purged!', 12, 0, 100, 0, 0, 0, 0, 'Onslaught Raven Priest');
INSERT INTO creature_text VALUES (27202, 0, 1, 'You are impure!', 12, 0, 100, 0, 0, 0, 0, 'Onslaught Raven Priest');
INSERT INTO creature_text VALUES (27202, 0, 2, 'Gah! What are you doing?', 12, 0, 100, 5, 0, 7256, 0, 'Onslaught Raven Priest');
INSERT INTO creature_text VALUES (27202, 1, 0, 'I sense the taint of this land in you, footman.  Report to the Bishop before the start of your next shift.', 12, 0, 100, 0, 0, 0, 0, 'Onslaught Raven Priest');
INSERT INTO creature_text VALUES (27202, 1, 1, 'Your protection is strong, child.  Continue your work.', 12, 0, 100, 0, 0, 0, 0, 'Onslaught Raven Priest');
INSERT INTO creature_text VALUES (27202, 1, 2, 'The Grand Admiral himself has come to see to our dedication.  If I see you slacking on your post again, I will gut you myself.', 12, 0, 100, 0, 0, 0, 0, 'Onslaught Raven Priest');
INSERT INTO creature_text VALUES (27202, 1, 3, 'You require the Bishop''s blessing.  Go to him soon.', 12, 0, 100, 0, 0, 0, 0, 'Onslaught Raven Priest');
INSERT INTO creature_text VALUES (27202, 2, 0, 'HELP! HELP! THIS $g MAN : WOMAN; HAS STOLEN MY IMAGE!', 12, 0, 100, 0, 0, 0, 0, 'Onslaught Raven Priest');
INSERT INTO creature_text VALUES (27405, 0, 0, 'What''s going on here, sarge?', 12, 0, 100, 0, 0, 0, 0, 'Onslaught Footman');
INSERT INTO creature_text VALUES (27406, 0, 0, 'I don''t know. Better kill them both to be on the safe side!', 12, 0, 100, 0, 0, 0, 0, 'Onslaught Footman');
UPDATE creature_template SET AIName="SmartAI" WHERE entry IN (27202, 27405, 27406);
DELETE FROM smart_scripts WHERE entryorguid IN (27202, 27405, 27406) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN (2740500, 2740600) AND source_type=9;
INSERT INTO smart_scripts VALUES (27202, 0, 0, 0, 0, 0, 100, 0, 500, 1000, 3000, 3500, 11, 50740, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Raven Priest - In Combat - Cast Raven Flock');
INSERT INTO smart_scripts VALUES (27202, 0, 1, 0, 2, 0, 100, 0, 0, 30, 14000, 18000, 11, 50750, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Raven Priest - Between 0-30% Health - Cast Raven Heal');
INSERT INTO smart_scripts VALUES (27202, 0, 2, 3, 8, 0, 100, 0, 48679, 0, 0, 0, 85, 48762, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Raven Priest - On Spellhit Banshee''s Magic Mirror - Cast A Fall from Grace: Scarlet Raven Priest Image - Master');
INSERT INTO smart_scripts VALUES (27202, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 11, 48648, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Raven Priest - On Spellhit Banshee''s Magic Mirror - Cast The Perfect Dissemblance: Summon Player''s Footman & Credit Credit');
INSERT INTO smart_scripts VALUES (27202, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 85, 48654, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Raven Priest - On Spellhit Banshee''s Magic Mirror - Cast The Perfect Dissemblance: Summon Priest''s Footman');
INSERT INTO smart_scripts VALUES (27202, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Raven Priest - On Spellhit Banshee''s Magic Mirror - Say Line 2');
INSERT INTO smart_scripts VALUES (27202, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Raven Priest - On Spellhit Banshee''s Magic Mirror - Set Faction');
INSERT INTO smart_scripts VALUES (27405, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 80, 2740500, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Footman - On just summoned - Action list');
INSERT INTO smart_scripts VALUES (2740500, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Footman - Action list - Set faction');
INSERT INTO smart_scripts VALUES (2740500, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Footman - Action list - Talk text1');
INSERT INTO smart_scripts VALUES (2740500, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Onslaught Footman - Action list - Start attack');
INSERT INTO smart_scripts VALUES (27405, 0, 1, 0, 0, 0, 100, 0, 2000, 2000, 28000, 28000, 11, 50713, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Footman - IC - Unrelenting Onslaught');
INSERT INTO smart_scripts VALUES (27406, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 80, 2740600, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Footman - On just summoned - Action list');
INSERT INTO smart_scripts VALUES (2740600, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Footman - Action list - Set faction');
INSERT INTO smart_scripts VALUES (2740600, 9, 1, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Footman - Action list - Talk text1');
INSERT INTO smart_scripts VALUES (2740600, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Onslaught Footman - Action list - Start attack');
INSERT INTO smart_scripts VALUES (27406, 0, 1, 0, 0, 0, 100, 0, 2000, 2000, 28000, 28000, 11, 50713, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Footman - IC - Unrelenting Onslaught');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=27202;

-- Return of the High Chief (12069)
UPDATE creature_template SET AIName='SmartAI' WHERE entry IN(26772, 26654, 26656, 26608);
REPLACE INTO creature_template_addon VALUES (26772, 0, 0, 0, 1, 0, '');
REPLACE INTO creature_template_addon VALUES (26608, 0, 0, 0, 1, 0, '');
REPLACE INTO creature_template_addon VALUES (26656, 0, 0, 0, 1, 0, '');
REPLACE INTO creature_template_addon VALUES (26654, 0, 0, 0, 1, 0, '');
UPDATE gameobject_template SET AIName='SmartGameObjectAI' WHERE entry=188463;
DELETE FROM smart_scripts WHERE entryorguid=188463 AND source_type=1;
INSERT INTO smart_scripts VALUES (188463, 1, 0, 1, 70, 0, 100, 0, 2, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 26654, 50, 0, 0, 0, 0, 0, 'Anub ar Mechanism - On State Changed - Set Data on Roanauk Icemist');
INSERT INTO smart_scripts VALUES (188463, 1, 1, 0, 61, 0, 100, 0, 2, 0, 0, 0, 70, 600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Anub ar Mechanism - On State Changed - Despawn GO');
DELETE FROM smart_scripts WHERE entryorguid=26656 AND source_type=0;
INSERT INTO smart_scripts VALUES (26656, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 11, 47272, 0, 0, 0, 0, 0, 9, 26656, 10, 20, 0, 0, 0, 0, 'Anub''ar Prison - On Data Set 1 1 - Cast Anub''ar Prison');
INSERT INTO smart_scripts VALUES (26656, 0, 1, 0, 38, 0, 100, 0, 2, 2, 0, 0, 28, 47272, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Prison - On Data Set 2 2 - Remove Anub''ar Prison');
DELETE FROM smart_scripts WHERE entryorguid=26772 AND source_type=0;
INSERT INTO smart_scripts VALUES (26772, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, 29266, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Icemist Warrior - On Spawn - Cast Permament Feign Death');
INSERT INTO smart_scripts VALUES (26772, 0, 1, 0, 8, 0, 100, 0, 47378, 0, 0, 0, 28, 29266, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Icemist Warrior - On On Spell Hit (Glory of the Ancestors) - Remove Aura Permament Feign Death');
INSERT INTO smart_scripts VALUES (26772, 0, 2, 0, 38, 0, 100, 0, 1, 1, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Icemist Warrior - On Data Set - Despawn');
DELETE FROM smart_scripts WHERE entryorguid=26654 AND source_type=0;
INSERT INTO smart_scripts VALUES (26654, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 26656, 10, 0, 0, 0, 0, 0, 'Roanauk Icemist - On Spawn - Set Data 1 1 on Anub''ar Prison');
INSERT INTO smart_scripts VALUES (26654, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - On Spawn - Set Phase 1');
INSERT INTO smart_scripts VALUES (26654, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 11, 47273, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - On Spawn - Cast Icemist''s Prison');
INSERT INTO smart_scripts VALUES (26654, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - On Spawn - Set Passive');
INSERT INTO smart_scripts VALUES (26654, 0, 4, 0, 1, 1, 100, 0, 5000, 30000, 120000, 150000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - OOC (Phase 1) - Say Line 0');
INSERT INTO smart_scripts VALUES (26654, 0, 5, 0, 38, 0, 100, 1, 1, 1, 0, 0, 80, 2665400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - On Data Set 1 1 - Run Script');
INSERT INTO smart_scripts VALUES (26654, 0, 6, 0, 40, 0, 100, 0, 1, 0, 0, 0, 80, 2665401, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - On Reached WP1 - Run Script');
INSERT INTO smart_scripts VALUES (26654, 0, 7, 0, 38, 0, 100, 0, 2, 2, 0, 0, 80, 2665402, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - On Data Set - Run Script');
DELETE FROM smart_scripts WHERE entryorguid=26608 AND source_type=0;
INSERT INTO smart_scripts VALUES (26608, 0, 0, 1, 38, 0, 100, 0, 1, 1, 0, 0, 97, 15, 60, 0, 0, 0, 0,  1, 0, 0, 0, 4088.679932, 2219.449951, 150.304993, 0, 'Under-King Anub''et''kan - On Data Set - Jump to Position');
INSERT INTO smart_scripts VALUES (26608, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 6000, 6000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Under-King Anub''et''kan - On Data Set - Create Timed Event');
INSERT INTO smart_scripts VALUES (26608, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0,  0, 1, 0, 0, 0, 0, 0, 0, 0, 'Under-King Anub''et''kan - On Data Set - Set Agressive');
INSERT INTO smart_scripts VALUES (26608, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0,  0, 1, 0, 0, 0, 0, 0, 0, 0, 'Under-King Anub''et''kan - On Data Set - Set Unit Flags');
INSERT INTO smart_scripts VALUES (26608, 0, 4, 0, 1, 0, 100, 0, 0, 0, 25000, 45000, 1, 0, 0, 0,  0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Under-King Anub''et''kan - OOC - Say Line 0');
INSERT INTO smart_scripts VALUES (26608, 0, 5, 6, 6, 0, 100, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0,  0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Under-King Anub''et''kan - On Death  - Say Line 3');
INSERT INTO smart_scripts VALUES (26608, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 1, 4, 0,  0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Under-King Anub''et''kan - On Death  - Say Line 4');
INSERT INTO smart_scripts VALUES (26608, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 11, 47400, 2, 0,  0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Under-King Anub''et''kan - On Death  - Cast Summon Husk');
INSERT INTO smart_scripts VALUES (26608, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1,  0, 0, 0, 0, 11, 26772, 100, 0, 0, 0, 0, 0, 'Under-King Anub''et''kan - On Death  - Set Data on Icemist');
INSERT INTO smart_scripts VALUES (26608, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0,  0, 19, 26654, 0, 0, 0, 0, 0, 0, 'Under-King Anub''et''kan - On Death  - Set Data on Roanauk Icemist');
INSERT INTO smart_scripts VALUES (26608, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0,  0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Under-King Anub''et''kan - On Death - Despawn');
INSERT INTO smart_scripts VALUES (26608, 0, 11, 0, 59, 0, 100, 0, 1, 0, 0, 0, 101, 0, 0, 0,  0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Under-King Anub''et''kan - Timed Event - Set Home Position');
INSERT INTO smart_scripts VALUES (26608, 0, 12, 0, 7, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0,  0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Under-King Anub''et''kan - On Evade - Despawn');
INSERT INTO smart_scripts VALUES (26608, 0, 13, 0, 11, 0, 100, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0,  0, 1, 0, 0, 0, 0, 0, 0, 0, 'Under-King Anub''et''kan - On Spawn - Set Unit Flags');
DELETE FROM smart_scripts WHERE entryorguid IN(2665400, 2665401, 2665402, 2660800) AND source_type=9;
INSERT INTO smart_scripts VALUES (2665400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 28, 47273, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Script - Remove Aura Icemist''s Prison');
INSERT INTO smart_scripts VALUES (2665400, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 9, 26656, 0, 200, 0, 0, 0, 0, 'Roanauk Icemist - Script - Set Data 2 2 on Anub''ar Prison');
INSERT INTO smart_scripts VALUES (2665400, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Script - Set Phase 2');
INSERT INTO smart_scripts VALUES (2665400, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Script - Say Line 1');
INSERT INTO smart_scripts VALUES (2665400, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 53, 0, 26654, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Script - Start WP');
INSERT INTO smart_scripts VALUES (2665401, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Script 2 - Say Line 2');
INSERT INTO smart_scripts VALUES (2665401, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Script 2 - Say Line 3');
INSERT INTO smart_scripts VALUES (2665401, 9, 2, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 26608, 100, 0, 0, 0, 0, 0, 'Roanauk Icemist - Script 2 - Say Line 1 on Under-King Anub''et''kan');
INSERT INTO smart_scripts VALUES (2665401, 9, 3, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 11, 47378, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Script 2 - Cast Glory of the Ancestors');
INSERT INTO smart_scripts VALUES (2665401, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Script 2 - Say Line 4');
INSERT INTO smart_scripts VALUES (2665401, 9, 5, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 11, 47379, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Script 2 - Cast Icemist''s Blessing');
INSERT INTO smart_scripts VALUES (2665401, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Script 2 - Say Line 5');
INSERT INTO smart_scripts VALUES (2665401, 9, 7, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Script 2 - Say Line 6');
INSERT INTO smart_scripts VALUES (2665401, 9, 8, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 26608, 100, 0, 0, 0, 0, 0, 'Roanauk Icemist - Script 2 - Say Line 2 on Under-King Anub''et''kan');
INSERT INTO smart_scripts VALUES (2665401, 9, 9, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Script 2 - Say Line 7');
INSERT INTO smart_scripts VALUES (2665401, 9, 10, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 26608, 100, 0, 0, 0, 0, 0, 'Roanauk Icemist - Script 2 - Say Line 7');
INSERT INTO smart_scripts VALUES (2665401, 9, 11, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Script 2 - Set Unit Flags');
INSERT INTO smart_scripts VALUES (2665401, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Script 2 - Set Home Position');
INSERT INTO smart_scripts VALUES (2665401, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Script 2 - Set Agressive');
INSERT INTO smart_scripts VALUES (2665401, 9, 14, 0, 0, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 26608, 0, 0, 0, 0, 0, 0, 'Roanauk Icemist - Script 2 - Attack');

-- All Hail Roanauk! (12140)
DELETE FROM smart_scripts WHERE entryorguid=26379 AND source_type=0;
INSERT INTO smart_scripts VALUES (26379, 0, 0, 1, 19, 0, 100, 0, 12140, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Overlord Agmar - On Quest Accept (All Hail Roanauk!) - Set Active on');
INSERT INTO smart_scripts VALUES (26379, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Overlord Agmar - On Quest Accept (All Hail Roanauk!) - Set Npc Flags');
INSERT INTO smart_scripts VALUES (26379, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 91, 255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Overlord Agmar - On Quest Accept (All Hail Roanauk!) - Remove Bytes 1');
INSERT INTO smart_scripts VALUES (26379, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Overlord Agmar - On Quest Accept (All Hail Roanauk!) - Say Line 1');
INSERT INTO smart_scripts VALUES (26379, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 53, 0, 26379, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Overlord Agmar - On Quest Accept (All Hail Roanauk!) - Start WP');
INSERT INTO smart_scripts VALUES (26379, 0, 5, 0, 40, 0, 100, 0, 10, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 26810, 0, 0, 0, 0, 0, 0, 'Overlord Agmar - On reached WP10 - Set Orientation');
INSERT INTO smart_scripts VALUES (26379, 0, 6, 7, 38, 0, 100, 0, 1, 1, 0, 0, 101, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Overlord Agmar - On Data Set - Set Home Pos (Respawn)');
INSERT INTO smart_scripts VALUES (26379, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Overlord Agmar - On Data Set - Evade');
INSERT INTO smart_scripts VALUES (26379, 0, 8, 9, 21, 0, 100, 0, 0, 0, 0, 0, 81, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Overlord Agmar - On Reached Home - Set Unit Flags');
INSERT INTO smart_scripts VALUES (26379, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Overlord Agmar - On Reached Home - Set Active off');

-- On Ruby Wings (12498)
DELETE FROM creature_text WHERE entry=28006;
INSERT INTO creature_text VALUES (28006, 0, 0, 'You think you''ve won, mortal? Face the unbridled power of Antiok!', 14, 0, 100, 0, 0, 0, 0, 'Antiok Yell1');
INSERT INTO creature_text VALUES (28006, 1, 0, 'Behold! The Scythe of Antiok!', 14, 0, 100, 0, 0, 0, 0, 'Antiok Yell2');
INSERT INTO creature_text VALUES (28006, 2, 0, 'Soon, the bones of Galakrond will rise from their eternal slumber and wreak havoc upon this world!', 14, 0, 100, 0, 0, 0, 0, 'Antiok Yell3');
INSERT INTO creature_text VALUES (28006, 2, 1, 'The Lich King demands more frost wyrms be sent to Angrathar! Meet his demands or face my wrath!', 14, 0, 100, 0, 0, 0, 0, 'Antiok Yell4');
INSERT INTO creature_text VALUES (28006, 2, 2, 'Faster, dogs! We mustn''t relent in our assault against the interlopers!', 14, 0, 100, 0, 0, 0, 0, 'Antiok Yell5');
INSERT INTO creature_text VALUES (28006, 2, 3, 'Attackers are upon us! Let none through to this ancient grave!', 14, 0, 100, 0, 0, 0, 0, 'Antiok Yell6');
INSERT INTO creature_text VALUES (28006, 2, 4, 'Hear me, minions! Hear your lord, Antiok! Double your efforts or pay the consequences of failure!', 14, 0, 100, 0, 0, 0, 0, 'Antiok Yell7');
UPDATE creature_template SET unit_flags=4 WHERE entry=28006;
DELETE FROM vehicle_template_accessory WHERE entry=28018;
INSERT INTO vehicle_template_accessory VALUES (28018, 28006, 0, 0, 'Thiassi the Light Bringer', 8, 0);
DELETE FROM smart_scripts WHERE entryorguid IN(28006, 28018) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=28006*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (28018, 0, 0, 0, 0, 0, 100, 0, 5000, 5000, 12000, 14000, 11, 50456, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Thiassi the Lightning Bringer - In Combat - Cast Thiassi''s Stormbolt');
INSERT INTO smart_scripts VALUES (28018, 0, 1, 0, 0, 0, 100, 0, 9000, 9000, 15000, 19000, 11, 15593, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thiassi the Lightning Bringer - In Combat - Cast War Stomp');
INSERT INTO smart_scripts VALUES (28018, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 19, 28006, 10, 0, 0, 0, 0, 0, 'Thiassi the Lightning Bringer - On Death - remove unitflag from target');
INSERT INTO smart_scripts VALUES (28006, 0, 0, 0, 0, 0, 100, 0, 7000, 7000, 18000, 18000, 11, 32863, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - In Combat - Cast Seed of Corruption');
INSERT INTO smart_scripts VALUES (28006, 0, 1, 0, 0, 0, 100, 0, 1100, 1100, 2000, 3000, 11, 50455, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (28006, 0, 2, 0, 1, 0, 100, 0, 10000, 10000, 40000, 40000, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - Out of Combat - Say Line 2');
INSERT INTO smart_scripts VALUES (28006, 0, 3, 0, 2, 0, 100, 1, 0, 25, 0, 0, 11, 50497, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - Between 0-25% Health - Cast Scream of Chaos');
INSERT INTO smart_scripts VALUES (28006, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 50472, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - On Just Died - Cast Drop Scythe of Antiok');
INSERT INTO smart_scripts VALUES (28006, 0, 5, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 50494, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - On Reset - Cast Shroud of Lightning');
INSERT INTO smart_scripts VALUES (28006, 0, 6, 0, 38, 0, 100, 0, 1, 0, 0, 0, 80, 28006*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - On Data Set - Run Script');
INSERT INTO smart_scripts VALUES (28006, 0, 7, 0, 7, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - On Evade - Despawn');
INSERT INTO smart_scripts VALUES (28006*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - Script9 - Say Line 0');
INSERT INTO smart_scripts VALUES (28006*100, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - Script9 - Say Line 1');
INSERT INTO smart_scripts VALUES (28006*100, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 11, 50501, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - Script9 - Cast Flesh Harvest');
INSERT INTO smart_scripts VALUES (28006*100, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 28, 50494, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - Script9 - Remove Aura Shroud of Lightning');
INSERT INTO smart_scripts VALUES (28006*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 19, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - Script9 - Remove Unit Flags');
INSERT INTO smart_scripts VALUES (28006*100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - Script9 - Attack Start');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=50501;
INSERT INTO conditions VALUES (13, 3, 50501, 0, 0, 31, 0, 3, 27996, 0, 0, 0, 0, '', 'Target Wyrmrest Vanquisher');

-- The Might of the Horde (12053)
UPDATE creature_template SET unit_flags=4, AIName='SmartAI', ScriptName='' WHERE entry=26678;
DELETE FROM smart_scripts WHERE entryorguid=26678 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=26678*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (26678, 0, 0, 0, 60, 0, 100, 1, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Warsong Battle Standard - On Update - Set React State Passive');
INSERT INTO smart_scripts VALUES (26678, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 6, 12053, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Warsong Battle Standard - On Just Died - Fail Quest The Might of the Horde');
INSERT INTO smart_scripts VALUES (26678, 0, 2, 0, 54, 0, 100, 0, 0, 0, 0, 0, 80, 26678*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Warsong Battle Standard - On Just Summoned - Run Script');
INSERT INTO smart_scripts VALUES (26678*100, 9, 0, 0, 0, 0, 100, 0, 5000, 15000, 0, 0, 11, 47303, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Warsong Battle Standard - On Script - Cast Summon Anub''ar Invader');
INSERT INTO smart_scripts VALUES (26678*100, 9, 1, 0, 0, 0, 100, 0, 8000, 15000, 0, 0, 11, 47303, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Warsong Battle Standard - On Script - Cast Summon Anub''ar Invader');
INSERT INTO smart_scripts VALUES (26678*100, 9, 2, 0, 0, 0, 100, 0, 8000, 15000, 0, 0, 11, 47303, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Warsong Battle Standard - On Script - Cast Summon Anub''ar Invader');
INSERT INTO smart_scripts VALUES (26678*100, 9, 3, 0, 0, 0, 100, 0, 8000, 15000, 0, 0, 11, 47303, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Warsong Battle Standard - On Script - Cast Summon Anub''ar Invader');
INSERT INTO smart_scripts VALUES (26678*100, 9, 4, 0, 0, 0, 100, 0, 8000, 15000, 0, 0, 11, 47303, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Warsong Battle Standard - On Script - Cast Summon Anub''ar Invader');
INSERT INTO smart_scripts VALUES (26678*100, 9, 5, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 15, 12053, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Warsong Battle Standard - On Script - Quest Credit The Might of the Horde');
INSERT INTO smart_scripts VALUES (26678*100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Warsong Battle Standard - On Script - Despawn');
