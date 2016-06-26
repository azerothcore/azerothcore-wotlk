
-- -------------------------------------------
-- ICECROWN
-- -------------------------------------------
-- Mistcaller Yngvar (14102)
DELETE FROM event_scripts WHERE id=21997;
INSERT INTO event_scripts VALUES(21997, 0, 10, 34965, 180000, 1, 10182, 1183.42, 76.2, 5.93);

-- Battle at Valhalas: Fallen Heroes (13214)
UPDATE creature_template SET AIName='', ScriptName="npc_battle_at_valhalas" WHERE entry=31135;
DELETE FROM smart_scripts WHERE entryorguid=31135 AND source_type=0;
UPDATE quest_template SET PrevQuestId=13213 WHERE Id=13214;
UPDATE creature_template SET minlevel=80, maxlevel=80, mindmg=417, maxdmg=582, attackpower=608, faction=14, AIName="SmartAI" WHERE entry IN(31191, 31192, 31193, 31194, 31195, 31196);
DELETE FROM smart_scripts WHERE entryorguid IN(31191, 31192, 31193, 31194, 31195, 31196) AND source_type=0;
INSERT INTO smart_scripts VALUES(31191, 0, 0, 0, 0, 0, 100, 0, 5000, 6000, 10000, 12000, 11, 25054, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC spell cast');
INSERT INTO smart_scripts VALUES(31191, 0, 1, 0, 0, 0, 100, 0, 7000, 8000, 12000, 14000, 11, 15586, 64, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC spell cast');
INSERT INTO smart_scripts VALUES(31192, 0, 0, 0, 0, 0, 100, 0, 4000, 5000, 10000, 11000, 11, 15496, 64, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC spell cast');
INSERT INTO smart_scripts VALUES(31192, 0, 1, 0, 0, 0, 100, 0, 8000, 9000, 16000, 19000, 11, 41056, 64, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC spell cast');
INSERT INTO smart_scripts VALUES(31193, 0, 0, 0, 0, 0, 100, 0, 3000, 4000, 10000, 12000, 11, 61041, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC spell cast');
INSERT INTO smart_scripts VALUES(31193, 0, 1, 0, 0, 0, 100, 0, 6000, 7000, 14000, 16000, 11, 46182, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC spell cast');
INSERT INTO smart_scripts VALUES(31194, 0, 0, 0, 0, 0, 100, 0, 4000, 4000, 10000, 11000, 11, 14873, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC spell cast');
INSERT INTO smart_scripts VALUES(31196, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 14000, 16000, 11, 61044, 64, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC spell cast');
INSERT INTO smart_scripts VALUES(31196, 0, 1, 0, 0, 0, 100, 0, 3000, 4000, 10000, 11000, 11, 58461, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC spell cast');

-- Battle at Valhalas: Khit'rix the Dark Master (13215)
UPDATE quest_template SET PrevQuestId=13214 WHERE Id=13215;
UPDATE creature_template SET AIName="SmartAI", faction=14 WHERE entry=31222;
DELETE FROM smart_scripts WHERE entryorguid IN(31222) AND source_type=0;
DELETE FROM creature_text WHERE entry=31222;
INSERT INTO creature_text VALUES(31222, 0, 0, 'When I am done here, I am going to mount your heads upon the walls of Azjol-Nerub!', 14, 0, 100, 0, 0, 0, 0, 'Dark Master yell');
INSERT INTO smart_scripts VALUES(31222, 0, 0, 0, 0, 0, 100, 1, 2000, 2000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'say on update');
INSERT INTO smart_scripts VALUES(31222, 0, 1, 0, 0, 0, 100, 0, 5000, 6000, 10000, 11000, 11, 38243, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC spell cast');
INSERT INTO smart_scripts VALUES(31222, 0, 2, 0, 0, 0, 100, 0, 5000, 6000, 16000, 19000, 11, 22884, 64, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC spell cast');
INSERT INTO smart_scripts VALUES(31222, 0, 3, 0, 0, 0, 100, 0, 11000, 14000, 23000, 25000, 11, 61055, 64, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC spell cast');

-- Battle at Valhalas: The Return of Sigrid Iceborn (13216)
UPDATE quest_template SET PrevQuestId=13215 WHERE Id=13216;
UPDATE creature_template SET minlevel=80, maxlevel=80, mindmg=417, maxdmg=582, attackpower=608, faction=14, AIName="SmartAI" WHERE entry=31242;
DELETE FROM smart_scripts WHERE entryorguid IN(31242) AND source_type=0;
DELETE FROM creature_text WHERE entry=31242;
REPLACE INTO creature_template_addon VALUES(31242, 0, 0, 0, 65536, 0, "61165");
INSERT INTO creature_text VALUES(31242, 0, 0, "I told you I'd be better prepared when next we meet. I've fought and won the Hyldsmeet, trained at Valkyrion, and here I am. Come and get some!", 14, 0, 100, 0, 0, 0, 0, 'Dark Master yell');
INSERT INTO smart_scripts VALUES(31242, 0, 0, 0, 0, 0, 100, 1, 3000, 3000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'say on update');
INSERT INTO smart_scripts VALUES(31242, 0, 1, 0, 0, 0, 100, 0, 5000, 6000, 10000, 11000, 11, 61168, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC spell cast');
INSERT INTO smart_scripts VALUES(31242, 0, 2, 0, 0, 0, 100, 0, 11000, 14000, 23000, 25000, 11, 61170, 64, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC spell cast');

-- Battle at Valhalas: Carnage! (13217)
UPDATE quest_template SET PrevQuestId=13216 WHERE Id=13217;
UPDATE creature_template SET minlevel=80, maxlevel=80, mindmg=500, maxdmg=600, attackpower=608, faction=14, AIName="SmartAI" WHERE entry=31271;
DELETE FROM smart_scripts WHERE entryorguid IN(31271) AND source_type=0;
INSERT INTO smart_scripts VALUES(31271, 0, 0, 0, 0, 0, 100, 0, 5000, 6000, 10000, 11000, 11, 61070, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC spell cast');
INSERT INTO smart_scripts VALUES(31271, 0, 1, 0, 0, 0, 100, 0, 11000, 14000, 23000, 25000, 11, 61065, 64, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC spell cast');

-- Battle at Valhalas: Thane Deathblow (13218)
UPDATE quest_template SET PrevQuestId=13217 WHERE Id=13218;
UPDATE creature_template SET minlevel=80, maxlevel=80, mindmg=417, maxdmg=582, attackpower=608, faction=14, AIName="SmartAI" WHERE entry=31277;
DELETE FROM smart_scripts WHERE entryorguid IN(31277) AND source_type=0;
DELETE FROM creature_text WHERE entry=31277;
INSERT INTO creature_text VALUES(31277, 0, 0, "ENOUGH! You tiny insects are not worthy to do battle within this sacred place! You do not fight with honor! Do do not even ascend!", 14, 0, 100, 0, 0, 0, 0, 'Thane yell');
INSERT INTO creature_text VALUES(31277, 1, 0, "Fight me and die you cowards!", 14, 0, 100, 0, 0, 0, 0, 'Thane yell');
INSERT INTO creature_text VALUES(31277, 2, 0, "Haraak foln! ", 12, 0, 100, 0, 0, 0, 0, 'Thane say');
INSERT INTO smart_scripts VALUES(31277, 0, 0, 0, 0, 0, 100, 1, 3000, 3000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'say on update');
INSERT INTO smart_scripts VALUES(31277, 0, 1, 0, 0, 0, 100, 1, 10000, 10000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'say on update');
INSERT INTO smart_scripts VALUES(31277, 0, 2, 0, 0, 0, 100, 1, 15000, 15000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'say on update');
INSERT INTO smart_scripts VALUES(31277, 0, 3, 0, 0, 0, 100, 0, 5000, 6000, 10000, 11000, 11, 13737, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC spell cast');
INSERT INTO smart_scripts VALUES(31277, 0, 4, 0, 0, 0, 100, 0, 11000, 14000, 23000, 25000, 11, 61133, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC spell cast');
INSERT INTO smart_scripts VALUES(31277, 0, 5, 0, 0, 0, 100, 0, 17000, 18000, 15000, 17000, 11, 61139, 64, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC spell cast');

-- Battle at Valhalas: Final Challenge (13219)
UPDATE quest_template SET PrevQuestId=13218 WHERE Id=13219;
UPDATE creature_template SET minlevel=80, maxlevel=80, mindmg=417, maxdmg=582, attackpower=608, faction=14, AIName='SmartAI', ScriptName='' WHERE entry=14688;
DELETE FROM smart_scripts WHERE entryorguid=14688 AND source_type=0;
DELETE FROM creature_text WHERE entry=14688;
REPLACE INTO creature_template_addon VALUES(14688, 0, 0, 0, 65536, 0, "");
INSERT INTO creature_text VALUES(14688, 0, 0, "Hardly a fitting introduction, Spear-Wife. Now, who is this outsider that I've been hearing so much about?", 14, 0, 100, 1, 0, 0, 0, 'Prince yell');
INSERT INTO creature_text VALUES(14688, 1, 0, "I will make this as easy as possible for you. Simply come here and die. That is all that I ask for your many trespasses. For your sullying this exlated place of battle.", 14, 0, 100, 1, 0, 0, 0, 'Prince yell');
INSERT INTO creature_text VALUES(14688, 2, 0, "FOR YOUR EFFRONTERY TO THE LICH KING!", 14, 0, 100, 15, 0, 0, 0, 'Prince yell');
INSERT INTO smart_scripts VALUES(14688, 0, 0, 0, 0, 0, 100, 257, 3000, 3000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - On Update - Say Line 0');
INSERT INTO smart_scripts VALUES(14688, 0, 1, 0, 0, 0, 100, 257, 10000, 10000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - On Update - Say Line 1');
INSERT INTO smart_scripts VALUES(14688, 0, 2, 0, 0, 0, 100, 257, 15000, 15000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - On Update - Say Line 2');
INSERT INTO smart_scripts VALUES(14688, 0, 3, 0, 0, 0, 100, 257, 17000, 17000, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - On Update - Attack Start');
INSERT INTO smart_scripts VALUES(14688, 0, 4, 0, 0, 0, 100, 0, 11000, 14000, 23000, 25000, 11, 61162, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - In Combat - Cast Engulfing Strike');
INSERT INTO smart_scripts VALUES(14688, 0, 5, 0, 0, 0, 100, 0, 17000, 18000, 15000, 17000, 11, 61163, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - On Update - Say Line 0');

-- It's All Fun and Games (12887)
-- It's All Fun and Games (12892)
UPDATE creature_template SET modelid1=26536, modelid2=0, InhabitType=4, Armor_mod=0, flags_extra=0 WHERE entry=29747;
UPDATE creature_template SET InhabitType=4, Armor_mod=0 WHERE entry=29790;
UPDATE creature_model_info SET combat_reach=20 WHERE modelid=26536;
UPDATE quest_template SET ExclusiveGroup=0 WHERE id IN(12887, 12892); -- Next Quest is enaugh...
UPDATE quest_template SET ExclusiveGroup=0 WHERE id IN(12898, 12899); -- Next Quest is enaugh... The Shadow Vault quests

-- No Rest For The Wicked (13346)
-- No Rest For The Wicked (13350)
-- No Rest For The Wicked (13367)
-- No Rest For The Wicked (13368)
UPDATE creature_template SET faction=21 WHERE entry=32300;
UPDATE creature SET spawndist=0, MovementType=0 WHERE guid=122317;
UPDATE creature_template SET AIName='SmartAI' WHERE entry=32300;
DELETE FROM smart_scripts WHERE source_type=0 AND entryorguid=32300;
INSERT INTO smart_scripts VALUES (32300, 0, 0, 0, 0, 0, 100, 0, 8000, 9000, 8000, 9000, 11, 60472, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Alumeth - IC - Cast Mindflay');
INSERT INTO smart_scripts VALUES (32300, 0, 1, 0, 0, 0, 100, 0, 8000, 10000, 8000, 10000, 11, 34322, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Alumeth - IC - Cast Psychicscream');
INSERT INTO smart_scripts VALUES (32300, 0, 2, 0, 0, 0, 100, 0, 9000, 12000, 9000, 12000, 11, 37978, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Alumeth - IC - Cast Renew');
INSERT INTO smart_scripts VALUES (32300, 0, 3, 0, 0, 0, 100, 0, 7000, 10000, 7000, 10000, 11, 34942, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Alumeth - IC - Cast Shadow Word: Pain');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(60831, 60834);
INSERT INTO conditions VALUES(13, 1, 60831, 0, 0, 31, 0, 3, 32347, 0, 0, 0, 0, '', "Alumeth Summon Bunny");
INSERT INTO conditions VALUES(13, 1, 60834, 0, 0, 31, 0, 3, 32347, 0, 0, 0, 0, '', "Alumeth Summon Bunny");
DELETE FROM spell_scripts WHERE id=60834;
UPDATE creature_template SET AIName='SmartAI' WHERE entry=32347;
DELETE FROM smart_scripts WHERE source_type=0 AND entryorguid=32347;
INSERT INTO smart_scripts VALUES (32347, 0, 0, 1, 8, 0, 100, 0, 60834, 0, 0, 0, 12, 32300, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 8219, 2187.09, 499.82, 3.10669, 'Alumeth Summon Bunny - On Spellhit - Summon Alumeth the Ascended');

-- Establishing Superiority (13259)
UPDATE creature_template SET KillCredit1=31413 WHERE entry=31411;

-- Deep in the Bowels of The Underhalls (13042)
-- Book Dr. Terrible's "Building a Better Flesh Giant", starts quest
UPDATE creature_loot_template SET ChanceOrQuestChance=100 WHERE item=42772;
UPDATE creature_template SET AIName='SmartAI' WHERE entry=30409;
DELETE FROM smart_scripts WHERE source_type=0 AND entryorguid=30409;
INSERT INTO smart_scripts VALUES (30409, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 5000, 7000, 11, 60290, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Osterkilgr - In Combat - cast Blast Wave');
INSERT INTO smart_scripts VALUES (30409, 0, 1, 0, 0, 0, 100, 0, 1000, 2000, 1000, 2000, 11, 14034, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Osterkilgr - In Combat - cast Fireball');
INSERT INTO smart_scripts VALUES (30409, 0, 2, 0, 2, 0, 100, 1, 40, 80, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Osterkilgr - @80%HP - say text 0');
INSERT INTO smart_scripts VALUES (30409, 0, 3, 4, 2, 0, 100, 1, 0, 40, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Osterkilgr - @40%HP - say text 1');
INSERT INTO smart_scripts VALUES (30409, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 33, 30412, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0 ,0, 'Apprentice Osterkilgr - At 40% HP - give kill credit');
DELETE FROM creature_text WHERE entry=30409;
INSERT INTO creature_text VALUES (30409, 0, 0,'You''ve come for the doctor''s plans! You''ll only find death!', 12, 0, 0, 0, 0, 0,0,'Apprentice Osterkilgr - Say 0');
INSERT INTO creature_text VALUES (30409, 1, 0,'The doctor entrusted me with the plans to Nergeld, our flesh giant amalgamation made entirely of vargul! It will be the most powerful creation of its kind and a whole legion of them will be created to destroy your pitiful forces!', 12, 0, 0, 0, 0, 0,0,'Apprentice Osterkilgr - Say 1');
DELETE FROM conditions WHERE SourceEntry=30409 AND SourceTypeOrReferenceId=22;
INSERT INTO conditions VALUES (22, 3, 30409, 0, 0, 9, 2, 13042, 0, 0, 0, 0, 0, '', 'Only execute SAI of Osterkilgr when player has quest 13042');
INSERT INTO conditions VALUES (22, 4, 30409, 0, 0, 9, 2, 13042, 0, 0, 0, 0, 0, '', 'Only execute SAI of Osterkilgr when player has quest 13042');
DELETE FROM conditions WHERE SourceEntry=42772 AND SourceTypeOrReferenceId=1;
INSERT INTO conditions VALUES (1, 30409, 42772, 0, 0, 14, 0, 13042, 0, 0, 1, 0, 0, '', 'Dr. Terribles "Building a Better Flesh Giant" only drops if player has any status at Deep in the Bowels of The Underhalls');
UPDATE creature SET equipment_id=0, spawndist=0, MovementType=0, dynamicflags=32, unit_flags=768|131072|2 WHERE id=30250 AND guid IN(121544, 121545, 121546, 121547, 121548, 121549, 121550, 121555, 121556, 121557, 121558, 121563);
REPLACE INTO creature_addon VALUES (121544, 0, 0, 7, 0, 0, '');
REPLACE INTO creature_addon VALUES (121545, 0, 0, 7, 0, 0, '');
REPLACE INTO creature_addon VALUES (121546, 0, 0, 7, 0, 0, '');
REPLACE INTO creature_addon VALUES (121547, 0, 0, 7, 0, 0, '');
REPLACE INTO creature_addon VALUES (121548, 0, 0, 7, 0, 0, '');
REPLACE INTO creature_addon VALUES (121549, 0, 0, 7, 0, 0, '');
REPLACE INTO creature_addon VALUES (121550, 0, 0, 7, 0, 0, '');
REPLACE INTO creature_addon VALUES (121555, 0, 0, 7, 0, 0, '');
REPLACE INTO creature_addon VALUES (121556, 0, 0, 7, 0, 0, '');
REPLACE INTO creature_addon VALUES (121557, 0, 0, 7, 0, 0, '');
REPLACE INTO creature_addon VALUES (121558, 0, 0, 7, 0, 0, '');
REPLACE INTO creature_addon VALUES (121563, 0, 0, 7, 0, 0, '');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=30250;
DELETE FROM smart_scripts WHERE entryorguid IN(30250, -121544, -121545, -121546, -121547, -121548, -121549, -121550, -121555, -121556, -121557, -121558, -121563) AND source_type=0;
INSERT INTO smart_scripts VALUES (30250, 0, 0, 0, 9, 0, 100, 0, 0, 5, 3000, 5000, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Valhalas Vargul - Within 0-5 Range - Cast Cleave');
INSERT INTO smart_scripts VALUES (30250, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 33, 30644, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Valhalas Vargul - On Just Died - Quest Credit The Art of Being a Water Terror');
INSERT INTO smart_scripts VALUES (-121544, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Valhalas Vargul - On Reset - Set React Passive');
INSERT INTO smart_scripts VALUES (-121545, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Valhalas Vargul - On Reset - Set React Passive');
INSERT INTO smart_scripts VALUES (-121546, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Valhalas Vargul - On Reset - Set React Passive');
INSERT INTO smart_scripts VALUES (-121547, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Valhalas Vargul - On Reset - Set React Passive');
INSERT INTO smart_scripts VALUES (-121548, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Valhalas Vargul - On Reset - Set React Passive');
INSERT INTO smart_scripts VALUES (-121549, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Valhalas Vargul - On Reset - Set React Passive');
INSERT INTO smart_scripts VALUES (-121550, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Valhalas Vargul - On Reset - Set React Passive');
INSERT INTO smart_scripts VALUES (-121555, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Valhalas Vargul - On Reset - Set React Passive');
INSERT INTO smart_scripts VALUES (-121556, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Valhalas Vargul - On Reset - Set React Passive');
INSERT INTO smart_scripts VALUES (-121557, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Valhalas Vargul - On Reset - Set React Passive');
INSERT INTO smart_scripts VALUES (-121558, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Valhalas Vargul - On Reset - Set React Passive');
INSERT INTO smart_scripts VALUES (-121563, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Valhalas Vargul - On Reset - Set React Passive');

-- Retest Now (13321)
-- Retest Now (13322)
-- Retest Now (13356)
-- Retest Now (13357)
-- Cannot Reproduce (13355)
-- Cannot Reproduce (13320)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(60310, 60256);
INSERT INTO conditions VALUES(13, 1, 60310, 0, 0, 31, 0, 3, 32242, 0, 0, 0, 0, '', "KC blue bunny");
INSERT INTO conditions VALUES(13, 1, 60310, 0, 1, 31, 0, 3, 32244, 0, 0, 0, 0, '', "KC green bunny");
INSERT INTO conditions VALUES(13, 1, 60310, 0, 2, 31, 0, 3, 32245, 0, 0, 0, 0, '', "KC dark bunny");
INSERT INTO conditions VALUES(13, 1, 60256, 0, 0, 31, 0, 3, 32242, 0, 0, 0, 0, '', "KC blue bunny");
INSERT INTO conditions VALUES(13, 1, 60256, 0, 1, 31, 0, 3, 32244, 0, 0, 0, 0, '', "KC green bunny");
INSERT INTO conditions VALUES(13, 1, 60256, 0, 2, 31, 0, 3, 32245, 0, 0, 0, 0, '', "KC dark bunny");
UPDATE creature_template SET AIName="SmartAI" WHERE entry IN(32242, 32244, 32245);
DELETE FROM smart_scripts WHERE entryorguid IN(32242, 32244, 32245) AND source_type=0;
INSERT INTO smart_scripts VALUES(32242, 0, 2, 0, 8, 0, 100, 0, 60256, 0, 0, 0, 33, 32242, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Kill credit on spell hit");
INSERT INTO smart_scripts VALUES(32242, 0, 0, 1, 8, 0, 100, 0, 60310, 0, 0, 0, 33, 32266, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Kill credit on spell hit");
INSERT INTO smart_scripts VALUES(32242, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 60504, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Cast spell linked (Spell power)");
INSERT INTO smart_scripts VALUES(32244, 0, 2, 0, 8, 0, 100, 0, 60256, 0, 0, 0, 33, 32244, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Kill credit on spell hit");
INSERT INTO smart_scripts VALUES(32244, 0, 0, 1, 8, 0, 100, 0, 60310, 0, 0, 0, 33, 32266, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Kill credit on spell hit");
INSERT INTO smart_scripts VALUES(32244, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 60506, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Cast spell linked (Stamina)");
INSERT INTO smart_scripts VALUES(32245, 0, 2, 0, 8, 0, 100, 0, 60256, 0, 0, 0, 33, 32245, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Kill credit on spell hit");
INSERT INTO smart_scripts VALUES(32245, 0, 0, 1, 8, 0, 100, 0, 60310, 0, 0, 0, 33, 32266, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Kill credit on spell hit");
INSERT INTO smart_scripts VALUES(32245, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 60505, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Cast spell linked (Attack power)");

-- From Whence They Came (13171)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=193058;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=58658;
INSERT INTO conditions VALUES(13, 1, 58658, 0, 0, 31, 0, 3, 31131, 0, 0, 0, 0, '', '');
UPDATE creature_template SET AIName="SmartAI", faction=35, unit_flags=4 WHERE entry=31131;
DELETE FROM smart_scripts WHERE entryorguid=31131 AND source_type=0;
INSERT INTO smart_scripts VALUES(31131, 0, 0, 1, 8, 0, 100, 0, 58662, 0, 0, 0, 33, 31131, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "kill monstercredit on spellhit");
INSERT INTO smart_scripts VALUES(31131, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "linked forcedespawn");

-- An Undead's Best Friend (13169)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=30952);
REPLACE INTO creature_template_addon VALUES(30952, 0, 0, 0, 0, 0, '8279');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(30952, 31119);
DELETE FROM smart_scripts WHERE entryorguid IN(30952, 31119) AND source_type=0;
INSERT INTO smart_scripts VALUES(31119, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hungering Plaguehound - On Respawn - Store Target');
INSERT INTO smart_scripts VALUES(31119, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 11, 30952, 10, 0, 0, 0, 0, 0, 'Hungering Plaguehound - On Respawn - Store Target');
INSERT INTO smart_scripts VALUES(31119, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 31119, 0, 0, 0, 0, 0, 11, 30952, 10, 0, 0, 0, 0, 0, 'Hungering Plaguehound - On Respawn - Set Data');
INSERT INTO smart_scripts VALUES(31119, 0, 3, 0, 38, 0, 100, 0, 30952, 0, 0, 0, 11, 58564, 0, 0, 0, 0, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Hungering Plaguehound - On Data Set - Kill Credit');
INSERT INTO smart_scripts VALUES(30952, 0, 0, 0, 38, 0, 100, 0, 31119, 0, 40000, 40000, 69, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Hungering Plaguehound - On Data Set - Move To Point');
INSERT INTO smart_scripts VALUES(30952, 0, 1, 2, 34, 0, 100, 0, 8, 1, 0, 0, 45, 30952, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Hungering Plaguehound - On Movement Inform - Set Data');
INSERT INTO smart_scripts VALUES(30952, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 75, 12098, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hungering Plaguehound - On Movement Inform - Add Aura');
DELETE FROM spell_script_names WHERE spell_id=58562;

-- Honor is for the Weak (13170)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=58563;
INSERT INTO conditions VALUES(17, 0, 58563, 0, 0, 31, 1, 3, 30951, 0, 0, 0, 0, '', '');
UPDATE creature_template SET AIName="SmartAI" WHERE entry=30951;
DELETE FROM smart_scripts WHERE entryorguid=30951 AND source_type=0;
INSERT INTO smart_scripts VALUES(30951, 0, 0, 1, 8, 0, 100, 0, 58563, 0, 0, 0, 33, 30951, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "kill monstercredit on spellhit");
INSERT INTO smart_scripts VALUES(30951, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "linked forcedespawn");

-- The Last Line of Defence (13086)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(30236, 30593, 30575, 30188));
DELETE FROM creature WHERE id IN(30236, 30593, 30575, 30188);
INSERT INTO creature VALUES (NULL, 30236, 571, 1, 64, 0, 0, 6219.18, 59.9966, 400.452, 1.6057, 30, 0, 0, 126000, 1000, 0, 0, 0, 0),(NULL, 30236, 571, 1, 64, 0, 0, 6256.12, 93.243, 410.839, 0.767945, 30, 0, 0, 126000, 1000, 0, 0, 0, 0),(NULL, 30236, 571, 1, 64, 0, 0, 6162.81, 60.9792, 400.371, 1.55334, 30, 0, 0, 126000, 1000, 0, 0, 0, 0),(NULL, 30236, 571, 1, 64, 0, 0, 6297.37, 53.5677, 410.78, 0.802851, 30, 0, 0, 126000, 1000, 0, 0, 0, 0),
(NULL, 30188, 571, 1, 64, 0, 0, 6249.02, 125.228, 382.387, 3.09908, 30, 0, 0, 126000, 0, 0, 0, 0, 0),(NULL, 30188, 571, 1, 64, 0, 0, 6246.68, 179.719, 382.039, 4.91652, 30, 0, 0, 126000, 0, 0, 0, 0, 0),(NULL, 30188, 571, 1, 64, 0, 0, 6262.91, 143.184, 383.286, 1.06465, 30, 0, 0, 126000, 0, 0, 0, 0, 0),
(NULL, 30188, 571, 1, 64, 0, 0, 6152.44, 141.575, 372.699, 1.86295, 30, 0, 0, 126000, 0, 0, 0, 0, 0),(NULL, 30188, 571, 1, 64, 0, 0, 6154.12, 151.842, 373.096, 2.637, 30, 0, 0, 126000, 0, 0, 0, 0, 0),(NULL, 30188, 571, 1, 64, 0, 0, 6151.16, 141.297, 372.471, 3.57614, 30, 0, 0, 126000, 0, 0, 0, 0, 0),(NULL, 30188, 571, 1, 64, 0, 0, 6156.4, 144.03, 372.742, 2.38721, 30, 0, 0, 126000, 0, 0, 0, 0, 0),
(NULL, 30188, 571, 1, 64, 0, 0, 6157.15, 141.258, 372.971, 2.25609, 30, 0, 0, 126000, 0, 0, 0, 0, 0),(NULL, 30188, 571, 1, 64, 0, 0, 6155.53, 143.235, 372.971, 2.2561, 30, 0, 0, 126000, 0, 0, 0, 0, 0),(NULL, 30188, 571, 1, 64, 0, 0, 6161.14, 138.823, 373.386, 2.69543, 30, 0, 0, 126000, 0, 0, 0, 0, 0),(NULL, 30188, 571, 1, 64, 0, 0, 6158.07, 146.608, 373.122, 2.73098, 30, 0, 0, 126000, 0, 0, 0, 0, 0),
(NULL, 30188, 571, 1, 64, 0, 0, 6246.22, 185.978, 382.595, 1.41336, 30, 0, 0, 126000, 0, 0, 0, 0, 0),(NULL, 30188, 571, 1, 64, 0, 0, 6272.77, 124.211, 385.494, 1.11701, 30, 0, 0, 126000, 0, 0, 0, 0, 0),(NULL, 30188, 571, 1, 64, 0, 0, 6300.42, 104.958, 391.12, 0.820305, 30, 0, 0, 126000, 0, 0, 0, 0, 0),(NULL, 30188, 571, 1, 64, 0, 0, 6242.73, 125.182, 381.81, -1.89843, 30, 0, 0, 126000, 0, 0, 0, 0, 0),
(NULL, 30188, 571, 1, 64, 0, 0, 6241.55, 125.338, 381.798, -2.21407, 30, 0, 0, 126000, 0, 0, 0, 0, 0),(NULL, 30188, 571, 1, 64, 0, 0, 6241.5, 125.384, 381.736, 1.03978, 30, 0, 0, 126000, 0, 0, 0, 0, 0),(NULL, 30188, 571, 1, 64, 0, 0, 6372.27, 47.8277, 411.066, 6.25127, 30, 0, 0, 126000, 0, 0, 0, 0, 0),(NULL, 30188, 571, 1, 64, 0, 0, 6358.33, 47.916, 396.048, -0.105028, 30, 0, 0, 126000, 0, 0, 0, 0, 0),
(NULL, 30188, 571, 1, 64, 0, 0, 6361.23, 47.916, 397.135, -0.152355, 30, 0, 0, 126000, 0, 0, 0, 0, 0),(NULL, 30188, 571, 1, 64, 0, 0, 6333.1, 35.6342, 389.32, 0.91866, 30, 0, 0, 126000, 0, 0, 0, 0, 0),(NULL, 30188, 571, 1, 64, 0, 0, 6348.99, 40.0256, 393.048, 1.96786, 30, 0, 0, 126000, 0, 0, 0, 0, 0),(NULL, 30188, 571, 1, 64, 0, 0, 6312.09, 9.89461, 392.475, 3.83839, 30, 0, 0, 126000, 0, 0, 0, 0, 0),
(NULL, 30188, 571, 1, 64, 0, 0, 6279.07, 107.587, 387.434, 1.0821, 30, 0, 0, 126000, 0, 0, 0, 0, 0),(NULL, 30188, 571, 1, 64, 0, 0, 6300.73, 134.442, 387.945, 1.01229, 30, 0, 0, 126000, 0, 0, 0, 0, 0);
UPDATE creature_template SET faction=2069, minlevel=80, maxlevel=80, spell1=54185, AIName='CombatAI', ScriptName='' WHERE entry IN(30593);
UPDATE creature_template SET faction=2069, minlevel=80, maxlevel=80, spell1=57477, spell2=53363, AIName='CombatAI', ScriptName='' WHERE entry IN(30575);
UPDATE creature_template SET mindmg=400, maxdmg=600, faction=2070, minlevel=80, maxlevel=80, spell1=53625, ScriptName='npc_llod_generic' WHERE entry IN(30188);
UPDATE creature_template SET unit_flags=4, npcflag=16777216, vehicleId=246, Mana_mod=0.500752, InhabitType=4 WHERE entry=30236;
DELETE FROM npc_spellclick_spells WHERE npc_entry=30236;
INSERT INTO npc_spellclick_spells VALUES(30236, 57573, 1, 0);
UPDATE creature_model_info SET combat_reach=7 WHERE modelid=27101;
DELETE FROM gameobject WHERE id IN(192657, 192658, 192767, 192768, 192769, 192770, 192771, 192772);
INSERT INTO gameobject VALUES (NULL, 192657, 571, 1, 64, 6255.96, 93.0556, 403.037, -0.829032, 0, 0, -0.402747, 0.915311, 300, 100, 1, 0),(NULL, 192658, 571, 1, 64, 6255.96, 93.0642, 408.47, -0.837755, 0, 0, -0.406735, 0.913546, 300, 100, 1, 0),(NULL, 192767, 571, 1, 64, 6297.22, 53.3958, 402.997, -0.750493, 0, 0, -0.366502, 0.930417, 300, 100, 1, 0),(NULL, 192768, 571, 1, 64, 6297.23, 53.4045, 408.413, -0.759217, 0, 0, -0.370557, 0.92881, 300, 100, 1, 0),
(NULL, 192769, 571, 1, 64, 6219.21, 59.8681, 392.513, -2e-006, 0, 0, -1e-006, 1, 300, 100, 1, 0),(NULL, 192770, 571, 1, 64, 6219.2, 59.875, 397.924, -0.008724, 0, 0, -0.00436199, 0.99999, 300, 100, 1, 0),(NULL, 192771, 571, 1, 64, 6162.77, 60.7344, 392.436, -0.017452, 0, 0, -0.00872589, 0.999962, 300, 100, 1, 0),(NULL, 192772, 571, 1, 64, 6162.77, 60.7431, 397.814, -0.026177, 0, 0, -0.0130881, 0.999914, 300, 100, 1, 0);
DELETE FROM spell_script_names WHERE spell_id IN(57385, 57412);
INSERT INTO spell_script_names VALUES(57385, "spell_q13086_last_line_of_defence");
INSERT INTO spell_script_names VALUES(57412, "spell_q13086_last_line_of_defence");
DELETE FROM smart_scripts WHERE entryorguid=30593 AND source_type=0;

-- Once More Unto The Breach, Hero (13105)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=20 AND SourceEntry IN(13104, 13105);
UPDATE quest_template SET RequiredClasses=1503 WHERE Id=13104;
UPDATE quest_template SET RequiredClasses=32 WHERE Id=13105;

-- Blood in the Water (12810)
UPDATE creature_template SET AIName='SmartAI', InhabitType=2 WHERE entry=29392;
DELETE FROM smart_scripts WHERE source_type=0 AND entryorguid=29392;
INSERT INTO smart_scripts VALUES(29392, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 11000, 13500, 11, 3391, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Thrash");
INSERT INTO smart_scripts VALUES(29392, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 47172, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Cosmetic");
INSERT INTO smart_scripts VALUES(29392, 0, 2, 3, 8, 0, 100, 0, 6509, 0, 0, 0, 33, 29391, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Killcredit on spell hit");
INSERT INTO smart_scripts VALUES(29392, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 28, 47172, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "remove aura linked");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=6509;
INSERT INTO conditions VALUES (17, 0, 6509, 0, 0, 31, 1, 3, 29392, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES (17, 0, 6509, 0, 0, 36, 1, 0, 0, 0, 1, 0, 0, '', '');
INSERT INTO conditions VALUES (17, 0, 6509, 0, 0, 1, 1, 47172, 0, 0, 0, 0, 0, '', '');

-- Before the Gate of Horror (13329)
-- Before the Gate of Horror (13335)
UPDATE creature_template SET AIName= 'SmartAI' WHERE entry=32467;
DELETE FROM smart_scripts WHERE source_type=0 AND entryorguid=32467;
INSERT INTO smart_scripts VALUES (32467, 0, 0, 1, 8, 0, 100, 0, 60428, 0, 0, 0, 33, 32288, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Reaver - On hit by spell Dissolve - Give kill credit to invoker');
INSERT INTO smart_scripts VALUES (32467, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Reaver - Linked with previous event - Set unseen');
INSERT INTO smart_scripts VALUES (32467, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Reaver - Linked with previous event - Set despawn in 1 ms');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=60428;
INSERT INTO conditions VALUES (17, 0, 60428, 0, 0, 31, 1, 3, 32467, 0, 0, 0, 0, '', 'Dissolve can be casted only on Skeletal Reavers');
INSERT INTO conditions VALUES (17, 0, 60428, 0, 0, 36, 1, 0, 0, 0, 1, 0, 0, '', 'Dissolve can be casted only on creatures that are not alive');

-- Shadow Vault Decree (12943)
DELETE FROM creature_text WHERE entry=29919;
INSERT INTO creature_text VALUES (29919, 1, 0, 'By order of Duke Lankral, Commander of the Knights of the Ebon Blade, Vanquisher of the Scourge and Conquerer of The Shadow Vault, you are hearby served notice to cease and desist from all activities providing materiel assistance, vrykul, and any other type of support to the Lich King. Failure to comply will result in your immediate destruction. My messenger will serve as the instrument of my will. What is your decision?', 12, 0, 100, 0, 0, 0, 0, 'Thane');
INSERT INTO creature_text VALUES (29919, 2, 0, 'What is this?', 14, 0, 100, 0, 0, 0, 0, 'Thane');
INSERT INTO creature_text VALUES (29919, 3, 0, 'My answer? Here''s my answer, little messenger!', 14, 0, 100, 0, 0, 0, 0, 'Thane');
INSERT INTO creature_text VALUES (29919, 4, 0, 'I will feed you to the dogs!', 12, 0, 100, 0, 0, 0, 0, 'Thane');
DELETE FROM event_scripts WHERE id=19490;
DELETE FROM spell_script_names WHERE spell_id IN(31696);
INSERT INTO spell_script_names VALUES(31696, "spell_q12943_shadow_vault_decree");
UPDATE creature_template SET unit_flags=0, AIName='SmartAI', ScriptName='' WHERE entry=29919;
DELETE FROM smart_scripts WHERE source_type=0 AND entryorguid=29919;
INSERT INTO smart_scripts VALUES (29919, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thane Ufrang the Mighty - On Reset - Set React Defensive');
INSERT INTO smart_scripts VALUES (29919, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 18, 768+131072+8192+2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thane Ufrang the Mighty - On Reset - Set Unit Flags');
INSERT INTO smart_scripts VALUES (29919, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 84, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Thane Ufrang the Mighty - On Aggro - Say Line 1');
INSERT INTO smart_scripts VALUES (29919, 0, 3, 0, 0, 0, 100, 1, 2000, 2000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thane Ufrang the Mighty - In Combat - Say Line 2');
INSERT INTO smart_scripts VALUES (29919, 0, 4, 0, 0, 0, 100, 1, 7000, 7000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thane Ufrang the Mighty - In Combat - Say Line 3');
INSERT INTO smart_scripts VALUES (29919, 0, 5, 6, 0, 0, 100, 1, 12000, 12000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thane Ufrang the Mighty - In Combat - Say Line 4');
INSERT INTO smart_scripts VALUES (29919, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 19, 768+131072+8192+2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thane Ufrang the Mighty - In Combat - Remove Unit Flags');
INSERT INTO smart_scripts VALUES (29919, 0, 7, 0, 0, 0, 100, 0, 4000, 7000, 4000, 7000, 11, 58460, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Thane Ufrang the Mighty - In Combat - Cast Brutal Strike');
INSERT INTO smart_scripts VALUES (29919, 0, 8, 0, 0, 0, 100, 0, 4000, 15000, 4000, 15000, 11, 16509, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Thane Ufrang the Mighty - In Combat - Cast Rend');
INSERT INTO smart_scripts VALUES (29919, 0, 9, 0, 0, 0, 100, 0, 12000, 25000, 12000, 25000, 11, 60868, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Thane Ufrang the Mighty - In Combat - Cast Powerful Smash');

-- Destroying the Altars (13119)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(57852);
INSERT INTO spell_linked_spell VALUES(57852, 57931, 1, 'link fire on hit');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(57853, 57852);
INSERT INTO conditions VALUES(13, 1, 57853, 0, 0, 31, 0, 3, 30742, 0, 0, 0, 0, '', ''),(13, 1, 57853, 0, 1, 31, 0, 3, 30744, 0, 0, 0, 0, '', ''),(13, 1, 57853, 0, 2, 31, 0, 3, 30745, 0, 0, 0, 0, '', ''),(13, 1, 57853, 0, 3, 31, 0, 3, 30950, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 57852, 0, 0, 31, 0, 3, 30742, 0, 0, 0, 0, '', ''),(13, 1, 57852, 0, 1, 31, 0, 3, 30744, 0, 0, 0, 0, '', ''),(13, 1, 57852, 0, 2, 31, 0, 3, 30745, 0, 0, 0, 0, '', ''),(13, 1, 57852, 0, 3, 31, 0, 3, 30950, 0, 0, 0, 0, '', '');
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(30742, 30744, 30745, 30950));
REPLACE INTO creature_template_addon VALUES (30742, 0, 0, 0, 4097, 0, '57836');
REPLACE INTO creature_template_addon VALUES (30744, 0, 0, 0, 4097, 0, '57836');
REPLACE INTO creature_template_addon VALUES (30745, 0, 0, 0, 4097, 0, '57836');
REPLACE INTO creature_template_addon VALUES (30950, 0, 0, 0, 4097, 0, '57836');

-- The Sum is Greater than the Parts (13043)
UPDATE creature SET spawntimesecs=30, spawndist=0, MovementType=0 WHERE id=30403;
UPDATE creature_template SET unit_flags=unit_flags|4, AIName='SmartAI', ScriptName='' WHERE entry=30403;
DELETE FROM smart_scripts WHERE entryorguid=30403 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=3040300 AND source_type=9;
INSERT INTO smart_scripts VALUES (30403, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 75, 59037, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Respawn add root aura');
INSERT INTO smart_scripts VALUES (30403, 0, 1, 0, 28, 0, 100, 0, 0, 0, 0, 0, 75, 59037, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Passenger Removed add root aura');
INSERT INTO smart_scripts VALUES (30403, 0, 2, 3, 27, 0, 100, 0, 0, 0, 0, 0, 28, 59037, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Passenger Boarded remove root aura');
INSERT INTO smart_scripts VALUES (30403, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Passenger Boarded Talk');
INSERT INTO smart_scripts VALUES (30403, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Passenger Boarded Set State Passive');
INSERT INTO smart_scripts VALUES (30403, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 3040300, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Passenger Boarded Run SCript');
INSERT INTO smart_scripts VALUES (30403, 0, 6, 7, 8, 0, 100, 0, 32067, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spellhit Say');
INSERT INTO smart_scripts VALUES (30403, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spellhit Die');
INSERT INTO smart_scripts VALUES (3040300, 9, 0, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 12, 30471, 4, 3000, 0, 1, 0, 8, 0, 0, 0, 7993.9, 3336.91, 632.396, 0.14577, 'On Script - Spawn Vargul');
INSERT INTO smart_scripts VALUES (3040300, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 30471, 4, 3000, 0, 1, 0, 8, 0, 0, 0, 8003.72, 3323.56, 632.396, 0.648783, 'On Script - Spawn Vargul');
INSERT INTO smart_scripts VALUES (3040300, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 30471, 4, 3000, 0, 1, 0, 8, 0, 0, 0, 8026.94, 3307.58, 632.396, 1.48207, 'On Script - Spawn Vargul');
INSERT INTO smart_scripts VALUES (3040300, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 30471, 4, 3000, 0, 1, 0, 8, 0, 0, 0, 8001.77, 3306.38, 632.396, 0.863447, 'On Script - Spawn Vargul');
INSERT INTO smart_scripts VALUES (3040300, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 30471, 4, 3000, 0, 1, 0, 8, 0, 0, 0, 7987.9, 3308.9, 632.396, 0.68058, 'On Script - Spawn Vargul');
INSERT INTO smart_scripts VALUES (3040300, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 30471, 4, 3000, 0, 1, 0, 8, 0, 0, 0, 8016.52, 3318.92, 632.396, 0.940311, 'On Script - Spawn Vargul');
INSERT INTO smart_scripts VALUES (3040300, 9, 6, 0, 0, 0, 100, 0, 30000, 30000, 0, 0, 12, 30432, 4, 3000, 0, 1, 0, 8, 0, 0, 0, 7996.66, 3308.78, 632.396, 0.773231, 'On Script - Spawn Grimmr Hound');
INSERT INTO smart_scripts VALUES (3040300, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 30432, 4, 3000, 0, 1, 0, 8, 0, 0, 0, 8011.71, 3315.36, 632.396, 0.901169, 'On Script - Spawn Grimmr Hound');
INSERT INTO smart_scripts VALUES (3040300, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 30471, 4, 3000, 0, 1, 0, 8, 0, 0, 0, 8000.67, 3317.23, 632.396, 0.710591, 'On Script - Spawn Vargul');
INSERT INTO smart_scripts VALUES (3040300, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 30471, 4, 3000, 0, 1, 0, 8, 0, 0, 0, 8025.24, 3313.55, 632.396, 1.28693, 'On Script - Spawn Vargul');
INSERT INTO smart_scripts VALUES (3040300, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 30471, 4, 3000, 0, 1, 0, 8, 0, 0, 0, 8007.71, 3337.13, 632.396, 0.407285, 'On Script - Spawn Vargul');
INSERT INTO smart_scripts VALUES (3040300, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 30471, 4, 3000, 0, 1, 0, 8, 0, 0, 0, 8009.92, 3319.81, 632.396, 0.804842, 'On Script - Spawn Vargul');
INSERT INTO smart_scripts VALUES (3040300, 9, 12, 0, 0, 0, 100, 0, 30000, 30000, 0, 0, 12, 30432, 4, 3000, 0, 1, 0, 8, 0, 0, 0, 8021.79, 3312.45, 632.396, 1.13086, 'On Script - Spawn Grimmr Hound');
INSERT INTO smart_scripts VALUES (3040300, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 30432, 4, 3000, 0, 1, 0, 8, 0, 0, 0, 8001.36, 3332.71, 632.396, 0.443351, 'On Script - Spawn Grimmr Hound');
INSERT INTO smart_scripts VALUES (3040300, 9, 14, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 30432, 4, 3000, 0, 1, 0, 8, 0, 0, 0, 7999.22, 3302.52, 632.396, 0.872342, 'On Script - Spawn Grimmr Hound');
INSERT INTO smart_scripts VALUES (3040300, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 30471, 4, 3000, 0, 1, 0, 8, 0, 0, 0, 8000.5, 3345.77, 632.396, 5.82389, 'On Script - Spawn Vargul');
INSERT INTO smart_scripts VALUES (3040300, 9, 16, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 30471, 4, 3000, 0, 1, 0, 8, 0, 0, 0, 8001.77, 3311.95, 632.396, 0.797157, 'On Script - Spawn Vargul');
INSERT INTO smart_scripts VALUES (3040300, 9, 17, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 30471, 4, 3000, 0, 1, 0, 8, 0, 0, 0, 8012.21, 3325.82, 632.396, 0.737667, 'On Script - Spawn Vargul');
INSERT INTO smart_scripts VALUES (3040300, 9, 18, 0, 0, 0, 100, 0, 31000, 31000, 0, 0, 12, 30404, 4, 3000, 0, 1, 0, 8, 0, 0, 0, 7999.93, 3309.21, 632.40, 0.85, 'On Script - Spawn Dr. Terrible');
INSERT INTO smart_scripts VALUES (3040300, 9, 19, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 30432, 4, 3000, 0, 1, 0, 8, 0, 0, 0, 7994.21, 3310.94, 632.40, 0.798, 'On Script - Spawn Grimmr Hound');
INSERT INTO smart_scripts VALUES (3040300, 9, 20, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 30432, 4, 3000, 0, 1, 0, 8, 0, 0, 0, 8001.71, 3303.59, 632.40, 0.794, 'On Script - Spawn Grimmr Hound');

-- New Recruit (13143)
UPDATE creature_template SET AIName='SmartAI' WHERE entry IN(30894, 31049);
UPDATE creature_template SET flags_extra=130 WHERE entry=31049;
DELETE FROM smart_scripts WHERE source_type=0 AND entryorguid IN(30894, 31049);
INSERT INTO smart_scripts VALUES (30894, 0, 0, 0, 8, 0, 100, 0, 58151, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Follow invoker');
INSERT INTO smart_scripts VALUES (31049, 0, 0, 1, 10, 0, 100, 0, 1, 15, 1000, 1000, 33, 31049, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'OOC los kill credit');
INSERT INTO smart_scripts VALUES (31049, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 19, 30894, 40, 0, 0, 0, 0, 0, 'Linked - Despawn target');
DELETE FROM conditions WHERE SourceEntry=31049 AND SourceTypeOrReferenceId=22;
INSERT INTO conditions VALUES (22, 1, 31049, 0, 0, 1, 0, 58151, 0, 0, 0, 0, 0, '', 'Only execute SAI when player has aura 58151');

-- Fater Gustav / Ebon Watcher quests
UPDATE spell_area SET quest_end=13157 WHERE spell=57674;
UPDATE spell_area SET quest_end=13141 WHERE spell=57674 AND area=4580;

-- The Art of Being a Water Terror (13091)
UPDATE creature_template SET minlevel=80, maxlevel=80, spell1=57652, spell2=57668, spell3=57665, spell4=57643, AIName='', ScriptName='' WHERE entry=30645;
DELETE FROM smart_scripts WHERE source_type=0 AND entryorguid=30645;
DELETE FROM conditions WHERE SourceEntry=30645 AND SourceTypeOrReferenceId=22;

-- The Vile Hold (13145)
DELETE FROM conditions WHERE SourceEntry IN(58195, 58196, 58197, 58198) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 58195, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, "", "Target Lithe Stalker");
INSERT INTO conditions VALUES(13, 1, 58196, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, "", "Target Lithe Stalker");
INSERT INTO conditions VALUES(13, 1, 58197, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, "", "Target Lithe Stalker");
INSERT INTO conditions VALUES(13, 1, 58198, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, "", "Target Lithe Stalker");
UPDATE creature_template SET AIName='SmartAI' WHERE entry IN (31065, 31068, 31064, 31066);
DELETE FROM smart_scripts WHERE entryorguid IN (31065, 31068, 31064, 31066) AND source_type=0;
INSERT INTO smart_scripts VALUES (31065, 0, 0, 0, 60, 0, 100, 0, 5000, 5000, 5000, 5000, 11, 58196, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Malykriss Altar of Sacrifice Bunny - On OOC LoS - Credit Pulse');
INSERT INTO smart_scripts VALUES (31068, 0, 0, 0, 60, 0, 100, 0, 5000, 5000, 5000, 5000, 11, 58198, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Malykriss Blood Forge Bunny - On OOC LoS - Credit Pulse');
INSERT INTO smart_scripts VALUES (31064, 0, 0, 0, 60, 0, 100, 0, 5000, 5000, 5000, 5000, 11, 58195, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Malykriss Icy Lookout Bunny - On OOC LoS - Credit Pulse');
INSERT INTO smart_scripts VALUES (31066, 0, 0, 0, 60, 0, 100, 0, 5000, 5000, 5000, 5000, 11, 58197, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Malykriss Runeworks Bunny - On OOC LoS - Credit Pulse');
DELETE FROM conditions WHERE SourceGroup=10111 AND SourceTypeOrReferenceId=15;
INSERT INTO conditions VALUES(15, 10111, 0, 0, 0, 9, 0, 13145, 0, 0, 0, 0, 0, "", ""); -- The Vile Hold
INSERT INTO conditions VALUES(15, 10111, 0, 0, 1, 9, 0, 13146, 0, 0, 0, 0, 0, "", ""); -- Generosity Abounds
INSERT INTO conditions VALUES(15, 10111, 0, 0, 2, 9, 0, 13147, 0, 0, 0, 0, 0, "", ""); -- Matchmaker
UPDATE gameobject_template SET AIName='SmartGameObjectAI' WHERE entry=193424;
DELETE FROM smart_scripts WHERE entryorguid IN (193424) AND source_type=1;
INSERT INTO smart_scripts VALUES (193424, 1, 0, 1, 62, 0, 100, 0, 10111, 0, 0, 0, 85, 58037, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Invoker cast spell');
INSERT INTO smart_scripts VALUES (193424, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Close gossip linked');

-- Generosity Abounds (13146)
DELETE FROM creature_text WHERE entry=30920;
INSERT INTO creature_text VALUES(30920, 0, 0, 'That not nice!', 12, 0, 100, 0, 0, 0, 0, 'Generosity Abounds (13146)');
INSERT INTO creature_text VALUES(30920, 0, 1, 'This not go here.', 12, 0, 100, 0, 0, 0, 0, 'Generosity Abounds (13146)');
INSERT INTO creature_text VALUES(30920, 0, 2, 'For me?', 12, 0, 100, 0, 0, 0, 0, 'Generosity Abounds (13146)');
INSERT INTO creature_text VALUES(30920, 0, 3, 'What bomb thing for?', 12, 0, 100, 0, 0, 0, 0, 'Generosity Abounds (13146)');
INSERT INTO creature_text VALUES(30920, 0, 4, 'I not sure this safe, little giest.', 12, 0, 100, 0, 0, 0, 0, 'Generosity Abounds (13146)');
INSERT INTO creature_text VALUES(30920, 0, 5, 'Present?', 12, 0, 100, 0, 0, 0, 0, 'Generosity Abounds (13146)');
UPDATE creature SET spawndist=0, MovementType=0 WHERE id=31075;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=58203;
INSERT INTO conditions VALUES(17, 0, 58203, 0, 0, 31, 1, 3, 31075, 0, 0, 0, 0, "", "Need correct entry");
INSERT INTO conditions VALUES(17, 0, 58203, 0, 0, 1, 1, 58203, 0, 0, 1, 0, 0, "", "Must not have aura");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=58225;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=58596 AND ElseGroup=0;
INSERT INTO conditions VALUES (13, 1, 58225, 0, 0, 31, 0, 3, 30920, 0, 0, 0, 0, '', 'Scourge Bomb Aura trigger');
INSERT INTO conditions VALUES (13, 2, 58596, 0, 0, 31, 0, 3, 30920, 0, 0, 0, 0, '', 'Abomination Explosion - target abomination');
UPDATE creature_template SET AIName='SmartAI' WHERE entry=31075;
DELETE FROM smart_scripts WHERE entryorguid IN (31075) AND source_type=0;
INSERT INTO smart_scripts VALUES (31075, 0, 0, 1, 8, 0, 100, 0, 58203, 0, 0, 0, 29, 2, 3, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On spell hit - follow');
INSERT INTO smart_scripts VALUES (31075, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 58226, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Linked - Cast spell');
INSERT INTO smart_scripts VALUES (31075, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Death - force despawn');
INSERT INTO smart_scripts VALUES (31075, 0, 3, 4, 31, 0, 100, 0, 58225, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 30920, 15, 0, 0, 0, 0, 0, 'Spell hit target - Make abomination talk');
INSERT INTO smart_scripts VALUES (31075, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 11, 58596, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Linked - cast spell');
INSERT INTO smart_scripts VALUES (31075, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 33, 31075, 0, 0, 0, 0, 0, 21, 15, 0, 0, 0, 0, 0, 0, 'Linked - Kill credit');

-- Matchmaker (13147)
UPDATE creature_template SET AIName='SmartAI' WHERE entry=30921;
DELETE FROM creature_text WHERE entry=30922;
INSERT INTO creature_text VALUES(30922, 0, 0, 'WHO THREW DAT ROCK?', 12, 0, 100, 0, 0, 0, 0, 'Matchmaker (13147)');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=58283;
INSERT INTO conditions VALUES(17, 0, 58283, 0, 0, 31, 1, 3, 30922, 0, 0, 0, 0, "", "Need correct entry");
UPDATE creature_template SET AIName='SmartAI' WHERE entry=30922;
DELETE FROM smart_scripts WHERE entryorguid IN (30921, 30922) AND source_type=0;
INSERT INTO smart_scripts VALUES (30922, 0, 0, 1, 8, 0, 95, 0, 58283, 0, 0, 0, 33, 31481, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On spell hit - kill credit');
INSERT INTO smart_scripts VALUES (30922, 0, 1, 2, 61, 0, 100, 0, 58283, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Linked - say text');
INSERT INTO smart_scripts VALUES (30922, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 2, 1692, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Linked - set faction');
INSERT INTO smart_scripts VALUES (30922, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 2, 1693, 0, 0, 0, 0, 0, 19, 30921, 15, 0, 0, 0, 0, 0, 'Linked - set faction');
INSERT INTO smart_scripts VALUES (30922, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 30921, 15, 0, 0, 0, 0, 0, 'Linked - Attack Start');
INSERT INTO smart_scripts VALUES (30922, 0, 5, 0, 25, 0, 100, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - set faction to default');
INSERT INTO smart_scripts VALUES (30922, 0, 6, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 50420, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'HP Update - cast enrage');
INSERT INTO smart_scripts VALUES (30922, 0, 7, 0, 0, 0, 100, 0, 3000, 4000, 7000, 8000, 11, 13446, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - cast strike');
INSERT INTO smart_scripts VALUES (30922, 0, 8, 0, 0, 0, 100, 0, 6000, 7000, 10000, 11000, 11, 10966, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - cast uppercut');
INSERT INTO smart_scripts VALUES (30921, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - set faction to default');

-- Stunning View (13160)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=31012);
REPLACE INTO creature_template_addon VALUES (31012, 0, 0, 50331657, 0, 0, '58269');
UPDATE creature SET spawndist=0, MovementType=0 WHERE id=31012;
UPDATE creature_template SET unit_flags=4+131072, flags_extra=262144+64, AIName='SmartAI', ScriptName='' WHERE entry=31012;
DELETE FROM smart_scripts WHERE entryorguid=31012 AND source_type=0;
INSERT INTO smart_scripts VALUES (31012, 0, 0, 1, 8, 0, 100, 0, 58282, 0, 0, 0, 33, 31012, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Iceskin Sentry - On Spell Hit - Kill Credit');
INSERT INTO smart_scripts VALUES (31012, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 58285, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Iceskin Sentry - On Spell Hit - Cast Spell');

-- That's Abominable! (13264)
-- That's Abominable! (13276)
-- That's Abominable! (13288)
-- That's Abominable! (13289)
UPDATE creature_template SET minlevel=80, maxlevel=80, mindmg=500, maxdmg=700, spell1=59564, spell2=59576, AIName='SmartAI', ScriptName='' WHERE entry=31692;
DELETE FROM spell_linked_spell WHERE spell_trigger IN(59576, -59576, 59579, -59579);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(59564, 59576, 59579);
INSERT INTO conditions VALUES (13, 3, 59564, 0, 0, 31, 0, 3, 31142, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES (13, 3, 59564, 0, 1, 31, 0, 3, 31147, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES (13, 3, 59564, 0, 2, 31, 0, 3, 31205, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES (13, 2, 59576, 0, 0, 31, 0, 3, 31142, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES (13, 2, 59576, 0, 1, 31, 0, 3, 31147, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES (13, 2, 59576, 0, 2, 31, 0, 3, 31205, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES (13, 1, 59579, 0, 0, 31, 0, 3, 31142, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES (13, 1, 59579, 0, 1, 31, 0, 3, 31147, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES (13, 1, 59579, 0, 2, 31, 0, 3, 31205, 0, 0, 0, 0, '', '');
DELETE FROM smart_scripts WHERE entryorguid=31692 AND source_type=0;
INSERT INTO smart_scripts VALUES (31692, 0, 0, 3, 31, 0, 100, 0, 59576, 0, 0, 0, 33, 31743, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Abomination - Spell Hit Target - Killedmonster credit');
INSERT INTO smart_scripts VALUES (31692, 0, 1, 3, 31, 0, 100, 0, 59576, 0, 0, 0, 33, 32168, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Abomination - Spell Hit Target - Killedmonster credit');
INSERT INTO smart_scripts VALUES (31692, 0, 2, 3, 31, 0, 100, 0, 59576, 0, 0, 0, 33, 32167, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Abomination - Spell Hit Target - Killedmonster credit');
INSERT INTO smart_scripts VALUES (31692, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 85, 52516, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Abomination - Linked - Invoker Cast Burst at the Seams:Bone');
INSERT INTO smart_scripts VALUES (31692, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 41, 200, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Abomination - Linked - Despawn');
INSERT INTO smart_scripts VALUES (31692, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 11, 52523, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Abomination - Linked - Cast Explode Abomination:Bloody Meat');
INSERT INTO smart_scripts VALUES (31692, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 59580, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Abomination - Linked - Cast Burst at the Seams');
DELETE FROM conditions WHERE SourceEntry=31692 AND SourceTypeOrReferenceId=22;
INSERT INTO conditions VALUES(22, 1, 31692, 0, 0, 31, 0, 3, 31142, 0, 0, 0, 0, '', 'Only execute SAI if invoker has entry 31142');
INSERT INTO conditions VALUES(22, 2, 31692, 0, 0, 31, 0, 3, 31147, 0, 0, 0, 0, '', 'Only execute SAI if invoker has entry 31147');
INSERT INTO conditions VALUES(22, 3, 31692, 0, 0, 31, 0, 3, 31205, 0, 0, 0, 0, '', 'Only execute SAI if invoker has entry 31205');


-- -----------------------------------------------------------------------
-- Leading the Charge (13380) -- ALLIANCE SHORT
-- Static Shock Troops: the Bombardment (13404) -- ALLIANCE SHORT
-- Watts My Target (13381) -- ALLIANCE LONG
-- Putting the Hertz: The Valley of Lost Hope (13382) -- ALLIANCE LONG
-- Riding the Wavelength: The Bombardment (13406) -- HORDE SHORT
-- Fringe Science Benefits (13373) -- HORDE SHORT
-- Amped for Revolt! (13374) -- HORDE LONG
-- Total Ohmage: The Valley of Lost Hope! (13376) -- HORDE LONG
-- -----------------------------------------------------------------------
-- Fix Bomber Givers
UPDATE creature_template SET npcflag=npcflag|1, exp=2, minlevel=80, maxlevel=80, gossip_menu_id=10119, AIName='SmartAI', ScriptName='' WHERE entry=31648;
UPDATE creature_template SET npcflag=npcflag|1, exp=2, minlevel=80, maxlevel=80, gossip_menu_id=10120, AIName='SmartAI', ScriptName='' WHERE entry=31839;
DELETE FROM creature WHERE id=31839; -- MISSING SPAWN
INSERT INTO creature VALUES(NULL, 31839, 571, 1, 1, 0, 0, 7884.2, 2057.69, 600.26, 3.1196, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
DELETE FROM smart_scripts WHERE entryorguid IN(31648, 31839) AND source_type=0;
INSERT INTO smart_scripts VALUES(31648, 0, 0, 2, 62, 0, 100, 0, 10119, 0, 0, 0, 85, 59552, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Select - Invoker cast');
INSERT INTO smart_scripts VALUES(31648, 0, 1, 2, 62, 0, 100, 0, 10119, 1, 0, 0, 85, 61151, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Select - Invoker cast');
INSERT INTO smart_scripts VALUES(31648, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Select - Close gossip');
INSERT INTO smart_scripts VALUES(31839, 0, 0, 2, 62, 0, 100, 0, 10120, 0, 0, 0, 85, 59780, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Select - Invoker cast');
INSERT INTO smart_scripts VALUES(31839, 0, 1, 2, 62, 0, 100, 0, 10120, 1, 0, 0, 85, 61152, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Select - Invoker cast');
INSERT INTO smart_scripts VALUES(31839, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Select - Close gossip');
DELETE FROM conditions WHERE SourceTypeOrReferenceID=15 AND SourceGroup IN(10119, 10120);
INSERT INTO conditions VALUES (15, 10120, 0, 0, 0, 9, 0, 13373, 0, 0, 0, 0, 0, '', 'show gossip on quest 13373 taken');
INSERT INTO conditions VALUES (15, 10120, 0, 0, 1, 9, 0, 13406, 0, 0, 0, 0, 0, '', 'show gossip on quest 13406 taken');
INSERT INTO conditions VALUES (15, 10120, 1, 0, 0, 9, 0, 13374, 0, 0, 0, 0, 0, '', 'show gossip on quest 13374 taken');
INSERT INTO conditions VALUES (15, 10120, 1, 0, 1, 9, 0, 13376, 0, 0, 0, 0, 0, '', 'show gossip on quest 13376 taken');
INSERT INTO conditions VALUES (15, 10119, 0, 0, 0, 9, 0, 13404, 0, 0, 0, 0, 0, '', 'show gossip on quest 13404 taken');
INSERT INTO conditions VALUES (15, 10119, 0, 0, 1, 9, 0, 13380, 0, 0, 0, 0, 0, '', 'show gossip on quest 13380 taken');
INSERT INTO conditions VALUES (15, 10119, 1, 0, 0, 9, 0, 13381, 0, 0, 0, 0, 0, '', 'show gossip on quest 13381 taken');
INSERT INTO conditions VALUES (15, 10119, 1, 0, 1, 9, 0, 13382, 0, 0, 0, 0, 0, '', 'show gossip on quest 13382 taken');
DELETE FROM gossip_menu_option WHERE menu_id IN(10120, 10119);
INSERT INTO gossip_menu_option VALUES (10119, 0, 0, 'Give me a bomber!', 1, 1, 0, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (10119, 1, 0, 'Give me a bomber!', 1, 1, 0, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (10120, 0, 0, 'Give me a bomber!', 1, 1, 0, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (10120, 1, 0, 'Give me a bomber!', 1, 1, 0, 0, 0, 0, '');
-- correct spawn trigger positions
UPDATE creature_template SET InhabitType=4, flags_extra=130 WHERE entry=31690;
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=31690 AND position_z < 610);
DELETE FROM creature WHERE id=31690 AND position_z < 610;
UPDATE creature SET position_z=620, spawndist=0, MovementType=0 WHERE id=31690;
-- summoning spells target conditions
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(59552, 59780, 61151, 61152);
INSERT INTO conditions VALUES (13, 1, 59552, 0, 0, 31, 0, 3, 31690, 0, 0, 0, 0, '', 'Target Infra-Green Flight Master');
INSERT INTO conditions VALUES (13, 1, 59780, 0, 0, 31, 0, 3, 31690, 0, 0, 0, 0, '', 'Target Infra-Green Flight Master');
INSERT INTO conditions VALUES (13, 1, 61151, 0, 0, 31, 0, 3, 31690, 0, 0, 0, 0, '', 'Target Infra-Green Flight Master');
INSERT INTO conditions VALUES (13, 1, 61152, 0, 0, 31, 0, 3, 31690, 0, 0, 0, 0, '', 'Target Infra-Green Flight Master');
-- fix switching spells
DELETE FROM spell_script_names WHERE spell_id IN(59196, 59194, 59193);
INSERT INTO spell_script_names VALUES(59196, 'spell_switch_infragreen_bomber_station');
INSERT INTO spell_script_names VALUES(59194, 'spell_switch_infragreen_bomber_station');
INSERT INTO spell_script_names VALUES(59193, 'spell_switch_infragreen_bomber_station');
DELETE FROM spell_script_names WHERE spell_id IN(59061, 59288);
INSERT INTO spell_script_names VALUES(59061, 'spell_charge_shield_bomber');
INSERT INTO spell_script_names VALUES(59288, 'spell_charge_shield_bomber');
DELETE FROM spell_script_names WHERE spell_id IN(61093);
INSERT INTO spell_script_names VALUES(61093, 'spell_fight_fire_bomber');
DELETE FROM spell_script_names WHERE spell_id IN(59622);
INSERT INTO spell_script_names VALUES(59622, 'spell_anti_air_rocket_bomber');

-- Fix Quest creatures
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=32769);
DELETE FROM creature_formations WHERE leaderGUID IN(SELECT guid FROM creature WHERE id=32769);
DELETE FROM creature WHERE id=32769;
INSERT INTO creature VALUES (NULL, 32769, 571, 1, 1, 25753, 0, 7523.09, 1852.78, 491.641, 1.16008, 10, 60, 0, 12600, 3994, 1, 0, 0, 0),(NULL, 32769, 571, 1, 1, 25753, 0, 7523.09, 1852.78, 491.641, 3.23212, 10, 60, 0, 12600, 3994, 1, 0, 0, 0),(NULL, 32769, 571, 1, 1, 25753, 0, 7703.2, 1822.89, 469.378, 3.47223, 10, 60, 0, 12600, 3994, 1, 0, 0, 0),(NULL, 32769, 571, 1, 1, 25753, 0, 7703.2, 1822.89, 469.378, 3.94286, 10, 60, 0, 12600, 3994, 1, 0, 0, 0),(NULL, 32769, 571, 1, 1, 25753, 0, 7770.85, 1626.59, 469.378, 4.35007, 10, 60, 0, 12600, 3994, 1, 0, 0, 0),(NULL, 32769, 571, 1, 1, 25753, 0, 7770.85, 1626.59, 469.378, 0.010103, 10, 60, 0, 12600, 3994, 1, 0, 0, 0),(NULL, 32769, 571, 1, 1, 25753, 0, 7733.55, 1578.02, 469.378, 3.23125, 10, 60, 0, 12600, 3994, 1, 0, 0, 0),(NULL, 32769, 571, 1, 1, 25753, 0, 7733.55, 1578.02, 469.378, 2.51066, 10, 60, 0, 12600, 3994, 1, 0, 0, 0),
(NULL, 32769, 571, 1, 1, 25753, 0, 7700.71, 1866.03, 464.062, 0.0335467, 10, 60, 0, 12600, 3994, 1, 0, 0, 0),(NULL, 32769, 571, 1, 1, 25753, 0, 7634.01, 1863.8, 453.321, 0.100306, 10, 60, 0, 12600, 3994, 1, 0, 0, 0),(NULL, 32769, 571, 1, 1, 25753, 0, 7735.12, 1823.7, 464.062, 0.0335467, 10, 60, 0, 12600, 3994, 1, 0, 0, 0),(NULL, 32769, 571, 1, 1, 25753, 0, 7783.46, 1783.04, 469.012, 0.0335467, 10, 60, 0, 12600, 3994, 1, 0, 0, 0),(NULL, 32769, 571, 1, 1, 25753, 0, 7838.73, 1761.25, 466.425, 4.96978, 10, 60, 0, 12600, 3994, 1, 0, 0, 0),(NULL, 32769, 571, 1, 1, 25753, 0, 7763.36, 1704.4, 459.294, 3.89379, 10, 60, 0, 12600, 3994, 1, 0, 0, 0),(NULL, 32769, 571, 1, 1, 25753, 0, 7685.98, 1708.66, 460.417, 3.89379, 10, 60, 0, 12600, 3994, 1, 0, 0, 0),(NULL, 32769, 571, 1, 1, 25753, 0, 7711.54, 1636.03, 447.492, 4.85589, 10, 60, 0, 12600, 3994, 1, 0, 0, 0),(NULL, 32769, 571, 1, 1, 25753, 0, 7630.44, 1601.94, 445.692, 2.12271, 10, 60, 0, 12600, 3994, 1, 0, 0, 0),
(NULL, 32769, 571, 1, 1, 25753, 0, 7559.02, 1547.51, 435.682, 1.52973, 10, 60, 0, 12600, 3994, 1, 0, 0, 0),(NULL, 32769, 571, 1, 1, 25753, 0, 7695.42, 1557.94, 483.848, 2.97487, 10, 60, 0, 12600, 3994, 1, 0, 0, 0),(NULL, 32769, 571, 1, 1, 25753, 0, 7681.77, 1636.37, 491.285, 2.97487, 10, 60, 0, 12600, 3994, 1, 0, 0, 0),(NULL, 32769, 571, 1, 1, 25753, 0, 7651.87, 1722.94, 495.997, 2.97487, 10, 60, 0, 12600, 3994, 1, 0, 0, 0),(NULL, 32769, 571, 1, 1, 25753, 0, 7725.34, 1767.48, 510.085, 6.28139, 10, 60, 0, 12600, 3994, 1, 0, 0, 0),(NULL, 32769, 571, 1, 1, 25753, 0, 7791.85, 1708.06, 518.138, 6.28139, 300, 60, 0, 12600, 3994, 1, 0, 0, 0);
UPDATE creature_template SET KillCredit2=32188, AIName='SmartAI', ScriptName='' WHERE entry=32769; -- Gargoyle Ambusher
DELETE FROM smart_scripts WHERE entryorguid=32769 AND source_type=0;
INSERT INTO smart_scripts VALUES(32769, 0, 0, 0, 1, 0, 100, 0, 5000, 10000, 3000, 6000, 49, 0, 0, 0, 0, 0, 0, 19, 31406, 80, 0, 0, 0, 0, 0, 'Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES(32769, 0, 1, 0, 1, 0, 100, 0, 5000, 10000, 3000, 6000, 49, 0, 0, 0, 0, 0, 0, 19, 32512, 80, 0, 0, 0, 0, 0, 'Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES(32769, 0, 2, 0, 1, 0, 100, 0, 5000, 10000, 3000, 6000, 49, 0, 0, 0, 0, 0, 0, 19, 31838, 80, 0, 0, 0, 0, 0, 'Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES(32769, 0, 3, 0, 1, 0, 100, 0, 5000, 10000, 3000, 6000, 49, 0, 0, 0, 0, 0, 0, 19, 32513, 80, 0, 0, 0, 0, 0, 'Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES(32769, 0, 4, 0, 9, 0, 100, 0, 0, 40, 1500, 1500, 11, 60239, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'In Range - Cast Spell Gargoyle Ambusher Strike');
INSERT INTO smart_scripts VALUES(32769, 0, 5, 0, 37, 0, 100, 257, 0, 0, 0, 0, 134, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Set Combat Distance');
REPLACE INTO creature_template_addon VALUES (32767, 0, 0, 50331648, 0, 0, '');
DELETE FROM creature WHERE id=32767 AND guid > 130000;
INSERT INTO creature VALUES (NULL, 32767, 571, 1, 1, 27064, 0, 7244.55, 1285.52, 416.07, 2.71176, 10, 60, 0, 25200, 0, 1, 0, 0, 0),(NULL, 32767, 571, 1, 1, 27064, 0, 7134.18, 1373.87, 408.537, 5.90048, 10, 60, 0, 25200, 0, 1, 0, 0, 0),
(NULL, 32767, 571, 1, 1, 27064, 0, 7155.42, 1211.4, 386.189, 5.49993, 10, 60, 0, 25200, 0, 1, 0, 0, 0),(NULL, 32767, 571, 1, 1, 27064, 0, 7302.18, 1240.95, 390.122, 0.418399, 10, 60, 0, 25200, 0, 1, 0, 0, 0),(NULL, 32767, 571, 1, 1, 27064, 0, 7333.87, 1348.77, 393.362, 0.418399, 10, 60, 0, 25200, 0, 1, 0, 0, 0),(NULL, 32767, 571, 1, 1, 27064, 0, 7239.56, 1441.97, 384.094, 4.94622, 10, 60, 0, 25200, 0, 1, 0, 0, 0),(NULL, 32767, 571, 1, 1, 27064, 0, 7407.94, 1436.64, 390.421, 0.300584, 10, 60, 0, 25200, 0, 1, 0, 0, 0),(NULL, 32767, 571, 1, 1, 27064, 0, 7526.03, 1354.32, 401.356, 0.300584, 300, 60, 0, 25200, 0, 1, 0, 0, 0);
UPDATE creature_template SET KillCredit1=31721, AIName='SmartAI', ScriptName='' WHERE entry=32767; -- Frostbrood Sentry
DELETE FROM smart_scripts WHERE entryorguid=32767 AND source_type=0;
INSERT INTO smart_scripts VALUES(32767, 0, 0, 0, 1, 0, 100, 0, 5000, 10000, 3000, 6000, 49, 0, 0, 0, 0, 0, 0, 19, 31406, 80, 0, 0, 0, 0, 0, 'Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES(32767, 0, 1, 0, 1, 0, 100, 0, 5000, 10000, 3000, 6000, 49, 0, 0, 0, 0, 0, 0, 19, 32512, 80, 0, 0, 0, 0, 0, 'Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES(32767, 0, 2, 0, 1, 0, 100, 0, 5000, 10000, 3000, 6000, 49, 0, 0, 0, 0, 0, 0, 19, 31838, 80, 0, 0, 0, 0, 0, 'Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES(32767, 0, 3, 0, 1, 0, 100, 0, 5000, 10000, 3000, 6000, 49, 0, 0, 0, 0, 0, 0, 19, 32513, 80, 0, 0, 0, 0, 0, 'Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES(32767, 0, 4, 0, 9, 0, 100, 0, 0, 40, 2000, 3000, 11, 60542, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'In Range - Cast Spell Bitter Blast');
INSERT INTO smart_scripts VALUES(32767, 0, 5, 0, 37, 0, 100, 257, 0, 0, 0, 0, 134, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Set Combat Distance');
UPDATE creature_template SET KillCredit1=32410 WHERE entry=32771; -- Bombardment Captain
UPDATE creature_template SET minlevel=80, maxlevel=80, faction=21, mindmg=420, maxdmg=630, attackpower=157, AIName='SmartAI', ScriptName='' WHERE entry=32154;
DELETE FROM smart_scripts WHERE entryorguid=32154 AND source_type=0;
INSERT INTO smart_scripts VALUES(32154, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 52324, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Death - Cast Spell Scourgewagon Explosion');
UPDATE creature_template SET modelid1=15958, modelid2=12818, modelid3=15962, minlevel=80, maxlevel=80, faction=21, mindmg=420, maxdmg=630, attackpower=157, mechanic_immune_mask=8388624 WHERE entry=32410;
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(32154, 32410));
DELETE FROM creature WHERE id IN(32154, 32410);
INSERT INTO creature VALUES (NULL, 32154, 571, 1, 1, 0, 0, 7707.46, 1695.11, 341.05, 4.43793, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7724.26, 1771.43, 348.847, 1.70868, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7826.99, 1768.44, 358.238, 2.96924, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7851.09, 1955.81, 367.002, 1.97571, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7842.81, 1840.36, 365.721, 4.29656, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7795.76, 1835.98, 362.766, 4.24158, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7813.27, 1662.84, 356.26, 6.26398, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7202.76, 1316.63, 305.442, 3.29517, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7220.64, 1216.06, 307.663, 1.15889, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7129.91, 1155.77, 305.815, 1.17067, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7144.89, 1115.43, 314.937, 5.51785, 60, 0, 0, 31500, 0, 0, 0, 0, 0),
(NULL, 32154, 571, 1, 1, 0, 0, 7172.32, 1152.7, 309.25, 6.03229, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7173.22, 1185.4, 308.278, 6.03229, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7153.32, 1234.99, 301.82, 4.89346, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7737.62, 1637.87, 346.603, 4.43793, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7611.61, 1651.27, 342.069, 1.94822, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7616.57, 1716.3, 344.036, 1.94822, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7232.34, 1365.87, 309.911, 3.61719, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7179.8, 1368.87, 310.435, 3.61719, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7163.97, 1335.66, 307.248, 3.61719, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7142.1, 1313.45, 303.877, 3.61719, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7124.12, 1286.83, 299.649, 3.61719, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7119.05, 1254.62, 297.911, 4.89346, 60, 0, 0, 31500, 0, 0, 0, 0, 0),
(NULL, 32154, 571, 1, 1, 0, 0, 7553.98, 2091.65, 500.312, 3.96984, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7540, 2101.52, 500.312, 4.12692, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7534.32, 2014.59, 500.312, 1.81785, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7515.71, 2002.49, 500.273, 2.21054, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7494.5, 2011.03, 500.273, 0.561207, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7512.02, 2044.56, 499.729, 2.22232, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7488.65, 2092.86, 499.729, 1.20523, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7471.24, 2101.12, 499.729, 1.03637, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7513.48, 2121.57, 500.311, 3.50645, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7471.66, 2146.02, 500.311, 4.16618, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7459.63, 2151.93, 500.311, 4.22509, 60, 0, 0, 31500, 0, 0, 0, 0, 0),
(NULL, 32154, 571, 1, 1, 0, 0, 7446.16, 2156.28, 500.311, 4.29577, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7457.32, 2110.68, 499.729, 1.0992, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7426.65, 2167.64, 500.312, 4.42536, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7421.56, 2149.44, 500.312, 6.19643, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7530.32, 2108.52, 500.312, 4.19759, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7600.73, 2060.82, 500.068, 3.10982, 60, 0, 0, 31500, 0, 0, 0, 0, 0),(NULL, 32154, 571, 1, 1, 0, 0, 7741.72, 1968.48, 367.425, 0.935059, 300, 0, 0, 31500, 0, 0, 0, 0, 0);

-- Alliance Infra-green Bomber (31406), short
-- Alliance Infra-green Bomber (32512), long
UPDATE creature_template SET exp=2, npcflag=16777216, speed_walk=1.2, speed_run=1.14286, VehicleId=273, InhabitType=4, RegenHealth=0, AIName='', ScriptName='npc_infra_green_bomber_generic' WHERE entry=31406;
UPDATE creature_template SET exp=2, npcflag=16777216, speed_walk=1.2, speed_run=1.14286, VehicleId=273, InhabitType=4, RegenHealth=0, AIName='', ScriptName='npc_infra_green_bomber_generic' WHERE entry=32512;
DELETE FROM npc_spellclick_spells WHERE npc_entry IN(31406, 32512);
INSERT INTO npc_spellclick_spells VALUES (31406, 46598, 1, 0);
INSERT INTO npc_spellclick_spells VALUES (32512, 46598, 1, 0);
DELETE FROM vehicle_template_accessory WHERE entry IN(31406, 32512);
INSERT INTO vehicle_template_accessory VALUES (31406, 31408, 0, 1, 'Alliance Bomber Seat on Alliance Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (31406, 31407, 1, 1, 'Alliance Turret Seat on Alliance Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (31406, 31409, 2, 1, 'Alliance Engineering Seat on rides Alliance Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (31406, 32217, 3, 1, 'Banner Bunny, Hanging, Alliance on Alliance Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (31406, 32221, 4, 1, 'Banner Bunny, Side, Alliance on Alliance Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (31406, 32221, 5, 1, 'Banner Bunny, Side, Alliance on Alliance Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (31406, 32256, 6, 1, 'Shield Visual Loc Bunny on Alliance Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (31406, 32274, 7, 1, 'Alliance Bomber Pilot rides Alliance Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (32512, 31408, 0, 1, 'Alliance Bomber Seat on Alliance Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (32512, 31407, 1, 1, 'Alliance Turret Seat on Alliance Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (32512, 31409, 2, 1, 'Alliance Engineering Seat on rides Alliance Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (32512, 32217, 3, 1, 'Banner Bunny, Hanging, Alliance on Alliance Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (32512, 32221, 4, 1, 'Banner Bunny, Side, Alliance on Alliance Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (32512, 32221, 5, 1, 'Banner Bunny, Side, Alliance on Alliance Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (32512, 32256, 6, 1, 'Shield Visual Loc Bunny on Alliance Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (32512, 32274, 7, 1, 'Alliance Bomber Pilot rides Alliance Infra-green Bomber', 8, 0);
DELETE FROM waypoints WHERE entry=31406;
INSERT INTO waypoints VALUES (31406, 1, 7753.45, 2044.47, 592.04, 'Alliance Infra-green Bomber - Short'),(31406, 2, 7766.17, 2004.16, 575.364, 'Alliance Infra-green Bomber - Short'),(31406, 3, 7804.4, 1951.74, 549.136, 'Alliance Infra-green Bomber - Short'),(31406, 4, 7825.09, 1928.68, 532.879, 'Alliance Infra-green Bomber - Short'),(31406, 5, 7866.31, 1885.58, 496.232, 'Alliance Infra-green Bomber - Short'),(31406, 6, 7895.59, 1845.43, 466.525, 'Alliance Infra-green Bomber - Short'),(31406, 7, 7883.56, 1804.89, 449.938, 'Alliance Infra-green Bomber - Short'),(31406, 8, 7837, 1801.84, 435.217, 'Alliance Infra-green Bomber - Short'),(31406, 9, 7815.85, 1813.61, 431.672, 'Alliance Infra-green Bomber - Short'),(31406, 10, 7772.53, 1841.07, 431.172, 'Alliance Infra-green Bomber - Short'),(31406, 11, 7739.59, 1852.73, 430.873, 'Alliance Infra-green Bomber - Short'),(31406, 12, 7701.6, 1856.26, 428.418, 'Alliance Infra-green Bomber - Short'),
(31406, 13, 7658.51, 1855.49, 430.772, 'Alliance Infra-green Bomber - Short'),(31406, 14, 7634.45, 1847.34, 432.35, 'Alliance Infra-green Bomber - Short'),(31406, 15, 7587.81, 1815.65, 431.884, 'Alliance Infra-green Bomber - Short'),(31406, 16, 7577.23, 1780.84, 425.398, 'Alliance Infra-green Bomber - Short'),(31406, 17, 7588.97, 1748.31, 416.64, 'Alliance Infra-green Bomber - Short'),(31406, 18, 7606.15, 1728.53, 411.093, 'Alliance Infra-green Bomber - Short'),(31406, 19, 7635.87, 1700.63, 410.406, 'Alliance Infra-green Bomber - Short'),(31406, 20, 7661.84, 1677.63, 415.037, 'Alliance Infra-green Bomber - Short'),(31406, 21, 7683.93, 1657.1, 418.071, 'Alliance Infra-green Bomber - Short'),(31406, 22, 7730.4, 1647.6, 420.767, 'Alliance Infra-green Bomber - Short'),(31406, 23, 7760.93, 1663.64, 426.739, 'Alliance Infra-green Bomber - Short'),(31406, 24, 7817.86, 1688.59, 436.1, 'Alliance Infra-green Bomber - Short'),(31406, 25, 7857.05, 1734.45, 413.059, 'Alliance Infra-green Bomber - Short'),
(31406, 26, 7865.85, 1752.09, 411.13, 'Alliance Infra-green Bomber - Short'),(31406, 27, 7873.44, 1803.01, 416.629, 'Alliance Infra-green Bomber - Short'),(31406, 28, 7853.76, 1838.35, 425.217, 'Alliance Infra-green Bomber - Short'),(31406, 29, 7816.59, 1856.3, 430.695, 'Alliance Infra-green Bomber - Short'),(31406, 30, 7778.95, 1853.29, 432.243, 'Alliance Infra-green Bomber - Short'),(31406, 31, 7750.59, 1828.18, 431.892, 'Alliance Infra-green Bomber - Short'),(31406, 32, 7735.12, 1799.6, 429.134, 'Alliance Infra-green Bomber - Short'),(31406, 33, 7720.96, 1767.72, 426.263, 'Alliance Infra-green Bomber - Short'),(31406, 34, 7709.29, 1745.03, 423.882, 'Alliance Infra-green Bomber - Short'),(31406, 35, 7687.72, 1717.87, 419.22, 'Alliance Infra-green Bomber - Short'),(31406, 36, 7663.97, 1692.6, 414.53, 'Alliance Infra-green Bomber - Short'),(31406, 37, 7639.08, 1668.44, 409.85, 'Alliance Infra-green Bomber - Short'),(31406, 38, 7606.57, 1637.13, 404.108, 'Alliance Infra-green Bomber - Short'),(31406, 39, 7614.29, 1603.57, 397.91, 'Alliance Infra-green Bomber - Short'),
(31406, 40, 7624.51, 1570.93, 390.542, 'Alliance Infra-green Bomber - Short'),(31406, 41, 7634.43, 1530.19, 382.105, 'Alliance Infra-green Bomber - Short'),(31406, 42, 7613.33, 1494.48, 381.294, 'Alliance Infra-green Bomber - Short'),(31406, 43, 7584.1, 1491.31, 387.931, 'Alliance Infra-green Bomber - Short'),(31406, 44, 7555.27, 1497.66, 401.862, 'Alliance Infra-green Bomber - Short'),(31406, 45, 7523.53, 1511.46, 421.102, 'Alliance Infra-green Bomber - Short'),(31406, 46, 7489.08, 1510.24, 431.514, 'Alliance Infra-green Bomber - Short'),(31406, 47, 7477.76, 1486.37, 435.962, 'Alliance Infra-green Bomber - Short'),(31406, 48, 7498.74, 1445.82, 440.44, 'Alliance Infra-green Bomber - Short'),(31406, 49, 7532.11, 1412.9, 448.849, 'Alliance Infra-green Bomber - Short'),(31406, 50, 7563.08, 1404.79, 453.795, 'Alliance Infra-green Bomber - Short'),(31406, 51, 7601.4, 1415.79, 458.653, 'Alliance Infra-green Bomber - Short'),(31406, 52, 7626.93, 1435.78, 461.89, 'Alliance Infra-green Bomber - Short'),(31406, 53, 7641.68, 1453.63, 464.418, 'Alliance Infra-green Bomber - Short'),(31406, 54, 7660.38, 1501.85, 472.969, 'Alliance Infra-green Bomber - Short'),
(31406, 55, 7668.88, 1535.63, 476.438, 'Alliance Infra-green Bomber - Short'),(31406, 56, 7676.59, 1569.65, 479.256, 'Alliance Infra-green Bomber - Short'),(31406, 57, 7685.44, 1599.73, 482.085, 'Alliance Infra-green Bomber - Short'),(31406, 58, 7698.4, 1631.93, 486.528, 'Alliance Infra-green Bomber - Short'),(31406, 59, 7713.19, 1663.23, 491.681, 'Alliance Infra-green Bomber - Short'),(31406, 60, 7743.51, 1725.39, 502.409, 'Alliance Infra-green Bomber - Short'),(31406, 61, 7760.73, 1755.16, 508.887, 'Alliance Infra-green Bomber - Short'),(31406, 62, 7777.56, 1785.01, 515.946, 'Alliance Infra-green Bomber - Short'),(31406, 63, 7787.84, 1815.11, 522.388, 'Alliance Infra-green Bomber - Short'),(31406, 64, 7788.78, 1851.14, 531.797, 'Alliance Infra-green Bomber - Short'),(31406, 65, 7785.71, 1884.7, 541.23, 'Alliance Infra-green Bomber - Short'),(31406, 66, 7783.92, 1918.17, 551.305, 'Alliance Infra-green Bomber - Short'),(31406, 67, 7782.55, 1974.89, 569.197, 'Alliance Infra-green Bomber - Short'),
(31406, 68, 7779.93, 2000.37, 585.416, 'Alliance Infra-green Bomber - Short'),(31406, 69, 7633.95, 2061.49, 618.75, 'Alliance Infra-green Bomber - Short');
DELETE FROM waypoints WHERE entry=32512;
INSERT INTO waypoints VALUES (32512, 1, 7740.12, 2037.47, 594.088, 'Alliance Infra-green Bomber - Long'),(32512, 2, 7742.67, 2023.95, 583.412, 'Alliance Infra-green Bomber - Long'),(32512, 3, 7740.06, 1991.28, 559.206, 'Alliance Infra-green Bomber - Long'),(32512, 4, 7728.47, 1976.46, 540.522, 'Alliance Infra-green Bomber - Long'),(32512, 5, 7710.74, 1968.24, 523.864, 'Alliance Infra-green Bomber - Long'),(32512, 6, 7684.83, 1956.37, 503.568, 'Alliance Infra-green Bomber - Long'),(32512, 7, 7633.76, 1925.8, 466.762, 'Alliance Infra-green Bomber - Long'),(32512, 8, 7608.49, 1909.46, 448.915, 'Alliance Infra-green Bomber - Long'),(32512, 9, 7583.64, 1878.65, 428.868, 'Alliance Infra-green Bomber - Long'),(32512, 10, 7594.58, 1848.98, 417.143, 'Alliance Infra-green Bomber - Long'),(32512, 11, 7623.07, 1838.43, 407.831, 'Alliance Infra-green Bomber - Long'),(32512, 12, 7660.62, 1844.98, 397.19, 'Alliance Infra-green Bomber - Long'),(32512, 13, 7678.44, 1849.78, 394.788, 'Alliance Infra-green Bomber - Long'),(32512, 14, 7709.07, 1857.01, 393.746, 'Alliance Infra-green Bomber - Long'),(32512, 15, 7736.76, 1861.04, 395.752, 'Alliance Infra-green Bomber - Long'),(32512, 16, 7787.22, 1866.39, 403.213, 'Alliance Infra-green Bomber - Long'),(32512, 17, 7837.2, 1851.71, 409.706, 'Alliance Infra-green Bomber - Long'),(32512, 18, 7852.85, 1828.93, 411.219, 'Alliance Infra-green Bomber - Long'),(32512, 19, 7853.23, 1800.17, 412.38, 'Alliance Infra-green Bomber - Long'),
(32512, 20, 7829.07, 1770.52, 406.956, 'Alliance Infra-green Bomber - Long'),(32512, 21, 7811.85, 1768.51, 404.165, 'Alliance Infra-green Bomber - Long'),(32512, 22, 7799.06, 1768.1, 403.979, 'Alliance Infra-green Bomber - Long'),(32512, 23, 7766.45, 1769.32, 405.503, 'Alliance Infra-green Bomber - Long'),(32512, 24, 7731.83, 1774.18, 407.213, 'Alliance Infra-green Bomber - Long'),(32512, 25, 7672.1, 1781.93, 409.652, 'Alliance Infra-green Bomber - Long'),(32512, 26, 7636.9, 1764.66, 408.927, 'Alliance Infra-green Bomber - Long'),(32512, 27, 7622.94, 1733.91, 407.852, 'Alliance Infra-green Bomber - Long'),(32512, 28, 7637.13, 1701.48, 401.798, 'Alliance Infra-green Bomber - Long'),(32512, 29, 7656.35, 1687.47, 392.133, 'Alliance Infra-green Bomber - Long'),(32512, 30, 7683.72, 1664.33, 389.155, 'Alliance Infra-green Bomber - Long'),(32512, 31, 7704.89, 1644.36, 391.315, 'Alliance Infra-green Bomber - Long'),(32512, 32, 7723.43, 1616.93, 396.226, 'Alliance Infra-green Bomber - Long'),(32512, 33, 7725.81, 1591.86, 400.687, 'Alliance Infra-green Bomber - Long'),(32512, 34, 7715.29, 1556.66, 405.374, 'Alliance Infra-green Bomber - Long'),(32512, 35, 7700.13, 1537.58, 406.834, 'Alliance Infra-green Bomber - Long'),(32512, 36, 7669.18, 1514.83, 407.87, 'Alliance Infra-green Bomber - Long'),(32512, 37, 7645.32, 1502.62, 408.244, 'Alliance Infra-green Bomber - Long'),(32512, 38, 7597.58, 1487.31, 407.425, 'Alliance Infra-green Bomber - Long'),
(32512, 39, 7563.26, 1480.56, 406.112, 'Alliance Infra-green Bomber - Long'),(32512, 40, 7530.64, 1468.65, 404.426, 'Alliance Infra-green Bomber - Long'),(32512, 41, 7509.13, 1449.03, 402.95, 'Alliance Infra-green Bomber - Long'),(32512, 42, 7486.21, 1414.11, 401.32, 'Alliance Infra-green Bomber - Long'),(32512, 43, 7477.96, 1391.06, 401.176, 'Alliance Infra-green Bomber - Long'),(32512, 44, 7468.21, 1357.44, 401.054, 'Alliance Infra-green Bomber - Long'),(32512, 45, 7454.79, 1315.26, 400.386, 'Alliance Infra-green Bomber - Long'),(32512, 46, 7441.42, 1292.08, 399.426, 'Alliance Infra-green Bomber - Long'),(32512, 47, 7413.4, 1266.08, 397.33, 'Alliance Infra-green Bomber - Long'),(32512, 48, 7384.47, 1254.93, 393.811, 'Alliance Infra-green Bomber - Long'),(32512, 49, 7352.79, 1259.18, 387.868, 'Alliance Infra-green Bomber - Long'),(32512, 50, 7330.17, 1269.94, 382.371, 'Alliance Infra-green Bomber - Long'),(32512, 51, 7313.91, 1280.48, 377.967, 'Alliance Infra-green Bomber - Long'),(32512, 52, 7287.94, 1302.62, 370.212, 'Alliance Infra-green Bomber - Long'),(32512, 53, 7247.12, 1334.65, 357.074, 'Alliance Infra-green Bomber - Long'),(32512, 54, 7222.75, 1346.71, 350.44, 'Alliance Infra-green Bomber - Long'),(32512, 55, 7191.05, 1359.21, 342.487, 'Alliance Infra-green Bomber - Long'),(32512, 56, 7146.12, 1365.7, 334.615, 'Alliance Infra-green Bomber - Long'),(32512, 57, 7118.05, 1354.57, 333.155, 'Alliance Infra-green Bomber - Long'),
(32512, 58, 7095.1, 1336.85, 333.92, 'Alliance Infra-green Bomber - Long'),(32512, 59, 7082.05, 1313.63, 335.456, 'Alliance Infra-green Bomber - Long'),(32512, 60, 7081.52, 1280.37, 338.251, 'Alliance Infra-green Bomber - Long'),(32512, 61, 7098.09, 1251.42, 340.588, 'Alliance Infra-green Bomber - Long'),(32512, 62, 7115.06, 1235.56, 342.192, 'Alliance Infra-green Bomber - Long'),(32512, 63, 7140.75, 1236.72, 344.987, 'Alliance Infra-green Bomber - Long'),(32512, 64, 7147.52, 1246.17, 345.62, 'Alliance Infra-green Bomber - Long'),(32512, 65, 7161.72, 1280.15, 359.42, 'Alliance Infra-green Bomber - Long'),(32512, 66, 7182.57, 1286.26, 358.761, 'Alliance Infra-green Bomber - Long'),(32512, 67, 7190.92, 1275.2, 359.311, 'Alliance Infra-green Bomber - Long'),(32512, 68, 7202, 1246.16, 364.335, 'Alliance Infra-green Bomber - Long'),(32512, 69, 7228.05, 1205.15, 374.81, 'Alliance Infra-green Bomber - Long'),(32512, 70, 7257.44, 1201, 379.775, 'Alliance Infra-green Bomber - Long'),(32512, 71, 7283.25, 1207.12, 383.432, 'Alliance Infra-green Bomber - Long'),(32512, 72, 7313.53, 1231.6, 386.708, 'Alliance Infra-green Bomber - Long'),(32512, 73, 7320.05, 1252.78, 386.454, 'Alliance Infra-green Bomber - Long'),(32512, 74, 7325.5, 1287.34, 385.663, 'Alliance Infra-green Bomber - Long'),(32512, 75, 7336.36, 1325.32, 386.77, 'Alliance Infra-green Bomber - Long'),
(32512, 76, 7358.37, 1348.92, 389.222, 'Alliance Infra-green Bomber - Long'),(32512, 77, 7377.21, 1357.82, 390.506, 'Alliance Infra-green Bomber - Long'),(32512, 78, 7411, 1366.82, 391.944, 'Alliance Infra-green Bomber - Long'),(32512, 79, 7478.71, 1383.7, 396.844, 'Alliance Infra-green Bomber - Long'),(32512, 80, 7508.38, 1396.75, 399.75, 'Alliance Infra-green Bomber - Long'),(32512, 81, 7549.64, 1435.9, 402.703, 'Alliance Infra-green Bomber - Long'),(32512, 82, 7579.53, 1488.62, 405.454, 'Alliance Infra-green Bomber - Long'),(32512, 83, 7594.04, 1530.21, 405.995, 'Alliance Infra-green Bomber - Long'),(32512, 84, 7597.78, 1580.15, 406.863, 'Alliance Infra-green Bomber - Long'),(32512, 85, 7599.84, 1629.51, 398.177, 'Alliance Infra-green Bomber - Long'),(32512, 86, 7600.09, 1641.16, 397.327, 'Alliance Infra-green Bomber - Long'),(32512, 87, 7601.76, 1706.16, 392.187, 'Alliance Infra-green Bomber - Long'),(32512, 88, 7609.87, 1734.02, 391.214, 'Alliance Infra-green Bomber - Long'),(32512, 89, 7629.48, 1766.95, 392.821, 'Alliance Infra-green Bomber - Long'),(32512, 90, 7654.89, 1787.01, 394.78, 'Alliance Infra-green Bomber - Long'),(32512, 91, 7687.36, 1798.35, 400.772, 'Alliance Infra-green Bomber - Long'),(32512, 92, 7723.2, 1803.61, 409.558, 'Alliance Infra-green Bomber - Long'),(32512, 93, 7739.02, 1803.96, 413.524, 'Alliance Infra-green Bomber - Long'),(32512, 94, 7772.81, 1801.73, 422.254, 'Alliance Infra-green Bomber - Long'),
(32512, 95, 7806.51, 1798.3, 431.083, 'Alliance Infra-green Bomber - Long'),(32512, 96, 7839.75, 1795.2, 441.564, 'Alliance Infra-green Bomber - Long'),(32512, 97, 7880.53, 1792.37, 458.585, 'Alliance Infra-green Bomber - Long'),(32512, 98, 7915.31, 1795.76, 477.234, 'Alliance Infra-green Bomber - Long'),(32512, 99, 7948.23, 1808.57, 499.45, 'Alliance Infra-green Bomber - Long'),(32512, 100, 7966.47, 1831.04, 518.671, 'Alliance Infra-green Bomber - Long'),(32512, 101, 7971.64, 1849.81, 531.481, 'Alliance Infra-green Bomber - Long'),(32512, 102, 7972.72, 1865.6, 541.284, 'Alliance Infra-green Bomber - Long'),(32512, 103, 7960.29, 1916.23, 549.119, 'Alliance Infra-green Bomber - Long'),(32512, 104, 7938.55, 1934.97, 553.812, 'Alliance Infra-green Bomber - Long'),(32512, 105, 7889.36, 1953.47, 563.336, 'Alliance Infra-green Bomber - Long'),(32512, 106, 7855.36, 1959.24, 569.281, 'Alliance Infra-green Bomber - Long'),(32512, 107, 7821.29, 1965.55, 574.228, 'Alliance Infra-green Bomber - Long'),(32512, 108, 7812.15, 1967.28, 575.42, 'Alliance Infra-green Bomber - Long'),
(32512, 109, 7774.67, 1986.76, 580.059, 'Alliance Infra-green Bomber - Long'),(32512, 110, 7633.95, 2061.49, 618.75, 'Alliance Infra-green Bomber - Long');
DELETE FROM npc_spellclick_spells WHERE npc_entry IN(31407, 31408, 31409);
INSERT INTO npc_spellclick_spells VALUES (31407, 59060, 1, 0);
INSERT INTO npc_spellclick_spells VALUES (31408, 59060, 1, 0);
INSERT INTO npc_spellclick_spells VALUES (31409, 59060, 1, 0);
-- Alliance Turret Seat (31407)
REPLACE INTO creature_template_addon VALUES (31407, 0, 0, 0, 0, 0, '59458');
UPDATE creature_template SET exp=2, npcflag=16777216, unit_class=8, unit_flags=33554432, unit_flags2=0, spell1=59622, spell2=61313, spell4=59196, spell5=59194, spell6=59193, VehicleId=277, RegenHealth=0, InhabitType=7, AIName='NullCreatureAI' WHERE entry=31407;
-- Alliance Bomber Seat (31408)
REPLACE INTO creature_template_addon VALUES (31408, 0, 0, 0, 0, 0, '59443');
UPDATE creature_template SET exp=2, npcflag=16777216, unit_class=8, unit_flags=33554432, unit_flags2=0, spell1=59059, spell4=59196, spell5=59194, spell6=59193, VehicleId=274, RegenHealth=0, InhabitType=7, AIName='NullCreatureAI' WHERE entry=31408;
-- Alliance Engineering Seat (31409)
UPDATE creature_template SET exp=2, npcflag=16777216, unit_class=1, unit_flags=33554432, spell1=59061, spell2=61093, spell4=59196, spell5=59194, spell6=59193, VehicleId=278, RegenHealth=0, InhabitType=7, AIName='NullCreatureAI' WHERE entry=31409;
-- Banner Bunny, Hanging, Alliance (32217)
REPLACE INTO creature_template_addon VALUES (32217, 0, 0, 0, 0, 0, '60161');
UPDATE creature_template SET exp=2, unit_flags=33554432, RegenHealth=1, flags_extra=128, AIName='NullCreatureAI' WHERE entry=32217;
-- Banner Bunny, Side, Alliance (32221)
REPLACE INTO creature_template_addon VALUES (32221, 0, 0, 0, 0, 0, '60189');
UPDATE creature_template SET exp=2, unit_flags=33554432, RegenHealth=1, flags_extra=128, AIName='NullCreatureAI' WHERE entry=32221;
-- Alliance Bomber Pilot (32274)
UPDATE creature_template SET exp=2, unit_flags=33554432, RegenHealth=1, AIName='NullCreatureAI' WHERE entry=32274;

-- Horde Infra-green Bomber (31838), short
-- Horde Infra-green Bomber (32513), long
UPDATE creature_template SET exp=2, npcflag=16777216, speed_walk=1.2, speed_run=1.14286, VehicleId=287, InhabitType=4, RegenHealth=0, AIName='', ScriptName='npc_infra_green_bomber_generic' WHERE entry=31838;
UPDATE creature_template SET exp=2, npcflag=16777216, speed_walk=1.2, speed_run=1.14286, VehicleId=287, InhabitType=4, RegenHealth=0, AIName='', ScriptName='npc_infra_green_bomber_generic' WHERE entry=32513;
DELETE FROM npc_spellclick_spells WHERE npc_entry IN(31838, 32513);
INSERT INTO npc_spellclick_spells VALUES (31838, 46598, 1, 0);
INSERT INTO npc_spellclick_spells VALUES (32513, 46598, 1, 0);
DELETE FROM vehicle_template_accessory WHERE entry IN(31838, 32513);
INSERT INTO vehicle_template_accessory VALUES (31838, 31856, 0, 1, 'Horde Bomber Seat on Horde Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (31838, 31840, 1, 1, 'Horde Turret Seat on Horde Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (31838, 32152, 2, 1, 'Horde Engineering Seat on rides Horde Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (31838, 32214, 3, 1, 'Banner Bunny, Hanging, Horde on Horde Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (31838, 32215, 4, 1, 'Banner Bunny, Side, Horde on Horde Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (31838, 32215, 5, 1, 'Banner Bunny, Side, Horde on Horde Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (31838, 32256, 6, 1, 'Shield Visual Loc Bunny on Horde Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (31838, 32317, 7, 1, 'Horde Bomber Pilot rides Horde Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (32513, 31856, 0, 1, 'Horde Bomber Seat on Horde Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (32513, 31840, 1, 1, 'Horde Turret Seat on Horde Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (32513, 32152, 2, 1, 'Horde Engineering Seat on rides Horde Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (32513, 32214, 3, 1, 'Banner Bunny, Hanging, Horde on Horde Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (32513, 32215, 4, 1, 'Banner Bunny, Side, Horde on Horde Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (32513, 32215, 5, 1, 'Banner Bunny, Side, Horde on Horde Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (32513, 32256, 6, 1, 'Shield Visual Loc Bunny on Horde Infra-green Bomber', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (32513, 32317, 7, 1, 'Horde Bomber Pilot rides Horde Infra-green Bomber', 8, 0);
DELETE FROM waypoints WHERE entry=31838;
INSERT INTO waypoints VALUES (31838, 1, 7753.45, 2044.47, 592.04, 'Horde Infra-green Bomber - Short'),(31838, 2, 7766.17, 2004.16, 575.364, 'Horde Infra-green Bomber - Short'),(31838, 3, 7804.4, 1951.74, 549.136, 'Horde Infra-green Bomber - Short'),(31838, 4, 7825.09, 1928.68, 532.879, 'Horde Infra-green Bomber - Short'),(31838, 5, 7866.31, 1885.58, 496.232, 'Horde Infra-green Bomber - Short'),(31838, 6, 7895.59, 1845.43, 466.525, 'Horde Infra-green Bomber - Short'),(31838, 7, 7883.56, 1804.89, 449.938, 'Horde Infra-green Bomber - Short'),(31838, 8, 7837, 1801.84, 435.217, 'Horde Infra-green Bomber - Short'),(31838, 9, 7815.85, 1813.61, 431.672, 'Horde Infra-green Bomber - Short'),(31838, 10, 7772.53, 1841.07, 431.172, 'Horde Infra-green Bomber - Short'),(31838, 11, 7739.59, 1852.73, 430.873, 'Horde Infra-green Bomber - Short'),(31838, 12, 7701.6, 1856.26, 428.418, 'Horde Infra-green Bomber - Short'),(31838, 13, 7658.51, 1855.49, 430.772, 'Horde Infra-green Bomber - Short'),(31838, 14, 7634.45, 1847.34, 432.35, 'Horde Infra-green Bomber - Short'),
(31838, 15, 7587.81, 1815.65, 431.884, 'Horde Infra-green Bomber - Short'),(31838, 16, 7577.23, 1780.84, 425.398, 'Horde Infra-green Bomber - Short'),(31838, 17, 7588.97, 1748.31, 416.64, 'Horde Infra-green Bomber - Short'),(31838, 18, 7606.15, 1728.53, 411.093, 'Horde Infra-green Bomber - Short'),(31838, 19, 7635.87, 1700.63, 410.406, 'Horde Infra-green Bomber - Short'),(31838, 20, 7661.84, 1677.63, 415.037, 'Horde Infra-green Bomber - Short'),(31838, 21, 7683.93, 1657.1, 418.071, 'Horde Infra-green Bomber - Short'),(31838, 22, 7730.4, 1647.6, 420.767, 'Horde Infra-green Bomber - Short'),(31838, 23, 7760.93, 1663.64, 426.739, 'Horde Infra-green Bomber - Short'),(31838, 24, 7817.86, 1688.59, 436.1, 'Horde Infra-green Bomber - Short'),(31838, 25, 7857.05, 1734.45, 413.059, 'Horde Infra-green Bomber - Short'),(31838, 26, 7865.85, 1752.09, 411.13, 'Horde Infra-green Bomber - Short'),(31838, 27, 7873.44, 1803.01, 416.629, 'Horde Infra-green Bomber - Short'),(31838, 28, 7853.76, 1838.35, 425.217, 'Horde Infra-green Bomber - Short'),
(31838, 29, 7816.59, 1856.3, 430.695, 'Horde Infra-green Bomber - Short'),(31838, 30, 7778.95, 1853.29, 432.243, 'Horde Infra-green Bomber - Short'),(31838, 31, 7750.59, 1828.18, 431.892, 'Horde Infra-green Bomber - Short'),(31838, 32, 7735.12, 1799.6, 429.134, 'Horde Infra-green Bomber - Short'),(31838, 33, 7720.96, 1767.72, 426.263, 'Horde Infra-green Bomber - Short'),(31838, 34, 7709.29, 1745.03, 423.882, 'Horde Infra-green Bomber - Short'),(31838, 35, 7687.72, 1717.87, 419.22, 'Horde Infra-green Bomber - Short'),(31838, 36, 7663.97, 1692.6, 414.53, 'Horde Infra-green Bomber - Short'),(31838, 37, 7639.08, 1668.44, 409.85, 'Horde Infra-green Bomber - Short'),(31838, 38, 7606.57, 1637.13, 404.108, 'Horde Infra-green Bomber - Short'),(31838, 39, 7614.29, 1603.57, 397.91, 'Horde Infra-green Bomber - Short'),(31838, 40, 7624.51, 1570.93, 390.542, 'Horde Infra-green Bomber - Short'),(31838, 41, 7634.43, 1530.19, 382.105, 'Horde Infra-green Bomber - Short'),
(31838, 42, 7613.33, 1494.48, 381.294, 'Horde Infra-green Bomber - Short'),(31838, 43, 7584.1, 1491.31, 387.931, 'Horde Infra-green Bomber - Short'),(31838, 44, 7555.27, 1497.66, 401.862, 'Horde Infra-green Bomber - Short'),(31838, 45, 7523.53, 1511.46, 421.102, 'Horde Infra-green Bomber - Short'),(31838, 46, 7489.08, 1510.24, 431.514, 'Horde Infra-green Bomber - Short'),(31838, 47, 7477.76, 1486.37, 435.962, 'Horde Infra-green Bomber - Short'),(31838, 48, 7498.74, 1445.82, 440.44, 'Horde Infra-green Bomber - Short'),(31838, 49, 7532.11, 1412.9, 448.849, 'Horde Infra-green Bomber - Short'),(31838, 50, 7563.08, 1404.79, 453.795, 'Horde Infra-green Bomber - Short'),(31838, 51, 7601.4, 1415.79, 458.653, 'Horde Infra-green Bomber - Short'),(31838, 52, 7626.93, 1435.78, 461.89, 'Horde Infra-green Bomber - Short'),(31838, 53, 7641.68, 1453.63, 464.418, 'Horde Infra-green Bomber - Short'),(31838, 54, 7660.38, 1501.85, 472.969, 'Horde Infra-green Bomber - Short'),(31838, 55, 7668.88, 1535.63, 476.438, 'Horde Infra-green Bomber - Short'),(31838, 56, 7676.59, 1569.65, 479.256, 'Horde Infra-green Bomber - Short'),(31838, 57, 7685.44, 1599.73, 482.085, 'Horde Infra-green Bomber - Short'),
(31838, 58, 7698.4, 1631.93, 486.528, 'Horde Infra-green Bomber - Short'),(31838, 59, 7713.19, 1663.23, 491.681, 'Horde Infra-green Bomber - Short'),(31838, 60, 7743.51, 1725.39, 502.409, 'Horde Infra-green Bomber - Short'),(31838, 61, 7760.73, 1755.16, 508.887, 'Horde Infra-green Bomber - Short'),(31838, 62, 7777.56, 1785.01, 515.946, 'Horde Infra-green Bomber - Short'),(31838, 63, 7787.84, 1815.11, 522.388, 'Horde Infra-green Bomber - Short'),(31838, 64, 7788.78, 1851.14, 531.797, 'Horde Infra-green Bomber - Short'),(31838, 65, 7785.71, 1884.7, 541.23, 'Horde Infra-green Bomber - Short'),(31838, 66, 7783.92, 1918.17, 551.305, 'Horde Infra-green Bomber - Short'),(31838, 67, 7782.55, 1974.89, 569.197, 'Horde Infra-green Bomber - Short'),
(31838, 68, 7779.93, 2000.37, 585.416, 'Horde Infra-green Bomber - Short'),(31838, 69, 7887.33, 2057.64, 618.75, 'Horde Infra-green Bomber - Short');
DELETE FROM waypoints WHERE entry=32513;
INSERT INTO waypoints VALUES (32513, 1, 7740.12, 2037.47, 594.088, 'Horde Infra-green Bomber - Long'),(32513, 2, 7742.67, 2023.95, 583.412, 'Horde Infra-green Bomber - Long'),(32513, 3, 7740.06, 1991.28, 559.206, 'Horde Infra-green Bomber - Long'),(32513, 4, 7728.47, 1976.46, 540.522, 'Horde Infra-green Bomber - Long'),(32513, 5, 7710.74, 1968.24, 523.864, 'Horde Infra-green Bomber - Long'),(32513, 6, 7684.83, 1956.37, 503.568, 'Horde Infra-green Bomber - Long'),(32513, 7, 7633.76, 1925.8, 466.762, 'Horde Infra-green Bomber - Long'),(32513, 8, 7608.49, 1909.46, 448.915, 'Horde Infra-green Bomber - Long'),(32513, 9, 7583.64, 1878.65, 428.868, 'Horde Infra-green Bomber - Long'),(32513, 10, 7594.58, 1848.98, 417.143, 'Horde Infra-green Bomber - Long'),(32513, 11, 7623.07, 1838.43, 407.831, 'Horde Infra-green Bomber - Long'),(32513, 12, 7660.62, 1844.98, 397.19, 'Horde Infra-green Bomber - Long'),(32513, 13, 7678.44, 1849.78, 394.788, 'Horde Infra-green Bomber - Long'),(32513, 14, 7709.07, 1857.01, 393.746, 'Horde Infra-green Bomber - Long'),(32513, 15, 7736.76, 1861.04, 395.752, 'Horde Infra-green Bomber - Long'),(32513, 16, 7787.22, 1866.39, 403.213, 'Horde Infra-green Bomber - Long'),(32513, 17, 7837.2, 1851.71, 409.706, 'Horde Infra-green Bomber - Long'),(32513, 18, 7852.85, 1828.93, 411.219, 'Horde Infra-green Bomber - Long'),(32513, 19, 7853.23, 1800.17, 412.38, 'Horde Infra-green Bomber - Long'),
(32513, 20, 7829.07, 1770.52, 406.956, 'Horde Infra-green Bomber - Long'),(32513, 21, 7811.85, 1768.51, 404.165, 'Horde Infra-green Bomber - Long'),(32513, 22, 7799.06, 1768.1, 403.979, 'Horde Infra-green Bomber - Long'),(32513, 23, 7766.45, 1769.32, 405.503, 'Horde Infra-green Bomber - Long'),(32513, 24, 7731.83, 1774.18, 407.213, 'Horde Infra-green Bomber - Long'),(32513, 25, 7672.1, 1781.93, 409.652, 'Horde Infra-green Bomber - Long'),(32513, 26, 7636.9, 1764.66, 408.927, 'Horde Infra-green Bomber - Long'),(32513, 27, 7622.94, 1733.91, 407.852, 'Horde Infra-green Bomber - Long'),(32513, 28, 7637.13, 1701.48, 401.798, 'Horde Infra-green Bomber - Long'),(32513, 29, 7656.35, 1687.47, 392.133, 'Horde Infra-green Bomber - Long'),(32513, 30, 7683.72, 1664.33, 389.155, 'Horde Infra-green Bomber - Long'),(32513, 31, 7704.89, 1644.36, 391.315, 'Horde Infra-green Bomber - Long'),(32513, 32, 7723.43, 1616.93, 396.226, 'Horde Infra-green Bomber - Long'),(32513, 33, 7725.81, 1591.86, 400.687, 'Horde Infra-green Bomber - Long'),(32513, 34, 7715.29, 1556.66, 405.374, 'Horde Infra-green Bomber - Long'),(32513, 35, 7700.13, 1537.58, 406.834, 'Horde Infra-green Bomber - Long'),(32513, 36, 7669.18, 1514.83, 407.87, 'Horde Infra-green Bomber - Long'),(32513, 37, 7645.32, 1502.62, 408.244, 'Horde Infra-green Bomber - Long'),(32513, 38, 7597.58, 1487.31, 407.425, 'Horde Infra-green Bomber - Long'),
(32513, 39, 7563.26, 1480.56, 406.112, 'Horde Infra-green Bomber - Long'),(32513, 40, 7530.64, 1468.65, 404.426, 'Horde Infra-green Bomber - Long'),(32513, 41, 7509.13, 1449.03, 402.95, 'Horde Infra-green Bomber - Long'),(32513, 42, 7486.21, 1414.11, 401.32, 'Horde Infra-green Bomber - Long'),(32513, 43, 7477.96, 1391.06, 401.176, 'Horde Infra-green Bomber - Long'),(32513, 44, 7468.21, 1357.44, 401.054, 'Horde Infra-green Bomber - Long'),(32513, 45, 7454.79, 1315.26, 400.386, 'Horde Infra-green Bomber - Long'),(32513, 46, 7441.42, 1292.08, 399.426, 'Horde Infra-green Bomber - Long'),(32513, 47, 7413.4, 1266.08, 397.33, 'Horde Infra-green Bomber - Long'),(32513, 48, 7384.47, 1254.93, 393.811, 'Horde Infra-green Bomber - Long'),(32513, 49, 7352.79, 1259.18, 387.868, 'Horde Infra-green Bomber - Long'),(32513, 50, 7330.17, 1269.94, 382.371, 'Horde Infra-green Bomber - Long'),(32513, 51, 7313.91, 1280.48, 377.967, 'Horde Infra-green Bomber - Long'),(32513, 52, 7287.94, 1302.62, 370.212, 'Horde Infra-green Bomber - Long'),(32513, 53, 7247.12, 1334.65, 357.074, 'Horde Infra-green Bomber - Long'),(32513, 54, 7222.75, 1346.71, 350.44, 'Horde Infra-green Bomber - Long'),(32513, 55, 7191.05, 1359.21, 342.487, 'Horde Infra-green Bomber - Long'),(32513, 56, 7146.12, 1365.7, 334.615, 'Horde Infra-green Bomber - Long'),(32513, 57, 7118.05, 1354.57, 333.155, 'Horde Infra-green Bomber - Long'),
(32513, 58, 7095.1, 1336.85, 333.92, 'Horde Infra-green Bomber - Long'),(32513, 59, 7082.05, 1313.63, 335.456, 'Horde Infra-green Bomber - Long'),(32513, 60, 7081.52, 1280.37, 338.251, 'Horde Infra-green Bomber - Long'),(32513, 61, 7098.09, 1251.42, 340.588, 'Horde Infra-green Bomber - Long'),(32513, 62, 7115.06, 1235.56, 342.192, 'Horde Infra-green Bomber - Long'),(32513, 63, 7140.75, 1236.72, 344.987, 'Horde Infra-green Bomber - Long'),(32513, 64, 7147.52, 1246.17, 345.62, 'Horde Infra-green Bomber - Long'),(32513, 65, 7161.72, 1280.15, 359.42, 'Horde Infra-green Bomber - Long'),(32513, 66, 7182.57, 1286.26, 358.761, 'Horde Infra-green Bomber - Long'),(32513, 67, 7190.92, 1275.2, 359.311, 'Horde Infra-green Bomber - Long'),(32513, 68, 7202, 1246.16, 364.335, 'Horde Infra-green Bomber - Long'),(32513, 69, 7228.05, 1205.15, 374.81, 'Horde Infra-green Bomber - Long'),(32513, 70, 7257.44, 1201, 379.775, 'Horde Infra-green Bomber - Long'),(32513, 71, 7283.25, 1207.12, 383.432, 'Horde Infra-green Bomber - Long'),(32513, 72, 7313.53, 1231.6, 386.708, 'Horde Infra-green Bomber - Long'),(32513, 73, 7320.05, 1252.78, 386.454, 'Horde Infra-green Bomber - Long'),(32513, 74, 7325.5, 1287.34, 385.663, 'Horde Infra-green Bomber - Long'),(32513, 75, 7336.36, 1325.32, 386.77, 'Horde Infra-green Bomber - Long'),(32513, 76, 7358.37, 1348.92, 389.222, 'Horde Infra-green Bomber - Long'),
(32513, 77, 7377.21, 1357.82, 390.506, 'Horde Infra-green Bomber - Long'),(32513, 78, 7411, 1366.82, 391.944, 'Horde Infra-green Bomber - Long'),(32513, 79, 7478.71, 1383.7, 396.844, 'Horde Infra-green Bomber - Long'),(32513, 80, 7508.38, 1396.75, 399.75, 'Horde Infra-green Bomber - Long'),(32513, 81, 7549.64, 1435.9, 402.703, 'Horde Infra-green Bomber - Long'),(32513, 82, 7579.53, 1488.62, 405.454, 'Horde Infra-green Bomber - Long'),(32513, 83, 7594.04, 1530.21, 405.995, 'Horde Infra-green Bomber - Long'),(32513, 84, 7597.78, 1580.15, 406.863, 'Horde Infra-green Bomber - Long'),(32513, 85, 7599.84, 1629.51, 398.177, 'Horde Infra-green Bomber - Long'),(32513, 86, 7600.09, 1641.16, 397.327, 'Horde Infra-green Bomber - Long'),(32513, 87, 7601.76, 1706.16, 392.187, 'Horde Infra-green Bomber - Long'),(32513, 88, 7609.87, 1734.02, 391.214, 'Horde Infra-green Bomber - Long'),(32513, 89, 7629.48, 1766.95, 392.821, 'Horde Infra-green Bomber - Long'),(32513, 90, 7654.89, 1787.01, 394.78, 'Horde Infra-green Bomber - Long'),(32513, 91, 7687.36, 1798.35, 400.772, 'Horde Infra-green Bomber - Long'),(32513, 92, 7723.2, 1803.61, 409.558, 'Horde Infra-green Bomber - Long'),(32513, 93, 7739.02, 1803.96, 413.524, 'Horde Infra-green Bomber - Long'),(32513, 94, 7772.81, 1801.73, 422.254, 'Horde Infra-green Bomber - Long'),(32513, 95, 7806.51, 1798.3, 431.083, 'Horde Infra-green Bomber - Long'),
(32513, 96, 7839.75, 1795.2, 441.564, 'Horde Infra-green Bomber - Long'),(32513, 97, 7880.53, 1792.37, 458.585, 'Horde Infra-green Bomber - Long'),(32513, 98, 7915.31, 1795.76, 477.234, 'Horde Infra-green Bomber - Long'),(32513, 99, 7948.23, 1808.57, 499.45, 'Horde Infra-green Bomber - Long'),(32513, 100, 7966.47, 1831.04, 518.671, 'Horde Infra-green Bomber - Long'),(32513, 101, 7971.64, 1849.81, 531.481, 'Horde Infra-green Bomber - Long'),(32513, 102, 7972.72, 1865.6, 541.284, 'Horde Infra-green Bomber - Long'),(32513, 103, 7960.29, 1916.23, 549.119, 'Horde Infra-green Bomber - Long'),(32513, 104, 7938.55, 1934.97, 553.812, 'Horde Infra-green Bomber - Long'),(32513, 105, 7889.36, 1953.47, 563.336, 'Horde Infra-green Bomber - Long'),(32513, 106, 7855.36, 1959.24, 569.281, 'Horde Infra-green Bomber - Long'),(32513, 107, 7821.29, 1965.55, 574.228, 'Horde Infra-green Bomber - Long'),(32513, 108, 7812.15, 1967.28, 575.42, 'Horde Infra-green Bomber - Long'),
(32513, 109, 7774.67, 1986.76, 580.059, 'Horde Infra-green Bomber - Long'),(32513, 110, 7887.33, 2057.64, 618.75, 'Horde Infra-green Bomber - Long');
DELETE FROM npc_spellclick_spells WHERE npc_entry IN(31840, 31856, 32152);
INSERT INTO npc_spellclick_spells VALUES (31840, 59060, 1, 0);
INSERT INTO npc_spellclick_spells VALUES (31856, 59060, 1, 0);
INSERT INTO npc_spellclick_spells VALUES (32152, 59060, 1, 0);
-- Horde Turret Seat (31840)
REPLACE INTO creature_template_addon VALUES (31840, 0, 0, 0, 0, 0, '59458');
UPDATE creature_template SET exp=2, npcflag=16777216, unit_class=8, unit_flags=33554432, unit_flags2=0, spell1=59622, spell2=61313, spell4=59196, spell5=59194, spell6=59193, VehicleId=277, RegenHealth=0, InhabitType=7, AIName='NullCreatureAI' WHERE entry=31840;
-- Horde Bomber Seat (31856)
REPLACE INTO creature_template_addon VALUES (31856, 0, 0, 0, 0, 0, '59443');
UPDATE creature_template SET exp=2, npcflag=16777216, unit_class=8, unit_flags=33554432, unit_flags2=0, spell1=59059, spell4=59196, spell5=59194, spell6=59193, VehicleId=274, RegenHealth=0, InhabitType=7, AIName='NullCreatureAI' WHERE entry=31856;
-- Horde Engineering Seat (32152)
UPDATE creature_template SET exp=2, npcflag=16777216, unit_class=1, unit_flags=33554432, spell1=59061, spell2=61093, spell4=59196, spell5=59194, spell6=59193, VehicleId=278, RegenHealth=0, InhabitType=7, AIName='NullCreatureAI' WHERE entry=32152;
-- Banner Bunny, Hanging, Horde (32214)
REPLACE INTO creature_template_addon VALUES (32214, 0, 0, 0, 0, 0, '60070');
UPDATE creature_template SET exp=2, unit_flags=33554432, RegenHealth=0, flags_extra=128, AIName='NullCreatureAI' WHERE entry=32214;
-- Banner Bunny, Side, Horde (32215)
REPLACE INTO creature_template_addon VALUES (32215, 0, 0, 0, 0, 0, '60151');
UPDATE creature_template SET exp=2, unit_flags=33554432, RegenHealth=0, flags_extra=128, AIName='NullCreatureAI' WHERE entry=32215;
-- Horde Bomber Pilot (32317)
UPDATE creature_template SET exp=2, unit_flags=33554432, RegenHealth=1, AIName='NullCreatureAI' WHERE entry=32317;


-- Through the Eye (13121)
DELETE FROM creature_text WHERE entry IN(30835, 30836);
INSERT INTO creature_text VALUES(30835, 0, 0, 'Scrying upon many insignificant situations within Icecrown, you stumble upon something interesting...', 41, 0, 100, 0, 0, 0, 0, 'Through the Eye (13121)');
INSERT INTO creature_text VALUES(30835, 1, 0, 'My lady.', 12, 0, 100, 0, 0, 0, 0, 'Through the Eye (13121)');
INSERT INTO creature_text VALUES(30835, 2, 0, 'There is word from Jotunheim. The sleep-watchers there believe that they have found someone of significance.', 12, 0, 100, 0, 0, 0, 0, 'Through the Eye (13121)');
INSERT INTO creature_text VALUES(30835, 3, 0, 'Look like, my lady? A vrykul, I suppose. They did not actually show him to me. Ever since The Shadow Vault....', 12, 0, 100, 0, 0, 0, 0, 'Through the Eye (13121)');
INSERT INTO creature_text VALUES(30835, 4, 0, 'A name? Oh, yes, the name! I believe it was Iskalder.', 12, 0, 100, 0, 0, 0, 0, 'Through the Eye (13121)');
INSERT INTO creature_text VALUES(30835, 5, 0, 'Right away, my lady.', 12, 0, 100, 0, 0, 0, 0, 'Through the Eye (13121)');
INSERT INTO creature_text VALUES(30836, 0, 0, 'Report.', 12, 0, 100, 0, 0, 0, 0, 'Through the Eye (13121)');
INSERT INTO creature_text VALUES(30836, 1, 0, 'Describe this vrykul. What does he look like?', 12, 0, 100, 0, 0, 0, 0, 'Through the Eye (13121)');
INSERT INTO creature_text VALUES(30836, 2, 0, 'I am not interested in excuses. Perhaps they gave you a name?', 12, 0, 100, 0, 0, 0, 0, 'Through the Eye (13121)');
INSERT INTO creature_text VALUES(30836, 3, 0, 'Iskalder? You fool! Have you no idea who that is? He''s only the greatest vrykul warrior who ever lived!', 12, 0, 100, 0, 0, 0, 0, 'Through the Eye (13121)');
INSERT INTO creature_text VALUES(30836, 4, 0, 'Return to Jotunheim and tell them to keep him asleep until I arrive. I will judge this vrykul with my own eyes.', 12, 0, 100, 0, 0, 0, 0, 'Through the Eye (13121)');
DELETE FROM conditions WHERE SourceGroup=10005 AND SourceTypeOrReferenceId=15;
INSERT INTO conditions VALUES(15, 10005, 0, 0, 0, 9, 0, 13121, 0, 0, 0, 0, 0, "", "");
UPDATE gameobject_template SET AIName='SmartGameObjectAI' WHERE entry=192861;
DELETE FROM smart_scripts WHERE entryorguid IN (192861) AND source_type=1;
INSERT INTO smart_scripts VALUES (192861, 1, 0, 1, 62, 0, 100, 0, 10005, 0, 0, 0, 12, 30836, 3, 53000, 0, 0, 0, 8, 0, 0, 0, 6830.86, 3816.12, 621.07, 4.16, 'On gossip select - Summon Creature');
INSERT INTO smart_scripts VALUES (192861, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 12, 30835, 3, 53000, 0, 0, 0, 8, 0, 0, 0, 6825.43, 3807.28, 621.07, 1.00, 'Linked - Summon Creature');
INSERT INTO smart_scripts VALUES (192861, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Linked - Close gossip');
DELETE FROM conditions WHERE SourceEntry IN(192861) AND SourceTypeOrReferenceId=22;
INSERT INTO conditions VALUES(22, 1, 192861, 1, 0, 29, 0, 30835, 30, 0, 1, 0, 0, '', 'Only execute SAI if there is no npc near');
UPDATE creature_template SET unit_flags=2|256|512, minlevel=80, maxlevel=80, flags_extra=2, AIName='SmartAI' WHERE entry=30835;
UPDATE creature_template SET unit_flags=2, minlevel=80, maxlevel=80, AIName='NullCreatureAI' WHERE entry=30836;
DELETE FROM smart_scripts WHERE entryorguid IN(30835, 30836) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=30835*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (30835, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 80, 30835*100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On reset - Run Script');
INSERT INTO smart_scripts VALUES (30835*100, 9, 0, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - say text 0');
INSERT INTO smart_scripts VALUES (30835*100, 9, 1, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - say text 1');
INSERT INTO smart_scripts VALUES (30835*100, 9, 2, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 30836, 30, 0, 0, 0, 0, 0, 'Script9 - NPC 30836 say text 0');
INSERT INTO smart_scripts VALUES (30835*100, 9, 3, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - say text 2');
INSERT INTO smart_scripts VALUES (30835*100, 9, 4, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 30836, 30, 0, 0, 0, 0, 0, 'Script9 - NPC 30836 say text 1');
INSERT INTO smart_scripts VALUES (30835*100, 9, 5, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - say text 3');
INSERT INTO smart_scripts VALUES (30835*100, 9, 6, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 30836, 30, 0, 0, 0, 0, 0, 'Script9 - NPC 30836 say text 2');
INSERT INTO smart_scripts VALUES (30835*100, 9, 7, 0, 0, 0, 100, 0, 4500, 4500, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - say text 4');
INSERT INTO smart_scripts VALUES (30835*100, 9, 8, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 19, 30836, 30, 0, 0, 0, 0, 0, 'Script9 - NPC 30836 say text 3');
INSERT INTO smart_scripts VALUES (30835*100, 9, 9, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 19, 30836, 30, 0, 0, 0, 0, 0, 'Script9 - NPC 30836 say text 4');
INSERT INTO smart_scripts VALUES (30835*100, 9, 10, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - say text 5');
INSERT INTO smart_scripts VALUES (30835*100, 9, 11, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 33, 30750, 0, 0, 0, 0, 0, 18, 40, 0, 0, 0, 0, 0, 0, 'Script9 - Kill credit for players');
INSERT INTO smart_scripts VALUES (30835*100, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 6814.44, 3799.72, 621.07, 3.8, 'Script9 - Move to pos');

-- Find the Ancient Hero (13133)
UPDATE creature_template SET AIName='SmartAI', unit_flags=0 WHERE entry=30718;
DELETE FROM smart_scripts WHERE entryorguid IN(30718, 3088400, 3088401);
INSERT INTO smart_scripts VALUES (30718, 0, 0, 0, 62, 0, 100, 0, 10008, 0, 0, 0, 87, 3088400, 3088400, 3088400, 3088401, 3088400, 3088400, 1, 0, 0, 0, 0, 0, 0, 0, 'Slumbering Mjordin - Gossip - Random Script');
INSERT INTO smart_scripts VALUES (3088400, 9, 0, 0, 0, 0, 100, 0, 500, 500, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Slumbering Mjordin - Script - Enemy'); -- Option 1
INSERT INTO smart_scripts VALUES (3088400, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Slumbering Mjordin - Script - Aggresive');
INSERT INTO smart_scripts VALUES (3088401, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 30884, 3, 180000, 0, 0, 0, 1, 0, 0, 0, 0, 0,  0, 0, 'Slumbering Mjordin - Script - Summon Iskalder '); -- Option 2
INSERT INTO smart_scripts VALUES (3088401, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0,  0, 0, 'Slumbering Mjordin - Script - Unseen');
INSERT INTO smart_scripts VALUES (3088401, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0,  0, 0, 'Slumbering Mjordin - Script - Despawn');
UPDATE creature_template SET exp=2, faction=14, minlevel=80, maxlevel=80, mindmg=300, maxdmg=350, AIName='SmartAI' WHERE entry=30884;
DELETE FROM smart_scripts WHERE entryorguid=30884;
INSERT INTO smart_scripts VALUES (30884, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 1, 1, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Iskalder - On summon - Say text');
INSERT INTO smart_scripts VALUES (30884, 0, 1, 0, 8, 0, 100, 0, 3921, 0, 0, 0, 41, 5500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Iskalder - On hit by spell from amulet - Despawn');
UPDATE creature_template SET AIName='SmartAI' WHERE entry=30886;
DELETE FROM smart_scripts WHERE entryorguid=30886;
INSERT INTO smart_scripts VALUES (30886, 0, 0, 0, 25, 0, 100, 1, 0, 0, 0, 0, 18, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Friendly Iskalder - On IC - Change field flag to immune to npc/prevents from not moving bug/');
INSERT INTO smart_scripts VALUES (30886, 0, 1, 0, 1, 0, 100, 0, 2000, 3000, 2000, 3000, 29, 0, 0, 30232, 0, 1, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Friendly Iskalder - On OOC - Follow Bonnewitch if in range 10 yards');
INSERT INTO smart_scripts VALUES (30886, 0, 2, 3, 65, 0, 100, 0, 0, 0, 0, 0, 11, 25729, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Friendly Iskalder - On follow complete - Cast spell credit to player');
INSERT INTO smart_scripts VALUES (30886, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Friendly Iskalder - On follow complete - Force despawn');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=3921;
INSERT INTO conditions VALUES (17, 0, 3921, 0, 0, 31, 1, 3, 30884, 0, 0, 0, 0, '', 'Amulet can target only Iskalder');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=3921;
INSERT INTO conditions VALUES (13, 2, 3921, 0, 0, 31, 1, 3, 30884, 0, 0, 0, 0, '', 'The purple beam effect of amulet can target only Iskalder');
DELETE FROM creature_text WHERE entry=30884;
INSERT INTO creature_text VALUES (30884, 1, 1, 'You have found him! Now is the time to use the The Bone Witch"s Amulet!', 41, 0, 100, 0, 100, 0, 0, 'Originaly it as the Bonne witch guide');

-- Killing Two Scourge With One Skeleton (13144)
UPDATE creature_template SET AIName='SmartAI' WHERE entry=31048;
DELETE FROM smart_scripts WHERE entryorguid=31048 AND source_type=0;
INSERT INTO smart_scripts VALUES (31048, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 11, 58594, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Burning Skeleton - On Summon - cast Skeleton Check Master');
INSERT INTO smart_scripts VALUES (31048, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 33, 30995, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Burning Skeleton - On Death - give KillCredit for Abomition');
INSERT INTO smart_scripts VALUES (31048, 0, 2, 0, 31, 0, 100, 0, 58593, 0, 0, 0, 11, 58596, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Burning Skeleton - On Spell_Hit - cast Abomination Explosion');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=58593;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=58596 AND ElseGroup=1;
INSERT INTO conditions VALUES (13, 1, 58593, 0, 0, 31, 0, 3, 30689, 0, 0, 0, 0, '', 'Skeleton check - target abomination');
INSERT INTO conditions VALUES (13, 2, 58596, 0, 1, 31, 0, 3, 30689, 0, 0, 0, 0, '', 'Explosion - target abomination');

-- Banshee's Revenge (13142), missing scene
UPDATE creature_template SET faction=91, AIName='SmartAI' WHERE entry=31016;
DELETE FROM event_scripts WHERE id=20108;
INSERT INTO event_scripts VALUES (20108, 0, 10, 31016, 500000, 0, 7088.22, 4380.14, 872.267, 4.36759);
UPDATE gameobject_template SET data3=30000, CastBarCaption='Summoning' WHERE entry=193028;
DELETE FROM smart_scripts WHERE entryorguid=31016 AND source_type=0;
INSERT INTO smart_scripts VALUES (31016, 0, 0, 0, 0, 0, 100, 0, 15000, 15000, 30000, 30000, 11, 61076, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Whirlwind');
INSERT INTO smart_scripts VALUES (31016, 0, 1, 0, 0, 0, 100, 0, 2000, 2000, 8000, 8000, 11, 15043, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (31016, 0, 2, 0, 0, 0, 100, 0, 7000, 8000, 15000, 15000, 11, 61085, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Blizzard');
INSERT INTO smart_scripts VALUES (31016, 0, 3, 0, 9, 0, 100, 0, 8, 25, 10000, 10000, 11, 60108, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Range Update - Cast Heroic Leap');

-- Blinding the Eyes in the Sky (13313)
DELETE FROM creature WHERE id=32189 AND guid NOT IN(124087, 124088, 124089, 124090);
INSERT INTO creature VALUES (NULL, 32189, 571, 1, 1, 0, 0, 7713.82, 2284.39, 441.144, 1.24984, 300, 5, 0, 10635, 3561, 1, 0, 0, 0),(NULL, 32189, 571, 1, 1, 0, 0, 7502.25, 2298.9, 428.318, 2.85839, 300, 5, 0, 10635, 3561, 1, 0, 0, 0),(NULL, 32189, 571, 1, 1, 0, 0, 7618.74, 2205.38, 415.836, 0.379779, 300, 5, 0, 10635, 3561, 1, 0, 0, 0),(NULL, 32189, 571, 1, 1, 0, 0, 7617.82, 2290.9, 429.679, 2.1435, 300, 5, 0, 10635, 3561, 1, 0, 0, 0),(NULL, 32189, 571, 1, 1, 0, 0, 7821.71, 2479.6, 429.679, 0.082789, 300, 5, 0, 10635, 3561, 1, 0, 0, 0),
(NULL, 32189, 571, 1, 1, 0, 0, 7886.05, 2362.13, 422.18, 5.04045, 300, 5, 0, 10635, 3561, 1, 0, 0, 0),(NULL, 32189, 571, 1, 1, 0, 0, 7843.17, 2270.17, 422.18, 4.99485, 300, 5, 0, 10635, 3561, 1, 0, 0, 0),(NULL, 32189, 571, 1, 1, 0, 0, 7732.2, 2238.19, 444.663, 2.82047, 300, 5, 0, 10635, 3561, 1, 0, 0, 0),(NULL, 32189, 571, 1, 1, 0, 0, 7570.88, 2209.88, 428.318, 2.65187, 300, 5, 0, 10635, 3561, 1, 0, 0, 0),(NULL, 32189, 571, 1, 1, 0, 0, 7854.98, 2279.9, 442.383, 3.30234, 300, 5, 0, 10635, 3561, 1, 0, 0, 0),
(NULL, 32189, 571, 1, 1, 0, 0, 7736.85, 2191.07, 409.605, 0.954677, 300, 5, 0, 10635, 3561, 1, 0, 0, 0),(NULL, 32189, 571, 1, 1, 0, 0, 7752.41, 2148.94, 409.605, 0.506288, 300, 5, 0, 10635, 3561, 1, 0, 0, 0),(NULL, 32189, 571, 1, 1, 0, 0, 7779.72, 2195.55, 434.186, 0.555665, 300, 5, 0, 10635, 3561, 1, 0, 0, 0);
REPLACE INTO creature_template_addon VALUES(32189, 0, 0, 50331648, 0, 0, '');

-- Second Chances (12847)
DELETE FROM creature_text WHERE entry IN(29560, 29572);
INSERT INTO creature_text VALUES (29560, 0, 0, "Let's get this over with.", 12, 0, 100, 0, 0, 0, 0, 'Lord Arete');
INSERT INTO creature_text VALUES (29560, 1, 0, "Come, Landgren, cough up your soul so that I can ask you a very important question.", 12, 0, 100, 0, 0, 0, 0, 'Lord Arete');
INSERT INTO creature_text VALUES (29560, 2, 0, "YOU WILL TELL ME WHERE WESTWIND IS OR I WILL DESTROY YOUR SOUL!", 14, 0, 100, 0, 0, 0, 0, 'Lord Arete');
INSERT INTO creature_text VALUES (29560, 3, 0, "Then you leave me no choice. I won't say that I won't enjoy this.", 12, 0, 100, 0, 0, 0, 0, 'Lord Arete');
INSERT INTO creature_text VALUES (29560, 4, 0, "Very well. Tell me!", 12, 0, 100, 0, 0, 0, 0, 'Lord Arete');
INSERT INTO creature_text VALUES (29560, 5, 0, "A hidden hollow? How very interesting. You've served your purpose, Landgren, but I'm afraid there'll be no resurrection for you this time!", 12, 0, 100, 0, 0, 0, 0, 'Lord Arete');
INSERT INTO creature_text VALUES (29560, 6, 0, "Now that the unpleasantness is finished with, let's talk about you dealing with Grand Admiral Westwind.", 12, 0, 100, 0, 0, 0, 0, 'Lord Arete');
INSERT INTO creature_text VALUES (29572, 0, 0, "You'll get nothing out of me, monster. I am beyond your ability to influence.", 12, 0, 100, 0, 0, 0, 0, 'Landgren Soul');
INSERT INTO creature_text VALUES (29572, 1, 0, "No.", 12, 0, 100, 0, 0, 0, 0, 'Landgren Soul');
INSERT INTO creature_text VALUES (29572, 2, 0, "STOP! It isn't worth it. I'll tell you where he is.", 12, 0, 100, 0, 0, 0, 0, 'Landgren Soul');
INSERT INTO creature_text VALUES (29572, 3, 0, "On the south end of the island is a cave -- a hidden hollow. The grand admiral has holed himself up in there, preparing for the final battle against the Lich King.", 12, 0, 100, 0, 0, 0, 0, 'Landgren Soul');
INSERT INTO creature_text VALUES (29572, 4, 0, "AAAEEEEIIIiiiiiiiiiiiiiiiiiiiiiiiiiiii........................................", 14, 0, 100, 0, 0, 0, 0, 'Landgren Soul');
UPDATE gameobject_template SET AIName='SmartGameObjectAI' WHERE entry=191579;
DELETE FROM smart_scripts WHERE entryorguid=191579 AND source_type=1;
INSERT INTO smart_scripts VALUES (191579, 1, 0, 0, 60, 0, 100, 1, 3000, 3000, 0, 0, 11, 18280, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Update - cast spell');
INSERT INTO smart_scripts VALUES (191579, 1, 1, 0, 60, 0, 100, 1, 85000, 85000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Update - Despawn');
UPDATE creature_template SET AIName='', ScriptName='npc_lord_arete' WHERE entry=29560;
DELETE FROM smart_scripts WHERE entryorguid=29560 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=2956000 AND source_type=9;
UPDATE creature_template SET InhabitType=4, AIName='NullCreatureAI', ScriptName='' WHERE entry=29572;
DELETE FROM smart_scripts WHERE entryorguid=29572 AND source_type=0;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=26560;
INSERT INTO conditions VALUES (17, 0, 26560, 0, 0, 29, 0, 29560, 100, 0, 1, 0, 0, '', 'No Arete Near');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=22966;
INSERT INTO conditions VALUES (13, 1, 22966, 0, 0, 31, 0, 3, 29542, 0, 0, 0, 0, '', 'Soul Coax');
DELETE FROM spell_script_names WHERE ScriptName='spell_q12847_summon_soul_moveto_bunny' AND spell_id=12601;
DELETE FROM spell_linked_spell WHERE spell_trigger=26560;

-- Drag and Drop (13318)
-- Drag and Drop (13323)
-- Drag and Drop (13352)
-- Drag and Drop (13353)
DELETE FROM creature_text WHERE entry=32236;
INSERT INTO creature_text VALUES(32236, 0, 0, "Okay, who's the joker that threw an orb at me?", 12, 0, 100, 0, 0, 0, 0, 'Dark Subjugator female');
INSERT INTO creature_text VALUES(32236, 0, 1, "What?!", 12, 0, 100, 0, 0, 0, 0, 'Dark Subjugator female');
INSERT INTO creature_text VALUES(32236, 0, 2, "Wait a minute, I didn't activate my...?", 12, 0, 100, 0, 0, 0, 0, 'Dark Subjugator female');
INSERT INTO creature_text VALUES(32236, 0, 3, "I feel funny all of a sudden. Er?!", 12, 0, 100, 0, 0, 0, 0, 'Dark Subjugator female');
INSERT INTO creature_text VALUES(32236, 1, 0, "NOOOOOO!", 12, 0, 100, 0, 0, 0, 0, 'Dark Subjugator female');
INSERT INTO creature_text VALUES(32236, 1, 1, "Not a sentry!", 12, 0, 100, 0, 0, 0, 0, 'Dark Subjugator female');
INSERT INTO creature_text VALUES(32236, 2, 0, "It was an accident. I was framed. Don't drop me!", 12, 0, 100, 0, 0, 0, 0, 'Dark Subjugator female');
INSERT INTO creature_text VALUES(32236, 2, 1, "You've got it all wrong. I'm a subjugator!", 12, 0, 100, 0, 0, 0, 0, 'Dark Subjugator female');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=32236;
DELETE FROM smart_scripts WHERE entryorguid=32236 AND source_type=0;
INSERT INTO smart_scripts VALUES (32236, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set Faction');
INSERT INTO smart_scripts VALUES (32236, 0, 0, 1, 8, 0, 100, 0, 5513, 0, 0, 0, 33, 32229, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Kill Credit');
INSERT INTO smart_scripts VALUES (32236, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 11, 4329, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Cast Spell');
INSERT INTO smart_scripts VALUES (32236, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Talk');
INSERT INTO smart_scripts VALUES (32236, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Set Faction');
INSERT INTO smart_scripts VALUES (32236, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 12, 32292, 3, 20000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 15, 0, 'On Spell Hit - Summon Creature');
INSERT INTO smart_scripts VALUES (32236, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 20000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Force Despawn');
UPDATE creature_template SET VehicleId=0 WHERE entry=32323;
REPLACE INTO creature_template_addon VALUES(32292, 0, 0, 50331648, 0, 0, '');
UPDATE creature_template SET unit_flags=256, faction=14, VehicleId=113, InhabitType=4, AIName='SmartAI' WHERE entry=32292;
DELETE FROM smart_scripts WHERE entryorguid=32292 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=32292*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (32292, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set React State');
INSERT INTO smart_scripts VALUES (32292, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 60, 1, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set Fly');
INSERT INTO smart_scripts VALUES (32292, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 32292*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Script9');
INSERT INTO smart_scripts VALUES (32292*100, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (32292*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Move Point');
INSERT INTO smart_scripts VALUES (32292*100, 9, 2, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 86, 52391, 0, 23, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cross Cast Summoner on self');
INSERT INTO smart_scripts VALUES (32292*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 60, 1, 300, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Fly');
INSERT INTO smart_scripts VALUES (32292*100, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 7564, 1988, 530, 0, 'Script9 - Move Point');
INSERT INTO smart_scripts VALUES (32292*100, 9, 5, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove All Auras');
INSERT INTO smart_scripts VALUES (32292*100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');

-- Putting Olakin Back Together Again  (13220)
DELETE FROM gameobject WHERE id IN(193091, 193092);
INSERT INTO gameobject VALUES(NULL, 193091, 571, 1, 1, 6636.1, 3211.47, 668.52, 1.39995, 0, 0, 0.644197, 0.764859, 300, 0, 1, 0);
INSERT INTO gameobject VALUES(NULL, 193092, 571, 1, 1, 6598.86, 3145.67, 667.008, 4.00902, 0, 0, 0.907411, -0.420245, 300, 0, 1, 0);
DELETE FROM event_scripts WHERE id=20269;
INSERT INTO event_scripts VALUES(20269, 0, 10, 31235, 30000, 0, 6636.56, 3210.9, 668.56, 1.02);
INSERT INTO event_scripts VALUES(20269, 0, 8, 31235, 1, 0, 0, 0, 0, 0);

-- Vile Like Fire! (13071)
UPDATE creature_template SET npcflag=16777216, AIName='NullCreatureAI' WHERE entry=30272;
DELETE FROM npc_spellclick_spells WHERE npc_entry=30272;
INSERT INTO npc_spellclick_spells VALUES(30272, 57401, 1, 0);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=18 AND SourceGroup=30272;
INSERT INTO conditions VALUES(18, 30272, 57401, 0, 0, 9, 0, 13071, 0, 0, 0, 0, 0, '', 'Show spell click if player has quest 13071 active');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=16 AND SourceEntry=30564;
INSERT INTO conditions VALUES(16, 0, 30564, 0, 0, 23, 0, 4526, 0, 0, 0, 0, 0, '', 'Allowed to fly in 4526 area');
REPLACE INTO creature_template_addon VALUES(30564, 0, 0, 50331648, 0, 0, '');
UPDATE creature_template SET exp=2, minlevel=80, maxlevel=80, spell1=57493, spell3=7769, speed_run=2.2, InhabitType=4, AIName='', ScriptName='' WHERE entry=30564;
DELETE FROM smart_scripts WHERE entryorguid=30564 AND source_type=0;
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(30576, 30599);
DELETE FROM smart_scripts WHERE entryorguid IN(30576, 30599) AND source_type=0;
INSERT INTO smart_scripts VALUES (30599, 0, 0, 0, 38, 0, 100, 0, 1, 0, 0, 0, 11, 51195, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vile Like Fire! Fire Bunny - On Data Set - Cast Cosmetic - Low Poly Fire');
INSERT INTO smart_scripts VALUES (30576, 0, 0, 1, 8, 0, 100, 0, 7769, 0, 0, 0, 33, 30576, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Vile Like Fire! Fire Bunny - On Spell Hit - Kill Credit');
INSERT INTO smart_scripts VALUES (30576, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 11, 51195, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vile Like Fire! Fire Bunny - On Spell Hit - Cast Cosmetic - Low Poly Fire');
INSERT INTO smart_scripts VALUES (30576, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 11, 30599, 20, 0, 0, 0, 0, 0, 'Vile Like Fire! Fire Bunny - On Spell Hit - Set Data');
INSERT INTO smart_scripts VALUES (30576, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 60000, 60000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Vile Like Fire! Fire Bunny - On Spell Hit - Create Timed Event');
INSERT INTO smart_scripts VALUES (30576, 0, 4, 5, 59, 0, 100, 0, 1, 0, 0, 0, 28, 51195, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vile Like Fire! Fire Bunny - On Timed Event - Remove Aura');
INSERT INTO smart_scripts VALUES (30576, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 28, 51195, 0, 0, 0, 0, 0, 11, 30599, 20, 0, 0, 0, 0, 0, 'Vile Like Fire! Fire Bunny - On Timed Event - Remove Aura');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=30576;
INSERT INTO conditions VALUES (22, 1, 30576, 0, 0, 1, 1, 51195, 0, 0, 1, 0, 0, '', 'Run Action if aura is not present');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=7769;
INSERT INTO conditions VALUES (13, 1, 7769, 0, 0, 31, 0, 3, 30576, 0, 0, 0, 0, '', 'Fire Building');

-- I'm Not Dead Yet! (13229)
-- I'm Not Dead Yet! (13221)
DELETE FROM creature_text WHERE entry=31279;
INSERT INTO creature_text VALUES(31279, 0, 0, "I've had my fill of this place. Let us depart.", 12, 0, 100, 0, 0, 0, 0, 'Father Kamaros');
INSERT INTO creature_text VALUES(31279, 1, 0, "Face your judgment by the Light!", 12, 0, 100, 0, 0, 0, 0, 'Father Kamaros');
INSERT INTO creature_text VALUES(31279, 1, 1, "The Argent Crusade never surrenders!", 12, 0, 100, 0, 0, 0, 0, 'Father Kamaros');
INSERT INTO creature_text VALUES(31279, 1, 2, "You must tell my brothers that I live.", 12, 0, 100, 0, 0, 0, 0, 'Father Kamaros');
INSERT INTO creature_text VALUES(31279, 1, 3, "You will never take me alive!", 12, 0, 100, 0, 0, 0, 0, 'Father Kamaros');
INSERT INTO creature_text VALUES(31279, 2, 0, "The Light's blessing be upon you for aiding me in my time of need, $N.", 12, 0, 100, 0, 0, 0, 0, 'Father Kamaros');
INSERT INTO creature_text VALUES(31279, 3, 0, "I have you to thank for my life. I will return to my comrades and spread word of your bravery. Fight the Scourge with all the strength you can muster, and we will be by your side.", 12, 0, 100, 0, 0, 0, 0, 'Father Kamaros');
UPDATE creature_template SET speed_walk=1.5, AIName='SmartAI' WHERE entry=31279;
DELETE FROM smart_scripts WHERE entryorguid=31279 AND source_type=0;
INSERT INTO smart_scripts VALUES(31279, 0, 0, 2, 19, 0, 100, 0, 13221, 0, 0, 0, 53, 0, 31279, 0, 13221, 0, 1, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Start WP');
INSERT INTO smart_scripts VALUES(31279, 0, 1, 2, 19, 0, 100, 0, 13229, 0, 0, 0, 53, 0, 31279, 0, 13229, 0, 1, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Start WP');
INSERT INTO smart_scripts VALUES(31279, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Talk');
INSERT INTO smart_scripts VALUES(31279, 0, 3, 4, 4, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Aggro - Talk');
INSERT INTO smart_scripts VALUES(31279, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 32595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Aggro - Cast Spell');
INSERT INTO smart_scripts VALUES(31279, 0, 5, 0, 0, 0, 100, 0, 1000, 1000, 2500, 2500, 11, 25054, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'On IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES(31279, 0, 6, 0, 0, 0, 100, 0, 0, 0, 12000, 12000, 11, 17146, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'On IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES(31279, 0, 7, 0, 0, 0, 100, 0, 15000, 15000, 15000, 15000, 11, 32595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES(31279, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Disable Combat Movement');
INSERT INTO smart_scripts VALUES(31279, 0, 9, 10, 40, 0, 100, 0, 24, 0, 0, 0, 1, 2, 8000, 0, 0, 0, 0, 12, 0xFFFFFF, 0, 0, 0, 0, 0, 0, 'On WP Reach - Talk');
INSERT INTO smart_scripts VALUES(31279, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 12000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Despawn');
INSERT INTO smart_scripts VALUES(31279, 0, 11, 0, 52, 0, 100, 0, 2, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Text Over - Talk');
DELETE FROM waypoints WHERE entry=31279;
INSERT INTO waypoints VALUES (31279, 1, 6718.19, 3446.39, 683.009, 'Father Kamaros'),(31279, 2, 6718.66, 3433.51, 682.197, 'Father Kamaros'),(31279, 3, 6727.97, 3433.36, 682.197, 'Father Kamaros'),(31279, 4, 6733.6, 3434.78, 682.077, 'Father Kamaros'),(31279, 5, 6743.57, 3444.41, 679.522, 'Father Kamaros'),(31279, 6, 6756.96, 3457.35, 675.294, 'Father Kamaros'),(31279, 7, 6772.01, 3471.9, 672.996, 'Father Kamaros'),(31279, 8, 6780.91, 3482.22, 673.676, 'Father Kamaros'),(31279, 9, 6787.95, 3482.83, 675.954, 'Father Kamaros'),(31279, 10, 6799.88, 3483.86, 679.676, 'Father Kamaros'),(31279, 11, 6815.02, 3481.96, 685.798, 'Father Kamaros'),(31279, 12, 6834.46, 3479.52, 690.412, 'Father Kamaros'),(31279, 13, 6855.22, 3476.92, 693.003, 'Father Kamaros'),(31279, 14, 6868.37, 3478.1, 694.185, 'Father Kamaros'),
(31279, 15, 6884.62, 3479.55, 696.186, 'Father Kamaros'),(31279, 16, 6908.83, 3479.78, 700.914, 'Father Kamaros'),(31279, 17, 6933.08, 3477.59, 706.439, 'Father Kamaros'),(31279, 18, 6952.38, 3473.44, 709.679, 'Father Kamaros'),(31279, 19, 6967.23, 3470.25, 710.385, 'Father Kamaros'),(31279, 20, 6971.81, 3469.26, 710.858, 'Father Kamaros'),(31279, 21, 6979.88, 3467.53, 710.857, 'Father Kamaros'),(31279, 22, 7007.67, 3456.89, 696.793, 'Father Kamaros'),(31279, 23, 7019.69, 3452.28, 696.654, 'Father Kamaros'),(31279, 24, 7041.24, 3438.29, 695.568, 'Father Kamaros');

-- The Admiral Revealed (12852)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=20211;
INSERT INTO conditions VALUES (17, 0, 20211, 0, 0, 31, 1, 3, 29621, 0, 0, 0, 0, '', 'Target Grand Admiral Westwind');
INSERT INTO conditions VALUES (17, 0, 20211, 0, 0, 1, 1, 50161, 0, 0, 0, 0, 0, '', 'Target Must have aura 50161');
DELETE FROM creature_text WHERE entry IN(29620, 29621);
INSERT INTO creature_text VALUES(29621, 0, 0, 'How did you find me? Did Landgren tell?', 12, 0, 100, 0, 0, 0, 0, 'Grand Admiral Westwind');
INSERT INTO creature_text VALUES(29621, 1, 0, 'You thought I would just let you kill me?', 12, 0, 100, 0, 0, 0, 0, 'Grand Admiral Westwind');
INSERT INTO creature_text VALUES(29621, 2, 0, "WHAT?! No matter. Even without my sphere, I will crush you! Behold my true identity and despair!", 14, 0, 100, 0, 0, 0, 0, 'Grand Admiral Westwind');
INSERT INTO creature_text VALUES(29620, 0, 0, "Gah! I spent too much time in that weak little shell.", 14, 0, 100, 0, 0, 0, 0, "Dreadlord Mal'Ganis");
INSERT INTO creature_text VALUES(29620, 1, 0, "Kirel narak! I am Mal'Ganis. I AM ETERNAL!", 14, 0, 100, 0, 0, 0, 0, "Dreadlord Mal'Ganis");
INSERT INTO creature_text VALUES(29620, 2, 0, "Anach kyree!", 14, 0, 100, 0, 0, 0, 0, "Dreadlord Mal'Ganis");
INSERT INTO creature_text VALUES(29620, 2, 1, "My Onslaught will wash over the Lich King's forces!", 14, 0, 100, 0, 0, 0, 0, "Dreadlord Mal'Ganis");
INSERT INTO creature_text VALUES(29620, 2, 2, "Your death is in vain, tiny mortal.", 14, 0, 100, 0, 0, 0, 0, "Dreadlord Mal'Ganis");
INSERT INTO creature_text VALUES(29620, 2, 3, "Your time has come to an end.", 14, 0, 100, 0, 0, 0, 0, "Dreadlord Mal'Ganis");
INSERT INTO creature_text VALUES(29620, 3, 0, "ENOUGH! I waste my time here. I must gather my strength on the homeworld.", 14, 0, 100, 0, 0, 0, 0, "Dreadlord Mal'Ganis");
INSERT INTO creature_text VALUES(29620, 4, 0, "You'll never defeat the Lich King without my forces. I'll have my revenge... on him AND you!", 14, 0, 100, 0, 0, 0, 0, "Dreadlord Mal'Ganis");
UPDATE creature_template SET minlevel=82, maxlevel=82, faction=14, dmg_multiplier=20, AIName='SmartAI' WHERE entry IN(29620, 29621);
DELETE FROM smart_scripts WHERE entryorguid IN(29620, 29621) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=29621*100 AND source_type=9;
INSERT INTO smart_scripts VALUES(29621, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set Phase 1');
INSERT INTO smart_scripts VALUES(29621, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 36, 29621, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Update Entry');
INSERT INTO smart_scripts VALUES(29621, 0, 2, 30, 61, 0, 100, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set Invincibility HP Level');
INSERT INTO smart_scripts VALUES(29621, 0, 30, 0, 61, 0, 100, 0, 0, 0, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set Combat Move On');
INSERT INTO smart_scripts VALUES(29621, 0, 3, 0, 0, 1, 100, 0, 2000, 2000, 7000, 7000, 11, 57846, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'On IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES(29621, 0, 4, 0, 0, 1, 100, 0, 5000, 5000, 14000, 14000, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'On IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES(29621, 0, 5, 0, 0, 1, 100, 0, 9000, 9000, 18000, 18000, 11, 49807, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES(29621, 0, 6, 0, 0, 2, 100, 0, 6000, 6000, 7000, 7000, 11, 60500, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'On IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES(29621, 0, 7, 0, 0, 2, 100, 0, 9000, 9000, 18000, 18000, 11, 60502, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'On IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES(29621, 0, 8, 0, 0, 2, 100, 0, 13000, 13000, 14000, 14000, 11, 53045, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 'On IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES(29621, 0, 9, 0, 0, 2, 100, 0, 7000, 7000, 30000, 30000, 11, 60501, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES(29621, 0, 10, 0, 4, 1, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Aggro - Talk');
INSERT INTO smart_scripts VALUES(29621, 0, 11, 12, 2, 1, 100, 1, 0, 50, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On HP Update - Remove All Auras');
INSERT INTO smart_scripts VALUES(29621, 0, 12, 24, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On HP Update - Talk');
INSERT INTO smart_scripts VALUES(29621, 0, 24, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 50161, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On HP Update - Cast Spell');
INSERT INTO smart_scripts VALUES(29621, 0, 13, 14, 8, 0, 100, 0, 31699, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Talk');
INSERT INTO smart_scripts VALUES(29621, 0, 14, 15, 61, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Set Phase');
INSERT INTO smart_scripts VALUES(29621, 0, 15, 0, 61, 0, 100, 0, 0, 0, 0, 0, 28, 50161, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Remove Aura');
INSERT INTO smart_scripts VALUES(29621, 0, 16, 17, 0, 2, 100, 1, 4000, 4000, 0, 0, 36, 29620, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On IC Update - Update Entry');
INSERT INTO smart_scripts VALUES(29621, 0, 17, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On IC Update - Talk');
INSERT INTO smart_scripts VALUES(29621, 0, 18, 0, 2, 2, 100, 1, 0, 20, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On HP Update - Talk');
INSERT INTO smart_scripts VALUES(29621, 0, 19, 0, 5, 2, 100, 0, 5000, 5000, 1, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Kill - Talk');
INSERT INTO smart_scripts VALUES(29621, 0, 20, 21, 2, 2, 100, 1, 0, 2, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On HP Update - Talk');
INSERT INTO smart_scripts VALUES(29621, 0, 21, 22, 61, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On HP Update - Set Passive');
INSERT INTO smart_scripts VALUES(29621, 0, 22, 23, 61, 0, 100, 0, 0, 0, 0, 0, 22, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On HP Update - Set Phase');
INSERT INTO smart_scripts VALUES(29621, 0, 23, 25, 61, 0, 100, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On HP Update - Remove All Auras');
INSERT INTO smart_scripts VALUES(29621, 0, 25, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 29621*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On HP Update - Script9');
INSERT INTO smart_scripts VALUES(29621*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Combat Move');
INSERT INTO smart_scripts VALUES(29621*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 18, 512+256+2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Unit Flags');
INSERT INTO smart_scripts VALUES(29621*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES(29621*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 33, 29627, 0, 0, 0, 0, 0, 18, 50, 0, 0, 0, 0, 0, 0, 'Script9 - Kill Credit');
INSERT INTO smart_scripts VALUES(29621*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Despawn');
INSERT INTO smart_scripts VALUES(29621*100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 7494, 4871, -12.65, 1.3, 'Script9 - Move Pos');
INSERT INTO smart_scripts VALUES(29621*100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 29627, 3, 12000, 0, 0, 0, 8, 0, 0, 0, 7493, 4865, -12.47, 1.33, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES(29621*100, 9, 7, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1.3, 'Script9 - Set Orientation');
INSERT INTO smart_scripts VALUES(29621*100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1.3, 'Script9 - Talk');
REPLACE INTO creature_template_addon VALUES(29627, 0, 0, 0, 0, 0, '27731');
UPDATE creature_template SET AIName='NullCreatureAI' WHERE entry=29627;
DELETE FROM smart_scripts WHERE entryorguid=29627 AND source_type=0;

-- The Broken Front (13228)
UPDATE creature SET curhealth=126 WHERE id=31273;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=10036;
INSERT INTO conditions VALUES(15, 10036, 0, 0, 0, 9, 0, 13228, 0, 0, 0, 0, 0, '', 'Only show gossip option 0 if player has if player has quest 13228 active');
UPDATE creature_template SET gossip_menu_id=10036, flags_extra=64, AIName='SmartAI', ScriptName='' WHERE entry=31273;
DELETE FROM smart_scripts WHERE entryorguid=31273 AND source_type=0;
INSERT INTO smart_scripts VALUES (31273, 0, 0, 0, 62, 0, 100, 0, 10036, 0, 0, 0, 11, 58922, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Dying Berserker - On Gossip Hello - Cast kill credit on gossip select');
INSERT INTO smart_scripts VALUES (31273, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dying Berserker - On Reset - Set Reactstate Defensive');

-- Avenge Me! (13230)
-- Finish Me! (13232)
UPDATE creature SET curhealth=126 WHERE id=31304;
UPDATE quest_template SET PrevQuestId=0 WHERE Id=13230;
UPDATE quest_template SET PrevQuestId=0 WHERE Id=13232;
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(19, 20) AND SourceEntry IN(13230, 13232);
INSERT INTO conditions VALUES (19, 0, 13230, 0, 0, 28, 0, 13228, 0, 0, 0, 0, 0, '', 'Require Quest The Broken Front Complete');
INSERT INTO conditions VALUES (19, 0, 13230, 0, 1, 8, 0, 13228, 0, 0, 0, 0, 0, '', 'Require Quest The Broken Front Rewarded');
INSERT INTO conditions VALUES (20, 0, 13230, 0, 0, 28, 0, 13228, 0, 0, 0, 0, 0, '', 'Require Quest The Broken Front Complete');
INSERT INTO conditions VALUES (20, 0, 13230, 0, 1, 8, 0, 13228, 0, 0, 0, 0, 0, '', 'Require Quest The Broken Front Rewarded');
INSERT INTO conditions VALUES (19, 0, 13232, 0, 0, 28, 0, 13231, 0, 0, 0, 0, 0, '', 'Require Quest The Broken Front Complete');
INSERT INTO conditions VALUES (19, 0, 13232, 0, 1, 8, 0, 13231, 0, 0, 0, 0, 0, '', 'Require Quest The Broken Front Rewarded');
INSERT INTO conditions VALUES (20, 0, 13232, 0, 0, 28, 0, 13231, 0, 0, 0, 0, 0, '', 'Require Quest The Broken Front Complete');
INSERT INTO conditions VALUES (20, 0, 13232, 0, 1, 8, 0, 13231, 0, 0, 0, 0, 0, '', 'Require Quest The Broken Front Rewarded');
DELETE FROM gossip_menu_option WHERE menu_id=10040;
INSERT INTO gossip_menu_option VALUES (10040, 0, 0, 'Stay with me, friend. I must know what happened here.', 1, 1, 10041, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (10040, 1, 0, 'Travel well, hero of the Alliance!', 1, 1, 0, 0, 0, 0, '');
UPDATE creature_template SET gossip_menu_id=10040, flags_extra=64, AIName='SmartAI', ScriptName='' WHERE entry=31304;
DELETE FROM smart_scripts WHERE entryorguid=31304 AND source_type=0;
INSERT INTO smart_scripts VALUES (31304, 0, 0, 0, 62, 0, 100, 0, 10040, 0, 0, 0, 11, 58955, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Dying Soldier - On Gossip Option 0 Selected - Cast Alliance Quest Aura');
INSERT INTO smart_scripts VALUES (31304, 0, 1, 2, 62, 0, 100, 0, 10040, 1, 0, 0, 85, 59226, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dying Soldier - On Gossip Option 1 Selected - Invoker Cast Finish It');
INSERT INTO smart_scripts VALUES (31304, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Dying Soldier - On Gossip Option 1 Selected - Close Gossip');
INSERT INTO smart_scripts VALUES (31304, 0, 4, 5, 8, 0, 100, 0, 59226, 0, 0, 0, 11, 58955, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Dying Soldier - On Spell Hit - Cast Alliance Quest Aura');
INSERT INTO smart_scripts VALUES (31304, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 3240, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dying Soldier - On Spell Hit - Cast Bloody Explosion');
INSERT INTO smart_scripts VALUES (31304, 0, 6, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dying Soldier - On Reset - Set Reactstate Defensive');
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(14, 15) AND SourceGroup=10040;
INSERT INTO conditions VALUES (14, 10040, 13948, 0, 0, 14, 0, 13232, 0, 0, 0, 0, 0, '', 'Only show gossip text 13948 if player has quest 13232 Not Taken');
INSERT INTO conditions VALUES (14, 10040, 14035, 0, 0, 9, 0, 13232, 0, 0, 0, 0, 0, '', 'Only show gossip text 14035 if player has quest 13232 active');
INSERT INTO conditions VALUES (15, 10040, 0, 0, 0, 9, 0, 13231, 0, 0, 0, 0, 0, '', 'Only show gossip option 0 if player has if player has quest 13231 active');
INSERT INTO conditions VALUES (15, 10040, 1, 0, 0, 9, 0, 13232, 0, 0, 0, 0, 0, '', 'Only show gossip option 1 if player has if player has quest 13232 active');

-- Basic Chemistry (13279)
-- Basic Chemistry (13295)
-- Neutralizing the Plague (13297)
-- Neutralizing the Plague (13281)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=31773);
DELETE FROM creature WHERE id=31773;
INSERT INTO creature VALUES (NULL, 31773, 571, 1, 1, 0, 0, 6776.68, 1628.61, 391.945, 4.70842, 300, 0, 0, 4979, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 31773, 571, 1, 1, 0, 0, 6777.45, 1539.3, 391.944, 1.55506, 300, 0, 0, 4979, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 31773, 571, 1, 1, 0, 0, 6753.01, 1583.78, 394.549, 0.255223, 300, 0, 0, 4979, 0, 0, 0, 0, 0);
DELETE FROM gameobject WHERE id=193580;
INSERT INTO gameobject VALUES (NULL, 193580, 571, 1, 1, 6776.68, 1628.61, 391.945, 0, 0, 0, 0, 1, 25, 0, 1, 0);
INSERT INTO gameobject VALUES (NULL, 193580, 571, 1, 1, 6777.45, 1539.3, 391.944, 0, 0, 0, 0, 1, 25, 0, 1, 0);
INSERT INTO gameobject VALUES (NULL, 193580, 571, 1, 1, 6753.01, 1583.78, 394.549, 0, 0, 0, 0, 1, 25, 0, 1, 0);
UPDATE creature_template SET modelid1=27766, modelid2=0, AIName='SmartAI', InhabitType=4, flags_extra=130 WHERE entry=31773;
UPDATE creature_template SET mindmg=464, maxdmg=604, attackpower=708, dmg_multiplier=7.5, faction=14, minlevel=81, maxlevel=81, AIName='SmartAI' WHERE entry=32176;
UPDATE creature_template SET mindmg=422, maxdmg=586, attackpower=642, dmg_multiplier=7.5, faction=14, minlevel=80, maxlevel=80, AIName='SmartAI' WHERE entry=32178;
UPDATE creature_template SET mindmg=422, maxdmg=586, attackpower=642, dmg_multiplier=1, faction=14, minlevel=80, maxlevel=80, AIName='SmartAI' WHERE entry=32181;
DELETE FROM creature_text WHERE entry=31773;
INSERT INTO creature_text VALUES (31773, 0, 0, "The plague cauldron begins to boil vigorously!", 42, 0, 100, 0, 0, 0, 0, "Plague Cauldron");
INSERT INTO creature_text VALUES (31773, 1, 0, "Something emerges from the cauldron!", 42, 0, 100, 0, 0, 0, 0, "Plague Cauldron");
INSERT INTO creature_text VALUES (31773, 2, 0, "The cauldron continues to boil...", 42, 0, 100, 0, 0, 0, 0, "Plague Cauldron");
INSERT INTO creature_text VALUES (31773, 3, 0, "Plague batch neutralized!", 42, 0, 100, 0, 0, 0, 0, "Plague Cauldron");
INSERT INTO creature_text VALUES (31773, 4, 0, "Plague batch becomes unstable!", 42, 0, 100, 0, 0, 0, 0, "Plague Cauldron");
INSERT INTO creature_text VALUES (31773, 5, 0, "Neutralizing agent failing!", 42, 0, 100, 0, 0, 0, 0, "Plague Cauldron");
INSERT INTO creature_text VALUES (31773, 6, 0, "Add fluid soon!", 42, 0, 100, 0, 0, 0, 0, "Plague Cauldron");
INSERT INTO creature_text VALUES (31773, 7, 0, "Add fluid NOW!!", 42, 0, 100, 0, 0, 0, 0, "Plague Cauldron");
DELETE FROM smart_scripts WHERE entryorguid IN(31773, 32176, 32178, 32181) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(31773*100, 31773*100+1) AND source_type=9;
INSERT INTO smart_scripts VALUES(31773, 0, 0, 0, 8, 0, 100, 0, 59659, 0, 0, 0, 80, 31773*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Script9');
INSERT INTO smart_scripts VALUES(31773, 0, 1, 2, 8, 0, 100, 0, 59659, 0, 0, 0, 11, 59872, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Cast Spell');
INSERT INTO smart_scripts VALUES(31773, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 59878, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Cast Spell');
INSERT INTO smart_scripts VALUES(31773, 0, 3, 0, 60, 1, 100, 1, 0, 0, 0, 0, 80, 31773*100+1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Script9');
INSERT INTO smart_scripts VALUES(31773, 0, 4, 5, 8, 0, 100, 0, 59659, 0, 0, 0, 11, 59873, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Cast Spell');
INSERT INTO smart_scripts VALUES(31773, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Set Phase');
INSERT INTO smart_scripts VALUES(31773, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 74, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Remove Timed Event');
INSERT INTO smart_scripts VALUES(31773, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 74, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Remove Timed Event');
INSERT INTO smart_scripts VALUES(31773, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 45000, 45000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Create Timed Event');
INSERT INTO smart_scripts VALUES(31773, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 2, 60000, 60000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Create Timed Event');
INSERT INTO smart_scripts VALUES(31773, 0, 10, 11, 59, 0, 100, 0, 1, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Timed Event - Say Line 5');
INSERT INTO smart_scripts VALUES(31773, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Timed Event - Say Line 6');
INSERT INTO smart_scripts VALUES(31773, 0, 12, 13, 59, 0, 100, 0, 2, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Timed Event - Say Line 5');
INSERT INTO smart_scripts VALUES(31773, 0, 13, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Timed Event - Say Line 7');
INSERT INTO smart_scripts VALUES(31773*100, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES(31773*100, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES(31773*100, 9, 2, 0, 0, 0, 100, 0, 500, 500, 0, 0, 11, 60059, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(31773*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 32176, 4, 20000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1.5, 0, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES(31773*100, 9, 4, 0, 0, 0, 100, 0, 30000, 30000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES(31773*100, 9, 5, 0, 0, 0, 100, 0, 30000, 30000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES(31773*100, 9, 6, 0, 0, 0, 100, 0, 500, 500, 0, 0, 11, 60059, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(31773*100, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 32178, 4, 20000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1.5, 0, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES(31773*100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 32178, 4, 20000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1.5, 1, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES(31773*100, 9, 9, 0, 0, 0, 100, 0, 35000, 35000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES(31773*100, 9, 10, 0, 0, 0, 100, 0, 30000, 30000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES(31773*100, 9, 11, 0, 0, 0, 100, 0, 500, 500, 0, 0, 11, 60059, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(31773*100, 9, 12, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 11, 60058, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(31773*100, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 60058, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(31773*100, 9, 14, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 60058, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(31773*100, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 60058, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(31773*100, 9, 16, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 60058, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(31773*100, 9, 17, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 60058, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(31773*100, 9, 18, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 60058, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(31773*100, 9, 19, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 60058, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(31773*100, 9, 20, 0, 0, 0, 100, 0, 30000, 30000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES(31773*100, 9, 21, 0, 0, 0, 100, 0, 500, 500, 0, 0, 11, 60059, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(31773*100, 9, 22, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 32178, 4, 20000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1.5, 0, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES(31773*100, 9, 23, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 32178, 4, 20000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1.5, 1, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES(31773*100, 9, 24, 0, 0, 0, 100, 0, 30000, 30000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES(31773*100, 9, 25, 0, 0, 0, 100, 0, 500, 500, 0, 0, 11, 60059, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(31773*100, 9, 26, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 11, 60058, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(31773*100, 9, 27, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 60058, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(31773*100, 9, 28, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 60058, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(31773*100, 9, 29, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 60058, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(31773*100, 9, 30, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 60058, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(31773*100, 9, 31, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 60058, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(31773*100, 9, 32, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 60058, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(31773*100, 9, 33, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 60058, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(31773*100, 9, 34, 0, 0, 0, 100, 0, 30000, 30000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES(31773*100, 9, 35, 0, 0, 0, 100, 0, 500, 500, 0, 0, 11, 60059, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(31773*100, 9, 36, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 32176, 4, 20000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1.5, 0, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES(31773*100, 9, 37, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES(31773*100, 9, 38, 0, 0, 0, 100, 0, 500, 500, 0, 0, 11, 60059, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(31773*100, 9, 39, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 11, 60058, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(31773*100, 9, 40, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 60058, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(31773*100, 9, 41, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 60058, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(31773*100, 9, 42, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 60058, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(31773*100, 9, 43, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 32178, 4, 20000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1.5, 1, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES(31773*100, 9, 44, 0, 0, 0, 100, 0, 25000, 25000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES(31773*100, 9, 45, 0, 0, 0, 100, 0, 0, 0, 0, 0, 33, 31767, 0, 0, 0, 0, 0, 18, 50, 0, 0, 0, 0, 0, 0, 'Script9 - Kill Credit');
INSERT INTO smart_scripts VALUES(31773*100+1, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES(31773*100+1, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove All Auras');
INSERT INTO smart_scripts VALUES(31773*100+1, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Evade');
INSERT INTO smart_scripts VALUES(32176, 0, 0, 0, 60, 0, 100, 257, 100, 100, 0, 0, 148, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Plague Drenched Ghoul - On AI Init - No Environment Update');
INSERT INTO smart_scripts VALUES(32176, 0, 1, 0, 60, 0, 100, 257, 100, 100, 0, 0, 11, 66947, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Plague Drenched Ghoul - On Update - Cast Emerge');
INSERT INTO smart_scripts VALUES(32176, 0, 2, 0, 60, 0, 100, 1, 3800, 3800, 0, 0, 11, 50106, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Plague Drenched Ghoul - On Update - Cast Disease Cloud');
INSERT INTO smart_scripts VALUES(32176, 0, 3, 0, 60, 0, 100, 257, 3200, 3200, 0, 0, 11, 52690, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Plague Drenched Ghoul - On Update - Cast Ghoul Jump');
INSERT INTO smart_scripts VALUES(32176, 0, 4, 0, 60, 0, 100, 0, 3800, 3800, 4000, 4000, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Plague Drenched Ghoul - On Update - Attack Start');
INSERT INTO smart_scripts VALUES(32176, 0, 5, 0, 0, 0, 100, 0, 3800, 7000, 11000, 21000, 11, 60678, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Plague Drenched Ghoul - In Combat - Cast Plague Bite');
INSERT INTO smart_scripts VALUES(32176, 0, 6, 0, 1, 0, 100, 1, 10000, 10000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Plague Drenched Ghoul - Out of Combat - Despawn');
INSERT INTO smart_scripts VALUES(32178, 0, 0, 0, 60, 0, 100, 257, 100, 100, 0, 0, 148, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rampaging Ghoul - On AI Init - No Environment Update');
INSERT INTO smart_scripts VALUES(32178, 0, 1, 0, 60, 0, 100, 257, 100, 100, 0, 0, 11, 66947, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rampaging Ghoul - On Update - Cast Emerge');
INSERT INTO smart_scripts VALUES(32178, 0, 2, 0, 60, 0, 100, 257, 3200, 3200, 0, 0, 11, 52690, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rampaging Ghoul - On Update - Cast Ghoul Jump');
INSERT INTO smart_scripts VALUES(32178, 0, 3, 0, 60, 0, 100, 0, 3800, 3800, 4000, 4000, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Rampaging Ghoul - On Update - Attack Start');
INSERT INTO smart_scripts VALUES(32178, 0, 4, 0, 0, 0, 100, 0, 3800, 17000, 21000, 41000, 11, 6016, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rampaging Ghoul - In Combat - Cast Pierce Armor');
INSERT INTO smart_scripts VALUES(32178, 0, 5, 0, 1, 0, 100, 1, 10000, 10000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rampaging Ghoul - Out of Combat - Despawn');
INSERT INTO smart_scripts VALUES(32181, 0, 0, 0, 60, 0, 100, 0, 1500, 1500, 4000, 4000, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Living Plague - On Update - Attack Start');
INSERT INTO smart_scripts VALUES(32181, 0, 1, 0, 1, 0, 100, 0, 10000, 10000, 4000, 4000, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Living Plague - Out of Combat - Despawn');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=59655;
INSERT INTO conditions VALUES (13, 1, 59655, 0, 0, 31, 0, 3, 31773, 0, 0, 0, 0, '', 'Target Plague Cauldron');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=31773;
INSERT INTO conditions VALUES (22, 1, 31773, 0, 0, 1, 1, 59878, 0, 0, 1, 0, 0, '', 'Requires no aura to run event');
INSERT INTO conditions VALUES (22, 2, 31773, 0, 0, 1, 1, 59878, 0, 0, 1, 0, 0, '', 'Requires no aura to run event');
INSERT INTO conditions VALUES (22, 4, 31773, 0, 0, 1, 1, 59873, 0, 0, 1, 0, 0, '', 'Requires no aura to run event');

-- Matthias Lehner Quest Chain
-- First meeting, appears with quest A Voice in the Dark
DELETE FROM spell_area WHERE spell=49416 AND area=4615;
INSERT INTO spell_area VALUES(49416, 4615, 13271, 13282, 0, 690, 2, 1, 74, 11);
INSERT INTO spell_area VALUES(49416, 4615, 13390, 13282, 0, 1101, 2, 1, 74, 11);
REPLACE INTO creature_template_addon VALUES (31237, 0, 0, 0, 1, 0, '10848 49414');
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(31237));
DELETE FROM creature WHERE id=31237;
INSERT INTO creature VALUES (NULL, 31237, 571, 1, 1, 0, 0, 5792.52, 2069.49, -345.088, 2.28638, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
-- A Voice in the Dark (13271)
-- A Voice in the Dark (13390)
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=2, AIName='SmartAI' WHERE entry=31237;
UPDATE gameobject_template SET AIName='SmartGameObjectAI' WHERE entry=193195;
DELETE FROM smart_scripts WHERE entryorguid=31237 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=193195 AND source_type=1;
INSERT INTO smart_scripts VALUES (193195, 1, 0, 0, 19, 0, 100, 0, 13390, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 31237, 60, 0, 0, 0, 0, 0, 'Pulsing Crystal - On A Voice in the Dark (A) quest accept set data to Matthias Lehner');
INSERT INTO smart_scripts VALUES (193195, 1, 1, 0, 19, 0, 100, 0, 13271, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 31237, 60, 0, 0, 0, 0, 0, 'Pulsing Crystal - On A Voice in the Dark (H) quest accept set data to Matthias Lehner');
INSERT INTO smart_scripts VALUES (31237, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 21, 60, 0, 0, 0, 0, 0, 0, 'Matthias Lehner - On data set (quest accepted at Pulsing Crystal) say text 0');

-- Second phase, after quest Field Repairs reward
DELETE FROM spell_area WHERE spell=49416 AND area=4537;
INSERT INTO spell_area VALUES(49416, 4537, 13304, 13305, 0, 690, 2, 1, 64, 11);
INSERT INTO spell_area VALUES(49416, 4537, 13393, 13394, 0, 1101, 2, 1, 64, 11);
REPLACE INTO creature_template_addon VALUES (32408, 0, 0, 0, 1, 0, '10848 49414');
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(32408));
DELETE FROM creature WHERE id=32408;
INSERT INTO creature VALUES (NULL, 32408, 571, 1, 1, 0, 0, 7304.98, 1178.44, 323.646, 2.43472, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
-- Do Your Worst (13305)
-- Do Your Worst (13394)
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=2, AIName='SmartAI' WHERE entry=32408;
UPDATE creature_template SET spell1=59733, spell2=73740, spell3=59737 WHERE entry=31830;
DELETE FROM smart_scripts WHERE entryorguid=32408 AND source_type=0;
INSERT INTO smart_scripts VALUES (32408, 0, 0, 0, 19, 0, 100, 0, 13305, 0, 0, 0, 85, 59724, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Invoker Cast Summon Demolisher');
INSERT INTO smart_scripts VALUES (32408, 0, 1, 0, 19, 0, 100, 0, 13394, 0, 0, 0, 85, 59724, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Invoker Cast Summon Demolisher');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=16 AND SourceEntry=31830;
INSERT INTO conditions VALUES (16, 0, 31830, 0, 0, 23, 0, 4537, 0, 0, 0, 0, 0, '', 'Vehicle must be in area 4537');

-- Third phase, on quest Do Your Worst completion (not reward)
DELETE FROM spell_area WHERE spell=49416 AND area=4622;
INSERT INTO spell_area VALUES(49416, 4622, 13305, 13348, 0, 690, 2, 1, 66, 11);
INSERT INTO spell_area VALUES(49416, 4622, 13394, 13396, 0, 1101, 2, 1, 66, 11);
REPLACE INTO creature_template_addon VALUES (32404, 0, 0, 0, 1, 0, '10848 49414');
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(32404));
DELETE FROM creature WHERE id=32404;
INSERT INTO creature VALUES (NULL, 32404, 571, 1, 1, 0, 0, 7600.17, 1398.21, 333.4267, 1.31, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
-- Army of the Damned (13236)
-- Army of the Damned (13395)
DELETE FROM creature_text WHERE entry IN(31254, 32414);
INSERT INTO creature_text VALUES (32414, 0, 0, "You've come to address the men, sir?", 12, 0, 100, 0, 0, 0, 0, 'Lordaeron Captain');
INSERT INTO creature_text VALUES (31254, 0, 0, "Has Prince Arthas turned against us?", 12, 0, 100, 0, 0, 0, 0, 'Lordaeron Footsoldier');
INSERT INTO creature_text VALUES (31254, 0, 1, "Stand your ground, men!", 12, 0, 100, 0, 0, 0, 0, 'Lordaeron Footsoldier');
INSERT INTO creature_text VALUES (31254, 0, 2, "The rumors were true! The prince has gone mad!", 12, 0, 100, 0, 0, 0, 0, 'Lordaeron Footsoldier');
INSERT INTO creature_text VALUES (31254, 0, 3, "The undead are upon us!", 12, 0, 100, 0, 0, 0, 0, 'Lordaeron Footsoldier');
INSERT INTO creature_text VALUES (31254, 0, 4, "We make our stand here!", 12, 0, 100, 0, 0, 0, 0, 'Lordaeron Footsoldier');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=16 AND SourceEntry=31830;
INSERT INTO conditions VALUES (16, 0, 31830, 0, 0, 23, 0, 4622, 0, 0, 0, 0, 0, '', 'Vehicle must be in area 4622');
INSERT INTO conditions VALUES (16, 0, 31830, 0, 1, 23, 0, 4537, 0, 0, 0, 0, 0, '', 'Vehicle must be in area 4537');
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=2, npcflag=3, AIName='SmartAI' WHERE entry=32404;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=2, mindmg=391, maxdmg=585, attackpower=146, dmg_multiplier=7.5, unit_class=2, VehicleId=269, spell1=58912, spell2=58913, spell3=58916, spell4=58917, AIName='SmartAI' WHERE entry=31268; -- Prodigal Leader
UPDATE creature_template SET faction=2136, minlevel=80, maxlevel=80, exp=2, mindmg=420, maxdmg=630, attackpower=157, AIName='SmartAI' WHERE entry IN(31254, 32414); -- Lordaeron soldier
UPDATE creature_template SET faction=14, minlevel=80, maxlevel=80, exp=2, mindmg=420, maxdmg=630, attackpower=157, speed_walk=0.77777, dmg_multiplier=1.3, unit_flags=8, type_flags=4096, AIName='SmartAI' WHERE entry=31276; -- Ghoul minion
DELETE FROM smart_scripts WHERE entryorguid IN(32404, 31254, 32414, 31276) AND source_type=0;
INSERT INTO smart_scripts VALUES (32404, 0, 0, 4, 19, 0, 100, 0, 13236, 0, 0, 0, 11, 58989, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Cast Spell Prodigal Leader Force Cast');
INSERT INTO smart_scripts VALUES (32404, 0, 1, 4, 19, 0, 100, 0, 13395, 0, 0, 0, 11, 58989, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Cast Spell Prodigal Leader Force Cast');
INSERT INTO smart_scripts VALUES (32404, 0, 2, 3, 62, 0, 100, 0, 10226, 0, 0, 0, 11, 58989, 3, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Matthias Lehner - on gossip select - cast spell Prodigal Leader Force Cast');
INSERT INTO smart_scripts VALUES (32404, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Matthias Lehner - on gossip select - close gossip');
INSERT INTO smart_scripts VALUES (32404, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 44, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Linked - Set Ingame phase');
INSERT INTO smart_scripts VALUES (32404, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 32414, 50, 0, 0, 0, 0, 0, 'Linked - Set Data');
INSERT INTO smart_scripts VALUES (32404, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 44, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Linked - Set Ingame phase');
INSERT INTO smart_scripts VALUES (32414, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Set Phase');
INSERT INTO smart_scripts VALUES (32414, 0, 1, 2, 60, 1, 100, 0, 2500, 2500, 2500, 2500, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Talk');
INSERT INTO smart_scripts VALUES (32414, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Set Phase');
INSERT INTO smart_scripts VALUES (31254, 0, 0, 0, 4, 0, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Aggro - Talk');
INSERT INTO smart_scripts VALUES (31254, 0, 1, 0, 8, 0, 100, 1, 58916, 0, 0, 0, 85, 58915, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lordaeron Footsoldier - on spellhit Gift of the Lich King - invoker cast Gift of the Lich King');
INSERT INTO smart_scripts VALUES (31254, 0, 2, 3, 8, 0, 100, 1, 58915, 0, 0, 0, 33, 31329, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Lordaeron Footsoldier - on spellhit Gift of the Lich King - give killcredit');
INSERT INTO smart_scripts VALUES (31254, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lordaeron Footsoldier - on spellhit Gift of the Lich King - force despawn');
INSERT INTO smart_scripts VALUES (31254, 0, 4, 0, 4, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 31254, 10, 0, 0, 0, 0, 0, 'Lordaeron Footsoldier - on aggro - set data');
INSERT INTO smart_scripts VALUES (31254, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 31254, 10, 0, 0, 0, 0, 0, 'Lordaeron Footsoldier - on aggro - set data');
INSERT INTO smart_scripts VALUES (31254, 0, 6, 0, 38, 0, 100, 0, 1, 1, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 31268, 20, 0, 0, 0, 0, 0, 'Lordaeron Footsoldier - on data set - attack start');
INSERT INTO smart_scripts VALUES (31276, 0, 0, 0, 8, 0, 100, 1, 58917, 0, 0, 0, 85, 58919, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghoulish Minion - on spellhit Consume Minions - cast Consume Minions');
INSERT INTO smart_scripts VALUES (31276, 0, 1, 0, 60, 0, 100, 1, 0, 0, 0, 0, 11, 50142, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghoulish Minion - On AI Init - Cast Spell');
INSERT INTO smart_scripts VALUES (31276, 0, 2, 0, 60, 0, 100, 1, 4000, 4000, 0, 0, 89, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghoulish Minion - on Update - move random');
INSERT INTO smart_scripts VALUES (31276, 0, 3, 0, 60, 0, 100, 1, 4000, 4000, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 31254, 15, 0, 0, 0, 0, 0, 'Ghoulish Minion - on Update - attack start');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=10226;
INSERT INTO conditions VALUES (15, 10226, 0, 0, 0, 9, 0, 13236, 0, 0, 0, 0, 0, '', 'Show gossip only if on quest');
INSERT INTO conditions VALUES (15, 10226, 0, 0, 1, 9, 0, 13395, 0, 0, 0, 0, 0, '', 'Show gossip only if on quest');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(58912, 58916, 58917);
INSERT INTO conditions VALUES (13, 1, 58912, 0, 0, 31, 0, 3, 31254, 0, 0, 0, 0, '', 'Target Lordaeron Footsoldier');
INSERT INTO conditions VALUES (13, 1, 58917, 0, 0, 31, 0, 3, 31276, 0, 0, 0, 0, '', 'Target Ghoul Minion');
INSERT INTO conditions VALUES (13, 1, 58916, 0, 0, 31, 0, 3, 31254, 0, 0, 0, 0, '', 'Target Lordaeron Footsoldier');
INSERT INTO conditions VALUES (13, 1, 58916, 0, 0, 36, 0, 0, 0, 0, 1, 0, 0, '', 'Target must be dead');
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(31254, 32414));
DELETE FROM creature WHERE id IN(31254, 32414);
INSERT INTO creature VALUES (NULL, 32414, 571, 1, 2, 24768, 1, 7590.2, 1394.21, 332.658, 1.6, 180, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7607.47, 1359.98, 336.215, 2.07694, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7601.23, 1356.92, 335.296, 1.8675, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7597.87, 1354.71, 334.685, 1.76278, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7598.16, 1375.46, 334.371, 2.04204, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7614.95, 1359.27, 337.009, 2.23402, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7609.59, 1356.69, 336.257, 2.07694, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7603.68, 1353.31, 335.445, 1.90241, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7600.04, 1350.75, 334.945, 1.79769, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7617.08, 1355.11, 336.881, 2.21657, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7611.87, 1352.6, 336.418, 2.07694, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7606.25, 1349.91, 336.055, 1.93731, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7601.94, 1347.68, 335.545, 1.8326, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7618.95, 1352.03, 337.313, 2.19912, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7614.41, 1348.76, 337.183, 2.09439, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7609.11, 1346.25, 336.764, 1.95477, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7604.91, 1343.7, 336.298, 1.8675, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7598.78, 1325.95, 335.845, 1.69297, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7594.16, 1325.51, 335.156, 1.62316, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7598.02, 1318.95, 336.317, 1.67552, 60, 0, 0, 12600, 0, 0, 0, 0, 0), 
(NULL, 31254, 571, 1, 2, 24768, 1, 7592.37, 1318.07, 335.528, 1.58825, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7597.55, 1310.82, 337.134, 1.69297, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7592.33, 1310, 336.354, 1.62316, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7586.7, 1310.51, 335.366, 1.5708, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7597.62, 1305.04, 337.836, 1.69297, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7592.61, 1305.42, 336.907, 1.62316, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7587.98, 1306, 335.96, 1.5708, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7581.65, 1306.05, 334.874, 1.51844, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7575.08, 1306.44, 333.991, 1.43117, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7604.29, 1378.75, 334.867, 2.44346, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7608.23, 1378.98, 334.807, 2.56563, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7600.95, 1385.34, 334.186, 2.68781, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7622.68, 1358.64, 337.641, 2.35619, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7624.06, 1355.43, 337.972, 2.32129, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7621.07, 1362.55, 337.626, 2.3911, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7618.37, 1366.67, 337.358, 2.42601, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7593.25, 1372.03, 333.624, 1.71042, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7598.13, 1372.08, 334.469, 1.95477, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7588.84, 1367.32, 332.888, 1.51844, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7597.88, 1367.29, 334.593, 1.8675, 60, 0, 0, 12600, 0, 0, 0, 0, 0), 
(NULL, 31254, 571, 1, 2, 24768, 1, 7577.17, 1385.13, 331.072, 0.383972, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7573.42, 1379.31, 330.573, 0.575959, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7589.81, 1375.82, 333.15, 1.53589, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7593.27, 1375.51, 333.626, 1.74533, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7613.16, 1363.57, 336.909, 2.26893, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7572.89, 1341.37, 331.671, 1.23918, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7568.35, 1344.57, 330.561, 1.13446, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7563.99, 1349.03, 329.878, 1.01229, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7558.83, 1352.61, 329.015, 0.890118, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7555.55, 1355.55, 328.198, 0.785398, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7575.36, 1345.21, 331.734, 1.25664, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7571.02, 1348.64, 330.53, 1.15192, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7566.87, 1352.06, 329.68, 1.02974, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7562.09, 1356.33, 328.945, 0.890118, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7558.44, 1359.3, 328.263, 0.785398, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7588.17, 1325.12, 334.319, 1.55334, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7582.48, 1325.18, 333.568, 1.46608, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7577.1, 1325.81, 332.855, 1.37881, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7581.49, 1318.21, 334.011, 1.44862, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7576.25, 1318.98, 333.319, 1.37881, 60, 0, 0, 12600, 0, 0, 0, 0, 0), 
(NULL, 31254, 571, 1, 2, 24768, 1, 7587.73, 1318.6, 334.791, 1.53589, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7580.7, 1310.45, 334.473, 1.50098, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7575.55, 1310.4, 333.824, 1.43117, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7584.47, 1376.15, 332.536, 1.18682, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7580.12, 1376.35, 331.819, 0.942478, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7593.32, 1367.28, 333.729, 1.69297, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7589.11, 1367.38, 332.953, 1.51844, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7583.89, 1367.6, 331.913, 1.309, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7579.37, 1368.24, 331.306, 1.11701, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7589.3, 1371.93, 333.009, 1.51844, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7584.05, 1372.18, 332.269, 1.23918, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7579.46, 1372.12, 331.681, 1.0472, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7562.34, 1362.78, 329.004, 0.785398, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7566.39, 1359.59, 329.762, 0.925025, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7570.57, 1356.49, 330.507, 1.0472, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7574.74, 1352.34, 330.964, 1.18682, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7578.45, 1348.97, 331.624, 1.29154, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7566.08, 1366.8, 329.689, 0.785398, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7570.33, 1363.06, 330.55, 0.942478, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7574.28, 1359.97, 331.297, 1.09956, 60, 0, 0, 12600, 0, 0, 0, 0, 0), 
(NULL, 31254, 571, 1, 2, 24768, 1, 7578.25, 1356.31, 331.319, 1.23918, 60, 0, 0, 12600, 0, 0, 0, 0, 0),(NULL, 31254, 571, 1, 2, 24768, 1, 7581.29, 1353.31, 331.509, 1.3439, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
UPDATE gameobject SET phasemask=phasemask|2 WHERE map=571 AND position_x BETWEEN 7520 AND 7610 AND position_y BETWEEN 1270 AND 1444;

-- Fourth phase, on quest Futility reward
DELETE FROM spell_area WHERE spell=49416 AND area=4533;
INSERT INTO spell_area VALUES(49416, 4533, 13348, 13360, 0, 690, 2, 1, 64, 11);
INSERT INTO spell_area VALUES(49416, 4533, 13396, 13399, 0, 1101, 2, 1, 64, 11);
REPLACE INTO creature_template_addon VALUES(32423, 0, 0, 0, 1, 0, '10848 49414');
DELETE FROM creature WHERE id=32423;
INSERT INTO creature VALUES(NULL, 32423, 571, 1, 3, 0, 0, 7854.05, 957.014, 450.898, 0.628319, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
-- Where Dragons Fell (13359)
-- Where Dragons Fell (13398)
DELETE FROM creature_text WHERE entry=32443;
INSERT INTO creature_text VALUES (32443, 0, 0, "Rise, Sindragosa! Rise and lead the Frostbrood into war!", 12, 0, 100, 0, 0, 0, 0, 'The Lich King, Where Dragons Fell');
REPLACE INTO creature_template_addon VALUES (32446, 0, 0, 50331648, 0, 0, '');
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=2, AIName='SmartAI' WHERE entry=32423;
REPLACE INTO creature_equip_template VALUES(32443, 1, 0, 0, 2551, 0);
UPDATE creature_template SET unit_flags=768, flags_extra=2, AIName='SmartAI', ScriptName='' WHERE entry=32443;
UPDATE creature_template SET unit_flags=768, flags_extra=2, InhabitType=4, AIName='SmartAI', ScriptName='' WHERE entry=32446;
DELETE FROM smart_scripts WHERE entryorguid IN(32423, 32443, 32446) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=32443*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (32423, 0, 0, 0, 20, 0, 100, 0, 13359, 0, 0, 0, 12, 32443, 4, 26000, 0, 0, 0, 8, 0, 0, 0, 7868.56, 941.67, 451.76, 1.78, 'On Quest Complete - Summon Creature');
INSERT INTO smart_scripts VALUES (32423, 0, 1, 0, 20, 0, 100, 0, 13398, 0, 0, 0, 12, 32443, 4, 26000, 0, 0, 0, 8, 0, 0, 0, 7868.56, 941.67, 451.76, 1.78, 'On Quest Complete - Summon Creature');
INSERT INTO smart_scripts VALUES (32443, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set Walk');
INSERT INTO smart_scripts VALUES (32443, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 32443*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Script9');
INSERT INTO smart_scripts VALUES (32443*100, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 7862.13, 962.6, 450.4, 1.52, 'Script9 - Move To Pos');
INSERT INTO smart_scripts VALUES (32443*100, 9, 1, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (32443*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Bytes 0');
INSERT INTO smart_scripts VALUES (32443*100, 9, 3, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 12, 32446, 3, 30000, 0, 0, 0, 8, 0, 0, 0, 7840.35, 1030, 425, 5.26, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (32443*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 0, 0, 0, 0, 0, 0, 19, 32446, 150, 0, 7840.35, 1030, 510, 0, 'Script9 - Move To Pos Target');
INSERT INTO smart_scripts VALUES (32443*100, 9, 5, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 130, 0, 0, 0, 0, 0, 0, 19, 32446, 150, 0, 8029.14, 753.7, 545.3, 0, 'Script9 - Move To Pos Target');
INSERT INTO smart_scripts VALUES (32446, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 60, 1, 200, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set Fly');
INSERT INTO smart_scripts VALUES (32446, 0, 1, 0, 60, 0, 100, 0, 5000, 5000, 0, 0, 60, 1, 550, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Update - Set Fly');

-- Fifth phase, on quest Time for Answers accept
DELETE FROM spell_area WHERE spell=49416 AND area=4519;
INSERT INTO spell_area VALUES(49416, 4519, 13360, 13362, 0, 690, 2, 1, 74, 11);
INSERT INTO spell_area VALUES(49416, 4519, 13399, 13401, 0, 1101, 2, 1, 74, 11);
REPLACE INTO creature_template_addon VALUES(32497, 0, 0, 0, 1, 0, '10848 49414');
DELETE FROM creature WHERE id=32497;
INSERT INTO creature VALUES(NULL, 32497, 571, 1, 1, 0, 0, 6364.04, 2328.19, 473.02, 1.23306, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
-- The Hunter and the Prince (13400)
-- The Hunter and the Prince (13361)
REPLACE INTO spell_proc_event VALUES(60617, 0, 0, 0, 0, 0, 0, 32, 0, 100, 0);
DELETE FROM event_scripts WHERE id=20723;
REPLACE INTO creature_text VALUES (31395, 0, 0, "Prepare to die!", 12, 0, 100, 0, 0, 0, 0, 'Illidan Stormrage');
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=2, AIName='SmartAI' WHERE entry=32497;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=2, mindmg=400, maxdmg=600, unit_class=2, dmg_multiplier=7.5, spell1=60617, spell2=60644, spell3=60672, spell4=60642, VehicleId=269, AIName='SmartAI' WHERE entry=32326;
UPDATE creature_template SET faction=14, type_flags=0, minlevel=82, maxlevel=82, exp=0, mindmg=450, maxdmg=550, dmg_multiplier=7.5, baseattacktime=1000, rank=0, AIName='SmartAI' WHERE entry=31395;
DELETE FROM smart_scripts WHERE entryorguid IN(32497, 31395) AND source_type=0;
INSERT INTO smart_scripts VALUES (32497, 0, 0, 2, 19, 0, 100, 0, 13361, 0, 0, 0, 50, 194023, 50, 0, 0, 0, 0, 8, 0, 0, 0, 6335.5, 2347.8, 477.23, 3.4, 'On Quest Accept - Summon GO');
INSERT INTO smart_scripts VALUES (32497, 0, 1, 2, 19, 0, 100, 0, 13400, 0, 0, 0, 50, 194023, 50, 0, 0, 0, 0, 8, 0, 0, 0, 6335.5, 2347.8, 477.23, 3.4, 'On Quest Accept - Summon GO');
INSERT INTO smart_scripts VALUES (32497, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 12, 31395, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 6314.5, 2342.8, 479.4, 0.22, 'On Quest Accept - Summon Creature');
INSERT INTO smart_scripts VALUES (31395, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 44, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'AI Init - Set Phase Mask');
INSERT INTO smart_scripts VALUES (31395, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Aggro - Talk');
INSERT INTO smart_scripts VALUES (31395, 0, 2, 0, 0, 0, 100, 0, 7000, 7000, 25000, 25000, 11, 60744, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Immolation Aura');
INSERT INTO smart_scripts VALUES (31395, 0, 3, 0, 0, 0, 100, 1, 25000, 25000, 0, 0, 11, 61101, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Pierced Heart');
INSERT INTO smart_scripts VALUES (31395, 0, 4, 0, 0, 0, 100, 1, 15000, 15000, 25000, 25000, 11, 60742, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Shear');
INSERT INTO smart_scripts VALUES (31395, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 33, 32797, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Death - Kill Credit');
-- TC
DELETE FROM spell_script_names WHERE ScriptName='spell_q13400_illidan_kill_master' AND spell_id=61752;

-- Assault By Ground (13284)
DELETE FROM creature_text WHERE entry=31737;
INSERT INTO creature_text VALUES (31737, 0, 0, 'Ambush!', 14, 0, 100, 0, 0, 0, 0, 'Skybreaker Squad Leader');
INSERT INTO creature_text VALUES (31737, 0, 1, 'Group up!', 14, 0, 100, 0, 0, 0, 0, 'Skybreaker Squad Leader');
INSERT INTO creature_text VALUES (31737, 0, 2, 'Incoming!', 14, 0, 100, 0, 0, 0, 0, 'Skybreaker Squad Leader');
INSERT INTO creature_text VALUES (31737, 0, 3, 'On your feet, boys!', 14, 0, 100, 0, 0, 0, 0, 'Skybreaker Squad Leader');
INSERT INTO creature_text VALUES (31737, 0, 4, 'Vrykul attack!', 14, 0, 100, 0, 0, 0, 0, 'Skybreaker Squad Leader');
INSERT INTO creature_text VALUES (31737, 1, 0, 'Thanks for keeping us covered back there! We''ll hold the gate while we wait for reinforcements.', 12, 0, 100, 0, 0, 0, 0, 'Skybreaker Squad Leader');
INSERT INTO creature_text VALUES (31737, 2, 0, 'Alright boys, let''s do this!', 12, 0, 100, 0, 0, 0, 0, 'Skybreaker Squad Leader');
UPDATE creature_template SET AIName='SmartAI' WHERE entry=31737;
UPDATE creature_template SET AIName='SmartAI' WHERE entry=31701;
DELETE FROM smart_scripts WHERE entryorguid IN(31737, 31701) AND source_type=0;
INSERT INTO smart_scripts VALUES (31737, 0, 0, 1, 19, 0, 100, 0, 13284, 0, 0, 0, 53, 1, 31737, 0, 0, 5000, 2, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Start WP');
INSERT INTO smart_scripts VALUES (31737, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 124407, 31701, 0, 0, 0, 0, 0, 'On Quest Accept - Set Data');
INSERT INTO smart_scripts VALUES (31737, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 10, 124408, 31701, 0, 0, 0, 0, 0, 'On Quest Accept - Set Data');
INSERT INTO smart_scripts VALUES (31737, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 3, 0, 0, 0, 0, 10, 124409, 31701, 0, 0, 0, 0, 0, 'On Quest Accept - Set Data');
INSERT INTO smart_scripts VALUES (31737, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 4, 0, 0, 0, 0, 10, 124410, 31701, 0, 0, 0, 0, 0, 'On Quest Accept - Set Data');
INSERT INTO smart_scripts VALUES (31737, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 5, 0, 0, 0, 0, 10, 124411, 31701, 0, 0, 0, 0, 0, 'On Quest Accept - Set Data');
INSERT INTO smart_scripts VALUES (31737, 0, 6, 7, 40, 0, 100, 0, 42, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Talk');
INSERT INTO smart_scripts VALUES (31737, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 20, 0, 0, 0, 0, 11, 31701, 50, 0, 0, 0, 0, 0, 'On WP Reach - Set Data');
INSERT INTO smart_scripts VALUES (31737, 0, 8, 9, 40, 0, 100, 0, 14, 0, 0, 0, 12, 31746, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 7214, 1591.2, 380.7, 6.1, 'On WP Reach - Summon Creature');
INSERT INTO smart_scripts VALUES (31737, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 12, 31746, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 7225.5, 1603, 379.47, 3.8, 'On WP Reach - Summon Creature');
INSERT INTO smart_scripts VALUES (31737, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 12, 31746, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 7228.9, 1597.9, 380.28, 3.7, 'On WP Reach - Summon Creature');
INSERT INTO smart_scripts VALUES (31737, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 12, 31746, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 7235.4, 1599.8, 380.97, 3.4, 'On WP Reach - Summon Creature');
INSERT INTO smart_scripts VALUES (31737, 0, 12, 13, 40, 0, 100, 0, 26, 0, 0, 0, 12, 31746, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 7352, 1654.8, 432.78, 4.6, 'On WP Reach - Summon Creature');
INSERT INTO smart_scripts VALUES (31737, 0, 13, 14, 61, 0, 100, 0, 0, 0, 0, 0, 12, 31746, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 7343.97, 1656.06, 433.3, 4.5, 'On WP Reach - Summon Creature');
INSERT INTO smart_scripts VALUES (31737, 0, 14, 0, 61, 0, 100, 0, 0, 0, 0, 0, 12, 31746, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 7335.12, 1648.5, 431.61, 5.57, 'On WP Reach - Summon Creature');
INSERT INTO smart_scripts VALUES (31737, 0, 15, 0, 6, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 31701, 50, 0, 0, 0, 0, 0, 'On Death - Despawn Target');
INSERT INTO smart_scripts VALUES (31737, 0, 16, 0, 40, 0, 100, 0, 0, 0, 0, 0, 45, 1, 10, 0, 0, 0, 0, 11, 31701, 50, 0, 0, 0, 0, 0, 'On WP Reach - Set Data');
INSERT INTO smart_scripts VALUES (31737, 0, 17, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Aggro - Talk');
INSERT INTO smart_scripts VALUES (31737, 0, 20, 0, 40, 0, 100, 0, 3, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Talk');
DELETE FROM smart_scripts WHERE entryorguid=31701 AND source_type=0;
INSERT INTO smart_scripts VALUES (31701, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 29, 0, 1, 0, 0, 0, 0, 19, 31737, 30, 0, 0, 0, 0, 0, "On Data Set - Move Follow");
INSERT INTO smart_scripts VALUES (31701, 0, 1, 0, 38, 0, 100, 0, 1, 2, 0, 0, 29, 1, 0, 0, 0, 0, 0, 19, 31737, 30, 0, 0, 0, 0, 0, "On Data Set - Move Follow");
INSERT INTO smart_scripts VALUES (31701, 0, 2, 0, 38, 0, 100, 0, 1, 3, 0, 0, 29, 0, 5, 0, 0, 0, 0, 19, 31737, 30, 0, 0, 0, 0, 0, "On Data Set - Move Follow");
INSERT INTO smart_scripts VALUES (31701, 0, 3, 0, 38, 0, 100, 0, 1, 4, 0, 0, 29, 2, 0, 0, 0, 0, 0, 19, 31737, 30, 0, 0, 0, 0, 0, "On Data Set - Move Follow");
INSERT INTO smart_scripts VALUES (31701, 0, 4, 0, 38, 0, 100, 0, 1, 5, 0, 0, 29, 1, 5, 0, 0, 0, 0, 19, 31737, 30, 0, 0, 0, 0, 0, "On Data Set - Move Follow");
INSERT INTO smart_scripts VALUES (31701, 0, 5, 0, 38, 0, 100, 0, 1, 10, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Data Set - Set Home Pos");
INSERT INTO smart_scripts VALUES (31701, 0, 6, 7, 38, 0, 100, 0, 1, 20, 0, 0, 33, 31794, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, "On Data Set - Kill Credit");
INSERT INTO smart_scripts VALUES (31701, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Data Set - Despawn");
INSERT INTO smart_scripts VALUES (31701, 0, 8, 0, 0, 0, 100, 0, 3000, 3000, 6000, 6000, 11, 29426, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "IC Update - Cast Spell Heroic Strike");
DELETE FROM waypoints WHERE entry=31737;
INSERT INTO waypoints VALUES (31737, 1, 7267.47, 1513.11, 321.101, 'Skybreaker Squad Leader'),(31737, 2, 7262.08, 1522.13, 322.781, 'Skybreaker Squad Leader'),(31737, 3, 7258.2, 1528.03, 324.766, 'Skybreaker Squad Leader'),(31737, 4, 7258.9, 1536.19, 327.97, 'Skybreaker Squad Leader'),(31737, 5, 7259.69, 1545.47, 332.991, 'Skybreaker Squad Leader'),(31737, 6, 7261.28, 1552.23, 336.939, 'Skybreaker Squad Leader'),(31737, 7, 7262.56, 1560.25, 340.868, 'Skybreaker Squad Leader'),(31737, 8, 7261.44, 1569.5, 344.573, 'Skybreaker Squad Leader'),(31737, 9, 7256.04, 1577.16, 350.38, 'Skybreaker Squad Leader'),(31737, 10, 7245.87, 1583.33, 358.627, 'Skybreaker Squad Leader'),(31737, 11, 7235.4, 1582.46, 365.785, 'Skybreaker Squad Leader'),(31737, 12, 7227.5, 1580.62, 370.843, 'Skybreaker Squad Leader'),(31737, 13, 7223.12, 1584.65, 374.247, 'Skybreaker Squad Leader'),(31737, 14, 7220.19, 1589.6, 377.672, 'Skybreaker Squad Leader'),(31737, 15, 7221.28, 1597.79, 379.132, 'Skybreaker Squad Leader'),(31737, 16, 7231.53, 1599.71, 380.835, 'Skybreaker Squad Leader'),(31737, 17, 7244.61, 1604.73, 382.654, 'Skybreaker Squad Leader'),(31737, 18, 7254.52, 1610.92, 383.888, 'Skybreaker Squad Leader'),(31737, 19, 7263.68, 1612.56, 382.778, 'Skybreaker Squad Leader'),(31737, 20, 7276.39, 1611.02, 383.531, 'Skybreaker Squad Leader'),
(31737, 21, 7288.75, 1607.65, 389.084, 'Skybreaker Squad Leader'),(31737, 22, 7301.3, 1610.83, 396.176, 'Skybreaker Squad Leader'),(31737, 23, 7312.62, 1613.75, 401.043, 'Skybreaker Squad Leader'),(31737, 24, 7325.46, 1619.44, 408.955, 'Skybreaker Squad Leader'),(31737, 25, 7336.22, 1624.36, 416.786, 'Skybreaker Squad Leader'),(31737, 26, 7344.82, 1632.38, 425.037, 'Skybreaker Squad Leader'),(31737, 27, 7344.28, 1642.79, 429.96, 'Skybreaker Squad Leader'),(31737, 28, 7344.28, 1642.79, 429.96, 'Skybreaker Squad Leader'),(31737, 29, 7332.73, 1644.65, 431.505, 'Skybreaker Squad Leader'),(31737, 30, 7320.07, 1646.6, 432.943, 'Skybreaker Squad Leader'),(31737, 31, 7308.4, 1648.01, 433.642, 'Skybreaker Squad Leader'),(31737, 32, 7297.06, 1650.87, 434.887, 'Skybreaker Squad Leader'),(31737, 33, 7286.66, 1655.95, 435.096, 'Skybreaker Squad Leader'),(31737, 34, 7276.17, 1655.57, 434.651, 'Skybreaker Squad Leader'),(31737, 35, 7263.66, 1652.5, 434.152, 'Skybreaker Squad Leader'),(31737, 36, 7250.86, 1653.05, 434.345, 'Skybreaker Squad Leader'),(31737, 37, 7239.87, 1661.84, 439.529, 'Skybreaker Squad Leader'),(31737, 38, 7227.71, 1668.63, 447.967, 'Skybreaker Squad Leader'),(31737, 39, 7215.83, 1677.98, 458.037, 'Skybreaker Squad Leader'),(31737, 40, 7207.03, 1685.58, 464.554, 'Skybreaker Squad Leader'),(31737, 41, 7198.43, 1693.49, 469.207, 'Skybreaker Squad Leader'),(31737, 42, 7189.35, 1702.63, 473.235, 'Skybreaker Squad Leader');

-- Assault By Ground (13301)
DELETE FROM creature_text WHERE entry=31833;
INSERT INTO creature_text VALUES (31833, 0, 0, 'Ambush!', 14, 0, 100, 0, 0, 0, 0, 'Korkron Squad Leader');
INSERT INTO creature_text VALUES (31833, 0, 1, 'Group up!', 14, 0, 100, 0, 0, 0, 0, 'Korkron Squad Leader');
INSERT INTO creature_text VALUES (31833, 0, 2, 'Incoming!', 14, 0, 100, 0, 0, 0, 0, 'Korkron Squad Leader');
INSERT INTO creature_text VALUES (31833, 0, 3, 'On your feet, boys!', 14, 0, 100, 0, 0, 0, 0, 'Korkron Squad Leader');
INSERT INTO creature_text VALUES (31833, 0, 4, 'Vrykul attack!', 14, 0, 100, 0, 0, 0, 0, 'Korkron Squad Leader');
INSERT INTO creature_text VALUES (31833, 1, 0, 'You''ve got some fight in you! Blood and honor, friend!', 12, 0, 100, 0, 0, 0, 0, 'Korkron Squad Leader');
UPDATE creature_template SET AIName='SmartAI' WHERE entry=31833;
UPDATE creature_template SET AIName='SmartAI' WHERE entry=31832;
DELETE FROM smart_scripts WHERE entryorguid IN(31833, 31832) AND source_type=0;
INSERT INTO smart_scripts VALUES (31833, 0, 0, 1, 19, 0, 100, 0, 13301, 0, 0, 0, 53, 1, 31833, 0, 0, 5000, 2, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Start WP');
INSERT INTO smart_scripts VALUES (31833, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 122301, 31832, 0, 0, 0, 0, 0, 'On Quest Accept - Set Data');
INSERT INTO smart_scripts VALUES (31833, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 10, 122302, 31832, 0, 0, 0, 0, 0, 'On Quest Accept - Set Data');
INSERT INTO smart_scripts VALUES (31833, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 3, 0, 0, 0, 0, 10, 122303, 31832, 0, 0, 0, 0, 0, 'On Quest Accept - Set Data');
INSERT INTO smart_scripts VALUES (31833, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 4, 0, 0, 0, 0, 10, 122304, 31832, 0, 0, 0, 0, 0, 'On Quest Accept - Set Data');
INSERT INTO smart_scripts VALUES (31833, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 5, 0, 0, 0, 0, 10, 122305, 31832, 0, 0, 0, 0, 0, 'On Quest Accept - Set Data');
INSERT INTO smart_scripts VALUES (31833, 0, 6, 7, 40, 0, 100, 0, 30, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Talk');
INSERT INTO smart_scripts VALUES (31833, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 20, 0, 0, 0, 0, 11, 31832, 50, 0, 0, 0, 0, 0, 'On WP Reach - Set Data');
INSERT INTO smart_scripts VALUES (31833, 0, 8, 9, 40, 0, 100, 0, 8, 0, 0, 0, 12, 31746, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 7421.68, 1857.33, 412.63, 5.9, 'On WP Reach - Summon Creature');
INSERT INTO smart_scripts VALUES (31833, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 12, 31746, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 7416.69, 1851.82, 417.24, 5.89, 'On WP Reach - Summon Creature');
INSERT INTO smart_scripts VALUES (31833, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 12, 31746, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 7421.9, 1844.2, 415.36, 0.33, 'On WP Reach - Summon Creature');
INSERT INTO smart_scripts VALUES (31833, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 12, 31746, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 7426.77, 1847.52, 410.5, 0.0, 'On WP Reach - Summon Creature');
INSERT INTO smart_scripts VALUES (31833, 0, 12, 0, 6, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 31832, 50, 0, 0, 0, 0, 0, 'On Death - Despawn Target');
INSERT INTO smart_scripts VALUES (31833, 0, 13, 0, 40, 0, 100, 0, 0, 0, 0, 0, 45, 1, 10, 0, 0, 0, 0, 11, 31832, 50, 0, 0, 0, 0, 0, 'On WP Reach - Set Data');
INSERT INTO smart_scripts VALUES (31833, 0, 14, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Aggro - Talk');
DELETE FROM smart_scripts WHERE entryorguid=31832 AND source_type=0;
INSERT INTO smart_scripts VALUES (31832, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 29, 0, 1, 0, 0, 0, 0, 19, 31833, 30, 0, 0, 0, 0, 0, "On Data Set - Move Follow");
INSERT INTO smart_scripts VALUES (31832, 0, 1, 0, 38, 0, 100, 0, 1, 2, 0, 0, 29, 1, 0, 0, 0, 0, 0, 19, 31833, 30, 0, 0, 0, 0, 0, "On Data Set - Move Follow");
INSERT INTO smart_scripts VALUES (31832, 0, 2, 0, 38, 0, 100, 0, 1, 3, 0, 0, 29, 0, 5, 0, 0, 0, 0, 19, 31833, 30, 0, 0, 0, 0, 0, "On Data Set - Move Follow");
INSERT INTO smart_scripts VALUES (31832, 0, 3, 0, 38, 0, 100, 0, 1, 4, 0, 0, 29, 2, 0, 0, 0, 0, 0, 19, 31833, 30, 0, 0, 0, 0, 0, "On Data Set - Move Follow");
INSERT INTO smart_scripts VALUES (31832, 0, 4, 0, 38, 0, 100, 0, 1, 5, 0, 0, 29, 1, 5, 0, 0, 0, 0, 19, 31833, 30, 0, 0, 0, 0, 0, "On Data Set - Move Follow");
INSERT INTO smart_scripts VALUES (31832, 0, 5, 0, 38, 0, 100, 0, 1, 10, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Data Set - Set Home Pos");
INSERT INTO smart_scripts VALUES (31832, 0, 6, 7, 38, 0, 100, 0, 1, 20, 0, 0, 33, 31845, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, "On Data Set - Kill Credit");
INSERT INTO smart_scripts VALUES (31832, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Data Set - Despawn");
INSERT INTO smart_scripts VALUES (31832, 0, 8, 0, 0, 0, 100, 0, 3000, 3000, 6000, 6000, 11, 29426, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "IC Update - Cast Spell Heroic Strike");
DELETE FROM waypoints WHERE entry=31833;
INSERT INTO waypoints VALUES (31833, 1, 7503.93, 1790.99, 357.285, 'Korkron Squad Leader'),(31833, 2, 7502.61, 1800.28, 356.863, 'Korkron Squad Leader'),(31833, 3, 7500.47, 1817.72, 355.487, 'Korkron Squad Leader'),(31833, 4, 7491.7, 1825.33, 360.781, 'Korkron Squad Leader'),(31833, 5, 7482.51, 1834.36, 369.439, 'Korkron Squad Leader'),(31833, 6, 7472.07, 1839.38, 377.258, 'Korkron Squad Leader'),(31833, 7, 7459.39, 1840.83, 387.083, 'Korkron Squad Leader'),(31833, 8, 7445.41, 1839.45, 397.161, 'Korkron Squad Leader'),(31833, 9, 7435.62, 1845.03, 403.664, 'Korkron Squad Leader'),(31833, 10, 7425.28, 1845.93, 411.936, 'Korkron Squad Leader'),(31833, 11, 7414.68, 1845.89, 419.947, 'Korkron Squad Leader'),(31833, 12, 7408.84, 1838.55, 424.703, 'Korkron Squad Leader'),(31833, 13, 7404.26, 1825.32, 428.076, 'Korkron Squad Leader'),(31833, 14, 7396.14, 1817, 430.819, 'Korkron Squad Leader'),(31833, 15, 7383.08, 1803.63, 435.749, 'Korkron Squad Leader'),(31833, 16, 7371.49, 1791.86, 440.379, 'Korkron Squad Leader'),(31833, 17, 7358.52, 1781.96, 445.676, 'Korkron Squad Leader'),
(31833, 18, 7345.37, 1772.43, 451.143, 'Korkron Squad Leader'),(31833, 19, 7341.18, 1759.16, 452.72, 'Korkron Squad Leader'),(31833, 20, 7335.7, 1748.92, 454.544, 'Korkron Squad Leader'),(31833, 21, 7326.92, 1732.49, 456.744, 'Korkron Squad Leader'),(31833, 22, 7317.86, 1725.23, 460.711, 'Korkron Squad Leader'),(31833, 23, 7305.95, 1720.51, 466.371, 'Korkron Squad Leader'),(31833, 24, 7284.95, 1720.43, 471.162, 'Korkron Squad Leader'),(31833, 25, 7268.57, 1720.36, 474.854, 'Korkron Squad Leader'),(31833, 26, 7250, 1718.9, 475.005, 'Korkron Squad Leader'),(31833, 27, 7233.69, 1717.44, 472.978, 'Korkron Squad Leader'),(31833, 28, 7216.94, 1709.8, 473.315, 'Korkron Squad Leader'),(31833, 29, 7201.11, 1705.87, 472.483, 'Korkron Squad Leader'),(31833, 30, 7193.72, 1711.64, 474.572, 'Korkron Squad Leader');

-- The Air Stands Still (13125)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(30829, 30830, 30831, 30838, 30839, 30840);
UPDATE creature_template SET AIName='NullCreatureAI', ScriptName='' WHERE entry IN(30841, 30850, 30852);
DELETE FROM smart_scripts WHERE entryorguid IN(30829, 30830, 30831, 30838, 30839, 30840) AND source_type=0;
INSERT INTO smart_scripts VALUES (30829, 0, 0, 0, 8, 0, 100, 1, 57906, 0, 0, 0, 11, 57910, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Salranax the Flesh Render - On Spellhit War Horn of Acherus - Cast Death Gate (Munch)');
INSERT INTO smart_scripts VALUES (30829, 0, 1, 0, 8, 0, 100, 1, 57906, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Salranax the Flesh Render - On Spellhit War Horn of Acherus - Start Attacking');
INSERT INTO smart_scripts VALUES (30829, 0, 2, 0, 17, 0, 100, 0, 0, 0, 0, 0, 85, 57911, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Salranax the Flesh Render - Just Summoned - Cast Death Gate');
INSERT INTO smart_scripts VALUES (30829, 0, 3, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 18100, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Salranax the Flesh Render - On Aggro - Cast Frost Armor');
INSERT INTO smart_scripts VALUES (30829, 0, 4, 0, 0, 0, 100, 0, 2000, 6000, 4000, 8000, 11, 15242, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Salranax the Flesh Render - In Combat - Cast Fireball');
INSERT INTO smart_scripts VALUES (30829, 0, 5, 0, 0, 0, 100, 0, 15000, 20000, 15000, 20000, 11, 15244, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Salranax the Flesh Render - In Combat - Cast Cone of Cold');
INSERT INTO smart_scripts VALUES (30829, 0, 6, 0, 0, 0, 100, 0, 25000, 26000, 25000, 26000, 11, 15122, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Salranax the Flesh Render - In Combat - Cast Counterspell');
INSERT INTO smart_scripts VALUES (30829, 0, 7, 0, 6, 0, 100, 0, 0, 0, 0, 0, 78, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Salranax the Flesh Render - On Just Died - Reset All Scripts');
INSERT INTO smart_scripts VALUES (30829, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 28, 18100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Salranax the Flesh Render - On Reset - Remove Aura Frost Armor');
INSERT INTO smart_scripts VALUES (30829, 0, 9, 0, 6, 0, 100, 0, 0, 0, 0, 0, 33, 30829, 0, 0, 0, 0, 0, 18, 40, 0, 0, 0, 0, 0, 0, 'On Death - Kill Credit');
INSERT INTO smart_scripts VALUES (30830, 0, 0, 0, 8, 0, 100, 1, 57906, 0, 0, 0, 11, 57890, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underking Talonox - On Spellhit War Horn of Acherus - Cast Death Gate (Mograine)');
INSERT INTO smart_scripts VALUES (30830, 0, 1, 0, 8, 0, 100, 1, 57906, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Underking Talonox - On Spellhit War Horn of Acherus - Start Attacking');
INSERT INTO smart_scripts VALUES (30830, 0, 2, 0, 17, 0, 100, 0, 0, 0, 0, 0, 85, 57892, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Underking Talonox - Just Summoned - Cast Death Gate');
INSERT INTO smart_scripts VALUES (30830, 0, 3, 0, 0, 0, 100, 0, 1000, 2000, 2000, 7000, 11, 60802, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Underking Talonox - In Combat - Cast Mandible Crush');
INSERT INTO smart_scripts VALUES (30830, 0, 4, 0, 0, 0, 100, 0, 1500, 2000, 10000, 15000, 11, 50283, 0, 0, 0, 0, 0, 7, 0, 2, 0, 0, 0, 0, 0, 'Underking Talonox - In Combat - Cast Blinding Swarm');
INSERT INTO smart_scripts VALUES (30830, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 78, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underking Talonox - On Just Died - Reset All Scripts');
INSERT INTO smart_scripts VALUES (30830, 0, 6, 0, 6, 0, 100, 0, 0, 0, 0, 0, 33, 30830, 0, 0, 0, 0, 0, 18, 40, 0, 0, 0, 0, 0, 0, 'On Death - Kill Credit');
INSERT INTO smart_scripts VALUES (30831, 0, 0, 0, 8, 0, 100, 1, 57906, 0, 0, 0, 11, 57916, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priest Yathamon - On Spellhit War Horn of Acherus - Cast Death Gate (Jayde)');
INSERT INTO smart_scripts VALUES (30831, 0, 1, 0, 8, 0, 100, 1, 57906, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'High Priest Yathamon - On Spellhit War Horn of Acherus - Start Attacking');
INSERT INTO smart_scripts VALUES (30831, 0, 2, 0, 17, 0, 100, 0, 0, 0, 0, 0, 85, 57917, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'High Priest Yathamon - Just Summoned - Cast Death Gate');
INSERT INTO smart_scripts VALUES (30831, 0, 3, 0, 0, 0, 100, 0, 2000, 3000, 6000, 8000, 11, 61705, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'High Priest Yathamon - In Combat - Cast Venomous Bite');
INSERT INTO smart_scripts VALUES (30831, 0, 4, 0, 0, 0, 100, 0, 2000, 7000, 10000, 20000, 11, 4962, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'High Priest Yathamon - In Combat - Cast Encasing Webs');
INSERT INTO smart_scripts VALUES (30831, 0, 5, 0, 0, 0, 100, 0, 2000, 7000, 8000, 20000, 11, 38243, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'High Priest Yathamon - In Combat - Cast Mind Flay');
INSERT INTO smart_scripts VALUES (30831, 0, 6, 0, 0, 0, 100, 0, 10000, 15000, 30000, 35000, 11, 34322, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'High Priest Yathamon - In Combat - Cast Psychic Scream');
INSERT INTO smart_scripts VALUES (30831, 0, 7, 0, 6, 0, 100, 0, 0, 0, 0, 0, 78, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Priest Yathamon - On Just Died - Reset All Scripts');
INSERT INTO smart_scripts VALUES (30831, 0, 8, 0, 6, 0, 100, 0, 0, 0, 0, 0, 33, 30831, 0, 0, 0, 0, 0, 18, 40, 0, 0, 0, 0, 0, 0, 'On Death - Kill Credit');
INSERT INTO smart_scripts VALUES (30838, 0, 0, 0, 60, 0, 100, 257, 2000, 2000, 0, 0, 49, 5000, 0, 0, 0, 0, 0, 19, 30830, 50, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - On Update - Attack Start');
INSERT INTO smart_scripts VALUES (30838, 0, 1, 2, 4, 0, 100, 1, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 19, 30841, 50, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - On Aggro - Despawn Target');
INSERT INTO smart_scripts VALUES (30838, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - On Aggro - Say Line 1');
INSERT INTO smart_scripts VALUES (30838, 0, 3, 0, 0, 0, 100, 0, 4000, 6000, 19000, 20000, 11, 52372, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - In Combat - Cast Icy Touch');
INSERT INTO smart_scripts VALUES (30838, 0, 4, 0, 0, 0, 100, 0, 4000, 8000, 10000, 11000, 11, 52373, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - In Combat - Cast Plague Strike');
INSERT INTO smart_scripts VALUES (30838, 0, 5, 0, 0, 0, 100, 0, 4000, 7000, 5000, 5000, 11, 49020, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - In Combat - Cast Obliterate');
INSERT INTO smart_scripts VALUES (30838, 0, 6, 7, 21, 0, 100, 1, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - On Just Reached Home - Say Line 2');
INSERT INTO smart_scripts VALUES (30838, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 11, 57890, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - On Just Reached Home - Cast Death Gate');
INSERT INTO smart_scripts VALUES (30838, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 3000, 3000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - On Just Reached Home - Create Timed Event');
INSERT INTO smart_scripts VALUES (30838, 0, 9, 10, 59, 0, 100, 0, 1, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 19, 30841, 50, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - On Timed Event - Move Point');
INSERT INTO smart_scripts VALUES (30838, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Darion Mograine - On Timed Event - Despawn');
INSERT INTO smart_scripts VALUES (30839, 0, 0, 0, 60, 0, 100, 257, 2000, 2000, 0, 0, 49, 5000, 0, 0, 0, 0, 0, 19, 30831, 50, 0, 0, 0, 0, 0, 'Jayde - On Update - Attack Start');
INSERT INTO smart_scripts VALUES (30839, 0, 1, 2, 4, 0, 100, 1, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 19, 30852, 50, 0, 0, 0, 0, 0, 'Jayde - On Aggro - Despawn Target');
INSERT INTO smart_scripts VALUES (30839, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jayde - On Aggro - Say Line 1');
INSERT INTO smart_scripts VALUES (30839, 0, 3, 0, 0, 0, 100, 0, 4000, 6000, 19000, 20000, 11, 52372, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Jayde - In Combat - Cast Icy Touch');
INSERT INTO smart_scripts VALUES (30839, 0, 4, 0, 0, 0, 100, 0, 4000, 8000, 10500, 11000, 11, 52373, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Jayde - In Combat - Cast Plague Strike');
INSERT INTO smart_scripts VALUES (30839, 0, 5, 0, 0, 0, 100, 0, 4000, 7000, 2000, 2500, 11, 52374, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Jayde - In Combat - Cast Blood Strike');
INSERT INTO smart_scripts VALUES (30839, 0, 6, 7, 21, 0, 100, 1, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jayde - On Just Reached Home - Say Line 2');
INSERT INTO smart_scripts VALUES (30839, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 11, 57916, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jayde - On Just Reached Home - Cast Death Gate');
INSERT INTO smart_scripts VALUES (30839, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 3000, 3000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Jayde - On Just Reached Home - Create Timed Event');
INSERT INTO smart_scripts VALUES (30839, 0, 9, 10, 59, 0, 100, 0, 1, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 19, 30852, 50, 0, 0, 0, 0, 0, 'Jayde - On Timed Event - Move Point');
INSERT INTO smart_scripts VALUES (30839, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jayde - On Timed Event - Despawn');
INSERT INTO smart_scripts VALUES (30840, 0, 0, 0, 60, 0, 100, 257, 2000, 2000, 0, 0, 49, 5000, 0, 0, 0, 0, 0, 19, 30829, 50, 0, 0, 0, 0, 0, 'Munch - On Update - Attack Start');
INSERT INTO smart_scripts VALUES (30840, 0, 1, 2, 4, 0, 100, 1, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 19, 30850, 50, 0, 0, 0, 0, 0, 'Munch - On Aggro - Despawn Target');
INSERT INTO smart_scripts VALUES (30840, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Munch - On Aggro - Say Line 1');
INSERT INTO smart_scripts VALUES (30840, 0, 3, 4, 0, 0, 100, 1, 4000, 4000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Munch - On Aggro - Say Line 2');
INSERT INTO smart_scripts VALUES (30840, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 57913, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Munch - On Aggro - Cast Summon Ghoul');
INSERT INTO smart_scripts VALUES (30840, 0, 5, 0, 0, 0, 100, 0, 4000, 6000, 19000, 20000, 11, 52372, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Munch - In Combat - Cast Icy Touch');
INSERT INTO smart_scripts VALUES (30840, 0, 6, 0, 0, 0, 100, 0, 4000, 8000, 10000, 11000, 11, 52373, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Munch - In Combat - Cast Plague Strike');
INSERT INTO smart_scripts VALUES (30840, 0, 7, 0, 0, 0, 100, 0, 4000, 7000, 2000, 3000, 11, 52374, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Munch - In Combat - Cast Blood Strike');
INSERT INTO smart_scripts VALUES (30840, 0, 8, 9, 21, 0, 100, 1, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Munch - On Just Reached Home - Say Line 3');
INSERT INTO smart_scripts VALUES (30840, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 11, 57910, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Munch - On Just Reached Home - Cast Death Gate');
INSERT INTO smart_scripts VALUES (30840, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 3000, 3000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Munch - On Just Reached Home - Create Timed Event');
INSERT INTO smart_scripts VALUES (30840, 0, 11, 12, 59, 0, 100, 0, 1, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 19, 30850, 50, 0, 0, 0, 0, 0, 'Munch - On Timed Event - Move Point');
INSERT INTO smart_scripts VALUES (30840, 0, 12, 13, 61, 0, 100, 0, 0, 0, 0, 0, 41, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Munch - On Timed Event - Despawn');
INSERT INTO smart_scripts VALUES (30840, 0, 13, 0, 61, 0, 100, 1, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 30851, 50, 0, 0, 0, 0, 0, 'Munch - On Aggro - Despawn Target');

-- Into The Wild Green Yonder (13045)
UPDATE creature_template SET InhabitType=4 WHERE entry=30228;

-- The Keeper's Favor (13073), fix portal
DELETE FROM conditions WHERE SourceTypeOrReferenceId=18 AND SourceGroup=32790;
INSERT INTO conditions VALUES (18, 32790, 57654, 0, 0, 14, 0, 13073, 0, 0, 1, 0, 0, '', 'Required quest with any state to see spellclick');

-- Eliminate the Competition (12955)
DELETE FROM smart_scripts WHERE source_type=0 AND entryorguid IN(30081, 30086, 30162, 30180);
INSERT INTO smart_scripts VALUES (30081, 0, 0, 0, 1, 0, 100, 0, 500, 1000, 600000, 600000, 11, 17232, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cast Devotion Aura on Spawn');
INSERT INTO smart_scripts VALUES (30081, 0, 1, 0, 2, 0, 100, 1, 0, 50, 0, 0, 11, 17233, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cast Lay on Hands at 50% HP');
INSERT INTO smart_scripts VALUES (30081, 0, 2, 0, 0, 0, 100, 0, 3300, 5500, 16000, 17600, 11, 14518, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Crusader Strike');
INSERT INTO smart_scripts VALUES (30081, 0, 3, 0, 0, 0, 80, 0, 9900, 9900, 21000, 32000, 11, 13005, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Hammer of Justice');
INSERT INTO smart_scripts VALUES (30081, 0, 4, 5, 62, 0, 100, 0, 9869, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On gossip select - Close gossip');
INSERT INTO smart_scripts VALUES (30081, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On link - Set invincible');
INSERT INTO smart_scripts VALUES (30081, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On link - Remove flags 256+512');
INSERT INTO smart_scripts VALUES (30081, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On link - Set faction hostile');
INSERT INTO smart_scripts VALUES (30081, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On link - Talk');
INSERT INTO smart_scripts VALUES (30081, 0, 9, 10, 2, 0, 100, 0, 0, 1, 0, 0, 33, 30081, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On 1 hp - Give killcredit');
INSERT INTO smart_scripts VALUES (30081, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On link - Evade');
INSERT INTO smart_scripts VALUES (30081, 0, 11, 0, 7, 0, 100, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Evade - Restore faction');
INSERT INTO smart_scripts VALUES (30086, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Phase 1 on Aggro');
INSERT INTO smart_scripts VALUES (30086, 0, 1, 0, 4, 1, 100, 1, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Moving on Aggro');
INSERT INTO smart_scripts VALUES (30086, 0, 2, 0, 4, 1, 100, 1, 0, 0, 0, 0, 11, 61168, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Throw on Aggro');
INSERT INTO smart_scripts VALUES (30086, 0, 3, 0, 9, 1, 100, 0, 5, 30, 3500, 4100, 11, 61168, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Throw');
INSERT INTO smart_scripts VALUES (30086, 0, 4, 0, 9, 1, 100, 0, 30, 100, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Start Moving when not in Throw Range');
INSERT INTO smart_scripts VALUES (30086, 0, 5, 0, 9, 1, 100, 0, 9, 15, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Moving at 15 Yards');
INSERT INTO smart_scripts VALUES (30086, 0, 6, 0, 9, 1, 100, 0, 0, 5, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Start Moving when not in Throw Range');
INSERT INTO smart_scripts VALUES (30086, 0, 7, 0, 9, 1, 100, 0, 5, 30, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Moving when in Throw Range');
INSERT INTO smart_scripts VALUES (30086, 0, 8, 0, 0, 1, 100, 0, 3000, 7000, 13000, 16700, 11, 61164, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Impale');
INSERT INTO smart_scripts VALUES (30086, 0, 9, 0, 13, 1, 100, 0, 12000, 18000, 0, 0, 11, 57635, 0, 0, 0, 0, 0, 6, 1, 0, 0, 0, 0, 0, 0, 'Cast Disengage on Target Spellcast');
INSERT INTO smart_scripts VALUES (30086, 0, 10, 0, 1, 0, 100, 0, 500, 1000, 600000, 600000, 11, 61165, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cast Frostbite Weapon on Spawn');
INSERT INTO smart_scripts VALUES (30086, 0, 11, 12, 62, 0, 100, 0, 9870, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On gossip select - Close gossip');
INSERT INTO smart_scripts VALUES (30086, 0, 12, 13, 61, 0, 100, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On link - Set invincible');
INSERT INTO smart_scripts VALUES (30086, 0, 13, 14, 61, 0, 100, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On link - Remove flags 256+512');
INSERT INTO smart_scripts VALUES (30086, 0, 14, 15, 61, 0, 100, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On link - Set faction hostile');
INSERT INTO smart_scripts VALUES (30086, 0, 15, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On link - Talk');
INSERT INTO smart_scripts VALUES (30086, 0, 16, 17, 2, 0, 100, 0, 0, 1, 0, 0, 33, 30086, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On 1 hp - Give killcredit');
INSERT INTO smart_scripts VALUES (30086, 0, 17, 18, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On link - Talk');
INSERT INTO smart_scripts VALUES (30086, 0, 18, 0, 61, 0, 100, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On link - Evade');
INSERT INTO smart_scripts VALUES (30086, 0, 19, 0, 7, 0, 100, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Evade - Restore faction');
INSERT INTO smart_scripts VALUES (30162, 0, 0, 0, 0, 0, 100, 0, 7000, 8000, 15600, 17800, 11, 61552, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Wrench Strike');
INSERT INTO smart_scripts VALUES (30162, 0, 1, 0, 0, 0, 100, 0, 13000, 14000, 21300, 23400, 11, 37666, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cast Heavy Dynamite');
INSERT INTO smart_scripts VALUES (30162, 0, 2, 3, 62, 0, 100, 0, 9875, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On gossip select - Close gossip');
INSERT INTO smart_scripts VALUES (30162, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On link - Set invincible');
INSERT INTO smart_scripts VALUES (30162, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On link - Remove flags 256+512');
INSERT INTO smart_scripts VALUES (30162, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On link - Set faction hostile');
INSERT INTO smart_scripts VALUES (30162, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On link - Talk');
INSERT INTO smart_scripts VALUES (30162, 0, 7, 8, 2, 0, 100, 0, 0, 1, 0, 0, 33, 30162, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On 1 hp - Give killcredit');
INSERT INTO smart_scripts VALUES (30162, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On link - Talk');
INSERT INTO smart_scripts VALUES (30162, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On link - Evade');
INSERT INTO smart_scripts VALUES (30162, 0, 10, 0, 7, 0, 100, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Evade - Restore faction');
INSERT INTO smart_scripts VALUES (30180, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Phase 1 on Aggro');
INSERT INTO smart_scripts VALUES (30180, 0, 1, 0, 4, 1, 100, 1, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Moving on Aggro');
INSERT INTO smart_scripts VALUES (30180, 0, 2, 0, 4, 1, 100, 1, 0, 0, 0, 0, 11, 15242, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast bolt on Aggro');
INSERT INTO smart_scripts VALUES (30180, 0, 3, 0, 9, 1, 100, 0, 0, 40, 3400, 4700, 11, 15242, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast bolt');
INSERT INTO smart_scripts VALUES (30180, 0, 4, 0, 9, 1, 100, 0, 40, 100, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Start Moving when not in bolt Range');
INSERT INTO smart_scripts VALUES (30180, 0, 5, 0, 9, 1, 100, 0, 10, 15, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Moving at 15 Yards');
INSERT INTO smart_scripts VALUES (30180, 0, 6, 0, 9, 1, 100, 0, 0, 40, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Moving when in bolt Range');
INSERT INTO smart_scripts VALUES (30180, 0, 7, 0, 3, 1, 100, 0, 0, 15, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Phase 2 at 15% Mana');
INSERT INTO smart_scripts VALUES (30180, 0, 8, 0, 3, 2, 100, 0, 0, 15, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Start Moving at 15% Mana');
INSERT INTO smart_scripts VALUES (30180, 0, 9, 0, 3, 2, 100, 0, 30, 100, 100, 100, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Phase 1 When Mana is above 30%');
INSERT INTO smart_scripts VALUES (30180, 0, 10, 0, 1, 0, 100, 0, 500, 1000, 600000, 600000, 11, 18100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cast Frost Armor on Spawn');
INSERT INTO smart_scripts VALUES (30180, 0, 11, 0, 13, 0, 100, 0, 12000, 18000, 0, 0, 11, 15122, 0, 0, 0, 0, 0, 6, 1, 0, 0, 0, 0, 0, 0, 'Cast Counterspell on Target Spellcast');
INSERT INTO smart_scripts VALUES (30180, 0, 12, 0, 0, 1, 100, 0, 5000, 5000, 14500, 17800, 11, 15244, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Cone of Cold');
INSERT INTO smart_scripts VALUES (30180, 0, 13, 14, 62, 0, 100, 0, 9878, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On gossip select - Close gossip');
INSERT INTO smart_scripts VALUES (30180, 0, 14, 15, 61, 0, 100, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On link - Set invincible');
INSERT INTO smart_scripts VALUES (30180, 0, 15, 16, 61, 0, 100, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On link - Remove flags 256+512');
INSERT INTO smart_scripts VALUES (30180, 0, 16, 17, 61, 0, 100, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On link - Set faction hostile');
INSERT INTO smart_scripts VALUES (30180, 0, 17, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On link - Talk');
INSERT INTO smart_scripts VALUES (30180, 0, 18, 19, 2, 0, 100, 0, 0, 1, 0, 0, 33, 30180, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On 1 hp - Give killcredit');
INSERT INTO smart_scripts VALUES (30180, 0, 19, 0, 61, 0, 100, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On link - Evade');
INSERT INTO smart_scripts VALUES (30180, 0, 20, 0, 7, 0, 100, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Evade - Restore faction');

-- Volatility (13239)
-- Volatility (13261)
-- Borrowed Technology (13291)
-- The Solution Solution (13292)
DELETE FROM vehicle_template_accessory WHERE entry=31583;
INSERT INTO vehicle_template_accessory VALUES (31583, 31630, 0, 1, 'Frostbrood Skytalon Explosion Bunny', 6, 30000);
DELETE FROM smart_scripts WHERE entryorguid=31578 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=3163000 AND source_type=9;
INSERT INTO smart_scripts VALUES (31578, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Armored Decoy - On Just Summoned - Store Targetlist');
INSERT INTO smart_scripts VALUES (31578, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 11, 59292, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Armored Decoy - On Just Summoned - Cast Fake Soldier Freeze Anim');
INSERT INTO smart_scripts VALUES (31578, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 59303, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Armored Decoy - On Just Summoned - Cast Summon Frost Wyrm');
INSERT INTO smart_scripts VALUES (31578, 0, 3, 0, 8, 0, 100, 0, 59335, 0, 0, 0, 11, 59329, 2, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Armored Decoy - On Spellhit Explode Frost Wyrm - Cast Fake Soldier Kill Credit');
INSERT INTO smart_scripts VALUES (3163000, 9, 0, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 86, 59335, 2, 19, 31583, 30, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skytalon Explosion Bunny - On Script - Cast Explode Frost Wyrm');

-- Shoot 'Em Up (13069)
REPLACE INTO creature_model_info VALUES (26882, 1.5, 4.0, 2, 0);
UPDATE creature SET curhealth=12600 WHERE id=30337;
UPDATE creature_template SET unit_flags=unit_flags|4, unit_flags2=2048 WHERE entry=30337;
UPDATE creature_template SET unit_flags=33587970, AIName='NullCreatureAI', ScriptName='' WHERE entry=30332;
UPDATE creature_template SET RegenHealth=0, flags_extra=flags_extra|64, AIName='SmartAI', ScriptName='' WHERE entry=30330;
DELETE FROM smart_scripts WHERE entryorguid=30330 AND source_type=0;
INSERT INTO smart_scripts VALUES (30330, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jotunheim Proto-Drake - On Reset - Set Active');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=56578;
INSERT INTO conditions VALUES(13, 3, 56578, 0, 0, 31, 0, 3, 30330, 0, 0, 0, 0, '', 'Jotunheim Proto-Drake');
DELETE FROM vehicle_template_accessory WHERE entry=30330;
INSERT INTO vehicle_template_accessory VALUES (30330, 30332, 0, 1, 'Jotunheim Proto-Drake', 6, 30000);

-- Tirion's Gambit (13364)
-- Tirion's Gambit (13403)
UPDATE creature SET spawntimesecs=10 WHERE id=32241;
UPDATE creature_template SET npcflag=1, AIName='', ScriptName='npc_tirions_gambit_tirion' WHERE entry=32239;
DELETE FROM spell_script_names WHERE spell_id=60532;
INSERT INTO spell_script_names VALUES (60532, 'spell_gen_default_count_pct_from_max_hp');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=60532;
INSERT INTO conditions VALUES(13, 3, 60532, 0, 0, 31, 0, 3, 32184, 0, 0, 0, 0, '', 'Target Lich King');
INSERT INTO conditions VALUES(13, 4, 60532, 0, 0, 31, 0, 3, 32272, 0, 0, 0, 0, '', 'Target Invoker Basaleph');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=60456;
INSERT INTO conditions VALUES(13, 1, 60456, 0, 0, 31, 0, 3, 24042, 0, 0, 0, 0, '', 'Target Generic Trigger LAB');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=61487;
INSERT INTO conditions VALUES(13, 1, 61487, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Target All Players');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=60536;
INSERT INTO conditions VALUES(13, 1, 60536, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Target All Players');
DELETE FROM spell_target_position WHERE id=60585;
INSERT INTO spell_target_position VALUES (60585, 0, 571, 6488.94, 413.64, 481.22, 3.14);
DELETE FROM creature_text WHERE entry IN(32239, 32184, 32241, 32310, 32312);
INSERT INTO creature_text VALUES (32239, 0, 0, "It is time. May the Light give us strength.", 12, 0, 100, 0, 0, 0, 0, 'Highlord Tirion Fordring');
INSERT INTO creature_text VALUES (32239, 1, 0, "Keep your heads down and follow my lead.", 12, 0, 100, 0, 0, 0, 0, 'Highlord Tirion Fordring');
INSERT INTO creature_text VALUES (32239, 2, 0, "Here it comes. Stand ready.", 12, 0, 100, 0, 0, 0, 0, 'Highlord Tirion Fordring');
INSERT INTO creature_text VALUES (32239, 3, 0, "Something's wrong... I sense a dark presence.", 12, 0, 100, 0, 0, 0, 0, 'Highlord Tirion Fordring');
INSERT INTO creature_text VALUES (32239, 4, 0, "The Lich King is here. May the Light guide our blades.", 12, 0, 100, 0, 0, 0, 0, 'Highlord Tirion Fordring');
INSERT INTO creature_text VALUES (32239, 5, 0, "You sound a little too confident. Especially considering the way our last encounter ended.", 12, 0, 100, 0, 0, 0, 0, 'Highlord Tirion Fordring');
INSERT INTO creature_text VALUES (32239, 6, 0, "That might be, but I don't need to stand on holy ground to run that disembodied heart of yours with the Ashbringer.", 12, 0, 100, 0, 0, 0, 0, 'Highlord Tirion Fordring');
INSERT INTO creature_text VALUES (32239, 7, 0, "The heart... the last remaining vestige of your humanity. I had to stop it from being destroyed. I had to see for myself. And at last I'm sure...", 12, 0, 100, 0, 0, 0, 0, 'Highlord Tirion Fordring');
INSERT INTO creature_text VALUES (32239, 8, 0, "Only shadows from the past remain. There's nothing left to redeem!", 12, 0, 100, 0, 0, 0, 0, 'Highlord Tirion Fordring');
INSERT INTO creature_text VALUES (32184, 0, 0, "Uninvited guests! Did you think you'd go unnoticed inside my dominion?", 12, 0, 100, 0, 0, 0, 0, 'Lich King');
INSERT INTO creature_text VALUES (32184, 1, 0, "I must confess... you were not altogether unexpected. I hope you find your final resting place... to your liking.", 12, 0, 100, 0, 0, 0, 0, 'Lich King');
INSERT INTO creature_text VALUES (32184, 2, 0, "Last time we met, you had the advantage of fighting on holy ground. You'll find that our situation has been... reversed.", 12, 0, 100, 0, 0, 0, 0, 'Lich King');
INSERT INTO creature_text VALUES (32184, 3, 0, "I call your bluff. You're a paladin after all. Your obsession with redemption goes beyond the inane.", 12, 0, 100, 0, 0, 0, 0, 'Lich King');
INSERT INTO creature_text VALUES (32184, 4, 0, "You surely wouldn't destroy humanity's only chance to redeem its most wayward son. You'd sooner die!", 12, 0, 100, 0, 0, 0, 0, 'Lich King');
INSERT INTO creature_text VALUES (32184, 5, 0, "Arrrrggggggggggh!!!!", 14, 0, 100, 0, 0, 0, 0, 'Lich King');
INSERT INTO creature_text VALUES (32184, 6, 0, "You... will pay for that, old man. Slay them all!", 14, 0, 100, 0, 0, 0, 0, 'Lich King');
INSERT INTO creature_text VALUES (32241, 0, 0, "Tirion's Down! Defend him with your lives!", 14, 0, 100, 0, 0, 0, 0, 'Disguised Crusader');
INSERT INTO creature_text VALUES (32310, 0, 0, "I hope you fellows don't mind if we crash this party. I brought some old friends with me!", 14, 0, 100, 0, 0, 0, 0, 'Thassarian');
INSERT INTO creature_text VALUES (32310, 1, 0, "Looks like whatever Tirion did put some hurt on the Lich King. It's too bad we cant' finish him off...", 12, 0, 100, 0, 0, 0, 0, 'Thassarian');
INSERT INTO creature_text VALUES (32312, 0, 0, "Quick, through the portal! He won't stay down for long.", 12, 0, 100, 0, 0, 0, 0, 'Highlord Darion Mograine');
INSERT INTO creature_text VALUES (32312, 1, 0, "Patience... we will get our chance soon enough. Be content that for once, it is Tirion who is in our debt.", 12, 0, 100, 0, 0, 0, 0, 'Highlord Darion Mograine');
UPDATE creature_template SET faction=35 WHERE entry=32184;
DELETE FROM creature_equip_template WHERE entry=32239;
INSERT INTO creature_equip_template VALUES (32239, 2, 13262, 0, 0, 0);
UPDATE creature_template SET faction=2144, mindmg=1200, maxdmg=1500, AIName='SmartAI' WHERE entry IN(32309, 32310, 32311, 32312);
UPDATE creature_template SET AIName='SmartAI' WHERE entry=32175;
DELETE FROM smart_scripts WHERE entryorguid IN (32309, 32310, 32311, 32312, 32175) AND source_type=0;
INSERT INTO smart_scripts VALUES (32175, 0, 0, 0, 0, 0, 30, 0, 3000, 20000, 60000, 100000, 11, 12530, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - cast Frailty');
INSERT INTO smart_scripts VALUES (32175, 0, 1, 0, 0, 0, 30, 0, 3000, 6000, 10000, 15000, 11, 13445, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - cast Rend');
INSERT INTO smart_scripts VALUES (32309, 0, 0, 0, 0, 0, 100, 0, 3000, 4000, 10000, 10000, 11, 58843, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - cast Icy Touch');
INSERT INTO smart_scripts VALUES (32309, 0, 1, 0, 0, 0, 100, 0, 7000, 8000, 10000, 10000, 11, 59011, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - cast Plague Strike');
INSERT INTO smart_scripts VALUES (32310, 0, 0, 0, 0, 0, 100, 0, 3000, 4000, 10000, 10000, 11, 58843, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - cast Icy Touch');
INSERT INTO smart_scripts VALUES (32310, 0, 1, 0, 0, 0, 100, 0, 7000, 8000, 10000, 10000, 11, 59011, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - cast Plague Strike');
INSERT INTO smart_scripts VALUES (32311, 0, 0, 0, 0, 0, 100, 0, 3000, 4000, 10000, 10000, 11, 58843, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - cast Icy Touch');
INSERT INTO smart_scripts VALUES (32311, 0, 1, 0, 0, 0, 100, 0, 7000, 8000, 10000, 10000, 11, 59011, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - cast Plague Strike');
INSERT INTO smart_scripts VALUES (32312, 0, 0, 0, 0, 0, 100, 0, 3000, 4000, 10000, 10000, 11, 58843, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - cast Icy Touch');
INSERT INTO smart_scripts VALUES (32312, 0, 1, 0, 0, 0, 100, 0, 7000, 8000, 10000, 10000, 11, 59011, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - cast Plague Strike');
INSERT INTO smart_scripts VALUES (32312, 0, 2, 0, 21, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 32239, 100, 0, 0, 0, 0, 0, 'On Reached Home - Set Data');
DELETE FROM creature_summon_groups WHERE summonerId=32239 AND summonerType=0;
INSERT INTO creature_summon_groups VALUES (32239, 0, 1, 32309, 6160.74, 2695.90, 573.92, 2.04, 3, 200000);
INSERT INTO creature_summon_groups VALUES (32239, 0, 1, 32309, 6164.98, 2697.90, 573.92, 2.04, 3, 200000);
INSERT INTO creature_summon_groups VALUES (32239, 0, 1, 32309, 6161.26, 2700.05, 573.92, 2.04, 3, 200000);
INSERT INTO creature_summon_groups VALUES (32239, 0, 1, 32310, 6159.74, 2697.90, 573.92, 2.04, 3, 200000);
INSERT INTO creature_summon_groups VALUES (32239, 0, 1, 32311, 6163.98, 2699.90, 573.92, 2.04, 3, 200000);
INSERT INTO creature_summon_groups VALUES (32239, 0, 1, 32312, 6160.26, 2702.05, 573.92, 2.04, 3, 200000);
DELETE FROM script_waypoint WHERE entry=32239;
INSERT INTO script_waypoint VALUES (32239, 1, 6241.8, 2653.47, 570.25, 0, 'Highlord Tirion Fordring');
INSERT INTO script_waypoint VALUES (32239, 2, 6241.43, 2641.81, 570.25, 0, 'Highlord Tirion Fordring');
INSERT INTO script_waypoint VALUES (32239, 3, 6230.28, 2631.59, 570.25, 0, 'Highlord Tirion Fordring');
INSERT INTO script_waypoint VALUES (32239, 4, 6214.25, 2621.85, 570.25, 0, 'Highlord Tirion Fordring');
INSERT INTO script_waypoint VALUES (32239, 5, 6199.11, 2627.92, 570.25, 0, 'Highlord Tirion Fordring');
INSERT INTO script_waypoint VALUES (32239, 6, 6190.45, 2637.36, 570.25, 7000, 'Highlord Tirion Fordring');
INSERT INTO script_waypoint VALUES (32239, 7, 6183.45, 2652.09, 572.712, 0, 'Highlord Tirion Fordring');
INSERT INTO script_waypoint VALUES (32239, 8, 6177.65, 2664.32, 574.714, 0, 'Highlord Tirion Fordring');
INSERT INTO script_waypoint VALUES (32239, 9, 6171.07, 2678.02, 573.946, 0, 'Highlord Tirion Fordring');
INSERT INTO script_waypoint VALUES (32239, 10, 6161.03, 2699.21, 573.914, 0, 'Highlord Tirion Fordring');
INSERT INTO script_waypoint VALUES (32239, 11, 6151.67, 2719.33, 573.914, 0, 'Highlord Tirion Fordring');
INSERT INTO script_waypoint VALUES (32239, 12, 6146.26, 2730.94, 573.914, 0, 'Highlord Tirion Fordring');
INSERT INTO script_waypoint VALUES (32239, 13, 6157.07, 2739.95, 573.914, 0, 'Highlord Tirion Fordring');
INSERT INTO script_waypoint VALUES (32239, 14, 6163.31, 2745.15, 573.914, 0, 'Highlord Tirion Fordring');
INSERT INTO script_waypoint VALUES (32239, 15, 6167.47, 2750.77, 573.914, 0, 'Highlord Tirion Fordring');
INSERT INTO script_waypoint VALUES (32239, 16, 6168.12, 2754.28, 573.914, 0, 'Highlord Tirion Fordring');
INSERT INTO script_waypoint VALUES (32239, 17, 6165.3, 2759.85, 573.914, 0, 'Highlord Tirion Fordring');
INSERT INTO script_waypoint VALUES (32239, 18, 6167.28, 2756.97, 573.92, 0, 'Highlord Tirion Fordring');
INSERT INTO script_waypoint VALUES (32239, 19, 6143.07, 2756.57, 573.92, 0, 'Highlord Tirion Fordring');
INSERT INTO script_waypoint VALUES (32239, 20, 6137.06, 2756.0, 573.92, 0, 'Highlord Tirion Fordring');

-- A Visit to the Doctor (13152)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=59115;
INSERT INTO conditions VALUES(13, 1, 59115, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Target All Players');
DELETE FROM smart_scripts WHERE entryorguid IN(30992, 30993, 30995) AND source_type=0;
UPDATE creature_template SET flags_extra=130 WHERE entry=30995;
DELETE FROM smart_scripts WHERE entryorguid IN(3099200,3099300) AND source_type=9;
DELETE FROM smart_scripts WHERE source_type=1 AND entryorguid=193025;
INSERT INTO smart_scripts VALUES (193025, 1, 0, 1, 70, 0, 100, 0, 2, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 121049, 30993, 0, 0, 0, 0, 0, 'Metal Stake - On State Changed - Set Data 1 1 on "Patches"');
INSERT INTO smart_scripts VALUES (193025, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 104, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Metal Stake - On State Changed - Set Flag In Use"');
INSERT INTO smart_scripts VALUES (193025, 1, 2, 0, 38, 0, 100, 0, 1, 1, 0, 0, 104, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Metal Stake - On Data Set - Remove Flag In Use"');
INSERT INTO smart_scripts VALUES (30992, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 3, 3, 0, 0, 0, 0, 10, 121049, 30993, 0, 0, 0, 0, 0, 'Doctor Sabnok - On Death - Set Data 3 3 on "Patches"');
INSERT INTO smart_scripts VALUES (30992, 0, 1, 0, 54, 0, 100, 0, 0, 0, 0, 0, 53, 0, 30992, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doctor Sabnok - On Just Summoned - Start WP');
INSERT INTO smart_scripts VALUES (30992, 0, 2, 0, 40, 0, 100, 0, 10, 30992, 0, 0, 45, 2, 2, 0, 0, 0, 0, 10, 121049, 30993, 0, 0, 0, 0, 0, 'Doctor Sabnok - Reached WP10 - Set Data 2 2 on "Patches"');
INSERT INTO smart_scripts VALUES (30992, 0, 3, 4, 40, 0, 100, 0, 14, 30992, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doctor Sabnok - Reached WP14 - Set Home Position');
INSERT INTO smart_scripts VALUES (30992, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doctor Sabnok - Reached WP14 - Set Hostile');
INSERT INTO smart_scripts VALUES (30992, 0, 5, 7, 61, 0, 100, 0, 0, 0, 0, 0, 80, 3099200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doctor Sabnok - Reached WP14 - Run Script');
INSERT INTO smart_scripts VALUES (30992, 0, 6, 0, 11, 0, 100, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doctor Sabnok - On Spawn - Set Unit Flags');
INSERT INTO smart_scripts VALUES (30992, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 5, 5, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doctor Sabnok - On Reached WP14 - Set Data 5 5 on "Patches"');
INSERT INTO smart_scripts VALUES (30993, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '"Patches" - On Respawn - Set Phase 2');
INSERT INTO smart_scripts VALUES (30993, 0, 1, 0, 1, 2, 100, 0, 0, 0, 3000, 3000, 11, 58108, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '"Patches" - OOC (Phase 2) - Cast Patches Chain');
INSERT INTO smart_scripts VALUES (30993, 0, 2, 3, 38, 0, 100, 0, 1, 1, 300000, 300000, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '"Patches" - On Data Set 1 1 - Set Phase 1');
INSERT INTO smart_scripts VALUES (30993, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 28, 58108, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '"Patches" - On Data Set 1 1 - Remove Aura Patches Chain');
INSERT INTO smart_scripts VALUES (30993, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 30995, 0, 0, 0, 0, 0, 0, '"Patches" - On Data Set 1 1 - Set Data 1 1 on Patches chain target');
INSERT INTO smart_scripts VALUES (30993, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 12, 30992, 2, 300000, 0, 0, 0, 8, 0, 0, 0, 6630.52, 3167.312, 659.3602, 2.740049, '"Patches" - On Data Set 1 1 - Summon Doctor Sabnok');
INSERT INTO smart_scripts VALUES (30993, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '"Patches" - On Data Set 1 1 - Say Line 1');
INSERT INTO smart_scripts VALUES (30993, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 2, 2036, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '"Patches" - On Data Set 1 1 - Set Faction');
INSERT INTO smart_scripts VALUES (30993, 0, 8, 9, 38, 0, 100, 0, 3, 3, 0, 0, 11, 59115, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Patches" - On Data Set 3 3 - Cast Patches Credit');
INSERT INTO smart_scripts VALUES (30993, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Patches" - On Data Set 3 3 - Despawn');
INSERT INTO smart_scripts VALUES (30993, 0, 10, 15, 38, 0, 100, 0, 5, 5, 0, 0, 89, 0, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Patches" - On On Data Set 5 5 - Turn Random Move Off');
INSERT INTO smart_scripts VALUES (30993, 0, 11, 0, 38, 0, 100, 0, 4, 4, 0, 0, 80, 3099300, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Patches" - On Data Set 4 4 - Run Script');
INSERT INTO smart_scripts VALUES (30993, 0, 12, 13, 11, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 14, 62005, 193025, 0, 0, 0, 0, 0, 'Patches" - On Respawn - Set Data 1 1 on Metal Stake');
INSERT INTO smart_scripts VALUES (30993, 0, 13, 14, 61, 0, 100, 0, 0, 0, 0, 0, 89, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Patches" - On Respawn - Set Random Movement');
INSERT INTO smart_scripts VALUES (30993, 0, 14, 0, 61, 0, 100, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Patches" - On Respawn - Set Unit Flags');
INSERT INTO smart_scripts VALUES (30993, 0, 15, 0, 61, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 30992, 0, 0, 0, 0, 0, 0, 'Patches" - On On Data Set 5 5 - Face Doctor Sabnok');
INSERT INTO smart_scripts VALUES (30993, 0, 16, 0, 17, 0, 100, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Patches" - Summoned Unit - Store Target');
INSERT INTO smart_scripts VALUES (30995, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 28, 58108, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Patches Chain Target - On Data Set 1 1 - Remove Aura Patches Chain');
INSERT INTO smart_scripts VALUES (3099200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Doctor Sabnok - Script - Face Player');
INSERT INTO smart_scripts VALUES (3099200, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 5, 21, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doctor Sabnok - Script - Play Emote OneShotApplaud');
INSERT INTO smart_scripts VALUES (3099200, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doctor Sabnok - Script - Say Line 1');
INSERT INTO smart_scripts VALUES (3099200, 9, 3, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doctor Sabnok - Script - Say Line 2');
INSERT INTO smart_scripts VALUES (3099200, 9, 4, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doctor Sabnok - Script - Say Line 3');
INSERT INTO smart_scripts VALUES (3099200, 9, 5, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 5, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doctor Sabnok - Script - Play Emote OneShotLaugh');
INSERT INTO smart_scripts VALUES (3099200, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 4, 4, 0, 0, 0, 0, 10, 121049, 30993, 0, 0, 0, 0, 0, 'Doctor Sabnok - Set Data 4 4 on "Patches"');
INSERT INTO smart_scripts VALUES (3099200, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doctor Sabnok - Set Unit Flags"');
INSERT INTO smart_scripts VALUES (3099300, 9, 0, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '"Patches" - Script - Set Hostile');
INSERT INTO smart_scripts VALUES (3099300, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '"Patches" - Script - Set Unit Flags');
INSERT INTO smart_scripts VALUES (3099300, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 30992, 0, 0, 0, 0, 0, 0, '"Patches" - Script - Start Attack');
INSERT INTO smart_scripts VALUES (3099300, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '"Patches" - Script - Say Line 2');
INSERT INTO smart_scripts VALUES (3099300, 9, 4, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 11, 58118, 0, 0, 0, 0, 0, 19, 30992, 0, 0, 0, 0, 0, 0, '"Patches" - Script - Cast Patches Revenge');

-- Judgment Day Comes! (13227)
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(19, 20) AND SourceEntry IN(13227);
INSERT INTO conditions VALUES (19, 0, 13227, 0, 0, 8, 0, 13086, 0, 0, 1, 0, 0, '', 'Quest The Last line of Defense Not rewarded');
INSERT INTO conditions VALUES (20, 0, 13227, 0, 0, 8, 0, 13086, 0, 0, 1, 0, 0, '', 'Quest The Last line of Defense Not rewarded');

-- Not a Bug (13342)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=32260);
DELETE FROM creature WHERE id=32260;
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(32259, 32260);
DELETE FROM smart_scripts WHERE entryorguid IN(32259, 32260) AND source_type=0;
INSERT INTO smart_scripts VALUES (32259, 0, 0, 0, 0, 0, 100, 0, 0, 2000, 3000, 4000, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Void Summoner - In Combat - Cast Shadowbolt');
INSERT INTO smart_scripts VALUES (32259, 0, 1, 0, 17, 0, 100, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Void Summoner - Just Summoned - Store Target');
INSERT INTO smart_scripts VALUES (32259, 0, 2, 3, 1, 0, 100, 1, 1000, 1000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Void Summoner - Out of Combat - Despawn Target');
INSERT INTO smart_scripts VALUES (32259, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 12, 32260, 7, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Void Summoner - Out of Combat - Summon Enslaved Minion');
INSERT INTO smart_scripts VALUES (32260, 0, 0, 0, 0, 0, 100, 0, 3000, 10000, 30000, 30000, 11, 31976, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Minion - In Combat - Cast Shadow Shield');
INSERT INTO smart_scripts VALUES (32260, 0, 1, 0, 1, 0, 100, 1, 0, 0, 0, 0, 29, 1, 90, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Minion - Out of Combat - Follow Owner');
INSERT INTO smart_scripts VALUES (32260, 0, 2, 0, 8, 0, 100, 0, 60531, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Minion - On Spell Hit Create Dark Matter - Despawn');
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13, 17) AND SourceEntry IN(60528, 60561, 60578);
INSERT INTO conditions VALUES (17, 0, 60578, 0, 0, 2, 0, 44434, 5, 0, 0, 22, 0, '', 'Requires 5 Dark Matter');
INSERT INTO conditions VALUES (13, 1, 60528, 0, 0, 31, 0, 3, 32260, 0, 0, 0, 0, '', 'Target Enslaved Minion');
INSERT INTO conditions VALUES (13, 1, 60528, 0, 0, 36, 0, 0, 0, 0, 1, 0, 0, '', 'Target Dead Unit');
INSERT INTO conditions VALUES (13, 1, 60561, 0, 0, 31, 0, 3, 32318, 0, 0, 0, 0, '', 'Target Summoning Stone Bunny');
UPDATE creature_template SET InhabitType=4, AIName='NullCreatureAI', ScriptName='' WHERE entry=32318;

-- From Their Corpses, Rise! (12813)
DELETE FROM spell_scripts WHERE Id=52741;
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(29329, 29330, 29333, 29338);
DELETE FROM smart_scripts WHERE entryorguid IN(29329, 29330, 29333, 29338) AND source_type=0;
INSERT INTO smart_scripts VALUES (29329, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 19131, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Paladin - On Aggro - Cast Shield Charge');
INSERT INTO smart_scripts VALUES (29329, 0, 1, 0, 0, 0, 100, 0, 2000, 9000, 17000, 30000, 11, 32774, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Paladin - In Combat - Cast Avenger''s Shield');
INSERT INTO smart_scripts VALUES (29329, 0, 2, 3, 8, 0, 100, 0, 52741, 0, 0, 0, 33, 29398, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Paladin - On Spell Hit - Kill Credit');
INSERT INTO smart_scripts VALUES (29329, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 11, 54415, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Paladin - On Spell Hit - Cast From Their Corpses, Rise!: Summon Corrupted Scarlet Onslaught');
INSERT INTO smart_scripts VALUES (29329, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Paladin - On Spell Hit - Despawn');
INSERT INTO smart_scripts VALUES (29330, 0, 0, 0, 0, 0, 100, 0, 0, 0, 3400, 4700, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Harbor Guard - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (29330, 0, 1, 0, 0, 0, 100, 0, 8000, 8000, 12000, 14000, 11, 50750, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Harbor Guard - In Combat - Cast Raven Heal');
INSERT INTO smart_scripts VALUES (29330, 0, 2, 3, 8, 0, 100, 0, 52741, 0, 0, 0, 33, 29398, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Harbor Guard - On Spell Hit - Kill Credit');
INSERT INTO smart_scripts VALUES (29330, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 11, 54415, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Harbor Guard - On Spell Hit - Cast From Their Corpses, Rise!: Summon Corrupted Scarlet Onslaught');
INSERT INTO smart_scripts VALUES (29330, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Harbor Guard - On Spell Hit - Despawn');
INSERT INTO smart_scripts VALUES (29333, 0, 0, 0, 0, 0, 100, 0, 0, 1500, 2500, 4000, 11, 54617, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Gryphon Rider - In Combat - Cast Throw Spear');
INSERT INTO smart_scripts VALUES (29333, 0, 1, 2, 8, 0, 100, 0, 52741, 0, 0, 0, 33, 29398, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Gryphon Rider - On Spell Hit - Kill Credit');
INSERT INTO smart_scripts VALUES (29333, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 11, 54415, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Gryphon Rider - On Spell Hit - Cast From Their Corpses, Rise!: Summon Corrupted Scarlet Onslaught');
INSERT INTO smart_scripts VALUES (29333, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Gryphon Rider - On Spell Hit - Despawn');
INSERT INTO smart_scripts VALUES (29338, 0, 0, 0, 0, 0, 100, 0, 0, 0, 3400, 4700, 11, 50740, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Raven Bishop - In Combat - Cast Raven Flock');
INSERT INTO smart_scripts VALUES (29338, 0, 1, 0, 2, 0, 100, 1, 10, 50, 2000, 8000, 11, 50750, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Raven Bishop - Between 10-50% Health - Cast Raven Heal');
INSERT INTO smart_scripts VALUES (29338, 0, 2, 3, 8, 0, 100, 0, 52741, 0, 0, 0, 33, 29398, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Raven Bishop - On Spell Hit - Kill Credit');
INSERT INTO smart_scripts VALUES (29338, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 11, 54415, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Raven Bishop - On Spell Hit - Cast From Their Corpses, Rise!: Summon Corrupted Scarlet Onslaught');
INSERT INTO smart_scripts VALUES (29338, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Raven Bishop - On Spell Hit - Despawn');

-- Leave Our Mark (12995)
DELETE FROM spell_scripts WHERE Id=23301;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=23301;
INSERT INTO conditions VALUES (17, 0, 23301, 0, 0, 31, 1, 3, 29880, 0, 0, 0, 0, '', 'Require Jotunheim Warrior');
INSERT INTO conditions VALUES (17, 0, 23301, 0, 1, 31, 1, 3, 30037, 0, 0, 0, 0, '', 'Require Mjordin Combatant');
INSERT INTO conditions VALUES (17, 0, 23301, 0, 2, 31, 1, 3, 30243, 0, 0, 0, 0, '', 'Njorndar Spear-Sister');
INSERT INTO conditions VALUES (17, 0, 23301, 0, 3, 31, 1, 3, 30632, 0, 0, 0, 0, '', 'Require Mjordin Water Magus');
INSERT INTO conditions VALUES (17, 0, 23301, 0, 0, 36, 1, 0, 0, 0, 1, 22, 0, '', 'Require Dead Unit');
INSERT INTO conditions VALUES (17, 0, 23301, 0, 1, 36, 1, 0, 0, 0, 1, 22, 0, '', 'Require Dead Unit');
INSERT INTO conditions VALUES (17, 0, 23301, 0, 2, 36, 1, 0, 0, 0, 1, 22, 0, '', 'Require Dead Unit');
INSERT INTO conditions VALUES (17, 0, 23301, 0, 3, 36, 1, 0, 0, 0, 1, 22, 0, '', 'Require Dead Unit');
INSERT INTO conditions VALUES (17, 0, 23301, 0, 0, 30, 1, 192180, 3, 0, 1, 0, 0, '', 'Require No Ebon Blade Banner Nearby');
INSERT INTO conditions VALUES (17, 0, 23301, 0, 1, 30, 1, 192180, 3, 0, 1, 0, 0, '', 'Require No Ebon Blade Banner Nearby');
INSERT INTO conditions VALUES (17, 0, 23301, 0, 2, 30, 1, 192180, 3, 0, 1, 0, 0, '', 'Require No Ebon Blade Banner Nearby');
INSERT INTO conditions VALUES (17, 0, 23301, 0, 3, 30, 1, 192180, 3, 0, 1, 0, 0, '', 'Require No Ebon Blade Banner Nearby');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(29880, 30243, 30632);
DELETE FROM smart_scripts WHERE entryorguid IN(29880, 30243, 30632) AND source_type=0;
INSERT INTO smart_scripts VALUES (29880, 0, 0, 0, 0, 0, 100, 0, 0, 0, 30000, 30000, 11, 23262, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jotunheim Warrior - In Combat - Cast Demoralize');
INSERT INTO smart_scripts VALUES (29880, 0, 1, 0, 0, 0, 100, 0, 2000, 3000, 5000, 7000, 11, 43410, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jotunheim Warrior - In Combat - Cast Chop');
INSERT INTO smart_scripts VALUES (29880, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 33, 30644, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Jotunheim Warrior - On Just Died - Quest Credit The Art of Being a Water Terror');
INSERT INTO smart_scripts VALUES (29880, 0, 3, 0, 4, 0, 66, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Jotunheim Warrior - On Agro - Say');
INSERT INTO smart_scripts VALUES (29880, 0, 4, 0, 8, 0, 100, 0, 23301, 0, 0, 0, 33, 30220, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Jotunheim Warrior - On Spell Hit - Kill Credit');
INSERT INTO smart_scripts VALUES (30243, 0, 0, 0, 0, 0, 100, 0, 2000, 3000, 3000, 4000, 11, 38029, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Njorndar Spear-Sister - In Combat - Cast Stab');
INSERT INTO smart_scripts VALUES (30243, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 33, 30644, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Njorndar Spear-Sister - On Just Died - Quest Credit The Art of Being a Water Terror');
INSERT INTO smart_scripts VALUES (30243, 0, 2, 0, 4, 0, 66, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Njorndar Spear-Sister - On Agro - Say');
INSERT INTO smart_scripts VALUES (30243, 0, 3, 0, 8, 0, 100, 0, 23301, 0, 0, 0, 33, 30220, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Njorndar Spear-Sister - On Spell Hit - Kill Credit');
INSERT INTO smart_scripts VALUES (30632, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 7855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Water Magus - On Respawn - Cast Summon Water Terror');
INSERT INTO smart_scripts VALUES (30632, 0, 1, 0, 0, 0, 100, 0, 0, 0, 3000, 4000, 11, 9672, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Water Magus - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (30632, 0, 2, 0, 0, 0, 100, 0, 3000, 3000, 7000, 9000, 11, 15532, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Water Magus - In Combat - Cast Frost Nova');
INSERT INTO smart_scripts VALUES (30632, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 33, 30644, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Water Magus - On Just Died - Quest Credit The Art of Being a Water Terror');
INSERT INTO smart_scripts VALUES (30632, 0, 4, 0, 4, 0, 66, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Water Magus - On Agro - Say');
INSERT INTO smart_scripts VALUES (30632, 0, 5, 0, 8, 0, 100, 0, 23301, 0, 0, 0, 33, 30220, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Water Magus - On Spell Hit - Kill Credit');

-- In Strict Confidence (12840)
DELETE FROM creature_text WHERE entry IN(29489, 29490);
INSERT INTO creature_text VALUES (29489, 0, 0, 'Please... wait... stop! I don''t know where the grand admiral is, but I''m sure we can work it out.', 12, 0, 100, 0, 0, 0, 0, 'Captain Welsington');
INSERT INTO creature_text VALUES (29489, 1, 0, 'Archbishop Landgren must know! Aaaaaagggghhhh.....!', 12, 0, 100, 0, 0, 0, 0, 'Captain Welsington');
INSERT INTO creature_text VALUES (29490, 0, 0, 'I don''t know where the grand admiral is. Go to hell!', 12, 0, 100, 0, 0, 0, 0, 'Captain Hartford');
DELETE FROM smart_scripts WHERE entryorguid IN(29489, 29490) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(2949000, 2949001) AND source_type=9;
INSERT INTO smart_scripts VALUES (29489, 0, 0, 0, 2, 0, 100, 1, 0, 30, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Captain Welsington - Between Health 0-30% - Say Line 0');
INSERT INTO smart_scripts VALUES (29489, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Captain Welsington- On Death - Say Line 1');
INSERT INTO smart_scripts VALUES (29489, 0, 2, 0, 9, 0, 100, 0, 8, 25000, 8000, 12000, 11, 20615, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Captain Welsington - Within 8-25 yd - cast Intercept');
INSERT INTO smart_scripts VALUES (29489, 0, 3, 0, 0, 0, 100, 0, 3000, 7000, 5000, 10000, 11, 16856, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Captain Welsington- In Combat - cast Mortal Strike');
INSERT INTO smart_scripts VALUES (29490, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Captain Hartford - On Death - Say Line 0');
INSERT INTO smart_scripts VALUES (29490, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 31, 1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Captain Hartford - On Aggro - Set Random Phase');
INSERT INTO smart_scripts VALUES (29490, 0, 3, 0, 0, 1, 100, 0, 0, 1000, 3000, 4000, 11, 20822, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Captain Hartford - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (29490, 0, 4, 0, 0, 2, 100, 0, 0, 1000, 3000, 4000, 11, 20823, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Captain Hartford - In Combat - Cast Fireball');
INSERT INTO smart_scripts VALUES (29490, 0, 5, 0, 0, 0, 100, 0, 5000, 10000, 10000, 15000, 11, 11831, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Captain Hartford - In Combat - cast Frost Nova');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry IN(29489, 29490);
INSERT INTO conditions VALUES (22, 1, 29489, 0, 0, 9, 2, 12840, 0, 0, 0, 0, 0, '', 'Captain Welsington- Between Health - Say Line 0 require quest 12840 taken');
INSERT INTO conditions VALUES (22, 2, 29489, 0, 0, 9, 0, 12840, 0, 0, 0, 0, 0, '', 'Captain Welsington- On Death - Say Line 1 require quest 12840 taken');
INSERT INTO conditions VALUES (22, 2, 29489, 0, 1, 28, 0, 12840, 0, 0, 0, 0, 0, '', 'Captain Welsington- On Death - Say Line 1 require quest 12840 complete');
INSERT INTO conditions VALUES (22, 1, 29490, 0, 0, 9, 0, 12840, 0, 0, 0, 0, 0, '', 'Captain Hartford - On Death - Say Line 0 require quest 12840 taken');
INSERT INTO conditions VALUES (22, 1, 29490, 0, 1, 28, 0, 12840, 0, 0, 0, 0, 0, '', 'Captain Hartford - On Death - Say Line 0 require quest 12840 complete');

-- Spill Their Blood (13134)
UPDATE gameobject_template SET data3=5000 WHERE entry IN(192932, 192933);

-- Ebon Blade Prisoners (12982)
DELETE FROM creature_text WHERE entry IN(30197, 30198, 30199, 30200);
INSERT INTO creature_text VALUES (30197, 0, 0, 'Thanks. How can I help?', 12, 0, 100, 0, 0, 0, 0, 'Ebon Blade Prisoner');
INSERT INTO creature_text VALUES (30197, 0, 1, 'I can fight by your side for a few minutes before I need to return to The Shadow Vault.', 12, 0, 100, 0, 0, 0, 0, 'Ebon Blade Prisoner');
INSERT INTO creature_text VALUES (30197, 0, 2, 'Thank you, $c. I owe you.', 12, 0, 100, 0, 0, 0, 0, 'Ebon Blade Prisoner');
INSERT INTO creature_text VALUES (30197, 0, 3, 'Excellent. Let''s kill some vrykul!', 12, 0, 100, 0, 0, 0, 0, 'Ebon Blade Prisoner');
INSERT INTO creature_text VALUES (30197, 0, 4, 'It''s time for revenge!', 12, 0, 100, 0, 0, 0, 0, 'Ebon Blade Prisoner');
INSERT INTO creature_text VALUES (30197, 0, 5, 'Where''s my damned helmet? Well, at least they left my sword here. Idiots.', 12, 0, 100, 0, 0, 0, 0, 'Ebon Blade Prisoner');
INSERT INTO creature_text VALUES (30197, 0, 6, 'Kill!', 12, 0, 100, 0, 0, 0, 0, 'Ebon Blade Prisoner');
INSERT INTO creature_text VALUES (30198, 0, 0, 'Thanks. How can I help?', 12, 0, 100, 0, 0, 0, 0, 'Ebon Blade Prisoner');
INSERT INTO creature_text VALUES (30198, 0, 1, 'I can fight by your side for a few minutes before I need to return to The Shadow Vault.', 12, 0, 100, 0, 0, 0, 0, 'Ebon Blade Prisoner');
INSERT INTO creature_text VALUES (30198, 0, 2, 'Thank you, $c. I owe you.', 12, 0, 100, 0, 0, 0, 0, 'Ebon Blade Prisoner');
INSERT INTO creature_text VALUES (30198, 0, 3, 'Excellent. Let''s kill some vrykul!', 12, 0, 100, 0, 0, 0, 0, 'Ebon Blade Prisoner');
INSERT INTO creature_text VALUES (30198, 0, 4, 'It''s time for revenge!', 12, 0, 100, 0, 0, 0, 0, 'Ebon Blade Prisoner');
INSERT INTO creature_text VALUES (30198, 0, 5, 'Where''s my damned helmet? Well, at least they left my sword here. Idiots.', 12, 0, 100, 0, 0, 0, 0, 'Ebon Blade Prisoner');
INSERT INTO creature_text VALUES (30198, 0, 6, 'Kill!', 12, 0, 100, 0, 0, 0, 0, 'Ebon Blade Prisoner');
INSERT INTO creature_text VALUES (30199, 0, 0, 'Thanks. How can I help?', 12, 0, 100, 0, 0, 0, 0, 'Ebon Blade Prisoner');
INSERT INTO creature_text VALUES (30199, 0, 1, 'I can fight by your side for a few minutes before I need to return to The Shadow Vault.', 12, 0, 100, 0, 0, 0, 0, 'Ebon Blade Prisoner');
INSERT INTO creature_text VALUES (30199, 0, 2, 'Thank you, $c. I owe you.', 12, 0, 100, 0, 0, 0, 0, 'Ebon Blade Prisoner');
INSERT INTO creature_text VALUES (30199, 0, 3, 'Excellent. Let''s kill some vrykul!', 12, 0, 100, 0, 0, 0, 0, 'Ebon Blade Prisoner');
INSERT INTO creature_text VALUES (30199, 0, 4, 'It''s time for revenge!', 12, 0, 100, 0, 0, 0, 0, 'Ebon Blade Prisoner');
INSERT INTO creature_text VALUES (30199, 0, 5, 'Where''s my damned helmet? Well, at least they left my sword here. Idiots.', 12, 0, 100, 0, 0, 0, 0, 'Ebon Blade Prisoner');
INSERT INTO creature_text VALUES (30199, 0, 6, 'Kill!', 12, 0, 100, 0, 0, 0, 0, 'Ebon Blade Prisoner');
INSERT INTO creature_text VALUES (30200, 0, 0, 'Thanks. How can I help?', 12, 0, 100, 0, 0, 0, 0, 'Ebon Blade Prisoner');
INSERT INTO creature_text VALUES (30200, 0, 1, 'I can fight by your side for a few minutes before I need to return to The Shadow Vault.', 12, 0, 100, 0, 0, 0, 0, 'Ebon Blade Prisoner');
INSERT INTO creature_text VALUES (30200, 0, 2, 'Thank you, $c. I owe you.', 12, 0, 100, 0, 0, 0, 0, 'Ebon Blade Prisoner');
INSERT INTO creature_text VALUES (30200, 0, 3, 'Excellent. Let''s kill some vrykul!', 12, 0, 100, 0, 0, 0, 0, 'Ebon Blade Prisoner');
INSERT INTO creature_text VALUES (30200, 0, 4, 'It''s time for revenge!', 12, 0, 100, 0, 0, 0, 0, 'Ebon Blade Prisoner');
INSERT INTO creature_text VALUES (30200, 0, 5, 'Where''s my damned helmet? Well, at least they left my sword here. Idiots.', 12, 0, 100, 0, 0, 0, 0, 'Ebon Blade Prisoner');
INSERT INTO creature_text VALUES (30200, 0, 6, 'Kill!', 12, 0, 100, 0, 0, 0, 0, 'Ebon Blade Prisoner');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(30197, 30198, 30199, 30200);
DELETE FROM smart_scripts WHERE entryorguid IN(30197, 30198, 30199, 30200) AND source_type=0;
INSERT INTO smart_scripts VALUES (30197, 0, 0, 0, 60, 0, 100, 257, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Ebon Blade Prisoner - On Respawn - Say Line 0');
INSERT INTO smart_scripts VALUES (30198, 0, 0, 0, 60, 0, 100, 257, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Ebon Blade Prisoner - On Respawn - Say Line 0');
INSERT INTO smart_scripts VALUES (30199, 0, 0, 0, 60, 0, 100, 257, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Ebon Blade Prisoner - On Respawn - Say Line 0');
INSERT INTO smart_scripts VALUES (30200, 0, 0, 0, 60, 0, 100, 257, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Ebon Blade Prisoner - On Respawn - Say Line 0');

-- Raise the Barricades (13306)
-- Raise the Barricades (13332)
REPLACE INTO creature_template_addon VALUES (31887, 0, 0, 0, 1, 0, '59919');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=31887;
DELETE FROM smart_scripts WHERE entryorguid=31887 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(31887*100+0, 31887*100+1, 31887*100+2) AND source_type=9;
INSERT INTO smart_scripts VALUES (31887, 0, 0, 1, 8, 0, 100, 0, 59925, 0, 0, 0, 88, 31887*100+0, 31887*100+2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ebon Blade Marker - On Spellhit Construct Barricade - Run Random Script');
INSERT INTO smart_scripts VALUES (31887, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 33, 31887, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Ebon Blade Marker - On Spellhit Construct Barricade - Quest Credit Raise the Barricades');
INSERT INTO smart_scripts VALUES (31887, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ebon Blade Marker - On Spellhit Construct Barricade - Despawn Instant');
INSERT INTO smart_scripts VALUES (31887*100+0, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 59922, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ebon Blade Marker - On Script - Cast Summon Barricade A');
INSERT INTO smart_scripts VALUES (31887*100+1, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 59923, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ebon Blade Marker - On Script - Cast Summon Barricade B');
INSERT INTO smart_scripts VALUES (31887*100+2, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 59924, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ebon Blade Marker - On Script - Cast Summon Barricade C');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=59925;
INSERT INTO conditions VALUES (13, 1, 59925, 0, 0, 31, 0, 3, 31887, 0, 0, 0, 0, '', 'Construct Barricade - Target must be Ebon Blade Marker');

-- The Ironwall Rampart (13312)
-- The Ironwall Rampart (13337)
DELETE FROM creature_text WHERE entry=32162;
INSERT INTO creature_text VALUES (32162, 0, 0, 'You think you can wrest this rampart from my control?', 12, 0, 100, 1, 0, 0, 0, 'Grimkor the Wicked');
INSERT INTO creature_text VALUES (32162, 1, 0, 'I think not. When I''ve finished beating the arrogance out of you, I''ll impale your corpse on the spikes as an example to any other ''heroes''!', 12, 0, 100, 1, 0, 0, 0, 'Grimkor the Wicked');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=60036;
INSERT INTO conditions VALUES (17, 0, 60036, 0, 0, 29, 0, 32162, 70, 0, 1, 0, 0, '', 'Require no Grimkor the Wicked nearby');
INSERT INTO conditions VALUES (17, 0, 60036, 0, 0, 29, 0, 32163, 70, 0, 1, 0, 0, '', 'Require no Grimkor''s Hound nearby');
DELETE FROM event_scripts WHERE id=20543;
INSERT INTO event_scripts VALUES (20543, 0, 10, 32162, 180000, 0, 7508.16, 2601.39, 534.672, 3.43);
INSERT INTO event_scripts VALUES (20543, 0, 10, 32163, 180000, 0, 7511.13, 2600.6, 534.672, 3.43);
UPDATE creature_template SET unit_flags=768, AIName='SmartAI', ScriptName='' WHERE entry=32162;
UPDATE creature_template SET minlevel=80, maxlevel=80, exp=2, mindmg=200, maxdmg=300, attackpower=400, unit_flags=768, AIName='SmartAI', ScriptName='' WHERE entry=32163;
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=28878;
DELETE FROM smart_scripts WHERE entryorguid IN(32162, 32163, 28878) AND source_type=0;
INSERT INTO smart_scripts VALUES (32162, 0, 0, 0, 60, 0, 100, 257, 2000, 2000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grimkor the Wicked - On Update - Say Line 0');
INSERT INTO smart_scripts VALUES (32162, 0, 1, 0, 60, 0, 100, 257, 8000, 8000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grimkor the Wicked - On Update - Say Line 1');
INSERT INTO smart_scripts VALUES (32162, 0, 2, 0, 60, 0, 100, 257, 13000, 13000, 0, 0, 5, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grimkor the Wicked - On Update - Play Emote');
INSERT INTO smart_scripts VALUES (32162, 0, 3, 4, 60, 0, 100, 257, 19000, 19000, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grimkor the Wicked - On Update - Remove Unit Flags');
INSERT INTO smart_scripts VALUES (32162, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 19, 32163, 10, 0, 0, 0, 0, 0, 'Grimkor the Wicked - On Update - Remove Unit Flags');
INSERT INTO smart_scripts VALUES (32162, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Grimkor the Wicked - On Update - Attack Start');
INSERT INTO smart_scripts VALUES (32162, 0, 6, 0, 0, 0, 100, 0, 0, 0, 3000, 4000, 11, 15537, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grimkor the Wicked - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (32162, 0, 7, 0, 0, 0, 100, 0, 11000, 15000, 25000, 35000, 11, 52611, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grimkor the Wicked - In Combat - Cast Summon Skeletons');
INSERT INTO smart_scripts VALUES (32162, 0, 8, 9, 7, 0, 100, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 19, 32163, 40, 0, 0, 0, 0, 0, 'Grimkor the Wicked - On Evade - Despawn Target');
INSERT INTO smart_scripts VALUES (32162, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 11, 28878, 40, 0, 0, 0, 0, 0, 'Grimkor the Wicked - On Evade - Despawn Target');
INSERT INTO smart_scripts VALUES (32162, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grimkor the Wicked - On Evade - Despawn Self');
INSERT INTO smart_scripts VALUES (32163, 0, 0, 0, 0, 0, 100, 0, 10000, 10000, 20000, 30000, 11, 20817, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grimkor''s Hound - In Combat - Cast Mana Burn');
INSERT INTO smart_scripts VALUES (32163, 0, 1, 0, 0, 0, 100, 0, 3000, 6000, 9000, 12000, 11, 3604, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grimkor''s Hound - In Combat - Cast Tendon Rip');
INSERT INTO smart_scripts VALUES (32163, 0, 2, 0, 0, 0, 100, 0, 9000, 11000, 19000, 22000, 11, 14331, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grimkor''s Hound - In Combat - Cast Vicious Rend');

-- You'll Need a Gryphon (12814)
UPDATE creature_loot_template SET ChanceOrQuestChance=-100 WHERE item=40970;
UPDATE creature_template SET speed_run=1.14286, InhabitType=5, AIName='SmartAI', ScriptName='' WHERE entry=29403;
DELETE FROM smart_scripts WHERE entryorguid=29403 AND source_type=0;
INSERT INTO smart_scripts VALUES (29403, 0, 0, 0, 25, 0, 100, 257, 0, 0, 0, 0, 11, 61646, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Gryphon - On Reset - Cast Loaner Vehicle Speed');

-- Honor Challenge (12939)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=30037);
DELETE FROM creature WHERE id=30037;
INSERT INTO creature VALUES (122271, 30037, 571, 1, 1, 26732, 1, 8457.58, 3118.42, 588.141, 4.496, 300, 0, 0, 12175, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (122272, 30037, 571, 1, 1, 26732, 1, 8418.17, 3089.28, 588.141, 3.57539, 300, 0, 0, 12175, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (122273, 30037, 571, 1, 1, 26730, 1, 8437.17, 3145.49, 588.143, 3.86766, 300, 0, 0, 12175, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (122274, 30037, 571, 1, 1, 26730, 1, 8468.54, 3095.92, 588.141, 0.620054, 300, 0, 0, 12175, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (122275, 30037, 571, 1, 1, 26732, 1, 8403.14, 3111.97, 588.142, 2.48368, 300, 0, 0, 12175, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (122276, 30037, 571, 1, 1, 26730, 1, 8434.06, 3077.33, 588.137, 5.59947, 300, 0, 0, 12175, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (122277, 30037, 571, 1, 1, 26731, 1, 8389.83, 3089.32, 588.211, 0.317654, 300, 0, 0, 12175, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (122280, 30037, 571, 1, 1, 26732, 1, 8434.4, 3142.86, 588.143, 0.762422, 300, 0, 0, 12175, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (122281, 30037, 571, 1, 1, 26730, 1, 8427.4, 3123.76, 588.657, 4.36666, 300, 0, 0, 12175, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (122282, 30037, 571, 1, 1, 26729, 1, 8413.82, 3087.25, 588.237, 0.493847, 300, 0, 0, 12175, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (122283, 30037, 571, 1, 1, 26732, 1, 8411.8, 3161.05, 588.103, 0.76142, 300, 0, 0, 12175, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (122284, 30037, 571, 1, 1, 26731, 1, 8425.78, 3120.35, 588.158, 1.05594, 300, 0, 0, 12175, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (122287, 30037, 571, 1, 1, 26729, 1, 8442.77, 3100.64, 588.224, 1.22173, 300, 0, 0, 12175, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (122288, 30037, 571, 1, 1, 26732, 1, 8400.3, 3114.16, 588.142, 5.62528, 300, 0, 0, 12175, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (122289, 30037, 571, 1, 1, 26730, 1, 8437.34, 3074.8, 588.211, 2.79253, 300, 0, 0, 12175, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (122290, 30037, 571, 1, 1, 26730, 1, 8394.13, 3090.78, 588.383, 3.66519, 300, 0, 0, 12175, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (122291, 30037, 571, 1, 1, 26730, 1, 8472.46, 3098.9, 588.224, 3.87463, 300, 0, 0, 12175, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (122292, 30037, 571, 1, 1, 26729, 1, 8444.67, 3104.78, 588.216, 4.28088, 300, 0, 0, 12175, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (122293, 30037, 571, 1, 1, 26731, 1, 8415.7, 3164.49, 588.215, 3.92699, 300, 0, 0, 12175, 0, 0, 0, 0, 0);
-- Require our Mark quest
REPLACE INTO creature_template_addon VALUES (30037, 0, 0, 0, 4097, 333, '');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=30037;
DELETE FROM smart_scripts WHERE entryorguid=30037 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=30037*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (30037, 0, 0, 0, 8, 0, 100, 0, 23301, 0, 0, 0, 33, 30220, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Combatant - On Spell Hit - Kill Credit');
INSERT INTO smart_scripts VALUES (30037, 0, 1, 0, 1, 1, 100, 0, 0, 1000, 1500, 2500, 10, 35, 36, 39, 43, 0, 0, 11, 30037, 5, 0, 0, 0, 0, 0, 'Mjordin Combatant - Out of Combat - Play Random Emote');
INSERT INTO smart_scripts VALUES (30037, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Combatant - On Reset - Set Event Phase');
INSERT INTO smart_scripts VALUES (30037, 0, 10, 11, 8, 1, 100, 0, 21855, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 11, 30037, 5, 0, 0, 0, 0, 0, 'Mjordin Combatant - On Spell Hit Challenge Flag - Set Data');
INSERT INTO smart_scripts VALUES (30037, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 30037, 5, 0, 0, 0, 0, 0, 'Mjordin Combatant - On Spell Hit Challenge Flag - Despawn Target');
INSERT INTO smart_scripts VALUES (30037, 0, 12, 13, 61, 0, 100, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Combatant - On Spell Hit Challenge Flag - Set Emote State');
INSERT INTO smart_scripts VALUES (30037, 0, 13, 14, 61, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Combatant - On Spell Hit Challenge Flag - Set Orientation');
INSERT INTO smart_scripts VALUES (30037, 0, 14, 15, 61, 0, 100, 0, 0, 0, 0, 0, 11, 52682, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Combatant - On Spell Hit Challenge Flag - Cast Honor Challenge: Summon Challenge Flag Object');
INSERT INTO smart_scripts VALUES (30037, 0, 15, 16, 61, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Combatant - On Spell Hit Challenge Flag - Set Event Phase');
INSERT INTO smart_scripts VALUES (30037, 0, 16, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 1000, 1000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Combatant - On Spell Hit Challenge Flag - Create Timed Event');
INSERT INTO smart_scripts VALUES (30037, 0, 17, 0, 59, 0, 100, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Mjordin Combatant - On Timed Event - Say Line 0');
INSERT INTO smart_scripts VALUES (30037, 0, 18, 0, 38, 0, 100, 0, 1, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Combatant - On Data Set - Set Event Phase');
INSERT INTO smart_scripts VALUES (30037, 0, 20, 0, 6, 2, 100, 0, 0, 0, 0, 0, 33, 30038, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Mjordin Combatant - On Just Died - Quest Credit Honor Challenge');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=21855;
INSERT INTO conditions VALUES (13, 1, 21855, 0, 0, 31, 0, 3, 30037, 0, 0, 0, 0, '', 'Target Mjordin Combatant');
DELETE FROM creature_text WHERE entry=30037;
INSERT INTO creature_text VALUES (30037, 0, 0, 'Come then, $r $c, I do not have all day!', 12, 0, 100, 15, 0, 0, 0, 'Mjordin Combatant');
INSERT INTO creature_text VALUES (30037, 0, 1, 'It will not get me any closer to proving myself at Valhalas to kill you, but it should be entertaining!', 12, 0, 100, 15, 0, 0, 0, 'Mjordin Combatant');
INSERT INTO creature_text VALUES (30037, 0, 2, 'If you seek death, you have found it!', 12, 0, 100, 15, 0, 0, 0, 'Mjordin Combatant');
INSERT INTO creature_text VALUES (30037, 0, 3, 'A quick trip to the underworld for you, and a laugh for me. Sounds like a fair trade!', 12, 0, 100, 15, 0, 0, 0, 'Mjordin Combatant');

-- Not-So-Honorable Combat (13137)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN (25727, 25715, 25745);
INSERT INTO conditions VALUES (13, 1, 25727, 0, 0, 31, 0, 3, 30959, 0, 0, 0, 0, '', 'Summon Nightswood only hits Target Bunny');
INSERT INTO conditions VALUES (13, 1, 25715, 0, 0, 31, 0, 3, 30924, 0, 0, 0, 0, '', 'Move Target Bunny only hits Target Bunny');
INSERT INTO conditions VALUES (13, 1, 25745, 0, 0, 31, 0, 3, 30945, 0, 0, 0, 0, '', 'Possess Vardmadra only hits Vardmadra');
UPDATE creature_template SET faction=2116, unit_flags=33088, mindmg=422, maxdmg=586, attackpower=642, minrangedmg=345, maxrangedmg=509, rangedattackpower=103, AIName='SmartAI', ScriptName='' WHERE entry=30924;
UPDATE creature_template SET faction=2116, unit_flags=33536, minlevel=80, maxlevel=80, AIName='SmartAI', ScriptName='' WHERE entry=30945;
UPDATE creature_template SET AIName='SmartAI', InhabitType=7 WHERE entry=30955;
UPDATE creature_template SET modelid1=21955, modelid2=11686, flags_extra=130, InhabitType=4, AIName='SmartAI', ScriptName='' WHERE entry=30959;
DELETE FROM creature_template_addon WHERE entry IN (30924, 30945);
INSERT INTO creature_template_addon VALUES (30924, 0, 0, 0, 1, 0, '58102');
INSERT INTO creature_template_addon VALUES (30945, 0, 0, 50331648, 1, 0, '');
DELETE FROM creature_equip_template WHERE entry=30924;
INSERT INTO creature_equip_template VALUES (30924, 1, 43296, 43295, 0, 0);
DELETE FROM creature_text WHERE entry IN (30924, 30945, 30955);
INSERT INTO creature_text VALUES (30924, 0, 0, 'Now fight me, $N! Kill Iskalder!', 14, 0, 100, 0, 0, 1167, 0, 'Possessed Iskalder');
INSERT INTO creature_text VALUES (30945, 0, 0, 'Iskalder, there you are. What is this? Engaged in battle already?', 14, 0, 100, 457, 0, 13824, 0, 'Vardmadra');
INSERT INTO creature_text VALUES (30945, 1, 0, 'NO! How is this possible?', 14, 0, 100, 457, 0, 13825, 0, 'Vardmadra');
INSERT INTO creature_text VALUES (30945, 2, 0, 'I know not how this was possible, but you must still be judged Iskalder. Wait... what is this?', 14, 0, 100, 457, 0, 13824, 0, 'Vardmadra');
INSERT INTO creature_text VALUES (30945, 3, 0, 'Stay away from me creature! Do not touch me!', 14, 0, 100, 0, 0, 1168, 0, 'Vardmadra to Nightswood');
INSERT INTO creature_text VALUES (30945, 4, 0, 'Ahahahahahaha! It is done. Return to my cave. We have much to discuss!', 14, 0, 100, 457, 0, 1167, 0, 'Vardmadra to ');
INSERT INTO creature_text VALUES (30955, 0, 0, 'This? This is me taking control of you. This is me setting up my final revenge!', 14, 0, 100, 457, 0, 13824, 0, 'Lady Nightswood');
DELETE FROM event_scripts WHERE id=20069;
INSERT INTO event_scripts VALUES (20069, 5, 10, 30924, 180000, 0, 7229.436, 3642.27, 809.0175, 0);
DELETE FROM smart_scripts WHERE source_type=0 AND entryorguid IN (30924, 30945, 30955, 30959);
DELETE FROM smart_scripts WHERE source_type=9 AND entryorguid=30959*100;
INSERT INTO smart_scripts VALUES (30924, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Iskalder - On Summon - Remove unit flag');
INSERT INTO smart_scripts VALUES (30924, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Iskalder - On Link - Talk');
INSERT INTO smart_scripts VALUES (30924, 0, 2, 0, 2, 0, 100, 1, 0, 65, 0, 0, 12, 30945, 3, 180000, 0, 0, 0, 8, 0, 0, 0, 7182.766602, 3661.931885, 826.149292, 5.838641, 'Possessed Iskalder - on 65% HP - Spawn Vardmara');
INSERT INTO smart_scripts VALUES (30924, 0, 3, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 60108, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Iskalder - On Aggro - Cast Heroic Leap');
INSERT INTO smart_scripts VALUES (30924, 0, 4, 0, 0, 0, 100, 0, 3500, 3500, 14500, 16700, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Iskalder - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (30924, 0, 5, 0, 0, 0, 100, 0, 5000, 6000, 11200, 15800, 11, 57846, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Iskalder - In Combat - Cast Heroic Strike');
INSERT INTO smart_scripts VALUES (30924, 0, 6, 0, 0, 0, 100, 0, 9000, 11000, 25000, 25000, 11, 60121, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Iskalder - In Combat - Cast Ancient Curse');
INSERT INTO smart_scripts VALUES (30924, 0, 7, 0, 2, 0, 100, 1, 0, 50, 0, 0, 1, 0, 0, 0, 0, 0, 0, 11, 30945, 200, 0, 0, 0, 0, 0, 'Iskalder - On HPC - Make Vardmadra Say');
INSERT INTO smart_scripts VALUES (30924, 0, 8, 0, 6, 0, 100, 1, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 30945, 200, 0, 0, 0, 0, 0, ' Iskalder - On event death - Send Data to Vardmadra');
INSERT INTO smart_scripts VALUES (30924, 0, 9, 10, 1, 0, 100, 1, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Iskalder - OOC - Remove unit flag');
INSERT INTO smart_scripts VALUES (30924, 0, 10, 0, 61, 0, 100, 1, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 11, 30945, 300, 0, 0, 0, 0, 0, 'Possessed Iskalder - On link - Set Data on Vardmara');
INSERT INTO smart_scripts VALUES (30945, 0, 0, 1, 38, 0, 100, 0, 1, 1, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vardmadra - On Receive Data - Set Run');
INSERT INTO smart_scripts VALUES (30945, 0, 1, 2, 61, 0, 100, 0, 1, 1, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 7234.742, 3643.584, 811.8065, 5.507, 'Vardmadra - Linked with Previous Event - Move to position');
INSERT INTO smart_scripts VALUES (30945, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vardmadra - Linked with Previous Event - Say');
INSERT INTO smart_scripts VALUES (30945, 0, 3, 4, 61, 0, 100, 1, 0, 0, 0, 0, 11, 25715, 2, 0, 0, 0, 0, 19, 30924, 200, 1, 0, 0, 0, 0, 'Vardmadra - Linked with Previous Event - Cast Not-So-Honorable Combat: Summon Lady Nightswood''s Moveto Target Bunny');
INSERT INTO smart_scripts VALUES (30945, 0, 4, 5, 52, 0, 100, 0, 1, 30945, 0, 0, 1, 2, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vardmadra - On Text Over - Say');
INSERT INTO smart_scripts VALUES (30945, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 30924, 200, 1, 0, 0, 0, 0, 'Vardmadra - On Link - Turn to Iskalder');
INSERT INTO smart_scripts VALUES (30945, 0, 6, 7, 52, 0, 100, 0, 2, 30945, 0, 0, 1, 0, 10000, 0, 0, 0, 0, 11, 30955, 200, 0, 0, 0, 0, 0, 'Vardmadra - On Text Over - Say');
INSERT INTO smart_scripts VALUES (30945, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 30955, 200, 0, 0, 0, 0, 0, 'Vardmadra - On Link - Turn to Lady Nightswood');
INSERT INTO smart_scripts VALUES (30945, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 30955, 200, 0, 0, 0, 0, 0, 'Vardmadra - On link - Send Data to Lady Nightswood');
INSERT INTO smart_scripts VALUES (30945, 0, 9, 0, 52, 0, 100, 0, 0, 30955, 0, 0, 1, 3, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vardmadra - On Text Over - Say');
INSERT INTO smart_scripts VALUES (30945, 0, 10, 0, 52, 0, 100, 0, 3, 30945, 0, 0, 1, 4, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vardmadra- On Text Over - Say');
INSERT INTO smart_scripts VALUES (30945, 0, 11, 0, 52, 0, 100, 0, 4, 30945, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vardmadra - On Text Over - Despawn');
INSERT INTO smart_scripts VALUES (30945, 0, 12, 0, 38, 0, 100, 0, 2, 2, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vardmadra - On Receive Data - Despawn');
INSERT INTO smart_scripts VALUES (30959, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 80, 30959*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lady Nightswood Move-to-Bunny - On Summon - Start Timed Script');
INSERT INTO smart_scripts VALUES (30959*100, 9, 0, 0, 0, 0, 100, 0, 7000, 7000, 7000, 7000, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 7242.77, 3631.67, 814.0644, 2.227, 'Lady Nightswood Move-to-Bunny - On Script - Go to position');
INSERT INTO smart_scripts VALUES (30959*100, 9, 1, 0, 0, 0, 100, 0, 8000, 8000, 8000, 8000, 11, 25727, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lady Nightswood Move-to-Bunny - Linked with Previous Event - Cast Not-So-Honorable Combat: Summon Lady Nightswood''s Moveto Target Bunny');
INSERT INTO smart_scripts VALUES (30955, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 30945, 200, 0, 0, 0, 0, 0, 'Lady Nightswood - On Summon - Turn to Vardmadra');
INSERT INTO smart_scripts VALUES (30955, 0, 1, 0, 38, 0, 100, 0, 1, 1, 0, 0, 11, 25745, 0, 0, 0, 0, 0, 19, 30945, 200, 0, 0, 0, 0, 0, 'Lady Nigtswood - On Receive Data - Possess Vardmadra');
