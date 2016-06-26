
REPLACE INTO game_event VALUES(1, "2014-06-22 00:01:00", "2020-12-31 06:00:00", 525600, 20160, 341, "Midsummer Fire Festival", 0);

-- Fix duplicate quest offers
DELETE FROM creature_queststarter WHERE quest IN(SELECT quest FROM game_event_creature_quest WHERE eventEntry=1);
DELETE FROM gameobject_queststarter WHERE quest IN(SELECT quest FROM game_event_gameobject_quest WHERE eventEntry=1);


-- Fix some vendors
UPDATE item_template SET BuyCount=5 WHERE entry IN(23326, 34599);

-- Shards of Ahune (35723) drop chance corrected
UPDATE gameobject_loot_template SET ChanceOrQuestChance=100 WHERE item=35723;

-- QUEST FIXES
-- Torch Tossing (11731), ally
-- More Torch Tossing (11921)
UPDATE quest_template SET LimitTime=40, SourceSpellId=45716 WHERE Id=11731;
UPDATE quest_template SET PrevQuestId=11731, LimitTime=90, SourceSpellId=46630 WHERE Id=11921;

-- Torch Tossing (11922), horde
-- More Torch Tossing (11926)
UPDATE quest_template SET LimitTime=40, SourceSpellId=45716 WHERE Id=11922;
UPDATE quest_template SET PrevQuestId=11922, LimitTime=90, SourceSpellId=46630 WHERE Id=11926;

-- Quest script
UPDATE creature_template SET ScriptName="npc_midsummer_torch_target" WHERE entry=25535;
DELETE FROM spell_script_names WHERE spell_id IN(46630, 45716);
INSERT INTO spell_script_names VALUES(46630, "spell_midsummer_torch_quest");
INSERT INTO spell_script_names VALUES(45716, "spell_midsummer_torch_quest");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=46054;
INSERT INTO conditions VALUES (13, 1, 46054, 0, 0, 31, 0, 3, 25535, 0, 0, 0, 0, '', '');

-- Torch Catching (11657)
-- More Torch Catching (11924)
-- Torch Catching (11923)
-- More Torch Catching (11925)
UPDATE quest_template SET PrevQuestId=11657 WHERE Id=11924;
UPDATE quest_template SET PrevQuestId=11923 WHERE Id=11925;
DELETE FROM disables WHERE entry=45669 AND sourceType=0 AND flags=64;
INSERT INTO disables VALUES(0, 45669, 64, '', '', 'Disable LOS for Torch Catching quests');

-- quest script
DELETE FROM spell_script_names WHERE spell_id IN(46747, 45671);
INSERT INTO spell_script_names VALUES(46747, "spell_midsummer_fling_torch");
INSERT INTO spell_script_names VALUES(45671, "spell_midsummer_fling_torch");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=45671;
INSERT INTO conditions VALUES (13, 1, 45671, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=45676;
INSERT INTO conditions VALUES (13, 5, 45676, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', '');

-- A Thief's Reward
UPDATE quest_template SET NextQuestId=9339, RewardSpellCast=29235 WHERE Id IN(9330, 9331, 9332, 11933);
UPDATE quest_template SET NextQuestId=9365, RewardSpellCast=29235 WHERE Id IN(9324, 9325, 9326, 11935);

-- Incense for the Scorchlings
UPDATE quest_template SET SpecialFlags=2, SourceSpellId=46825 WHERE Id=11964;
UPDATE quest_template SET SpecialFlags=2, SourceSpellId=46826 WHERE Id=11966;
REPLACE INTO creature_text VALUES(26520, 0, 0, "Thank you again, $N, for this delectable incense.", 12, 0, 100, 0, 0, 0, 0, "Scorchling 0");
REPLACE INTO creature_text VALUES(26520, 1, 0, "Summer Scorchling devours the incense. It's ravenous!", 16, 0, 100, 0, 0, 0, 0, "Scorchling 1");
REPLACE INTO creature_text VALUES(26520, 2, 0, "So good! So packed with energy!", 12, 0, 100, 0, 0, 0, 0, "Scorchling 2");
REPLACE INTO creature_text VALUES(26520, 3, 0, "It has everything a growing scorchling needs!", 12, 0, 100, 0, 0, 0, 0, "Scorchling 3");
REPLACE INTO creature_text VALUES(26520, 4, 0, "I can feel the power SURGING within me!", 12, 0, 100, 0, 0, 0, 0, "Scorchling 4");
REPLACE INTO creature_text VALUES(26520, 5, 0, "Summer Scorchling bellows with laughter!", 16, 0, 100, 0, 0, 0, 0, "Scorchling 5");
REPLACE INTO creature_text VALUES(26520, 6, 0, "Now! Finally! Our plans can take effect!", 12, 0, 100, 0, 0, 0, 0, "Scorchling 6");
REPLACE INTO creature_text VALUES(26520, 7, 0, "KNEEL, LITTLE MORTAL! KNEEL BEFORE THE MIGHT OF THE HERALD OF RAGNAROS!", 12, 0, 100, 0, 0, 0, 0, "Scorchling 7");
REPLACE INTO creature_text VALUES(26520, 8, 0, "YOU WILL ALL PERISH IN FLAMES!", 12, 0, 100, 0, 0, 0, 0, "Scorchling 8");
REPLACE INTO creature_text VALUES(26520, 9, 0, "Summer Scorchling blinks...", 16, 0, 100, 0, 0, 0, 0, "Scorchling 9");
REPLACE INTO creature_text VALUES(26520, 10, 0, "Ah. I was merely jesting...", 12, 0, 100, 0, 0, 0, 0, "Scorchling 10");
REPLACE INTO creature_text VALUES(26401, 0, 0, "Thank you again, $N, for this delectable incense.", 12, 0, 100, 0, 0, 0, 0, "Scorchling 0");
REPLACE INTO creature_text VALUES(26401, 1, 0, "Summer Scorchling devours the incense. It's ravenous!", 16, 0, 100, 0, 0, 0, 0, "Scorchling 1");
REPLACE INTO creature_text VALUES(26401, 2, 0, "So good! So packed with energy!", 12, 0, 100, 0, 0, 0, 0, "Scorchling 2");
REPLACE INTO creature_text VALUES(26401, 3, 0, "It has everything a growing scorchling needs!", 12, 0, 100, 0, 0, 0, 0, "Scorchling 3");
REPLACE INTO creature_text VALUES(26401, 4, 0, "I can feel the power SURGING within me!", 12, 0, 100, 0, 0, 0, 0, "Scorchling 4");
REPLACE INTO creature_text VALUES(26401, 5, 0, "Summer Scorchling bellows with laughter!", 16, 0, 100, 0, 0, 0, 0, "Scorchling 5");
REPLACE INTO creature_text VALUES(26401, 6, 0, "Now! Finally! Our plans can take effect!", 12, 0, 100, 0, 0, 0, 0, "Scorchling 6");
REPLACE INTO creature_text VALUES(26401, 7, 0, "KNEEL, LITTLE MORTAL! KNEEL BEFORE THE MIGHT OF THE HERALD OF RAGNAROS!", 12, 0, 100, 0, 0, 0, 0, "Scorchling 7");
REPLACE INTO creature_text VALUES(26401, 8, 0, "YOU WILL ALL PERISH IN FLAMES!", 12, 0, 100, 0, 0, 0, 0, "Scorchling 8");
REPLACE INTO creature_text VALUES(26401, 9, 0, "Summer Scorchling blinks...", 16, 0, 100, 0, 0, 0, 0, "Scorchling 9");
REPLACE INTO creature_text VALUES(26401, 10, 0, "Ah. I was merely jesting...", 12, 0, 100, 0, 0, 0, 0, "Scorchling 10");
UPDATE creature_template SET AIName="SmartAI" WHERE entry IN(26401, 26520, 26502);
DELETE FROM smart_scripts WHERE entryorguid IN(26401, 26520, 26502) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=26520*100 AND source_type=9;
-- ragnaros
INSERT INTO smart_scripts VALUES (26502, 0, 0, 1, 37, 0, 100, 0, 0, 0, 0, 0, 41, 2500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'forced despawn on AI init');
INSERT INTO smart_scripts VALUES (26502, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 17, 449, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'linked play emote');
-- scorchlings
INSERT INTO smart_scripts VALUES (26520, 0, 0, 0, 20, 0, 100, 0, 0, 0, 0, 0, 80, 26520*100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'OOC Start script');
INSERT INTO smart_scripts VALUES (26520*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'remove quest flags');
INSERT INTO smart_scripts VALUES (26520*100, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Say text 0');
INSERT INTO smart_scripts VALUES (26520*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Say text 1');
INSERT INTO smart_scripts VALUES (26520*100, 9, 3, 0, 0, 0, 100, 0, 2500, 2500, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Say text 2');
INSERT INTO smart_scripts VALUES (26520*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 47114, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'size increase');
INSERT INTO smart_scripts VALUES (26520*100, 9, 5, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Say text 3');
INSERT INTO smart_scripts VALUES (26520*100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 47114, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'size increase');
INSERT INTO smart_scripts VALUES (26520*100, 9, 7, 0, 0, 0, 100, 0, 2500, 2500, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Say text 4');
INSERT INTO smart_scripts VALUES (26520*100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 47114, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'size increase');
INSERT INTO smart_scripts VALUES (26520*100, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Say text 5');
INSERT INTO smart_scripts VALUES (26520*100, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 47114, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'size increase');
INSERT INTO smart_scripts VALUES (26520*100, 9, 11, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Say text 6');
INSERT INTO smart_scripts VALUES (26520*100, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 47114, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'size increase');
INSERT INTO smart_scripts VALUES (26520*100, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 47120, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'ragnaros spell');
INSERT INTO smart_scripts VALUES (26520*100, 9, 14, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Say text 7');
INSERT INTO smart_scripts VALUES (26520*100, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 47114, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'size increase');
INSERT INTO smart_scripts VALUES (26520*100, 9, 16, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Say text 8');
INSERT INTO smart_scripts VALUES (26520*100, 9, 17, 0, 0, 0, 100, 0, 0, 0, 0, 0, 28, 47114, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'size increase');
INSERT INTO smart_scripts VALUES (26520*100, 9, 18, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Say text 9');
INSERT INTO smart_scripts VALUES (26520*100, 9, 19, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Say text 10');
INSERT INTO smart_scripts VALUES (26520*100, 9, 20, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'add quest flags');
INSERT INTO smart_scripts VALUES (26401, 0, 0, 0, 20, 0, 100, 0, 0, 0, 0, 0, 80, 26520*100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'OOC Start script'); -- use prepared script

-- Ahune quest chain
UPDATE creature_template SET faction=35 WHERE entry=26221;
UPDATE quest_template SET MaxLevel=31, PrevQuestId=12012 WHERE Id=11917;
UPDATE quest_template SET MaxLevel=42, PrevQuestId=12012 WHERE Id=11947;
UPDATE quest_template SET MaxLevel=50, PrevQuestId=12012 WHERE Id=11948;
UPDATE quest_template SET MaxLevel=59, PrevQuestId=12012 WHERE Id=11952;
UPDATE quest_template SET MaxLevel=66, PrevQuestId=12012 WHERE Id=11953;
UPDATE quest_template SET PrevQuestId=12012 WHERE Id IN(11954, 11955);
UPDATE quest_template SET PrevQuestId=11955 WHERE Id=11696;
UPDATE creature SET spawnMask=3 WHERE id=25697;
UPDATE quest_template SET PrevQuestId=11696 WHERE id=11691;
-- Unusual Activity
UPDATE creature_template SET faction=168, minlevel=20, maxlevel=21, mindmg=40, maxdmg=50, lootid=entry WHERE entry IN(25863, 25866);
UPDATE creature_template SET faction=168, minlevel=22, maxlevel=22, mindmg=40, maxdmg=50, lootid=entry WHERE entry=25924;
REPLACE INTO creature_loot_template VALUES(25863, 35277, -100, 1, 0, 1, 1);
REPLACE INTO creature_loot_template VALUES(25866, 35277, -100, 1, 0, 1, 1);
REPLACE INTO creature_loot_template VALUES(25924, 35277, -100, 1, 0, 1, 1);
UPDATE creature_template SET AIName="SmartAI" WHERE entry=26534;
DELETE FROM smart_scripts WHERE entryorguid=26534 AND source_type=0;
INSERT INTO smart_scripts VALUES (26534, 0, 0, 0, 60, 0, 100, 1, 5000, 7000, 0, 0, 12, 25324, 3, 60000, 0, 0, 0, 1, 0, 0, 0, 3, 2, 0, 0, 'Summon npc');
-- An Innocent Disguise
UPDATE creature_template SET AIName="SmartAI" WHERE entry=25949;
REPLACE INTO creature_text VALUES(25949, 0, 0, "These stones should be the last of them. Our coordination with Neptulon's forces will be impeccable.", 12, 0, 100, 0, 0, 0, 0, "Ice Caller Briatha 1");
REPLACE INTO creature_text VALUES(25949, 1, 0, "And your own preparations? Will the Frost Lord have a path to the portal?", 12, 0, 100, 0, 0, 0, 0, "Ice Caller Briatha 2");
REPLACE INTO creature_text VALUES(25949, 2, 0, "The ritual in coilfang will bring Ahune through once he is fully prepared, and the resulting clash between Firelord and Frostlord will rend the foundations of this world. Our ultimate goals are in reach at last...", 12, 0, 100, 0, 0, 0, 0, "Ice Caller Briatha 3");
REPLACE INTO creature_text VALUES(25951, 0, 0, "Yess. The Tidehunter will be pleased at this development. The Firelord's hold will weaken.", 12, 0, 100, 0, 0, 0, 0, "Heretic Emissary 1");
REPLACE INTO creature_text VALUES(25951, 1, 0, "Skar'this has informed us well. We have worked our way into the slave pens and await your cryomancerss.", 12, 0, 100, 0, 0, 0, 0, "Heretic Emissary 2");
DELETE FROM smart_scripts WHERE entryorguid=25949 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=25949*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (25949, 0, 0, 0, 1, 0, 100, 0, 0, 0, 40000, 40000, 80, 25949*100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'OOC Start script');
INSERT INTO smart_scripts VALUES (25949*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Say text 0');
INSERT INTO smart_scripts VALUES (25949*100, 9, 1, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 25951, 10, 0, 0, 0, 0, 0, 'Say text 0, naga');
INSERT INTO smart_scripts VALUES (25949*100, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Say text 1');
INSERT INTO smart_scripts VALUES (25949*100, 9, 3, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 25951, 10, 0, 0, 0, 0, 0, 'Say text 1, naga');
INSERT INTO smart_scripts VALUES (25949*100, 9, 4, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Say text 2');
INSERT INTO smart_scripts VALUES (25949*100, 9, 5, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 26, 11891, 0, 0, 0, 0, 0, 18, 45, 0, 0, 0, 0, 0, 0, 'Groupeventhappens');
-- Striking Back quests
UPDATE creature_template SET faction=14, minlevel=22, maxlevel=22, mindmg=25, maxdmg=30 WHERE entry=26116;
UPDATE creature_template SET faction=14, minlevel=32, maxlevel=32, mindmg=30, maxdmg=40 WHERE entry=26178;
UPDATE creature_template SET faction=14, minlevel=43, maxlevel=43, mindmg=42, maxdmg=60 WHERE entry=26204;
UPDATE creature_template SET faction=14, minlevel=51, maxlevel=51, mindmg=60, maxdmg=80 WHERE entry=26214;
UPDATE creature_template SET faction=14, minlevel=60, maxlevel=60, mindmg=140, maxdmg=180 WHERE entry=26215;
UPDATE creature_template SET faction=14, minlevel=69, maxlevel=69, mindmg=340, maxdmg=500 WHERE entry=26216;



-- Fix for Festival Loremaster/Talespinner
-- fix Festival Loremaster position
UPDATE creature SET position_x=-8826.84, position_y=865.531, position_z=98.8461, orientation=1.02102 WHERE guid=202862;
DELETE FROM creature_questender WHERE id=16817 AND quest=9367;
REPLACE INTO creature_questender VALUES(16817, 9365);
-- Talespinner
DELETE FROM creature_questender WHERE id=16818 AND quest=9368;
REPLACE INTO creature_questender VALUES(16818, 9339);

-- Ribbon Pole
UPDATE creature_template SET InhabitType=4 WHERE entry=17066;
UPDATE gameobject_template SET data10=45406 WHERE entry=181605;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=29172;
INSERT INTO conditions VALUES (13, 1, 29172, 0, 0, 31, 0, 3, 17066, 0, 0, 0, 0, '', 'Spell 29172, requires ribbon pole debug target');
DELETE FROM spell_script_names WHERE spell_id=45406;
INSERT INTO spell_script_names VALUES(45406, "spell_midsummer_ribbon_pole");

-- Involved relations fixup
DELETE FROM creature_questender WHERE quest IN(
11580,11581,11732,11734,11735,11736,11737,11738,11739,11740,11741,11742,11743,11744,11745,
11746,11747,11748,11749,11750,11751,11752,11753,11754,11755,11756,11757,11758,11759,11760,11761,11762,11763,11764,11765,11766,11767,11768,11769,
11770,11771,11772,11773,11774,11775,11776,11777,11778,11779,11780,11781,11782,11783,11784,11785,11786,11787,11799,11800,11801,11802,11803,13440,
13441,13442,13443,13444,13445,13446,13447,13449,13450,13451,13453,13454,13455,13457,13458,11583,11584,11804,11805,11806,11807,11808,11809,11810,
11811,11812,11813,11814,11815,11816,11817,11818,11819,11820,11821,11822,11823,11824,11825,11826,11827,11828,11829,11830,11831,11832,11833,11834,
11835,11836,11837,11838,11839,11840,11841,11842,11843,11844,11845,11846,11847,11848,11849,11850,11851,11852,11853,11854,11855,11856,11857,11858,
11859,11860,11861,11862,11863,13485,13486,13487,13488,13489,13490,13491,13492,13493,13494,13495,13496,13497,13498,13499,13500);
DELETE FROM gameobject_questender WHERE quest IN(
11580,11581,11732,11734,11735,11736,11737,11738,11739,11740,11741,11742,11743,11744,11745,
11746,11747,11748,11749,11750,11751,11752,11753,11754,11755,11756,11757,11758,11759,11760,11761,11762,11763,11764,11765,11766,11767,11768,11769,
11770,11771,11772,11773,11774,11775,11776,11777,11778,11779,11780,11781,11782,11783,11784,11785,11786,11787,11799,11800,11801,11802,11803,13440,
13441,13442,13443,13444,13445,13446,13447,13449,13450,13451,13453,13454,13455,13457,13458,11583,11584,11804,11805,11806,11807,11808,11809,11810,
11811,11812,11813,11814,11815,11816,11817,11818,11819,11820,11821,11822,11823,11824,11825,11826,11827,11828,11829,11830,11831,11832,11833,11834,
11835,11836,11837,11838,11839,11840,11841,11842,11843,11844,11845,11846,11847,11848,11849,11850,11851,11852,11853,11854,11855,11856,11857,11858,
11859,11860,11861,11862,11863,13485,13486,13487,13488,13489,13490,13491,13492,13493,13494,13495,13496,13497,13498,13499,13500);

-- Flame Wardens
-- template fixups
UPDATE creature_template SET npcflag=3, faction=84, unit_flags=768, flags_extra=2 WHERE Name LIKE "% Flame Warden";
UPDATE creature_template SET minlevel=80, maxlevel=80 WHERE Name LIKE "% Flame Warden" AND minlevel=1;
REPLACE INTO creature_questender VALUES
(25883, 11805),(25887, 11804),(25888, 11806),(25889, 11807),(25890, 11808),(25891, 11809),(25892, 11810),(25893, 11811),(25894, 11812),(25895, 11813),
(25896, 11814),(25897, 11815),(25898, 11816),(25899, 11817),(25900, 11818),(25901, 11819),(25902, 11820),(25903, 11821),(25904, 11822),(25905, 11823),
(25906, 11824),(25907, 11825),(25908, 11826),(25909, 11827),(25910, 11583),(25911, 11828),(25912, 11829),(25913, 11830),(25914, 11831),(25915, 11832),
(25916, 11833),(25917, 11834),(25917, 11834),(32801, 13485),(32802, 13486),(32803, 13487),(32804, 13488),(32805, 13489),(32806, 13490),(32807, 13491),(32808, 13492);

-- Flame keeper
-- template fixups
UPDATE creature_template SET npcflag=3, faction=83, unit_flags=768, flags_extra=2 WHERE Name LIKE "% Flame Keeper" AND entry <> 9956;
UPDATE creature_template SET minlevel=80, maxlevel=80 WHERE Name LIKE "% Flame Keeper" AND minlevel=1 AND entry <> 9956;
REPLACE INTO creature_questender VALUES
(25884, 11841),(25918, 11835),(25919, 11836),(25920, 11837),(25921, 11838),(25922, 11839),(25923, 11840),(25925, 11842),(25926, 11843),(25927, 11844),
(25928, 11845),(25929, 11846),(25930, 11847),(25931, 11848),(25932, 11849),(25933, 11850),(25934, 11851),(25935, 11853),(25936, 11852),(25937, 11854),
(25938, 11855),(25939, 11584),(25940, 11856),(25941, 11857),(25942, 11858),(25943, 11859),(25944, 11860),(25945, 11861),(25946, 11862),(25947, 11863),
(32809, 13493),(32810, 13494),(32811, 13495),(32812, 13496),(32813, 13497),(32814, 13498),(32815, 13499),(32816, 13500);

-- required races fix
UPDATE quest_template SET RequiredRaces=1101 WHERE Id IN(
11805, 11804, 11806, 11807, 11808, 11809, 11810, 11811, 11812, 11813, 11814, 11815,
11816, 11817, 11818, 11819, 11820, 11821, 11822, 11823, 11824, 11825, 11826, 11827,
11583, 11828, 11829, 11830, 11831, 11832, 11833, 11834, 11834, 13485, 13486, 13487,
13488, 13489, 13490, 13491, 13492, 11580, 11764, 11765, 11799, 11800, 11801, 11802,
11803, 11766, 11767, 11768, 11769, 11770, 11771, 11772, 11773, 11774, 11775, 11776,
11777, 11778, 11779, 11780, 11781, 11782, 11783, 11784, 11785, 11786, 11787, 13441,
13450, 13451, 13453, 13454, 13455, 13457, 13458);
UPDATE quest_template SET RequiredRaces=690 WHERE Id IN(
11841, 11835, 11836, 11837, 11838, 11839, 11840, 11842, 11843, 11844, 11845, 11846,
11847, 11848, 11849, 11850, 11851, 11853, 11852, 11854, 11855, 11584, 11856, 11857,
11858, 11859, 11860, 11861, 11862, 11863, 13493, 13494, 13495, 13496, 13497, 13498,
13499, 13500, 11581, 11732, 11734, 11735, 11736, 11737, 11738, 11739, 11740, 11741,
11742, 11743, 11744, 11745, 11746, 11747, 11748, 11749, 11750, 11751, 11752, 11753,
11754, 11755, 11756, 11757, 11758, 11759, 11760, 11761, 11762, 11763, 13440, 13442,
13443, 13444, 13445, 13446, 13447, 13449);

-- Alliance bonefires fix
UPDATE gameobject_template SET faction=1735 WHERE name="Alliance Bonfire";
REPLACE INTO gameobject_questender VALUES 
(187564, 11581),(187914, 11732),(187916, 11734),(187917, 11735),(187919, 11736),(187920, 11737),(187921, 11738),(187922, 11739),(187923, 11740),
(187924, 11741),(187925, 11742),(187926, 11743),(187927, 11744),(187928, 11745),(187929, 11746),(187930, 11747),(187931, 11748),(187932, 11749),
(187933, 11750),(187934, 11751),(187935, 11752),(187936, 11753),(187937, 11754),(187938, 11755),(187939, 11756),(187940, 11757),(187941, 11758),
(187942, 11759),(187943, 11760),(187944, 11761),(187945, 11762),(187946, 11763),(194032, 13440),(194035, 13442),(194036, 13443),(194038, 13444),
(194040, 13445),(194044, 13446),(194045, 13447),(194049, 13449);

-- Horde bonefires fix
UPDATE gameobject_template SET faction=1732 WHERE name="Horde Bonfire";
REPLACE INTO gameobject_questender VALUES
(187559, 11580),(187947, 11764),(187948, 11765),(187949, 11799),(187950, 11800),(187951, 11801),(187952, 11802),(187953, 11803),(187954, 11766),
(187955, 11767),(187956, 11768),(187957, 11769),(187958, 11770),(187959, 11771),(187960, 11772),(187961, 11773),(187962, 11774),(187963, 11775),
(187964, 11776),(187965, 11777),(187966, 11778),(187967, 11779),(187968, 11780),(187969, 11781),(187970, 11782),(187971, 11783),(187972, 11784),
(187973, 11785),(187974, 11786),(187975, 11787),(194033, 13441),(194034, 13450),(194037, 13451),(194039, 13453),(194042, 13454),(194043, 13455),
(194046, 13457),(194048, 13458);

-- Gossip fix
-- Alliance
REPLACE INTO gossip_menu VALUES(9410, 12377),(9395, 12377),(9412, 12377),(9413, 12377),(9396, 12377),(9411, 12377),(9352, 12377),(9393, 12377),
(9406, 12377),(9354, 12377),(9386, 12377),(9389, 12377),(9390, 12377),(9391, 12377),(9392, 12377),(9394, 12377),(9397, 12377),(9398, 12377),
(9400, 12377),(9402, 12377),(9404, 12377),(9407, 12377),(9388, 12377),(9405, 12377),(10240, 12377),(10233, 12377),(10227, 12377),(10230, 12377),
(10238, 12377),(10243, 12377),(10237, 12377),(10234, 12377),(9384, 12377),(9387, 12377),(9403, 12377),(9401, 12377),(9399, 12377),(9408, 12377),
(9385, 12377),(9409, 12377);
-- Horde
REPLACE INTO gossip_menu VALUES(9382, 12374),(9365, 12374),(9374, 12374),(9376, 12374),(9380, 12374),(9363, 12374),(9361, 12374),(9359, 12374),
(9371, 12374),(9355, 12374),(9383, 12374),(9373, 12374),(9368, 12374),(9378, 12374),(9372, 12374),(9381, 12374),(9358, 12374),(9356, 12374),
(9353, 12374),(9375, 12374),(9366, 12374),(9370, 12374),(9367, 12374),(9364, 12374),(9377, 12374),(9362, 12374),(9360, 12374),(10241, 12374),
(10232, 12374),(10228, 12374),(10231, 12374),(10239, 12374),(10242, 12374),(10236, 12374),(10235, 12374),(9369, 12374),(9357, 12374),(9379, 12374);

DELETE FROM gossip_menu_option WHERE menu_id IN(9410, 9395, 9412, 9413, 9396, 9411, 9352, 9393, 9406, 9354, 9386, 9389, 9390, 9391, 9392, 9394, 9397, 9398,
9400, 9402, 9404, 9407, 9388, 9405, 10240, 10233, 10227, 10230, 10238, 10243, 10237, 10234, 9384, 9387,
9403, 9401, 9399, 9408, 9385, 9409, 9382, 9365, 9374, 9376, 9380, 9363, 9361, 9359, 9371, 9355, 9383, 9373,
9368, 9378, 9372, 9381, 9358, 9356, 9353, 9375, 9366, 9370, 9367, 9364, 9377, 9362, 9360, 10241,
10232, 10228, 10231, 10239, 10242, 10236, 10235, 9369, 9357, 9379);
INSERT INTO gossip_menu_option VALUES(9410, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9395, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9412, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9413, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9396, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9411, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9352, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9393, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9406, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9354, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9386, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9389, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9390, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9391, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9392, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9394, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9397, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9398, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9400, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9402, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9404, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9407, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9387, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(10238, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(10240, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(10230, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(10227, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9388, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9384, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9403, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9405, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9408, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9409, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9385, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9399, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9401, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(10233, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(10234, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(10237, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(10243, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9374, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9376, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9382, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9365, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9380, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9363, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9361, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9359, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9371, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9355, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9383, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9373, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9368, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9378, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9372, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9381, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9358, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9356, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9353, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9375, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9366, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9370, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9367, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(10239, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(10232, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(10241, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(10236, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9360, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(10231, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(10228, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9369, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9379, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9364, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9357, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9362, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9377, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(10235, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(10242, 0, 0, "Stamp out the bonfire.", 1, 0, 0, 0, 0, 0, "");


-- Bonfire functionality
UPDATE gameobject_template SET ScriptName="go_midsummer_bonfire" WHERE name="Alliance Bonfire" OR name="Horde Bonfire";
UPDATE gameobject_template SET faction=0, flags=16, data4=1 WHERE entry=181288;
UPDATE creature_template SET ScriptName="npc_midsummer_bonfire" WHERE entry=16592;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=45437;
INSERT INTO conditions VALUES (13, 3, 45437, 0, 0, 31, 0, 3, 16592, 0, 0, 0, 0, '', 'Spell 45437, requires midsummer bonfire');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=29437;
INSERT INTO conditions VALUES (13, 1, 29437, 0, 0, 31, 0, 5, 181288, 0, 0, 0, 0, '', 'Spell 29437, requires midsummer bonfire GO');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=29831;
INSERT INTO conditions VALUES (13, 2, 29831, 0, 0, 31, 0, 3, 16592, 0, 0, 0, 0, '', 'Spell 45437, requires midsummer bonfire');

-- capital
UPDATE gameobject_template SET faction=1735, size=1 WHERE entry IN(181332, 181333, 181334, 188128);
UPDATE gameobject_template SET faction=1732, size=1 WHERE entry IN(181335, 181336, 181337, 188129);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(29137, 29135, 29126, 29139, 29136, 29138, 46671, 46672);
INSERT INTO spell_linked_spell VALUES(29137, 29101, 1, "Flame of Stormwind");
INSERT INTO spell_linked_spell VALUES(29135, 29102, 1, "Flame of Ironforge");
INSERT INTO spell_linked_spell VALUES(29126, 29099, 1, "Flame of Darnassus");
INSERT INTO spell_linked_spell VALUES(29139, 29133, 1, "Flame of Undercity");
INSERT INTO spell_linked_spell VALUES(29136, 29130, 1, "Flame of Orgrimmar");
INSERT INTO spell_linked_spell VALUES(29138, 29132, 1, "Flame of Thunder Bluff");
INSERT INTO spell_linked_spell VALUES(46671, 46690, 1, "Flame of Exodar");
INSERT INTO spell_linked_spell VALUES(46672, 46689, 1, "Flame of Silvermoon");

-- some visuals, fire eater flame breath
UPDATE creature SET spawndist=0, MovementType=0 WHERE id=17066;
UPDATE creature_template SET faction=84 WHERE entry=16781;
UPDATE creature_template SET AIName="SmartAI" WHERE entry=25962;
DELETE FROM smart_scripts WHERE entryorguid=25962 AND source_type=0;
INSERT INTO smart_scripts VALUES (25962, 0, 0, 0, 60, 0, 100, 0, 5000, 10000, 15000, 20000, 11, 45385, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'spell cast');

-- item, juggling torch
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=45644;
INSERT INTO conditions VALUES (13, 1, 45644, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', '');
DELETE FROM spell_script_names WHERE spell_id IN(45819, 45644);
INSERT INTO spell_script_names VALUES(45819, "spell_midsummer_juggling_torch");
INSERT INTO spell_script_names VALUES(45644, "spell_midsummer_juggling_torch");

-- ------------------------
-- Achievements
-- ------------------------
-- Burning Hot Pole Dance (271)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(6804);
DELETE FROM disables WHERE sourceType=4 AND entry IN(6804);
INSERT INTO achievement_criteria_data VALUES(6804, 5, 58933, 0, "");

-- Torch Juggler (272)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(6937);
DELETE FROM disables WHERE sourceType=4 AND entry IN(6937);
INSERT INTO achievement_criteria_data VALUES(6937, 6, 4395, 0, "");

-- ------------------------
-- Spawns
-- ------------------------
-- Creature spawns
DELETE FROM game_event_creature WHERE guid IN(SELECT guid FROM creature WHERE id IN(SELECT entry FROM creature_template WHERE (name LIKE "% flame warden" OR name LIKE "% flame keeper") AND entry > 10000));
DELETE FROM game_event_creature WHERE guid IN(SELECT guid FROM creature WHERE id BETWEEN 32801 AND 32816 OR id IN(16592, 25535, 26188, 25863, 25866, 25924, 25949, 25710));
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id BETWEEN 32801 AND 32816 OR id IN(16592, 25535, 26188, 25863, 25866, 25924, 25949, 25710));
DELETE FROM creature WHERE id BETWEEN 32801 AND 32816 OR id IN(16592, 25535, 26188, 25863, 25866, 25924, 25949, 25710);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(SELECT entry FROM creature_template WHERE (name LIKE "% flame warden" OR name LIKE "% flame keeper") AND entry > 10000)); 
DELETE FROM creature WHERE id IN(SELECT entry FROM creature_template WHERE (name LIKE "% flame warden" OR name LIKE "% flame keeper") AND entry > 10000);
DELETE FROM creature WHERE guid BETWEEN 245500 AND 245704;
INSERT INTO creature VALUES (245500, 32801, 571, 1, 1, 0, 0, 4131.28, 5394.6, 26.0905, 3.59538, 300, 0, 0, 4278, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245501, 32802, 571, 1, 1, 0, 0, 5360, 4834.39, -196.398, 5.55015, 300, 0, 0, 4278, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245502, 32803, 571, 1, 1, 0, 0, 3936.92, -595.444, 241.153, 5.95157, 300, 0, 0, 4278, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245503, 32804, 571, 1, 1, 0, 0, 2466.97, -4892.68, 262.547, 2.30383, 300, 0, 0, 4278, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245504, 32805, 571, 1, 1, 0, 0, 3400.94, -2890.38, 201.497, 2.30383, 300, 0, 0, 4278, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245505, 32806, 571, 1, 1, 0, 0, 6087.44, -1105.52, 418.267, 1.09956, 300, 0, 0, 4278, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245506, 32807, 571, 1, 1, 0, 0, 5141.78, -685.003, 170.274, 5.95157, 300, 0, 0, 4278, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245507, 32808, 571, 1, 1, 0, 0, 5627.93, -2616.49, 292.502, 1.51844, 300, 0, 0, 4278, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245508, 32809, 571, 1, 1, 0, 0, 4454.67, 5623.54, 56.9156, 4.13643, 300, 0, 0, 4278, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245509, 32810, 571, 1, 1, 0, 0, 5499.81, 4878.98, -197.865, 3.1765, 300, 0, 0, 4278, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245510, 32811, 571, 1, 1, 0, 0, 3762.39, 1481.29, 92.8882, 3.4383, 300, 0, 0, 4278, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245511, 32812, 571, 1, 1, 0, 0, 2586.68, -4337.07, 276.07, 4.13643, 300, 0, 0, 4278, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245512, 32813, 571, 1, 1, 0, 0, 3376.01, -2124.78, 124.664, 0.139626, 300, 0, 0, 4278, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245513, 32814, 571, 1, 1, 0, 0, 6150.95, -1023.05, 408.364, 1.43117, 300, 0, 0, 4278, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245514, 32815, 571, 1, 1, 0, 0, 5536.52, -733.719, 149.622, 3.12414, 300, 0, 0, 4278, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245515, 32816, 571, 1, 1, 0, 0, 5280.31, -2766.15, 292.502, 2.30383, 300, 0, 0, 4278, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245516, 16592, 1, 1, 1, 11686, 0, 151.481, -4711.98, 18.5644, 3.07253, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245517, 16592, 530, 1, 1, 11686, 0, 9383.5, -6777.43, 13.7903, 0.0251532, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245518, 16592, 530, 1, 1, 11686, 0, -3053.71, 2398.05, 60.883, 4.43274, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245519, 16592, 530, 1, 1, 11686, 0, 2274.45, 6133.53, 136.905, 1.61654, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245520, 16592, 0, 1, 1, 11686, 0, -10657.1, 1054.63, 32.6733, 2.47837, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245521, 16592, 0, 1, 1, 11686, 0, 587.056, 1365.02, 90.4778, 2.6529, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245522, 16592, 530, 1, 1, 11686, 0, 200.9, 7686.96, 22.508, -0.506145, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245523, 16592, 1, 1, 1, 11686, 0, -5513.93, -2299.73, -58.0752, 2.44346, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245524, 16592, 0, 1, 1, 11686, 0, -447.95, -4527.65, 8.59595, 1.53589, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245525, 16592, 1, 1, 1, 11686, 0, -273.242, -2662.82, 91.695, -1.8675, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245526, 16592, 530, 1, 1, 11686, 0, -2553.32, 4277.61, 20.614, -1.36136, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245527, 16592, 0, 1, 1, 11686, 0, -10331.4, -3297.73, 21.9992, -2.89725, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245528, 16592, 1, 1, 1, 11686, 0, 952.992, 776.968, 104.474, -1.55334, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245529, 16592, 530, 1, 1, 11686, 0, -1211.01, 7474.44, 21.9953, -2.02458, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245530, 16592, 0, 1, 1, 11686, 0, -134.688, -802.767, 55.0147, -1.62316, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245531, 16592, 530, 1, 1, 11686, 0, 41.2448, 2587.44, 68.3453, -2.28638, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245532, 16592, 1, 1, 1, 11686, 0, -4573.22, 407.388, 41.5461, 2.46091, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245533, 16592, 1, 1, 1, 11686, 0, -3110.59, -2722.41, 33.4626, 0.226893, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245534, 16592, 1, 1, 1, 11686, 0, -1862.36, 3055.71, 0.744157, 2.49582, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245535, 16592, 0, 1, 1, 11686, 0, -7596.42, -2086.6, 125.17, -0.942478, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245536, 16592, 0, 1, 1, 11686, 0, -6704.48, -2200.91, 248.609, 0.017453, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245537, 16592, 1, 1, 1, 11686, 0, 6855.99, -4564.4, 708.51, 0.855211, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245538, 16592, 1, 1, 1, 11686, 0, -7122.51, -3657.11, 8.82202, -1.74533, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245539, 16592, 1, 1, 1, 11686, 0, -4395.96, 3481.54, 11.0626, 0.104316, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245540, 16592, 0, 1, 1, 11686, 0, -14376.7, 115.921, 1.4532, 2.11185, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245541, 16592, 1, 1, 1, 11686, 0, 2014.65, -2337.84, 89.5211, 2.37365, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245542, 16592, 0, 1, 1, 11686, 0, -1134.84, -3531.81, 51.0719, -0.820305, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245543, 16592, 1, 1, 1, 11686, 0, 6860.03, -4767.11, 696.833, -2.63545, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245544, 16592, 0, 1, 1, 11686, 0, 2273.88, 453.352, 33.9364, 3.35914, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245545, 16592, 1, 1, 1, 11686, 0, -7216.68, -3859.39, 11.4943, -2.72271, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245546, 16592, 0, 1, 1, 11686, 0, -8241.63, -2624.58, 133.184, 2.53448, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245547, 16592, 0, 1, 1, 11686, 0, -14288.1, 61.8062, 0.68836, 1.37881, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245548, 16592, 0, 1, 1, 11686, 0, -3448.2, -938.102, 10.6583, 0.034907, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245549, 16592, 0, 1, 1, 11686, 0, 188.243, -2132.53, 102.674, -1.37881, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245550, 16592, 1, 1, 1, 11686, 0, 9778.64, 1019.38, 1299.79, 0.261799, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245551, 16592, 0, 1, 1, 11686, 0, -9434.3, -2110.36, 65.8038, 0.349066, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245552, 16592, 0, 1, 1, 11686, 0, -5233.16, -2893.37, 337.286, -0.226893, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245553, 16592, 0, 1, 1, 11686, 0, -604.148, -545.813, 36.579, 0.698132, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245554, 16592, 530, 1, 1, 11686, 0, -528.509, 2339.11, 38.7252, 2.14675, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245555, 16592, 0, 1, 1, 11686, 0, -9394.21, 37.5017, 59.882, 1.15192, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245556, 16592, 1, 1, 1, 11686, 0, -3447.55, -4231.67, 10.6645, 0.802851, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245557, 16592, 0, 1, 1, 11686, 0, -10704.8, -1146.38, 24.7909, 2.09439, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245558, 16592, 0, 1, 1, 11686, 0, -5404.93, -492.299, 395.597, -0.506145, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245559, 16592, 1, 1, 1, 11686, 0, -55.5039, 1271.35, 91.9489, 1.5708, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245560, 16592, 1, 1, 1, 11686, 0, 6327.68, 512.61, 17.4723, 0.034907, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245561, 16592, 0, 1, 1, 11686, 0, -10951.5, -3218.1, 41.3475, 1.91986, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245562, 16592, 1, 1, 1, 11686, 0, 2558.73, -481.666, 109.821, -2.47837, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245563, 16592, 0, 1, 1, 11686, 0, -1211.6, -2676.88, 45.3612, -0.645772, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245564, 16592, 1, 1, 1, 11686, 0, -7000.75, 918.851, 8.93831, -2.23402, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245565, 16592, 1, 1, 1, 11686, 0, -6769.7, 526.854, -1.60197, 0.087266, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245566, 16592, 530, 1, 1, 11686, 0, -3946.07, 2041.28, 95.0669, 0.00549316, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245567, 16592, 1, 1, 1, 11686, 0, -2331.29, -633.621, -8.33476, 5.79781, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245568, 16592, 530, 1, 1, 11686, 0, 7696.83, -6834.27, 77.4663, 1.37997, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245569, 16592, 530, 1, 1, 11686, 0, -2529.23, 7555.4, -1.74901, 6.22584, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245570, 16592, 530, 1, 1, 11686, 0, 182.189, 6026.17, 22.1537, 0.743754, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245571, 16592, 530, 1, 1, 11686, 0, 2931.39, 3698.96, 143.537, 2.23621, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245572, 16592, 571, 1, 1, 11686, 0, 2483.96, -4886.47, 265.271, 6.27404, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245573, 16592, 571, 1, 1, 11686, 0, 2572.61, -4330.26, 276.656, 0.222526, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245574, 16592, 571, 1, 1, 11686, 0, 3360.71, -2113.31, 124.059, 0.175442, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245575, 16592, 571, 1, 1, 11686, 0, 3399.05, -2911.26, 202.028, 6.21516, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245576, 16592, 571, 1, 1, 11686, 0, 5288.52, -2757.12, 292.418, 6.27408, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245577, 16592, 571, 1, 1, 11686, 0, 5641.3, -2622.27, 292.419, 0.0655074, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245578, 16592, 571, 1, 1, 11686, 0, 6072.67, -1103.21, 419.456, 6.23874, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245579, 16592, 571, 1, 1, 11686, 0, 6139.2, -1024.37, 409.239, 0.132262, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245580, 16592, 571, 1, 1, 11686, 0, 5504.33, 4864.31, -197.319, 0.273637, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245581, 16592, 571, 1, 1, 11686, 0, 5370.74, 4842.57, -197.512, 0.00267172, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245582, 16592, 571, 1, 1, 11686, 0, 4440.61, 5624.95, 56.0681, 6.28193, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245583, 16592, 571, 1, 1, 11686, 0, 4121.36, 5394.75, 28.3803, 0.0458794, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245584, 16592, 571, 1, 1, 11686, 0, 3768.95, 1462.02, 92.6355, 0.0301769, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245585, 16592, 571, 1, 1, 11686, 0, 3940.62, -584.935, 240.743, 0.163699, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245586, 16592, 571, 1, 1, 11686, 0, 5141.08, -663.877, 170.145, 6.2769, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245587, 16592, 571, 1, 1, 11686, 0, 5540.38, -748.132, 151.854, 6.03735, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245588, 16592, 530, 1, 1, 11686, 0, 3122.3, 3755.28, 141.82, 0.0329792, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245589, 16592, 530, 1, 1, 11686, 0, 2025.02, 6577.95, 134.195, 4.76893, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245590, 16592, 530, 1, 1, 11686, 0, -2248.27, -11902, 26.3641, 5.16557, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245591, 16592, 530, 1, 1, 11686, 0, -3008.76, 4156.66, 3.76291, 0.225413, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245592, 16592, 0, 1, 1, 11686, 0, 1001.7, -1457.95, 61.0382, 3.15495, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245593, 16592, 530, 1, 1, 11686, 0, -4219.05, -12319.5, 2.33427, 6.06485, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245594, 26188, 0, 1, 1, 0, 0, -8825.9, 827.707, 98.8956, 4.64676, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245595, 26188, 1, 1, 1, 17612, 0, 8687.6, 971.462, 11.0922, 3.35103, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245596, 26188, 1, 1, 1, 0, 0, 8698.49, 948.968, 13.0619, 5.08307, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245597, 26188, 1, 1, 1, 0, 0, 8701.76, 978.752, 11.1585, 5.41685, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245598, 26188, 1, 1, 1, 0, 0, -1046.7, 308.95, 132.924, 5.17563, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245599, 26188, 1, 1, 1, 0, 0, -1053.49, 280.57, 132.812, 3.48702, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245600, 26188, 1, 1, 1, 0, 0, -1018.44, 293.602, 135.746, 1.06406, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245601, 26188, 1, 1, 1, 0, 0, -1020.82, 273.235, 135.746, 0.160856, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245602, 26188, 1, 1, 1, 0, 0, 1931.11, -4326.77, 20.1631, 4.69971, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245603, 26188, 1, 1, 1, 0, 0, 1949.99, -4276.73, 30.5469, 0.434993, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245604, 26188, 1, 1, 1, 0, 0, 1921.37, -4290.03, 28.5774, 2.29639, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245605, 26188, 1, 1, 1, 0, 0, 1933.86, -4304.12, 23.2211, 3.71796, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245606, 26188, 0, 1, 1, 0, 0, 1820.43, 254.418, 60.0192, 4.25153, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245607, 26188, 0, 1, 1, 0, 0, 1834.03, 260.86, 59.7436, 1.38875, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245608, 26188, 0, 1, 1, 0, 0, 1830.65, 242.479, 60.0923, 1.36912, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245609, 26188, 0, 1, 1, 0, 0, -4707.57, -1252.51, 501.66, 4.82262, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245610, 26188, 0, 1, 1, 0, 0, -4695.37, -1239.68, 501.66, 1.14696, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245611, 26188, 0, 1, 1, 0, 0, -4695.66, -1278.22, 502.142, 1.73208, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245612, 26188, 0, 1, 1, 0, 0, -4709.27, -1263.37, 501.66, 1.30797, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245613, 26188, 0, 1, 1, 0, 0, -8838.63, 828.143, 98.8545, 5.17298, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245614, 26188, 0, 1, 1, 0, 0, -8817.56, 820.912, 99.9065, 4.55251, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245615, 26188, 0, 1, 1, 0, 0, -8827.29, 806.683, 97.9935, 4.64676, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245616, 17066, 530, 1, 1, 0, 0, 9805.286, -7255.484, 32.0, 0.0, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245617, 17066, 530, 1, 1, 0, 0, -3821.917, -11508.147, -132.0, 0.0, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245618, 25863, 1, 1, 1, 0, 1, 3934.86, 748.963, 6.62723, 4.54896, 600, 0, 0, 400, 1202, 0, 0, 0, 0);
INSERT INTO creature VALUES (245619, 25863, 1, 1, 1, 0, 1, 3882.19, 787.573, 4.13287, 3.5358, 600, 0, 0, 400, 1202, 0, 0, 0, 0);
INSERT INTO creature VALUES (245620, 25863, 1, 1, 1, 0, 1, 3908.08, 823.662, 1.88817, 3.14703, 600, 0, 0, 400, 1202, 0, 0, 0, 0);
INSERT INTO creature VALUES (245621, 25863, 1, 1, 1, 0, 1, 3951.96, 862.214, 0.33636, 0.135025, 600, 0, 0, 400, 1202, 0, 0, 0, 0);
INSERT INTO creature VALUES (245622, 25866, 1, 1, 1, 0, 1, 3927.34, 748.497, 7.58843, 5.62497, 600, 0, 0, 480, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245623, 25866, 1, 1, 1, 0, 1, 3865.67, 783.307, 4.04259, 2.36163, 600, 0, 0, 480, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245624, 25866, 1, 1, 1, 0, 1, 3923.5, 817.866, 7.98442, 3.04101, 600, 0, 0, 480, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245625, 25866, 1, 1, 1, 0, 1, 3969.42, 864.603, 0.0898777, 0.0996887, 600, 0, 0, 480, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245626, 25924, 1, 1, 1, 0, 1, 3927.31, 794.43, 9.0578, 0.739775, 600, 0, 0, 480, 1357, 0, 0, 0, 0);
INSERT INTO creature VALUES (245627, 25949, 1, 1, 1, 0, 1, 4196.52, 1174.76, 6.43307, 0.56115, 300, 0, 0, 480, 1357, 0, 0, 0, 0);
INSERT INTO creature VALUES (245628, 26116, 1, 1, 1, 0, 0, 4192.36, 1165.88, 7.32119, 3.0307, 600, 0, 0, 1500, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245629, 26178, 1, 1, 1, 0, 0, -413.607, 2425.78, 65.7533, 4.50994, 600, 0, 0, 1700, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245630, 26204, 0, 1, 1, 0, 0, -12139.3, 896.525, 8.81937, 1.43034, 600, 0, 0, 3400, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245631, 26214, 0, 1, 1, 0, 0, -6621.54, -656.621, 233.754, 4.22936, 600, 0, 0, 5000, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245632, 26215, 1, 1, 1, 0, 0, -6312.41, 290.729, 13.6115, 3.17238, 600, 0, 0, 8000, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245633, 26216, 530, 1, 1, 0, 0, -176.004, 1104.13, 41.8132, 2.73275, 600, 0, 0, 4800, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245634, 26188, 530, 1, 1, 0, 0, 9833.03, -7279.73, 26.2544, 5.80349, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245635, 26188, 530, 1, 1, 0, 0, 9802.47, -7263.83, 26.3075, 1.7312, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245636, 26188, 530, 1, 1, 0, 0, 9805.45, -7282.21, 26.3535, 1.74691, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245637, 26188, 530, 1, 1, 0, 0, 9823.38, -7265.81, 26.1884, 1.99431, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245638, 26188, 530, 1, 1, 0, 0, -3778.15, -11490.8, -134.515, 1.61792, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245639, 26188, 530, 1, 1, 0, 0, -3775.84, -11510.9, -134.561, 3.7974, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245640, 26188, 530, 1, 1, 0, 0, -3765.56, -11490.1, -134.364, 5.10116, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245641, 26188, 530, 1, 1, 0, 0, -3776.85, -11469.5, -134.412, 5.10116, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245642, 25883, 1, 1, 1, 0, 0, 2568.97, -478.95, 108.392, 1.67552, 300, 0, 0, 1200, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245643, 25884, 1, 1, 1, 0, 0, 2009.33, -2345.09, 89.7369, 2.94961, 300, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245644, 25887, 0, 1, 1, 0, 0, -1209.27, -2667.5, 45.183, 5.93412, 300, 0, 0, 1000, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245645, 25888, 530, 1, 1, 0, 0, -4224.55, -12317.3, 2.79946, 4.43201, 300, 0, 0, 24, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245646, 25889, 530, 1, 1, 0, 0, 2035.2, 6600.39, 136.793, 4.61734, 600, 0, 0, 580, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245647, 25890, 0, 1, 1, 0, 0, -10946.6, -3227.53, 41.4308, 4.5204, 300, 0, 0, 2000, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245648, 25891, 530, 1, 1, 0, 0, -2252.28, -11899.4, 27.0338, 4.29298, 300, 0, 0, 1300, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245649, 25892, 0, 1, 1, 0, 0, -8248.18, -2623.69, 133.155, 1.8978, 300, 0, 0, 30, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245650, 25893, 1, 1, 1, 0, 0, 6317.35, 520.637, 18.5027, 1.3439, 300, 0, 0, 430, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245651, 25894, 1, 1, 1, 0, 0, -60.154, 1260.68, 90.8524, 2.98451, 300, 0, 0, 110, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245652, 25895, 0, 1, 1, 0, 0, -5418.36, -497.671, 397.224, 4.76475, 300, 0, 0, 12000, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245653, 25896, 0, 1, 1, 0, 0, -10699.7, -1156.26, 25.062, 3.90954, 300, 0, 0, 1500, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245654, 25897, 1, 1, 1, 0, 0, -3449.22, -4220.48, 11.5049, 2.61799, 300, 0, 0, 1100, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245655, 25898, 0, 1, 1, 0, 0, -9389.17, 26.7242, 60.1325, 4.5204, 300, 0, 0, 110, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245656, 25899, 1, 1, 1, 0, 0, -4402.07, 3477.84, 11.9477, 5.34385, 300, 0, 0, 220, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245657, 25900, 530, 1, 1, 0, 0, -526.014, 2328.92, 39.0606, 3.59538, 300, 0, 0, 3300, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245658, 25901, 0, 1, 1, 0, 0, -615.18, -547.146, 36.2658, 4.5204, 300, 0, 0, 1400, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245659, 25902, 0, 1, 1, 0, 0, -5240.81, -2891.73, 338.142, 1.93731, 300, 0, 0, 1500, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245660, 25903, 530, 1, 1, 0, 0, -2525.24, 7563.05, -1.45471, 5.33445, 300, 0, 0, 3600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245661, 25904, 0, 1, 1, 0, 0, -9428.77, -2118.63, 66.2485, 4.5204, 300, 0, 0, 1200, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245662, 25905, 530, 1, 1, 0, 0, -3938.03, 2048.87, 95.0824, 5.96191, 300, 0, 0, 1100, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245663, 25906, 1, 1, 1, 0, 0, 9780.85, 1011.06, 1299.62, 6.19592, 300, 0, 0, 230, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245664, 25907, 530, 1, 1, 0, 0, -3016.46, 4159.93, 3.56851, 3.07165, 300, 0, 0, 3800, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245665, 25908, 0, 1, 1, 0, 0, 181.536, -2127.07, 103.53, 3.66519, 300, 0, 0, 1700, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245666, 25909, 0, 1, 1, 0, 0, 1004.89, -1449.53, 61.6634, 3.39779, 300, 0, 0, 4300, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245667, 25910, 0, 1, 1, 0, 0, -10647.9, 1059.49, 32.9515, 5.49779, 300, 0, 0, 200, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245668, 25911, 0, 1, 1, 0, 0, -3445.12, -946.047, 10.3508, 4.10152, 300, 0, 0, 220, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245669, 25912, 530, 1, 1, 0, 0, 173.918, 6028.72, 21.7826, 1.33599, 300, 0, 0, 5200, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245670, 25913, 530, 1, 1, 0, 0, 3116.33, 3750.04, 142.44, 5.79643, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245671, 25914, 1, 1, 1, 0, 0, -6776.86, 535.37, -1.13638, 3.21141, 300, 0, 0, 2200, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245672, 25915, 0, 1, 1, 0, 0, -14296.5, 57.8357, 1.2391, 2.54818, 300, 0, 0, 1200, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245673, 25916, 1, 1, 1, 0, 0, -7225.97, -3859.08, 11.6922, 3.89208, 300, 0, 0, 1500, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245674, 25917, 1, 1, 1, 0, 0, 6856.55, -4757.79, 696.747, 0.890118, 300, 0, 0, 1700, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245675, 25918, 530, 1, 1, 0, 0, 2928.21, 3692.15, 143.55, 2.34459, 300, 0, 0, 2100, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245676, 25919, 1, 1, 1, 0, 0, -6990.84, 919.428, 9.77106, 1.02974, 300, 0, 0, 1300, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245677, 25920, 0, 1, 1, 0, 0, -14368.8, 119.621, 1.16959, 5.72468, 300, 0, 0, 590, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245678, 25921, 1, 1, 1, 0, 0, -7113.92, -3657.28, 9.63882, 1.02974, 300, 0, 0, 1600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245679, 25922, 1, 1, 1, 0, 0, 6846.1, -4567.41, 709.085, 4.43314, 300, 0, 0, 3728, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245680, 25923, 0, 1, 1, 0, 0, -1128.57, -3538.51, 51.0144, 3.9968, 300, 0, 0, 920, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245681, 25925, 0, 1, 1, 0, 0, -6695.69, -2196.15, 248.553, 1.5708, 300, 0, 0, 1200, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245682, 25926, 530, 1, 1, 0, 0, 2278.76, 6137.25, 136.707, 4.22391, 300, 0, 0, 840, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245683, 25927, 0, 1, 1, 0, 0, -7598.53, -2075.67, 127.085, 2.79253, 300, 0, 0, 1900, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245684, 25928, 1, 1, 1, 0, 0, -1853.53, 3057.99, 0.857634, 1.41372, 300, 0, 0, 1200, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245685, 25929, 1, 1, 1, 0, 0, 147.559, -4705.72, 18.602, 5.86374, 300, 0, 0, 955, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245686, 25930, 1, 1, 1, 0, 0, -3115.07, -2730.11, 33.8021, 3.03687, 300, 0, 0, 1500, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245687, 25931, 530, 1, 1, 0, 0, 9384.59, -6772.03, 14.2686, 3.31144, 300, 0, 0, 8700, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245688, 25932, 1, 1, 1, 0, 0, -4580.95, 411.728, 42.0259, 3.71755, 300, 0, 0, 2000, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245689, 25933, 530, 1, 1, 0, 0, 7700.87, -6837.83, 77.0927, 1.03095, 300, 0, 0, 140, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245690, 25934, 530, 1, 1, 0, 0, 33.5603, 2589.92, 69.2065, 3.63029, 300, 0, 0, 1600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245691, 25935, 0, 1, 1, 0, 0, -142.509, -807.779, 55.477, 2.42601, 300, 0, 0, 1400, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245692, 25936, 1, 1, 1, 0, 0, -2321.74, -619.749, -8.98915, 5.67232, 300, 0, 0, 9300, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245693, 25937, 530, 1, 1, 0, 0, -1215.73, 7482.89, 22.1811, 3.22886, 300, 0, 0, 6900, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245694, 25938, 530, 1, 1, 0, 0, -3060.18, 2399.51, 61.2253, 4.7626, 300, 0, 0, 510, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245695, 25939, 0, 1, 1, 0, 0, 593.82, 1363, 90.1024, 1.01229, 300, 0, 0, 88, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245696, 25940, 1, 1, 1, 0, 0, 947.727, 780.152, 104.199, 3.80482, 300, 0, 0, 440, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245697, 25941, 0, 1, 1, 0, 0, -10339.2, -3294.17, 22.5361, 1.79769, 300, 0, 0, 1100, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245698, 25942, 530, 1, 1, 0, 0, -2545.67, 4273.74, 19.9345, 0.610865, 300, 0, 0, 4800, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245699, 25943, 1, 1, 1, 0, 0, -282.304, -2668.31, 92.9559, 4.60767, 300, 0, 0, 1900, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245700, 25944, 0, 1, 1, 0, 0, -457.319, -4525.64, 9.81651, 1.8675, 300, 0, 0, 740, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245701, 25945, 1, 1, 1, 0, 0, -5519.48, -2294.23, -57.9951, 3.1765, 300, 0, 0, 11000, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245702, 25946, 0, 1, 1, 0, 0, 2281.77, 453.836, 33.9988, 4.05597, 300, 0, 0, 160, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245703, 25947, 530, 1, 1, 0, 0, 205.463, 7693.15, 23.3862, 2.04204, 300, 0, 0, 5000, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (245704, 25710, 547, 3, 1, 0, 0, 132.721, -116.256, -1.59053, 3.85833, 7200, 0, 0, 13000, 0, 0, 0, 0, 0);

DELETE FROM game_event_creature WHERE eventEntry=1 AND guid BETWEEN 245500 AND 245704;
REPLACE INTO game_event_creature VALUES(1, 245500),(1, 245501),(1, 245502),(1, 245503),(1, 245504),(1, 245505),(1, 245506),(1, 245507),(1, 245508),
(1, 245509),(1, 245510),(1, 245511),(1, 245512),(1, 245513),(1, 245514),(1, 245515),(1, 245516),(1, 245517),(1, 245518),(1, 245519),(1, 245520),
(1, 245521),(1, 245522),(1, 245523),(1, 245524),(1, 245525),(1, 245526),(1, 245527),(1, 245528),(1, 245529),(1, 245530),(1, 245531),
(1, 245532),(1, 245533),(1, 245534),(1, 245535),(1, 245536),(1, 245537),(1, 245538),(1, 245539),(1, 245540),(1, 245541),(1, 245542),
(1, 245543),(1, 245544),(1, 245545),(1, 245546),(1, 245547),(1, 245548),(1, 245549),(1, 245550),(1, 245551),(1, 245552),(1, 245553),
(1, 245554),(1, 245555),(1, 245556),(1, 245557),(1, 245558),(1, 245559),(1, 245560),(1, 245561),(1, 245562),(1, 245563),(1, 245564),
(1, 245565),(1, 245566),(1, 245567),(1, 245568),(1, 245569),(1, 245570),(1, 245571),(1, 245572),(1, 245573),(1, 245574),(1, 245575),
(1, 245576),(1, 245577),(1, 245578),(1, 245579),(1, 245580),(1, 245581),(1, 245582),(1, 245583),(1, 245584),(1, 245585),(1, 245586),
(1, 245587),(1, 245588),(1, 245589),(1, 245590),(1, 245591),(1, 245592),(1, 245593),(1, 245594),(1, 245595),(1, 245596),(1, 245597),
(1, 245598),(1, 245599),(1, 245600),(1, 245601),(1, 245602),(1, 245603),(1, 245604),(1, 245605),(1, 245606),(1, 245607),(1, 245608),
(1, 245609),(1, 245610),(1, 245611),(1, 245612),(1, 245613),(1, 245614),(1, 245615),(1, 245616),(1, 245617),(1, 245618),(1, 245619),
(1, 245620),(1, 245621),(1, 245622),(1, 245623),(1, 245624),(1, 245625),(1, 245626),(1, 245627),(1, 245628),(1, 245629),(1, 245630),
(1, 245631),(1, 245632),(1, 245633),(1, 245634),(1, 245635),(1, 245636),(1, 245637),(1, 245638),(1, 245639),(1, 245640),(1, 245641),
(1, 245642),(1, 245643),(1, 245644),(1, 245645),(1, 245646),(1, 245647),(1, 245648),(1, 245649),(1, 245650),(1, 245651),(1, 245652),
(1, 245653),(1, 245654),(1, 245655),(1, 245656),(1, 245657),(1, 245658),(1, 245659),(1, 245660),(1, 245661),(1, 245662),(1, 245663),
(1, 245664),(1, 245665),(1, 245666),(1, 245667),(1, 245668),(1, 245669),(1, 245670),(1, 245671),(1, 245672),(1, 245673),(1, 245674),
(1, 245675),(1, 245676),(1, 245677),(1, 245678),(1, 245679),(1, 245680),(1, 245681),(1, 245682),(1, 245683),(1, 245684),(1, 245685),
(1, 245686),(1, 245687),(1, 245688),(1, 245689),(1, 245690),(1, 245691),(1, 245692),(1, 245693),(1, 245694),(1, 245695),(1, 245696),
(1, 245697),(1, 245698),(1, 245699),(1, 245700),(1, 245701),(1, 245702),(1, 245703),(1, 245704);

-- Gameobject spawns
DELETE FROM gameobject WHERE guid BETWEEN 242500 AND 242684;
DELETE FROM gameobject WHERE id IN(SELECT entry FROM gameobject_template WHERE name="Alliance Bonfire" OR name="Horde Bonfire");
DELETE FROM gameobject WHERE id IN(181332, 181333, 181334, 181335, 181336, 181337, 188128, 188129, 181371);
INSERT INTO gameobject VALUES (242500, 187949, 530, 1, 1, 2931.39, 3698.96, 143.537, 2.23621, 0, 0, 0.899273, 0.437387, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242501, 187941, 530, 1, 1, 182.189, 6026.17, 22.1537, 0.743754, 0, 0, 0.363365, 0.931647, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242502, 187933, 530, 1, 1, -2529.23, 7555.4, -1.74901, 6.22584, 0, 0, 0.0286687, -0.999589, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242503, 187962, 530, 1, 1, 7696.83, -6834.27, 77.4663, 1.37997, 0, 0, 0.636526, 0.771256, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242504, 187965, 1, 1, 1, -2331.29, -633.621, -8.33476, 5.79781, 0, 0, 0.240312, -0.970696, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242505, 187935, 530, 1, 1, -3946.07, 2041.28, 95.0669, 0.00549316, 0, 0, 0.00274658, 0.999996, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242506, 187943, 1, 1, 1, -6769.7, 526.854, -1.60197, 0.087266, 0, 0, 0.0436192, 0.999048, 900, 100, 1, 0);
INSERT INTO gameobject VALUES (242507, 187950, 1, 1, 1, -7000.75, 918.851, 8.93831, -2.23402, 0, 0, -0.898794, 0.438372, 900, 100, 1, 0);
INSERT INTO gameobject VALUES (242508, 187914, 0, 1, 1, -1211.6, -2676.88, 45.3612, -0.645772, 0, 0, -0.317305, 0.948324, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242509, 187916, 1, 1, 1, 2558.73, -481.666, 109.821, -2.47837, 0, 0, -0.945519, 0.325567, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242510, 187920, 0, 1, 1, -10951.5, -3218.1, 41.3475, 1.91986, 0, 0, 0.819151, 0.573577, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242511, 187923, 1, 1, 1, 6327.68, 512.61, 17.4723, 0.034907, 0, 0, 0.0174526, 0.999848, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242512, 187924, 1, 1, 1, -55.5039, 1271.35, 91.9489, 1.5708, 0, 0, 0.707108, 0.707106, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242513, 187925, 0, 1, 1, -5404.93, -492.299, 395.597, -0.506145, 0, 0, -0.25038, 0.968148, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242514, 187926, 0, 1, 1, -10704.8, -1146.38, 24.7909, 2.09439, 0, 0, 0.866024, 0.500002, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242515, 187927, 1, 1, 1, -3447.55, -4231.67, 10.6645, 0.802851, 0, 0, 0.390731, 0.920505, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242516, 187928, 0, 1, 1, -9394.21, 37.5017, 59.882, 1.15192, 0, 0, 0.54464, 0.83867, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242517, 187930, 530, 1, 1, -528.509, 2339.11, 38.7252, 2.14675, 0, 0, 0.878816, 0.477161, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242518, 187931, 0, 1, 1, -604.148, -545.813, 36.579, 0.698132, 0, 0, 0.34202, 0.939693, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242519, 187932, 0, 1, 1, -5233.16, -2893.37, 337.286, -0.226893, 0, 0, -0.113203, 0.993572, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242520, 187934, 0, 1, 1, -9434.3, -2110.36, 65.8038, 0.349066, 0, 0, 0.173648, 0.984808, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242521, 187936, 1, 1, 1, 9778.64, 1019.38, 1299.79, 0.261799, 0, 0, 0.130526, 0.991445, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242522, 187938, 0, 1, 1, 188.243, -2132.53, 102.674, -1.37881, 0, 0, -0.636078, 0.771625, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242523, 187940, 0, 1, 1, -3448.2, -938.102, 10.6583, 0.034907, 0, 0, 0.0174526, 0.999848, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242524, 187944, 0, 1, 1, -14288.1, 61.8062, 0.68836, 1.37881, 0, 0, 0.636078, 0.771625, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242525, 187922, 0, 1, 1, -8241.63, -2624.58, 133.184, 2.53448, 0, 0, 0.954279, 0.298916, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242526, 187945, 1, 1, 1, -7216.68, -3859.39, 11.4943, -2.72271, 0, 0, -0.978147, 0.207914, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242527, 187974, 0, 1, 1, 2273.88, 453.352, 33.9364, 3.35914, 0, 0, 0.99409, -0.108559, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242528, 187946, 1, 1, 1, 6860.03, -4767.11, 696.833, -2.63545, 0, 0, -0.968148, 0.250379, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242529, 187947, 0, 1, 1, -1134.84, -3531.81, 51.0719, -0.820305, 0, 0, -0.398749, 0.91706, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242530, 187948, 1, 1, 1, 2014.65, -2337.84, 89.5211, 2.37365, 0, 0, 0.927184, 0.374606, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242531, 187951, 0, 1, 1, -14376.7, 115.921, 1.4532, 2.11185, 0, 0, 0.870356, 0.492423, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242532, 187929, 1, 1, 1, -4395.96, 3481.54, 11.0626, 0.104316, 0, 0, 0.0521344, 0.99864, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242533, 187952, 1, 1, 1, -7122.51, -3657.11, 8.82202, -1.74533, 0, 0, -0.766045, 0.642787, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242534, 187953, 1, 1, 1, 6855.99, -4564.4, 708.51, 0.855211, 0, 0, 0.414693, 0.909961, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242535, 187954, 0, 1, 1, -6704.48, -2200.91, 248.609, 0.017453, 0, 0, 0.00872639, 0.999962, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242536, 187956, 0, 1, 1, -7596.42, -2086.6, 125.17, -0.942478, 0, 0, -0.453991, 0.891006, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242537, 187957, 1, 1, 1, -1862.36, 3055.71, 0.744157, 2.49582, 0, 0, 0.948324, 0.317305, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242538, 187959, 1, 1, 1, -3110.59, -2722.41, 33.4626, 0.226893, 0, 0, 0.113203, 0.993572, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242539, 187961, 1, 1, 1, -4573.22, 407.388, 41.5461, 2.46091, 0, 0, 0.942641, 0.333809, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242540, 187963, 530, 1, 1, 41.2448, 2587.44, 68.3453, -2.28638, 0, 0, -0.909961, 0.414694, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242541, 187964, 0, 1, 1, -134.688, -802.767, 55.0147, -1.62316, 0, 0, -0.725376, 0.688353, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242542, 187966, 530, 1, 1, -1211.01, 7474.44, 21.9953, -2.02458, 0, 0, -0.848048, 0.52992, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242543, 187968, 1, 1, 1, 952.992, 776.968, 104.474, -1.55334, 0, 0, -0.700908, 0.713252, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242544, 187969, 0, 1, 1, -10331.4, -3297.73, 21.9992, -2.89725, 0, 0, -0.992546, 0.121868, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242545, 187970, 530, 1, 1, -2553.32, 4277.61, 20.614, -1.36136, 0, 0, -0.629322, 0.777145, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242546, 187971, 1, 1, 1, -273.242, -2662.82, 91.695, -1.8675, 0, 0, -0.803856, 0.594824, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242547, 187972, 0, 1, 1, -447.95, -4527.65, 8.59595, 1.53589, 0, 0, 0.694658, 0.71934, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242548, 187973, 1, 1, 1, -5513.93, -2299.73, -58.0752, 2.44346, 0, 0, 0.939692, 0.342021, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242549, 187975, 530, 1, 1, 200.9, 7686.96, 22.508, -0.506145, 0, 0, -0.25038, 0.968148, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242550, 187559, 0, 1, 1, 587.056, 1365.02, 90.4778, 2.6529, 0, 0, 0.970296, 0.241922, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242551, 187564, 0, 1, 1, -10657.1, 1054.63, 32.6733, 2.47837, 0, 0, 0.945519, 0.325567, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242552, 187955, 530, 1, 1, 2274.45, 6133.53, 136.905, 1.61654, 0, 0, 0.723093, 0.69075, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242553, 187967, 530, 1, 1, -3053.71, 2398.05, 60.883, 4.43274, 0, 0, 0.798755, -0.601657, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242554, 187960, 530, 1, 1, 9383.5, -6777.43, 13.7903, 0.0251532, 0, 0, 0.0125763, 0.999921, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242555, 187958, 1, 1, 1, 151.481, -4711.98, 18.5644, 3.07253, 0, 0, 0.999404, 0.0345244, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242556, 187917, 530, 1, 1, -4219.05, -12319.5, 2.33427, 6.06485, 0, 0, 0.108951, -0.994047, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242557, 187939, 0, 1, 1, 1001.7, -1457.95, 61.0382, 3.15495, 0, 0, 0.999978, -0.00667858, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242558, 187937, 530, 1, 1, -3008.76, 4156.66, 3.76291, 0.225413, 0, 0, 0.112468, 0.993655, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242559, 187921, 530, 1, 1, -2248.27, -11902, 26.3641, 5.16557, 0, 0, 0.530176, -0.847888, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242560, 187919, 530, 1, 1, 2025.02, 6577.95, 134.195, 4.76893, 0, 0, 0.686837, -0.726812, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242561, 187942, 530, 1, 1, 3122.3, 3755.28, 141.82, 0.0329792, 0, 0, 0.0164889, 0.999864, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242562, 194046, 571, 1, 1, 5540.38, -748.132, 151.854, 6.03735, 0, 0, 0.122608, -0.992455, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242563, 194045, 571, 1, 1, 5141.08, -663.877, 170.145, 6.2769, 0, 0, 0.00314274, -0.999995, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242564, 194036, 571, 1, 1, 3940.62, -584.935, 240.743, 0.163699, 0, 0, 0.0817581, 0.996652, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242565, 194037, 571, 1, 1, 3768.95, 1462.02, 92.6355, 0.0301769, 0, 0, 0.0150879, 0.999886, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242566, 194032, 571, 1, 1, 4121.36, 5394.75, 28.3803, 0.0458794, 0, 0, 0.0229377, 0.999737, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242567, 194033, 571, 1, 1, 4440.61, 5624.95, 56.0681, 6.28193, 0, 0, 0.000627669, -1, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242568, 194035, 571, 1, 1, 5370.74, 4842.57, -197.512, 0.00267172, 0, 0, 0.00133586, 0.999999, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242569, 194034, 571, 1, 1, 5504.33, 4864.31, -197.319, 0.273637, 0, 0, 0.136392, 0.990655, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242570, 194043, 571, 1, 1, 6139.2, -1024.37, 409.239, 0.132262, 0, 0, 0.0660828, 0.997814, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242571, 194044, 571, 1, 1, 6072.67, -1103.21, 419.456, 6.23874, 0, 0, 0.0222208, -0.999753, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242572, 194049, 571, 1, 1, 5641.3, -2622.27, 292.419, 0.0655074, 0, 0, 0.0327478, 0.999464, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242573, 194048, 571, 1, 1, 5288.52, -2757.12, 292.418, 6.27408, 0, 0, 0.00455274, -0.99999, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242574, 194040, 571, 1, 1, 3399.05, -2911.26, 202.028, 6.21516, 0, 0, 0.0340061, -0.999422, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242575, 194042, 571, 1, 1, 3360.71, -2113.31, 124.059, 0.175442, 0, 0, 0.0876085, 0.996155, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242576, 194039, 571, 1, 1, 2572.61, -4330.26, 276.656, 0.222526, 0, 0, 0.111034, 0.993817, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242577, 194038, 571, 1, 1, 2483.96, -4886.47, 265.271, 6.27404, 0, 0, 0.00457253, -0.99999, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242578, 181371, 530, 1, 1, 2931.39, 3698.96, 143.537, 2.23621, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242579, 181371, 530, 1, 1, 182.189, 6026.17, 22.1537, 0.743754, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242580, 181371, 530, 1, 1, -2529.23, 7555.4, -1.74901, 6.22584, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242581, 181371, 530, 1, 1, 7696.83, -6834.27, 77.4663, 1.37997, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242582, 181371, 1, 1, 1, -2331.29, -633.621, -8.33476, 5.79781, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242583, 181371, 530, 1, 1, -3946.07, 2041.28, 95.0669, 0.00549316, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242584, 181371, 1, 1, 1, -6769.7, 526.854, -1.60197, 0.087266, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242585, 181371, 1, 1, 1, -7000.75, 918.851, 8.93831, -2.23402, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242586, 181371, 0, 1, 1, -1211.6, -2676.88, 45.3612, -0.645772, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242587, 181371, 1, 1, 1, 2558.73, -481.666, 109.821, -2.47837, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242588, 181371, 0, 1, 1, -10951.5, -3218.1, 41.3475, 1.91986, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242589, 181371, 1, 1, 1, 6327.68, 512.61, 17.4723, 0.034907, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242590, 181371, 1, 1, 1, -55.5039, 1271.35, 91.9489, 1.5708, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242591, 181371, 0, 1, 1, -5404.93, -492.299, 395.597, -0.506145, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242592, 181371, 0, 1, 1, -10704.8, -1146.38, 24.7909, 2.09439, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242593, 181371, 1, 1, 1, -3447.55, -4231.67, 10.6645, 0.802851, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242594, 181371, 0, 1, 1, -9394.21, 37.5017, 59.882, 1.15192, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242595, 181371, 530, 1, 1, -528.509, 2339.11, 38.7252, 2.14675, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242596, 181371, 0, 1, 1, -604.148, -545.813, 36.579, 0.698132, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242597, 181371, 0, 1, 1, -5233.16, -2893.37, 337.286, -0.226893, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242598, 181371, 0, 1, 1, -9434.3, -2110.36, 65.8038, 0.349066, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242599, 181371, 1, 1, 1, 9778.64, 1019.38, 1299.79, 0.261799, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242600, 181371, 0, 1, 1, 188.243, -2132.53, 102.674, -1.37881, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242601, 181371, 0, 1, 1, -3448.2, -938.102, 10.6583, 0.034907, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242602, 181371, 0, 1, 1, -14288.1, 61.8062, 0.68836, 1.37881, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242603, 181371, 0, 1, 1, -8241.63, -2624.58, 133.184, 2.53448, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242604, 181371, 1, 1, 1, -7216.68, -3859.39, 11.4943, -2.72271, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242605, 181371, 0, 1, 1, 2273.88, 453.352, 33.9364, 3.35914, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242606, 181371, 1, 1, 1, 6860.03, -4767.11, 696.833, -2.63545, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242607, 181371, 0, 1, 1, -1134.84, -3531.81, 51.0719, -0.820305, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242608, 181371, 1, 1, 1, 2014.65, -2337.84, 89.5211, 2.37365, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242609, 181371, 0, 1, 1, -14376.7, 115.921, 1.4532, 2.11185, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242610, 181371, 1, 1, 1, -4395.96, 3481.54, 11.0626, 0.104316, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242611, 181371, 1, 1, 1, -7122.51, -3657.11, 8.82202, -1.74533, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242612, 181371, 1, 1, 1, 6855.99, -4564.4, 708.51, 0.855211, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242613, 181371, 0, 1, 1, -6704.48, -2200.91, 248.609, 0.017453, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242614, 181371, 0, 1, 1, -7596.42, -2086.6, 125.17, -0.942478, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242615, 181371, 1, 1, 1, -1862.36, 3055.71, 0.744157, 2.49582, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242616, 181371, 1, 1, 1, -3110.59, -2722.41, 33.4626, 0.226893, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242617, 181371, 1, 1, 1, -4573.22, 407.388, 41.5461, 2.46091, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242618, 181371, 530, 1, 1, 41.2448, 2587.44, 68.3453, -2.28638, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242619, 181371, 0, 1, 1, -134.688, -802.767, 55.0147, -1.62316, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242620, 181371, 530, 1, 1, -1211.01, 7474.44, 21.9953, -2.02458, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242621, 181371, 1, 1, 1, 952.992, 776.968, 104.474, -1.55334, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242622, 181371, 0, 1, 1, -10331.4, -3297.73, 21.9992, -2.89725, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242623, 181371, 530, 1, 1, -2553.32, 4277.61, 20.614, -1.36136, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242624, 181371, 1, 1, 1, -273.242, -2662.82, 91.695, -1.8675, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242625, 181371, 0, 1, 1, -447.95, -4527.65, 8.59595, 1.53589, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242626, 181371, 1, 1, 1, -5513.93, -2299.73, -58.0752, 2.44346, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242627, 181371, 530, 1, 1, 200.9, 7686.96, 22.508, -0.506145, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242628, 181371, 0, 1, 1, 587.056, 1365.02, 90.4778, 2.6529, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242629, 181371, 0, 1, 1, -10657.1, 1054.63, 32.6733, 2.47837, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242630, 181371, 530, 1, 1, 2274.45, 6133.53, 136.905, 1.61654, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242631, 181371, 530, 1, 1, -3053.71, 2398.05, 60.883, 4.43274, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242632, 181371, 530, 1, 1, 9383.5, -6777.43, 13.7903, 0.0251532, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242633, 181371, 1, 1, 1, 151.481, -4711.98, 18.5644, 3.07253, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242634, 181371, 530, 1, 1, -4219.05, -12319.5, 2.33427, 6.06485, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242635, 181371, 0, 1, 1, 1001.7, -1457.95, 61.0382, 3.15495, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242636, 181371, 530, 1, 1, -3008.76, 4156.66, 3.76291, 0.225413, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242637, 181371, 530, 1, 1, -2248.27, -11902, 26.3641, 5.16557, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242638, 181371, 530, 1, 1, 2025.02, 6577.95, 134.195, 4.76893, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242639, 181371, 530, 1, 1, 3122.3, 3755.28, 141.82, 0.0329792, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242640, 181371, 571, 1, 1, 5540.38, -748.132, 151.854, 6.03735, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242641, 181371, 571, 1, 1, 5141.08, -663.877, 170.145, 6.2769, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242642, 181371, 571, 1, 1, 3940.62, -584.935, 240.743, 0.163699, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242643, 181371, 571, 1, 1, 3768.95, 1462.02, 92.6355, 0.0301769, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242644, 181371, 571, 1, 1, 4121.36, 5394.75, 28.3803, 0.0458794, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242645, 181371, 571, 1, 1, 4440.61, 5624.95, 56.0681, 6.28193, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242646, 181371, 571, 1, 1, 5370.74, 4842.57, -197.512, 0.00267172, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242647, 181371, 571, 1, 1, 5504.33, 4864.31, -197.319, 0.273637, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242648, 181371, 571, 1, 1, 6139.2, -1024.37, 409.239, 0.132262, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242649, 181371, 571, 1, 1, 6072.67, -1103.21, 419.456, 6.23874, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242650, 181371, 571, 1, 1, 5641.3, -2622.27, 292.419, 0.0655074, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242651, 181371, 571, 1, 1, 5288.52, -2757.12, 292.418, 6.27408, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242652, 181371, 571, 1, 1, 3399.05, -2911.26, 202.028, 6.21516, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242653, 181371, 571, 1, 1, 3360.71, -2113.31, 124.059, 0.175442, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242654, 181371, 571, 1, 1, 2572.61, -4330.26, 276.656, 0.222526, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242655, 181371, 571, 1, 1, 2483.96, -4886.47, 265.271, 6.27404, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242656, 181332, 0, 1, 1, -8837.04, 857.657, 98.7763, -2.07694, 0, 0, 0.620629, 0.784104, 600, 100, 1, 0);
INSERT INTO gameobject VALUES (242657, 181333, 0, 1, 1, -4700.28, -1224.34, 501.659, -2.14675, 0, 0, -0.878816, 0.477161, 900, 100, 1, 0);
INSERT INTO gameobject VALUES (242658, 181334, 1, 1, 1, 8700.21, 931.422, 14.823, 1.67552, 0, 0, 0.743146, 0.669129, 900, 100, 1, 0);
INSERT INTO gameobject VALUES (242659, 181335, 0, 1, 1, 1822.27, 218.639, 59.8924, -0.034907, 0, 0, 0.855093, 0.518475, 600, 100, 1, 0);
INSERT INTO gameobject VALUES (242660, 181336, 1, 1, 1, 1911.67, -4338.28, 21.0705, -0.20944, 0, 0, 0.730581, -0.682826, 600, 100, 1, 0);
INSERT INTO gameobject VALUES (242661, 181337, 1, 1, 1, -1027.8, 296.424, 135.746, 2.82743, 0, 0, 0.116368, -0.993206, 600, 100, 1, 0);
INSERT INTO gameobject VALUES (242662, 188128, 530, 1, 1, -3799.94, -11498.6, -134.796, 3.03715, 0, 0, 0.998637, 0.0521976, 300, 100, 1, 0);
INSERT INTO gameobject VALUES (242663, 188129, 530, 1, 1, 9810.75, -7236.68, 26.07, -3.1066, 0, 0, 0.0537805, 0.998553, 300, 100, 1, 0);
INSERT INTO gameobject VALUES (242664, 181371, 0, 1, 1, -8837.04, 857.657, 98.7763, -2.07694, 0, 0, 0.620629, 0.784104, 600, 0, 1, 0);
INSERT INTO gameobject VALUES (242665, 181371, 0, 1, 1, -4700.28, -1224.34, 501.659, -2.14675, 0, 0, -0.878816, 0.477161, 900, 0, 1, 0);
INSERT INTO gameobject VALUES (242666, 181371, 1, 1, 1, 8700.21, 931.422, 14.823, 1.67552, 0, 0, 0.743146, 0.669129, 900, 0, 1, 0);
INSERT INTO gameobject VALUES (242667, 181371, 0, 1, 1, 1822.27, 218.639, 59.8924, 2.05146, 0, 0, 0.855093, 0.518475, 600, 0, 1, 0);
INSERT INTO gameobject VALUES (242668, 181371, 1, 1, 1, 1911.67, -4338.28, 21.0705, -0.20944, 0, 0, 0.730581, -0.682826, 600, 0, 1, 0);
INSERT INTO gameobject VALUES (242669, 181371, 1, 1, 1, -1027.8, 296.424, 135.746, 6.04992, 0, 0, 0.116368, -0.993206, 600, 0, 1, 0);
INSERT INTO gameobject VALUES (242670, 181371, 530, 1, 1, -3799.94, -11498.6, -134.796, 3.03715, 0, 0, 0.998637, 0.0521976, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242671, 181371, 530, 1, 1, 9810.75, -7236.68, 26.068, 0.107613, 0, 0, 0.0537805, 0.998553, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242672, 187708, 0, 1, 1, -8824.67, 852.899, 99.1583, 5.92068, 0, 0, 0.18026, -0.983619, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242673, 187708, 0, 1, 1, -8823.43, 860.628, 99.0081, 4.64048, 0, 0, 0.732068, -0.681231, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242674, 187708, 0, 1, 1, -8819.07, 856.909, 99.0216, 4.21637, 0, 0, 0.859049, -0.511892, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242675, 187708, 530, 1, 1, -3783.24, -11481.1, -134.536, 5.39681, 0, 0, 0.42882, -0.90339, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242676, 187708, 530, 1, 1, -3779.75, -11489.2, -134.528, 3.15451, 0, 0, 0.999979, -0.00645697, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242677, 187708, 530, 1, 1, -3776.01, -11497.6, -134.515, 3.30373, 0, 0, 0.996716, -0.080981, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242678, 187708, 530, 1, 1, -3775.55, -11481.9, -134.45, 3.61396, 0, 0, 0.972237, -0.233996, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242679, 187708, 530, 1, 1, -3772.38, -11492.3, -134.452, 3.343, 0, 0, 0.994934, -0.100535, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242680, 187708, 530, 1, 1, 9800.7, -7260.34, 26.2742, 4.30118, 0, 0, 0.836577, -0.547849, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242681, 187708, 530, 1, 1, 9805.14, -7262.75, 26.2874, 5.63635, 0, 0, 0.317807, -0.948155, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242682, 187708, 530, 1, 1, 9810.88, -7262.53, 26.2483, 0.291716, 0, 0, 0.145342, 0.989382, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242683, 187708, 530, 1, 1, 9816.93, -7260.88, 26.2029, 1.5837, 0, 0, 0.711653, 0.702531, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242684, 187708, 530, 1, 1, 9819.6, -7256.97, 26.1681, 1.9921, 0, 0, 0.839331, 0.54362, 300, 0, 1, 0);
REPLACE INTO game_event_gameobject VALUES(1, 242500),(1, 242501),(1, 242502),(1, 242503),(1, 242504),(1, 242505),(1, 242506),
(1, 242507),(1, 242508),(1, 242509),(1, 242510),(1, 242511),(1, 242512),(1, 242513),(1, 242514),(1, 242515),(1, 242516),(1, 242517),
(1, 242518),(1, 242519),(1, 242520),(1, 242521),(1, 242522),(1, 242523),(1, 242524),(1, 242525),(1, 242526),(1, 242527),(1, 242528),
(1, 242529),(1, 242530),(1, 242531),(1, 242532),(1, 242533),(1, 242534),(1, 242535),(1, 242536),(1, 242537),(1, 242538),(1, 242539),
(1, 242540),(1, 242541),(1, 242542),(1, 242543),(1, 242544),(1, 242545),(1, 242546),(1, 242547),(1, 242548),(1, 242549),(1, 242550),
(1, 242551),(1, 242552),(1, 242553),(1, 242554),(1, 242555),(1, 242556),(1, 242557),(1, 242558),(1, 242559),(1, 242560),(1, 242561),
(1, 242562),(1, 242563),(1, 242564),(1, 242565),(1, 242566),(1, 242567),(1, 242568),(1, 242569),(1, 242570),(1, 242571),(1, 242572),
(1, 242573),(1, 242574),(1, 242575),(1, 242576),(1, 242577),(1, 242578),(1, 242579),(1, 242580),(1, 242581),(1, 242582),(1, 242583),
(1, 242584),(1, 242585),(1, 242586),(1, 242587),(1, 242588),(1, 242589),(1, 242590),(1, 242591),(1, 242592),(1, 242593),(1, 242594),
(1, 242595),(1, 242596),(1, 242597),(1, 242598),(1, 242599),(1, 242600),(1, 242601),(1, 242602),(1, 242603),(1, 242604),(1, 242605),
(1, 242606),(1, 242607),(1, 242608),(1, 242609),(1, 242610),(1, 242611),(1, 242612),(1, 242613),(1, 242614),(1, 242615),(1, 242616),
(1, 242617),(1, 242618),(1, 242619),(1, 242620),(1, 242621),(1, 242622),(1, 242623),(1, 242624),(1, 242625),(1, 242626),(1, 242627),
(1, 242628),(1, 242629),(1, 242630),(1, 242631),(1, 242632),(1, 242633),(1, 242634),(1, 242635),(1, 242636),(1, 242637),(1, 242638),
(1, 242639),(1, 242640),(1, 242641),(1, 242642),(1, 242643),(1, 242644),(1, 242645),(1, 242646),(1, 242647),(1, 242648),(1, 242649),
(1, 242650),(1, 242651),(1, 242652),(1, 242653),(1, 242654),(1, 242655),(1, 242656),(1, 242657),(1, 242658),(1, 242659),(1, 242660),
(1, 242661),(1, 242662),(1, 242663),(1, 242664),(1, 242665),(1, 242666),(1, 242667),(1, 242668),(1, 242669),(1, 242670),(1, 242671),
(1, 242672),(1, 242673),(1, 242674),(1, 242675),(1, 242676),(1, 242677),(1, 242678),(1, 242679),(1, 242680),(1, 242681),(1, 242682),
(1, 242683),(1, 242684);
