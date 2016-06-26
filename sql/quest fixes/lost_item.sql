-- GENERIC item retrieving


-- Druid Signal (31763)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=8523 AND SourceEntry=1;
INSERT INTO conditions VALUES(15, 8523, 1, 0, 0, 14, 0, 10910, 0, 0, 1, 0, 0, '', 'Requires first quest with druid signal');
INSERT INTO conditions VALUES(15, 8523, 1, 0, 0, 2, 0, 31763, 1, 0, 1, 0, 0, '', 'Must not have item 31763');
INSERT INTO conditions VALUES(15, 8523, 1, 0, 0, 8, 0, 10912, 0, 0, 1, 0, 0, '', 'Requires quest 10912 to not be rewarded');
DELETE FROM gossip_menu_option WHERE menu_id=8523 AND id=1;
INSERT INTO gossip_menu_option VALUES(8523, 1, 0, "I've lost my Druid Signal.", 1, 1, 0, 0, 0, 0, "");
DELETE FROM smart_scripts WHERE entryorguid=22127 AND source_type=0 AND id IN(3, 4);
INSERT INTO smart_scripts VALUES (22127, 0, 3, 4, 62, 0, 100, 0, 8523, 1, 0, 0, 56, 31763, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Gossip Select - Add item");
INSERT INTO smart_scripts VALUES (22127, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Gossip Select - Close Gossip");

-- Brann's Communicator (40971)
UPDATE creature_template SET npcflag = npcflag | 1, AIName="SmartAI", gossip_menu_id=9854 WHERE entry=29937;
UPDATE creature_template SET npcflag = npcflag | 1, AIName="SmartAI" WHERE entry=29650;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup IN(9854, 9929);
INSERT INTO conditions VALUES(15, 9854, 1, 0, 0, 8, 0, 12910, 0, 0, 0, 0, 0, '', 'Must complete 12910 before this option is visible');
INSERT INTO conditions VALUES(15, 9854, 1, 0, 0, 2, 0, 40971, 1, 0, 1, 0, 0, '', 'Must not have item 40971');
INSERT INTO conditions VALUES(15, 9929, 1, 0, 0, 8, 0, 12855, 0, 0, 0, 0, 0, '', 'Must complete 12855 before this option is visible');
INSERT INTO conditions VALUES(15, 9929, 1, 0, 0, 2, 0, 40971, 1, 0, 1, 0, 0, '', 'Must not have item 40971');
DELETE FROM gossip_menu_option WHERE menu_id IN(9854, 9929);
INSERT INTO gossip_menu_option VALUES(9854, 1, 0, "I've lost my Brann\'s Communicator", 1, 1, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(9929, 1, 0, "I've lost my Brann\'s Communicator", 1, 1, 0, 0, 0, 0, "");
DELETE FROM smart_scripts WHERE entryorguid IN(29937, 29650) AND source_type=0;
INSERT INTO smart_scripts VALUES (29937, 0, 0, 1, 62, 0, 100, 0, 9854, 1, 0, 0, 56, 40971, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (29937, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip linked close gossip");
INSERT INTO smart_scripts VALUES (29650, 0, 0, 1, 62, 0, 100, 0, 9929, 1, 0, 0, 56, 40971, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (29650, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip linked close gossip");

-- Winterhoof Emblem (33340)
UPDATE creature_template SET npcflag = npcflag | 1, AIName="SmartAI" WHERE entry=24129;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup IN(8898);
INSERT INTO conditions VALUES
(15, 8898, 0, 0, 0, 8, 0, 11256, 0, 0, 0, 0, 0, '', 'Gossip Option requires Skorn Must Fall Rewarded'),
(15, 8898, 0, 0, 0, 8, 0, 11258, 0, 0, 1, 0, 0, '', 'Gossip Option requires Burn, Skorn, Burn not Rewarded'),
(15, 8898, 0, 0, 0, 2, 0, 33340, 1, 0, 1, 0, 0, '', 'Gossip Option requires Player does not Winterhoof Emblem'),
(15, 8898, 0, 0, 1, 8, 0, 11256, 0, 0, 0, 0, 0, '', 'Gossip Option requires Skorn Must Fall Rewarded'),
(15, 8898, 0, 0, 1, 8, 0, 11257, 0, 0, 1, 0, 0, '', 'Gossip Option requires Gruesome but Necessary not Rewarded'),
(15, 8898, 0, 0, 1, 2, 0, 33340, 1, 0, 1, 0, 0, '', 'Gossip Option requires Player does not Winterhoof Emblem'),
(15, 8898, 0, 0, 2, 8, 0, 11256, 0, 0, 0, 0, 0, '', 'Gossip Option requires Skorn Must Fall Rewarded'),
(15, 8898, 0, 0, 2, 8, 0, 11259, 0, 0, 1, 0, 0, '', 'Gossip Option requires Towers of Certain Doom not Rewarded'),
(15, 8898, 0, 0, 2, 2, 0, 33340, 1, 0, 1, 0, 0, '', 'Gossip Option requires Player does not Winterhoof Emblem'),
(15, 8898, 0, 0, 3, 8, 0, 11256, 0, 0, 0, 0, 0, '', 'Gossip Option requires Skorn Must Fall Rewarded'),
(15, 8898, 0, 0, 3, 8, 0, 11261, 0, 0, 1, 0, 0, '', 'Gossip Option requires The Conqueror of Skorn! not Rewarded'),
(15, 8898, 0, 0, 3, 2, 0, 33340, 1, 0, 1, 0, 0, '', 'Gossip Option requires Player does not Winterhoof Emblem');
DELETE FROM gossip_menu_option WHERE menu_id IN(8898);
INSERT INTO gossip_menu_option VALUES(8898, 0, 0, "Chief Ashtotem, I have misplaced the token that you gave me.", 1, 1, 0, 0, 0, 0, "");
DELETE FROM smart_scripts WHERE entryorguid=24129 AND source_type=0;
INSERT INTO smart_scripts VALUES (24129, 0, 0, 1, 62, 0, 100, 0, 8898, 0, 0, 0, 56, 33340, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (24129, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip linked close gossip");

-- Westguard Command Insignia (33311)
UPDATE creature_template SET gossip_menu_id=8852, npcflag=npcflag|1, AIName="SmartAI" WHERE entry=23749;
DELETE FROM gossip_menu WHERE entry=8852;
INSERT INTO gossip_menu VALUES (8852, 11494); -- 23749
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup IN(8852);
INSERT INTO conditions VALUES
(15, 8852, 0, 0, 0, 8, 0, 11248, 0, 0, 0, 0, 0, '', 'Gossip Option requires Operation: Skornful Wrath Rewarded'),
(15, 8852, 0, 0, 0, 8, 0, 11247, 0, 0, 1, 0, 0, '', 'Gossip Option requires Burn, Skorn, Burn not Rewarded'),
(15, 8852, 0, 0, 0, 2, 0, 33311, 1, 0, 1, 0, 0, '', 'Gossip Option requires Player does not have Westguard Command Insignia'),
(15, 8852, 0, 0, 1, 8, 0, 11248, 0, 0, 0, 0, 0, '', 'Gossip Option requires Operation: Skornful Wrath Rewarded'),
(15, 8852, 0, 0, 1, 8, 0, 11246, 0, 0, 1, 0, 0, '', 'Gossip Option requires Gruesome but Necessary not Rewarded'),
(15, 8852, 0, 0, 1, 2, 0, 33311, 1, 0, 1, 0, 0, '', 'Gossip Option requires Player does not Have Westguard Command Insignia'),
(15, 8852, 0, 0, 2, 8, 0, 11248, 0, 0, 0, 0, 0, '', 'Gossip Option requires Operation: Skornful Wrath Rewarded'),
(15, 8852, 0, 0, 2, 8, 0, 11245, 0, 0, 1, 0, 0, '', 'Gossip Option requires Towers of Certain Doom not Rewarded'),
(15, 8852, 0, 0, 2, 2, 0, 33311, 1, 0, 1, 0, 0, '', 'Gossip Option requires Player does not have Westguard Command Insignia'),
(15, 8852, 0, 0, 3, 8, 0, 11248, 0, 0, 0, 0, 0, '', 'Gossip Option requires Operation: Skornful Wrath'),
(15, 8852, 0, 0, 3, 8, 0, 11250, 0, 0, 1, 0, 0, '', 'Gossip Option requires All Hail the Conqueror of Skorn! not Rewarded'),
(15, 8852, 0, 0, 3, 2, 0, 33311, 1, 0, 1, 0, 0, '', 'Gossip Option requires Player does not have Westguard Command Insignia');
DELETE FROM gossip_menu_option WHERE menu_id=8852;
INSERT INTO gossip_menu_option VALUES(8852, 0, 0, "Captain, I've somehow lost my command insignia.", 1, 1, 0, 0, 0, 0, "");
DELETE FROM smart_scripts WHERE entryorguid=23749 AND source_type=0;
INSERT INTO smart_scripts VALUES (23749, 0, 0, 1, 62, 0, 100, 0, 8852, 0, 0, 0, 56, 33311, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (23749, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip linked close gossip");

-- Goblin Transponder (9173)
DELETE FROM gossip_menu_option WHERE menu_id=1628;
INSERT INTO gossip_menu_option VALUES(1628, 0, 0, "Scooty, i've lost my goblin transponder!", 1, 1, 0, 0, 0, 0, "");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=1628;
INSERT INTO conditions VALUES(15, 1628, 0, 0, 0, 8, 0, 2843, 0, 0, 0, 0, 0, '', 'Must complete 2843 before this option is visible');
INSERT INTO conditions VALUES(15, 1628, 0, 0, 0, 2, 0, 9173, 1, 0, 1, 0, 0, '', 'Must not have item 9173');
DELETE FROM smart_scripts WHERE entryorguid=7853 AND source_type=0 AND id IN(1, 2);
INSERT INTO smart_scripts VALUES (7853, 0, 1, 2, 62, 0, 100, 0, 1628, 0, 0, 0, 11, 13325, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Gossip Select - Cast Spell Summon Spectral Essence");
INSERT INTO smart_scripts VALUES (7853, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Gossipe Select - Close Gossip");

-- Spectrecles (30719)
-- Spectrecles (30721)
UPDATE creature_template SET npcflag = npcflag | 1, gossip_menu_id=8383, AIName="SmartAI" WHERE entry=21772;
UPDATE creature_template SET npcflag = npcflag | 1, AIName="SmartAI" WHERE entry=21774;
DELETE FROM gossip_menu_option WHERE menu_id IN(8392, 8383);
INSERT INTO gossip_menu_option VALUES(8392, 0, 0, "Zorus, I need a new pair of goggles.", 1, 1, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(8392, 1, 0, "Zorus, I need a new pair of goggles.", 1, 1, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(8383, 0, 0, "Hildagard, I need a new pair of goggles.", 1, 1, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(8383, 1, 0, "Hildagard, I need a new pair of goggles.", 1, 1, 0, 0, 0, 0, "");
DELETE FROM smart_scripts WHERE entryorguid IN(21772, 21774) AND source_type=0;
INSERT INTO smart_scripts VALUES (21772, 0, 0, 2, 62, 0, 100, 0, 8383, 0, 0, 0, 11, 37602, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select - Cast Spell");
INSERT INTO smart_scripts VALUES (21772, 0, 1, 2, 62, 0, 100, 0, 8383, 1, 0, 0, 11, 37700, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select - Cast Spell");
INSERT INTO smart_scripts VALUES (21772, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip linked close gossip");
INSERT INTO smart_scripts VALUES (21774, 0, 0, 2, 62, 0, 100, 0, 8392, 0, 0, 0, 11, 37602, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select - Cast Spell");
INSERT INTO smart_scripts VALUES (21774, 0, 1, 2, 62, 0, 100, 0, 8392, 1, 0, 0, 11, 37700, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select - Cast Spell");
INSERT INTO smart_scripts VALUES (21774, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip linked close gossip");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup IN(8383, 8392);
INSERT INTO conditions VALUES(15, 8383, 0, 0, 0, 9, 0, 10625, 0, 0, 0, 0, 0, '', 'Requires quest Spectrecles');
INSERT INTO conditions VALUES(15, 8383, 1, 0, 0, 14, 0, 10633, 0, 0, 1, 0, 0, '', 'Requires quest status Teron Gorefiend - Lore and Legend');
INSERT INTO conditions VALUES(15, 8392, 0, 0, 0, 9, 0, 10643, 0, 0, 0, 0, 0, '', 'Requires quest Harbingers of Shadowmoon');
INSERT INTO conditions VALUES(15, 8392, 1, 0, 0, 14, 0, 10644, 0, 0, 1, 0, 0, '', 'Requires quest status Teron Gorefiend - Lore and Legend');

-- Band of the Eternal Champion (29301)
-- Band of the Eternal Sage (29305)
-- Band of the Eternal Restorer (29309)
-- Band of the Eternal Defender (29297)
UPDATE creature_template SET npcflag=npcflag|1, gossip_menu_id=8234, AIName="SmartAI" WHERE entry=19935;
DELETE FROM gossip_menu_option WHERE menu_id=8234;
INSERT INTO gossip_menu_option VALUES(8234, 0, 0, "I've lost my Band of the Eternal Champion.", 1, 1, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(8234, 1, 0, "I've lost my Band of the Eternal Sage.", 1, 1, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(8234, 2, 0, "I've lost my Band of the Eternal Restorer.", 1, 1, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(8234, 3, 0, "I've lost my Band of the Eternal Defender.", 1, 1, 0, 0, 0, 0, "");
DELETE FROM smart_scripts WHERE entryorguid=19935 AND source_type=0;
INSERT INTO smart_scripts VALUES (19935, 0, 0, 4, 62, 0, 100, 0, 8234, 0, 0, 0, 11, 41529, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Soridormi - On Gossip Select - Cast Create Band of the Eternal Champion");
INSERT INTO smart_scripts VALUES (19935, 0, 1, 4, 62, 0, 100, 0, 8234, 1, 0, 0, 11, 41532, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Soridormi - On Gossip Select - Cast Create Band of the Eternal Sage");
INSERT INTO smart_scripts VALUES (19935, 0, 2, 4, 62, 0, 100, 0, 8234, 2, 0, 0, 11, 41531, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Soridormi - On Gossip Select - Cast Create Band of the Eternal Restorer");
INSERT INTO smart_scripts VALUES (19935, 0, 3, 4, 62, 0, 100, 0, 8234, 3, 0, 0, 11, 41530, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Soridormi - On Gossip Select - Cast Create Band of the Eternal Champion");
INSERT INTO smart_scripts VALUES (19935, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Soridormi - On Gossip Select - Close Gossip");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=8234;
INSERT INTO conditions VALUES(15, 8234, 0, 0, 0, 9, 0, 10474, 0, 0, 0, 0, 0, '', 'Requires quest Champion''s Covenant');
INSERT INTO conditions VALUES(15, 8234, 0, 0, 0, 2, 0, 29301, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8234, 0, 0, 0, 2, 0, 29305, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8234, 0, 0, 0, 2, 0, 29309, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8234, 0, 0, 0, 2, 0, 29297, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8234, 1, 0, 0, 9, 0, 10472, 0, 0, 0, 0, 0, '', 'Requires quest Sage''s Covenant');
INSERT INTO conditions VALUES(15, 8234, 1, 0, 0, 2, 0, 29301, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8234, 1, 0, 0, 2, 0, 29305, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8234, 1, 0, 0, 2, 0, 29309, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8234, 1, 0, 0, 2, 0, 29297, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8234, 2, 0, 0, 9, 0, 10473, 0, 0, 0, 0, 0, '', 'Requires quest Restorer''s Covenant');
INSERT INTO conditions VALUES(15, 8234, 2, 0, 0, 2, 0, 29301, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8234, 2, 0, 0, 2, 0, 29305, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8234, 2, 0, 0, 2, 0, 29309, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8234, 2, 0, 0, 2, 0, 29297, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8234, 3, 0, 0, 9, 0, 10475, 0, 0, 0, 0, 0, '', 'Requires quest Defender''s Covenant');
INSERT INTO conditions VALUES(15, 8234, 3, 0, 0, 2, 0, 29301, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8234, 3, 0, 0, 2, 0, 29305, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8234, 3, 0, 0, 2, 0, 29309, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8234, 3, 0, 0, 2, 0, 29297, 1, 1, 1, 0, 0, '', 'Requires no Band item');

-- Green Trophy Tabard of the Illidari (31404)
-- Purple Trophy Tabard of the Illidari (31405)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=9832 AND ConditionTypeOrReference=2 AND ConditionValue1=31408;

-- ICC Rings
DELETE FROM npc_text WHERE ID=15299 AND (text0_0 LIKE '%am deeply disappointed%' OR text0_0 LIKE '%MISSING TEXT%');
INSERT INTO npc_text VALUES (15299, 'Lost?$b$bI am deeply disappointed, $n.$b$bThat ring was one of a kind, crafted out of the remnants of the armor of our fallen heroes and the purified metal from our enemy''s blades.$b$bLet''s not allow this to happen again.', '', 0, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 12340);
DELETE FROM gossip_menu WHERE entry=10995 AND text_id=15295;
INSERT INTO gossip_menu VALUES(10995, 15295);
-- wisdom
REPLACE INTO gossip_menu_option VALUES (10995, 0, 0, 'It won''t.', 1, 1, 0, 0, 0, 10000000, 'A contribution is required.');
REPLACE INTO gossip_menu_option VALUES (10995, 1, 0, 'It won''t.', 1, 1, 0, 0, 0, 10000000, 'A contribution is required.');
REPLACE INTO gossip_menu_option VALUES (10995, 2, 0, 'It won''t.', 1, 1, 0, 0, 0, 10000000, 'A contribution is required.');
REPLACE INTO gossip_menu_option VALUES (10995, 3, 0, 'It won''t.', 1, 1, 0, 0, 0, 10000000, 'A contribution is required.');
-- vengeance
REPLACE INTO gossip_menu_option VALUES (10995, 4, 0, 'It won''t.', 1, 1, 0, 0, 0, 10000000, 'A contribution is required.');
REPLACE INTO gossip_menu_option VALUES (10995, 5, 0, 'It won''t.', 1, 1, 0, 0, 0, 10000000, 'A contribution is required.');
REPLACE INTO gossip_menu_option VALUES (10995, 6, 0, 'It won''t.', 1, 1, 0, 0, 0, 10000000, 'A contribution is required.');
REPLACE INTO gossip_menu_option VALUES (10995, 7, 0, 'It won''t.', 1, 1, 0, 0, 0, 10000000, 'A contribution is required.');
-- courage
REPLACE INTO gossip_menu_option VALUES (10995, 8, 0, 'It won''t.', 1, 1, 0, 0, 0, 10000000, 'A contribution is required.');
REPLACE INTO gossip_menu_option VALUES (10995, 9, 0, 'It won''t.', 1, 1, 0, 0, 0, 10000000, 'A contribution is required.');
REPLACE INTO gossip_menu_option VALUES (10995, 10, 0, 'It won''t.', 1, 1, 0, 0, 0, 10000000, 'A contribution is required.');
REPLACE INTO gossip_menu_option VALUES (10995, 11, 0, 'It won''t.', 1, 1, 0, 0, 0, 10000000, 'A contribution is required.');
-- destruction
REPLACE INTO gossip_menu_option VALUES (10995, 12, 0, 'It won''t.', 1, 1, 0, 0, 0, 10000000, 'A contribution is required.');
REPLACE INTO gossip_menu_option VALUES (10995, 13, 0, 'It won''t.', 1, 1, 0, 0, 0, 10000000, 'A contribution is required.');
REPLACE INTO gossip_menu_option VALUES (10995, 14, 0, 'It won''t.', 1, 1, 0, 0, 0, 10000000, 'A contribution is required.');
REPLACE INTO gossip_menu_option VALUES (10995, 15, 0, 'It won''t.', 1, 1, 0, 0, 0, 10000000, 'A contribution is required.');
-- might
REPLACE INTO gossip_menu_option VALUES (10995, 16, 0, 'It won''t.', 1, 1, 0, 0, 0, 10000000, 'A contribution is required.');
REPLACE INTO gossip_menu_option VALUES (10995, 17, 0, 'It won''t.', 1, 1, 0, 0, 0, 10000000, 'A contribution is required.');
REPLACE INTO gossip_menu_option VALUES (10995, 18, 0, 'It won''t.', 1, 1, 0, 0, 0, 10000000, 'A contribution is required.');
REPLACE INTO gossip_menu_option VALUES (10995, 19, 0, 'It won''t.', 1, 1, 0, 0, 0, 10000000, 'A contribution is required.');
REPLACE INTO gossip_menu_option VALUES (10996, 6, 0, 'I appear to have lost my ring.', 1, 1, 10995, 0, 0, 0, ''); -- First of all
UPDATE creature_template SET unit_flags=unit_flags|0x300, gossip_menu_id=10996, npcflag=4227, AIName='SmartAI', ScriptName='' WHERE entry=38316;
DELETE FROM smart_scripts WHERE entryorguid=38316 AND source_type=0;
INSERT INTO smart_scripts VALUES (38316, 0, 0, 20, 62, 0, 100, 0, 10995, 0, 0, 0, 56, 50378, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Ormus - On Gossip Select - Add Item");
INSERT INTO smart_scripts VALUES (38316, 0, 1, 20, 62, 0, 100, 0, 10995, 1, 0, 0, 56, 50386, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Ormus - On Gossip Select - Add Item");
INSERT INTO smart_scripts VALUES (38316, 0, 2, 20, 62, 0, 100, 0, 10995, 2, 0, 0, 56, 50399, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Ormus - On Gossip Select - Add Item");
INSERT INTO smart_scripts VALUES (38316, 0, 3, 20, 62, 0, 100, 0, 10995, 3, 0, 0, 56, 50400, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Ormus - On Gossip Select - Add Item");
INSERT INTO smart_scripts VALUES (38316, 0, 4, 20, 62, 0, 100, 0, 10995, 4, 0, 0, 56, 50376, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Ormus - On Gossip Select - Add Item");
INSERT INTO smart_scripts VALUES (38316, 0, 5, 20, 62, 0, 100, 0, 10995, 5, 0, 0, 56, 50387, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Ormus - On Gossip Select - Add Item");
INSERT INTO smart_scripts VALUES (38316, 0, 6, 20, 62, 0, 100, 0, 10995, 6, 0, 0, 56, 50401, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Ormus - On Gossip Select - Add Item");
INSERT INTO smart_scripts VALUES (38316, 0, 7, 20, 62, 0, 100, 0, 10995, 7, 0, 0, 56, 50402, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Ormus - On Gossip Select - Add Item");
INSERT INTO smart_scripts VALUES (38316, 0, 8, 20, 62, 0, 100, 0, 10995, 8, 0, 0, 56, 50375, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Ormus - On Gossip Select - Add Item");
INSERT INTO smart_scripts VALUES (38316, 0, 9, 20, 62, 0, 100, 0, 10995, 9, 0, 0, 56, 50388, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Ormus - On Gossip Select - Add Item");
INSERT INTO smart_scripts VALUES (38316, 0, 10, 20, 62, 0, 100, 0, 10995, 10, 0, 0, 56, 50403, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Ormus - On Gossip Select - Add Item");
INSERT INTO smart_scripts VALUES (38316, 0, 11, 20, 62, 0, 100, 0, 10995, 11, 0, 0, 56, 50404, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Ormus - On Gossip Select - Add Item");
INSERT INTO smart_scripts VALUES (38316, 0, 12, 20, 62, 0, 100, 0, 10995, 12, 0, 0, 56, 50377, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Ormus - On Gossip Select - Add Item");
INSERT INTO smart_scripts VALUES (38316, 0, 13, 20, 62, 0, 100, 0, 10995, 13, 0, 0, 56, 50384, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Ormus - On Gossip Select - Add Item");
INSERT INTO smart_scripts VALUES (38316, 0, 14, 20, 62, 0, 100, 0, 10995, 14, 0, 0, 56, 50397, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Ormus - On Gossip Select - Add Item");
INSERT INTO smart_scripts VALUES (38316, 0, 15, 20, 62, 0, 100, 0, 10995, 15, 0, 0, 56, 50398, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Ormus - On Gossip Select - Add Item");
INSERT INTO smart_scripts VALUES (38316, 0, 16, 20, 62, 0, 100, 0, 10995, 16, 0, 0, 56, 52569, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Ormus - On Gossip Select - Add Item");
INSERT INTO smart_scripts VALUES (38316, 0, 17, 20, 62, 0, 100, 0, 10995, 17, 0, 0, 56, 52570, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Ormus - On Gossip Select - Add Item");
INSERT INTO smart_scripts VALUES (38316, 0, 18, 20, 62, 0, 100, 0, 10995, 18, 0, 0, 56, 52571, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Ormus - On Gossip Select - Add Item");
INSERT INTO smart_scripts VALUES (38316, 0, 19, 20, 62, 0, 100, 0, 10995, 19, 0, 0, 56, 52572, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Ormus - On Gossip Select - Add Item");
INSERT INTO smart_scripts VALUES (38316, 0, 20, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Ormus - On Gossip Select - Close Gossip");

DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=10996;
INSERT INTO conditions VALUES(15, 10996, 6, 0, 0, 8, 0, 24815, 0, 0, 0, 0, 0, '', 'Requires quest Choose Your Path');
-- Ashen Band of Wisdom
INSERT INTO conditions VALUES(15, 10996, 6, 0, 0, 2, 0, 50378, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 10996, 6, 0, 0, 2, 0, 50386, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 10996, 6, 0, 0, 2, 0, 50399, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 10996, 6, 0, 0, 2, 0, 50400, 1, 1, 1, 0, 0, '', 'Requires no Band item');
-- Ashen Band of Vengeance 
INSERT INTO conditions VALUES(15, 10996, 6, 0, 0, 2, 0, 50376, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 10996, 6, 0, 0, 2, 0, 50387, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 10996, 6, 0, 0, 2, 0, 50401, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 10996, 6, 0, 0, 2, 0, 50402, 1, 1, 1, 0, 0, '', 'Requires no Band item');
-- Ashen Band of Courage 
INSERT INTO conditions VALUES(15, 10996, 6, 0, 0, 2, 0, 50375, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 10996, 6, 0, 0, 2, 0, 50388, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 10996, 6, 0, 0, 2, 0, 50403, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 10996, 6, 0, 0, 2, 0, 50404, 1, 1, 1, 0, 0, '', 'Requires no Band item');
-- Ashen Band of Destruction 
INSERT INTO conditions VALUES(15, 10996, 6, 0, 0, 2, 0, 50377, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 10996, 6, 0, 0, 2, 0, 50384, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 10996, 6, 0, 0, 2, 0, 50397, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 10996, 6, 0, 0, 2, 0, 50398, 1, 1, 1, 0, 0, '', 'Requires no Band item');
-- Ashen Band of Might 
INSERT INTO conditions VALUES(15, 10996, 6, 0, 0, 2, 0, 52569, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 10996, 6, 0, 0, 2, 0, 52570, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 10996, 6, 0, 0, 2, 0, 52571, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 10996, 6, 0, 0, 2, 0, 52572, 1, 1, 1, 0, 0, '', 'Requires no Band item');

DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=10995;
INSERT INTO conditions VALUES(15, 10995, 0, 0, 0, 8, 0, 24809, 0, 0, 0, 0, 0, '', 'Requires quest Wisdom Flag');
INSERT INTO conditions VALUES(15, 10995, 0, 0, 0, 50, 0, 24825, 0, 0, 0, 0, 0, '', 'Requires satisfy exclusive group Wisdom 1');
INSERT INTO conditions VALUES(15, 10995, 0, 0, 0, 2, 0, 50378, 1, 1, 1, 0, 0, '', 'Requires no item Wisdom 0');
INSERT INTO conditions VALUES(15, 10995, 1, 0, 0, 8, 0, 24809, 0, 0, 0, 0, 0, '', 'Requires quest Wisdom Flag');
INSERT INTO conditions VALUES(15, 10995, 1, 0, 0, 50, 0, 24825, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group Wisdom 1');
INSERT INTO conditions VALUES(15, 10995, 1, 0, 0, 50, 0, 24830, 0, 0, 0, 0, 0, '', 'Requires satisfy exclusive group Wisdom 2');
INSERT INTO conditions VALUES(15, 10995, 1, 0, 0, 2, 0, 50386, 1, 1, 1, 0, 0, '', 'Requires no item Wisdom 1');
INSERT INTO conditions VALUES(15, 10995, 2, 0, 0, 8, 0, 24809, 0, 0, 0, 0, 0, '', 'Requires quest Wisdom Flag');
INSERT INTO conditions VALUES(15, 10995, 2, 0, 0, 50, 0, 24825, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group Wisdom 1');
INSERT INTO conditions VALUES(15, 10995, 2, 0, 0, 50, 0, 24830, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group Wisdom 2');
INSERT INTO conditions VALUES(15, 10995, 2, 0, 0, 50, 0, 24831, 0, 0, 0, 0, 0, '', 'Requires satisfy exclusive group Wisdom 3');
INSERT INTO conditions VALUES(15, 10995, 2, 0, 0, 2, 0, 50399, 1, 1, 1, 0, 0, '', 'Requires no item Wisdom 2');
INSERT INTO conditions VALUES(15, 10995, 3, 0, 0, 8, 0, 24809, 0, 0, 0, 0, 0, '', 'Requires quest Wisdom Flag');
INSERT INTO conditions VALUES(15, 10995, 3, 0, 0, 50, 0, 24825, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group Wisdom 1');
INSERT INTO conditions VALUES(15, 10995, 3, 0, 0, 50, 0, 24830, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group Wisdom 2');
INSERT INTO conditions VALUES(15, 10995, 3, 0, 0, 50, 0, 24831, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group Wisdom 3');
INSERT INTO conditions VALUES(15, 10995, 3, 0, 0, 2, 0, 50400, 1, 1, 1, 0, 0, '', 'Requires no item Wisdom 3');
INSERT INTO conditions VALUES(15, 10995, 4, 0, 0, 8, 0, 24810, 0, 0, 0, 0, 0, '', 'Requires quest vengeance Flag');
INSERT INTO conditions VALUES(15, 10995, 4, 0, 0, 50, 0, 24826, 0, 0, 0, 0, 0, '', 'Requires satisfy exclusive group vengeance 1');
INSERT INTO conditions VALUES(15, 10995, 4, 0, 0, 2, 0, 50376, 1, 1, 1, 0, 0, '', 'Requires no item vengeance 0');
INSERT INTO conditions VALUES(15, 10995, 5, 0, 0, 8, 0, 24810, 0, 0, 0, 0, 0, '', 'Requires quest vengeance Flag');
INSERT INTO conditions VALUES(15, 10995, 5, 0, 0, 50, 0, 24826, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group vengeance 1');
INSERT INTO conditions VALUES(15, 10995, 5, 0, 0, 50, 0, 24832, 0, 0, 0, 0, 0, '', 'Requires satisfy exclusive group vengeance 2');
INSERT INTO conditions VALUES(15, 10995, 5, 0, 0, 2, 0, 50387, 1, 1, 1, 0, 0, '', 'Requires no item vengeance 1');
INSERT INTO conditions VALUES(15, 10995, 6, 0, 0, 8, 0, 24810, 0, 0, 0, 0, 0, '', 'Requires quest vengeance Flag');
INSERT INTO conditions VALUES(15, 10995, 6, 0, 0, 50, 0, 24826, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group vengeance 1');
INSERT INTO conditions VALUES(15, 10995, 6, 0, 0, 50, 0, 24832, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group vengeance 2');
INSERT INTO conditions VALUES(15, 10995, 6, 0, 0, 50, 0, 24833, 0, 0, 0, 0, 0, '', 'Requires satisfy exclusive group vengeance 3');
INSERT INTO conditions VALUES(15, 10995, 6, 0, 0, 2, 0, 50401, 1, 1, 1, 0, 0, '', 'Requires no item vengeance 2');
INSERT INTO conditions VALUES(15, 10995, 7, 0, 0, 8, 0, 24810, 0, 0, 0, 0, 0, '', 'Requires quest vengeance Flag');
INSERT INTO conditions VALUES(15, 10995, 7, 0, 0, 50, 0, 24826, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group vengeance 1');
INSERT INTO conditions VALUES(15, 10995, 7, 0, 0, 50, 0, 24832, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group vengeance 2');
INSERT INTO conditions VALUES(15, 10995, 7, 0, 0, 50, 0, 24833, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group vengeance 3');
INSERT INTO conditions VALUES(15, 10995, 7, 0, 0, 2, 0, 50402, 1, 1, 1, 0, 0, '', 'Requires no item vengeance 3');
INSERT INTO conditions VALUES(15, 10995, 8, 0, 0, 8, 0, 24808, 0, 0, 0, 0, 0, '', 'Requires quest Courage Flag');
INSERT INTO conditions VALUES(15, 10995, 8, 0, 0, 50, 0, 24827, 0, 0, 0, 0, 0, '', 'Requires satisfy exclusive group Courage 1');
INSERT INTO conditions VALUES(15, 10995, 8, 0, 0, 2, 0, 50375, 1, 1, 1, 0, 0, '', 'Requires no item Courage 0');
INSERT INTO conditions VALUES(15, 10995, 9, 0, 0, 8, 0, 24808, 0, 0, 0, 0, 0, '', 'Requires quest Courage Flag');
INSERT INTO conditions VALUES(15, 10995, 9, 0, 0, 50, 0, 24827, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group Courage 1');
INSERT INTO conditions VALUES(15, 10995, 9, 0, 0, 50, 0, 24834, 0, 0, 0, 0, 0, '', 'Requires satisfy exclusive group Courage 2');
INSERT INTO conditions VALUES(15, 10995, 9, 0, 0, 2, 0, 50388, 1, 1, 1, 0, 0, '', 'Requires no item Courage 1');
INSERT INTO conditions VALUES(15, 10995, 10, 0, 0, 8, 0, 24808, 0, 0, 0, 0, 0, '', 'Requires quest Courage Flag');
INSERT INTO conditions VALUES(15, 10995, 10, 0, 0, 50, 0, 24827, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group Courage 1');
INSERT INTO conditions VALUES(15, 10995, 10, 0, 0, 50, 0, 24834, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group Courage 2');
INSERT INTO conditions VALUES(15, 10995, 10, 0, 0, 50, 0, 24835, 0, 0, 0, 0, 0, '', 'Requires satisfy exclusive group Courage 3');
INSERT INTO conditions VALUES(15, 10995, 10, 0, 0, 2, 0, 50403, 1, 1, 1, 0, 0, '', 'Requires no item Courage 2');
INSERT INTO conditions VALUES(15, 10995, 11, 0, 0, 8, 0, 24808, 0, 0, 0, 0, 0, '', 'Requires quest Courage Flag');
INSERT INTO conditions VALUES(15, 10995, 11, 0, 0, 50, 0, 24827, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group Courage 1');
INSERT INTO conditions VALUES(15, 10995, 11, 0, 0, 50, 0, 24834, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group Courage 2');
INSERT INTO conditions VALUES(15, 10995, 11, 0, 0, 50, 0, 24835, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group Courage 3');
INSERT INTO conditions VALUES(15, 10995, 11, 0, 0, 2, 0, 50404, 1, 1, 1, 0, 0, '', 'Requires no item Courage 3');
INSERT INTO conditions VALUES(15, 10995, 12, 0, 0, 8, 0, 24811, 0, 0, 0, 0, 0, '', 'Requires quest Destruction Flag');
INSERT INTO conditions VALUES(15, 10995, 12, 0, 0, 50, 0, 24828, 0, 0, 0, 0, 0, '', 'Requires satisfy exclusive group Destruction 1');
INSERT INTO conditions VALUES(15, 10995, 12, 0, 0, 2, 0, 50377, 1, 1, 1, 0, 0, '', 'Requires no item Destruction 0');
INSERT INTO conditions VALUES(15, 10995, 13, 0, 0, 8, 0, 24811, 0, 0, 0, 0, 0, '', 'Requires quest Destruction Flag');
INSERT INTO conditions VALUES(15, 10995, 13, 0, 0, 50, 0, 24828, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group Destruction 1');
INSERT INTO conditions VALUES(15, 10995, 13, 0, 0, 50, 0, 24823, 0, 0, 0, 0, 0, '', 'Requires satisfy exclusive group Destruction 2');
INSERT INTO conditions VALUES(15, 10995, 13, 0, 0, 2, 0, 50384, 1, 1, 1, 0, 0, '', 'Requires no item Destruction 1');
INSERT INTO conditions VALUES(15, 10995, 14, 0, 0, 8, 0, 24811, 0, 0, 0, 0, 0, '', 'Requires quest Destruction Flag');
INSERT INTO conditions VALUES(15, 10995, 14, 0, 0, 50, 0, 24828, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group Destruction 1');
INSERT INTO conditions VALUES(15, 10995, 14, 0, 0, 50, 0, 24823, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group Destruction 2');
INSERT INTO conditions VALUES(15, 10995, 14, 0, 0, 50, 0, 24829, 0, 0, 0, 0, 0, '', 'Requires satisfy exclusive group Destruction 3');
INSERT INTO conditions VALUES(15, 10995, 14, 0, 0, 2, 0, 50397, 1, 1, 1, 0, 0, '', 'Requires no item Destruction 2');
INSERT INTO conditions VALUES(15, 10995, 15, 0, 0, 8, 0, 24811, 0, 0, 0, 0, 0, '', 'Requires quest Destruction Flag');
INSERT INTO conditions VALUES(15, 10995, 15, 0, 0, 50, 0, 24828, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group Destruction 1');
INSERT INTO conditions VALUES(15, 10995, 15, 0, 0, 50, 0, 24823, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group Destruction 2');
INSERT INTO conditions VALUES(15, 10995, 15, 0, 0, 50, 0, 24829, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group Destruction 3');
INSERT INTO conditions VALUES(15, 10995, 15, 0, 0, 2, 0, 50398, 1, 1, 1, 0, 0, '', 'Requires no item Destruction 3');
INSERT INTO conditions VALUES(15, 10995, 16, 0, 0, 8, 0, 25238, 0, 0, 0, 0, 0, '', 'Requires quest Might Flag');
INSERT INTO conditions VALUES(15, 10995, 16, 0, 0, 50, 0, 25239, 0, 0, 0, 0, 0, '', 'Requires satisfy exclusive group Might 1');
INSERT INTO conditions VALUES(15, 10995, 16, 0, 0, 2, 0, 52569, 1, 1, 1, 0, 0, '', 'Requires no item Might 0');
INSERT INTO conditions VALUES(15, 10995, 17, 0, 0, 8, 0, 25238, 0, 0, 0, 0, 0, '', 'Requires quest Might Flag');
INSERT INTO conditions VALUES(15, 10995, 17, 0, 0, 50, 0, 25239, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group Might 1');
INSERT INTO conditions VALUES(15, 10995, 17, 0, 0, 50, 0, 25240, 0, 0, 0, 0, 0, '', 'Requires satisfy exclusive group Might 2');
INSERT INTO conditions VALUES(15, 10995, 17, 0, 0, 2, 0, 52570, 1, 1, 1, 0, 0, '', 'Requires no item Might 1');
INSERT INTO conditions VALUES(15, 10995, 18, 0, 0, 8, 0, 25238, 0, 0, 0, 0, 0, '', 'Requires quest Might Flag');
INSERT INTO conditions VALUES(15, 10995, 18, 0, 0, 50, 0, 25239, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group Might 1');
INSERT INTO conditions VALUES(15, 10995, 18, 0, 0, 50, 0, 25240, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group Might 2');
INSERT INTO conditions VALUES(15, 10995, 18, 0, 0, 50, 0, 25242, 0, 0, 0, 0, 0, '', 'Requires satisfy exclusive group Might 3');
INSERT INTO conditions VALUES(15, 10995, 18, 0, 0, 2, 0, 52571, 1, 1, 1, 0, 0, '', 'Requires no item Might 2');
INSERT INTO conditions VALUES(15, 10995, 19, 0, 0, 8, 0, 25238, 0, 0, 0, 0, 0, '', 'Requires quest Might Flag');
INSERT INTO conditions VALUES(15, 10995, 19, 0, 0, 50, 0, 25239, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group Might 1');
INSERT INTO conditions VALUES(15, 10995, 19, 0, 0, 50, 0, 25240, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group Might 2');
INSERT INTO conditions VALUES(15, 10995, 19, 0, 0, 50, 0, 25242, 0, 0, 1, 0, 0, '', 'Requires not satisfy exclusive group Might 3');
INSERT INTO conditions VALUES(15, 10995, 19, 0, 0, 2, 0, 52572, 1, 1, 1, 0, 0, '', 'Requires no item Might 3');

-- Violet Signet of the Master Assassin (29283)
-- Violet Signet of the Archmage (29287)
-- Violet Signet of the Great Protector (29279)
-- Violet Signet of the Grand Restorer (29290)
UPDATE quest_template SET SpecialFlags=1 WHERE Id IN(11031, 11032, 11033, 11034);
UPDATE creature_template SET AIName="SmartAI" WHERE entry=18253;
DELETE FROM gossip_menu_option WHERE menu_id=8441;
INSERT INTO gossip_menu_option VALUES(8441, 0, 0, "I've lost my Violet Signet of the Master Assassin.", 1, 1, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(8441, 1, 0, "I've lost my Violet Signet of the Archmage.", 1, 1, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(8441, 2, 0, "I've lost my Violet Signet of the Great Protector.", 1, 1, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(8441, 3, 0, "I've lost my Violet Signet of the Grand Restorer.", 1, 1, 0, 0, 0, 0, "");
DELETE FROM smart_scripts WHERE entryorguid=18253 AND source_type=0;
INSERT INTO smart_scripts VALUES (18253, 0, 0, 4, 62, 0, 100, 0, 8441, 0, 0, 0, 11, 39654, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Soridormi - On Gossip Select - Cast Create Violet Signet of the Master Assassin");
INSERT INTO smart_scripts VALUES (18253, 0, 1, 4, 62, 0, 100, 0, 8441, 1, 0, 0, 11, 39651, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Soridormi - On Gossip Select - Cast Create Violet Signet of the Archmage");
INSERT INTO smart_scripts VALUES (18253, 0, 2, 4, 62, 0, 100, 0, 8441, 2, 0, 0, 11, 39653, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Soridormi - On Gossip Select - Cast Create Violet Signet of the Great Protector");
INSERT INTO smart_scripts VALUES (18253, 0, 3, 4, 62, 0, 100, 0, 8441, 3, 0, 0, 11, 39652, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Soridormi - On Gossip Select - Cast Create Violet Signet of the Grand Restorer");
INSERT INTO smart_scripts VALUES (18253, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Soridormi - On Gossip Select - Close Gossip");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=8441;
INSERT INTO conditions VALUES(15, 8441, 0, 0, 0, 9, 0, 10727, 0, 0, 0, 0, 0, '', 'Requires quest Eminence Among the Violet Eye');
INSERT INTO conditions VALUES(15, 8441, 0, 0, 0, 2, 0, 29283, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8441, 0, 0, 0, 2, 0, 29287, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8441, 0, 0, 0, 2, 0, 29279, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8441, 0, 0, 0, 2, 0, 29290, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8441, 1, 0, 0, 9, 0, 10725, 0, 0, 0, 0, 0, '', 'Requires quest Eminence Among the Violet Eye');
INSERT INTO conditions VALUES(15, 8441, 1, 0, 0, 2, 0, 29283, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8441, 1, 0, 0, 2, 0, 29287, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8441, 1, 0, 0, 2, 0, 29279, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8441, 1, 0, 0, 2, 0, 29290, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8441, 2, 0, 0, 9, 0, 10728, 0, 0, 0, 0, 0, '', 'Requires quest Eminence Among the Violet Eye');
INSERT INTO conditions VALUES(15, 8441, 2, 0, 0, 2, 0, 29283, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8441, 2, 0, 0, 2, 0, 29287, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8441, 2, 0, 0, 2, 0, 29279, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8441, 2, 0, 0, 2, 0, 29290, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8441, 3, 0, 0, 9, 0, 10726, 0, 0, 0, 0, 0, '', 'Requires quest Eminence Among the Violet Eye');
INSERT INTO conditions VALUES(15, 8441, 3, 0, 0, 2, 0, 29283, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8441, 3, 0, 0, 2, 0, 29287, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8441, 3, 0, 0, 2, 0, 29279, 1, 1, 1, 0, 0, '', 'Requires no Band item');
INSERT INTO conditions VALUES(15, 8441, 3, 0, 0, 2, 0, 29290, 1, 1, 1, 0, 0, '', 'Requires no Band item');
