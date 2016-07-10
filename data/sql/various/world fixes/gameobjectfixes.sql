-- [Generic] Unlearn engineering specialization
UPDATE gameobject_template SET ScriptName='go_evil_book_for_dummies' WHERE entry=177226;

-- Burial Chest (181665)
UPDATE gameobject_template SET flags=2 WHERE entry=181665;

-- Discombobulator Ray, obtained from Matrix Punchograph 3005-D
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=1050 AND SourceEntry=0;
INSERT INTO conditions VALUES (15, 1050, 0, 0, 0, 2, 0, 9327, 1, 0, 0, 0, 0, '', 'Gossip Option - Require item 9327');
INSERT INTO conditions VALUES (15, 1050, 0, 0, 0, 7, 0, 202, 160, 0, 0, 0, 0, '', 'Gossip Option - Require 160 Engineering');
INSERT INTO conditions VALUES (15, 1050, 0, 0, 0, 25, 0, 3959, 0, 0, 1, 0, 0, '', 'Gossip Option - No Spell 3959 learned');

-- Corrupted Songflower
DELETE FROM spell_script_names WHERE spell_id=15366;
INSERT INTO spell_script_names VALUES(15366, 'spell_gen_disabled_above_63');
UPDATE gameobject_template SET data5=1, AIName='SmartGameObjectAI' WHERE entry IN(164886, 171939, 171942, 174594, 174595, 174596, 174597, 174598, 174712, 174713);
UPDATE gameobject_template SET data3=1 WHERE entry IN(164882, 171940, 171943, 174610, 174612, 174613, 174614, 174615, 174714, 174715); -- Autoclose
DELETE FROM gameobject WHERE id IN(164882, 171940, 171943, 174610, 174612, 174613, 174614, 174615, 174714, 174715);
DELETE FROM smart_scripts WHERE entryorguid IN(164886, 171939, 171942, 174594, 174595, 174596, 174597, 174598, 174712, 174713) AND source_type=1;
INSERT INTO smart_scripts VALUES (164886, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 50, 164882, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject');
INSERT INTO smart_scripts VALUES (164886, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Set Loot State');
INSERT INTO smart_scripts VALUES (171939, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 50, 164882, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject');
INSERT INTO smart_scripts VALUES (171939, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Set Loot State');
INSERT INTO smart_scripts VALUES (171942, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 50, 164882, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject');
INSERT INTO smart_scripts VALUES (171942, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Set Loot State');
INSERT INTO smart_scripts VALUES (174594, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 50, 164882, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject');
INSERT INTO smart_scripts VALUES (174594, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Set Loot State');
INSERT INTO smart_scripts VALUES (174595, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 50, 164882, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject');
INSERT INTO smart_scripts VALUES (174595, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Set Loot State');
INSERT INTO smart_scripts VALUES (174596, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 50, 164882, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject');
INSERT INTO smart_scripts VALUES (174596, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Set Loot State');
INSERT INTO smart_scripts VALUES (174597, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 50, 164882, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject');
INSERT INTO smart_scripts VALUES (174597, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Set Loot State');
INSERT INTO smart_scripts VALUES (174598, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 50, 164882, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject');
INSERT INTO smart_scripts VALUES (174598, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Set Loot State');
INSERT INTO smart_scripts VALUES (174712, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 50, 164882, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject');
INSERT INTO smart_scripts VALUES (174712, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Set Loot State');
INSERT INTO smart_scripts VALUES (174713, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 50, 164882, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject');
INSERT INTO smart_scripts VALUES (174713, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Set Loot State');

-- Tournament Stables, hide model
-- hide various focus gameobjects (crystals)
UPDATE gameobject_template SET displayId=0 WHERE type=8 AND displayId IN(299, 327, 1807, 2150, 2770, 5811, 5932, 6805);

-- Sealed Tome (181768, 181845, 181846, 181847, 181848) - Karazhan, loot id 18509
DELETE FROM gameobject_loot_template WHERE entry=18509;
INSERT INTO gameobject_loot_template VALUES(18509, 1, 100, 1, 0, -185090, 1);
DELETE FROM reference_loot_template WHERE entry=185090;
INSERT INTO reference_loot_template VALUES(185090, 23857, 0, 1, 1, 1, 1), (185090, 23862, 0, 1, 1, 1, 1), (185090, 23864, 0, 1, 1, 1, 1), (185090, 23865, 0, 1, 1, 1, 1);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry IN(30567, 30557, 30550, 30562);
INSERT INTO conditions VALUES(17, 0, 30567, 0, 0, 22, 0, 532, 0, 0, 0, 0, 0, '', 'Limit buff to Karazhan');
INSERT INTO conditions VALUES(17, 0, 30557, 0, 0, 22, 0, 532, 0, 0, 0, 0, 0, '', 'Limit buff to Karazhan');
INSERT INTO conditions VALUES(17, 0, 30550, 0, 0, 22, 0, 532, 0, 0, 0, 0, 0, '', 'Limit buff to Karazhan');
INSERT INTO conditions VALUES(17, 0, 30562, 0, 0, 22, 0, 532, 0, 0, 0, 0, 0, '', 'Limit buff to Karazhan');
DELETE FROM spell_area WHERE spell IN(30567, 30557, 30550, 30562);
INSERT INTO spell_area VALUES(30567, 3457, 0, 0, 0, 0, 2, 0, 64, 11);
INSERT INTO spell_area VALUES(30557, 3457, 0, 0, 0, 0, 2, 0, 64, 11);
INSERT INTO spell_area VALUES(30550, 3457, 0, 0, 0, 0, 2, 0, 64, 11);
INSERT INTO spell_area VALUES(30562, 3457, 0, 0, 0, 0, 2, 0, 64, 11);

-- ------------------------------------------------
--           ROTATION FIXES
-- ------------------------------------------------
-- Nether Collector Tube (184117)
REPLACE INTO gameobject_addon VALUES (25023, 0, 0);
REPLACE INTO gameobject_addon VALUES (25024, 0, 0);
REPLACE INTO gameobject_addon VALUES (25025, 0, 0);
REPLACE INTO gameobject_addon VALUES (25026, 0, 0);

-- Portal Kruul (184289)
REPLACE INTO gameobject_addon VALUES (50347, 0, 0);

-- Portal Xilus (184290)
REPLACE INTO gameobject_addon VALUES (25120, 0, 0);

-- Portal Grimh (184414)
REPLACE INTO gameobject_addon VALUES (25256, 0, 0);

-- Portal Kaalez (184415)
REPLACE INTO gameobject_addon VALUES (25257, 0, 0);

-- Gateway Murketh (183350)
REPLACE INTO gameobject_addon VALUES (24222, 0, 0);

-- Gateway Shaadraz (183351)
REPLACE INTO gameobject_addon VALUES (24223, 0, 0);
