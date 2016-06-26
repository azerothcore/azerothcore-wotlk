-- ###################
-- ### General
-- ###################

UPDATE creature SET phaseMask=1 WHERE map=578;

DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN (49464, 49346, 49460, 66667, 49838); 
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry IN (49840,49592,50328,50341,50232);
INSERT INTO conditions VALUES (13, 5, 49464, 0, 0, 33, 0, 1, 5, 0, 0, 0, 0, '', 'Ruby Drake Saddle control vehicle aura can hit only created unit');
INSERT INTO conditions VALUES (13, 5, 49464, 0, 0, 31, 0, 3, 27756, 0, 0, 0, 0, '', 'Ruby Drake Saddle control vehicle aura can hit only specified npc');
INSERT INTO conditions VALUES (13, 5, 49346, 0, 0, 33, 0, 1, 5, 0, 0, 0, 0, '', 'Emerald Drake Saddle control vehicle aura can hit only created unit');
INSERT INTO conditions VALUES (13, 5, 49346, 0, 0, 31, 0, 3, 27692, 0, 0, 0, 0, '', 'Emerald Drake Saddle control vehicle aura can hit only specified npc');
INSERT INTO conditions VALUES (13, 5, 49460, 0, 0, 33, 0, 1, 5, 0, 0, 0, 0, '', 'Amber Drake Saddle control vehicle aura can hit only created unit');
INSERT INTO conditions VALUES (13, 5, 49460, 0, 0, 31, 0, 3, 27755, 0, 0, 0, 0, '', 'Amber Drake Saddle control vehicle aura can hit only specified npc');
INSERT INTO conditions VALUES (13, 7, 66667, 0, 0, 33, 0, 1, 5, 0, 0, 0, 0, '', 'Gear scaling for Oculus drakes can only hit created unit');
INSERT INTO conditions VALUES (13, 7, 66667, 0, 0, 31, 0, 3, 27756, 0, 0, 0, 0, '', 'Gear scaling for Oculus drakes can hit Ruby Drake');
INSERT INTO conditions VALUES (13, 7, 66667, 0, 1, 33, 0, 1, 5, 0, 0, 0, 0, '', 'Gear scaling for Oculus drakes can only hit created unit');
INSERT INTO conditions VALUES (13, 7, 66667, 0, 1, 31, 0, 3, 27692, 0, 0, 0, 0, '', 'Gear scaling for Oculus drakes can hit Emerald Drake');
INSERT INTO conditions VALUES (13, 7, 66667, 0, 2, 33, 0, 1, 5, 0, 0, 0, 0, '', 'Gear scaling for Oculus drakes can only hit created unit');
INSERT INTO conditions VALUES (13, 7, 66667, 0, 2, 31, 0, 3, 27755, 0, 0, 0, 0, '', 'Gear scaling for Oculus drakes can hit Amber Drake');
INSERT INTO conditions VALUES (17, 0, 49840, 0, 1, 31, 1, 3, 28236, 0, 0, 0, 0, '', 'Shock Lance target can be Azure Ring Captain');
INSERT INTO conditions VALUES (17, 0, 49840, 0, 2, 31, 1, 3, 27638, 0, 0, 0, 0, '', 'Shock Lance target can be Azure Ring Guardian');
INSERT INTO conditions VALUES (17, 0, 49840, 0, 3, 31, 1, 3, 28276, 0, 0, 0, 0, '', 'Shock Lance target can be Greater Lay Whelp');
INSERT INTO conditions VALUES (17, 0, 49840, 0, 4, 31, 1, 3, 27656, 0, 0, 0, 0, '', 'Shock Lance target can be Eregos');
INSERT INTO conditions VALUES (17, 0, 49592, 0, 1, 31, 1, 3, 28236, 0, 0, 0, 0, '', 'Temporal Rift target can be Azure Ring Captain');
INSERT INTO conditions VALUES (17, 0, 49592, 0, 2, 31, 1, 3, 27638, 0, 0, 0, 0, '', 'Temporal Rift target can be Azure Ring Guardian');
INSERT INTO conditions VALUES (17, 0, 49592, 0, 3, 31, 1, 3, 28276, 0, 0, 0, 0, '', 'Temporal Rift target can be Greater Lay Whelp');
INSERT INTO conditions VALUES (17, 0, 49592, 0, 4, 31, 1, 3, 27656, 0, 0, 0, 0, '', 'Temporal Rift target can be Eregos');
INSERT INTO conditions VALUES (17, 0, 50328, 0, 1, 31, 1, 3, 28236, 0, 0, 0, 0, '', 'Leeching Poison target can be Azure Ring Captain');
INSERT INTO conditions VALUES (17, 0, 50328, 0, 2, 31, 1, 3, 27638, 0, 0, 0, 0, '', 'Leeching Poison target can be Azure Ring Guardian');
INSERT INTO conditions VALUES (17, 0, 50328, 0, 3, 31, 1, 3, 28276, 0, 0, 0, 0, '', 'Leeching Poison target can be Greater Lay Whelp');
INSERT INTO conditions VALUES (17, 0, 50328, 0, 4, 31, 1, 3, 27656, 0, 0, 0, 0, '', 'Leeching Poison target can be Eregos');
INSERT INTO conditions VALUES (17, 0, 50341, 0, 1, 31, 1, 3, 28236, 0, 0, 0, 0, '', 'Touch the Nightmare target can be Azure Ring Captain');
INSERT INTO conditions VALUES (17, 0, 50341, 0, 2, 31, 1, 3, 27638, 0, 0, 0, 0, '', 'Touch the Nightmare target can be Azure Ring Guardian');
INSERT INTO conditions VALUES (17, 0, 50341, 0, 3, 31, 1, 3, 28276, 0, 0, 0, 0, '', 'Touch the Nightmare target can be Greater Lay Whelp');
INSERT INTO conditions VALUES (17, 0, 50341, 0, 4, 31, 1, 3, 27656, 0, 0, 0, 0, '', 'Touch the Nightmare target can be Eregos');
INSERT INTO conditions VALUES (17, 0, 50232, 0, 1, 31, 1, 3, 28236, 0, 0, 0, 0, '', 'Searing Wrath target can be Azure Ring Captain');
INSERT INTO conditions VALUES (17, 0, 50232, 0, 2, 31, 1, 3, 27638, 0, 0, 0, 0, '', 'Searing Wrath target can be Azure Ring Guardian');
INSERT INTO conditions VALUES (17, 0, 50232, 0, 3, 31, 1, 3, 28276, 0, 0, 0, 0, '', 'Searing Wrath target can be Greater Lay Whelp');
INSERT INTO conditions VALUES (17, 0, 50232, 0, 4, 31, 1, 3, 27656, 0, 0, 0, 0, '', 'Searing Wrath target can be Eregos');
DELETE FROM spell_script_names WHERE ScriptName='spell_oculus_ride_ruby_emerald_amber_drake_que' AND spell_id IN(49427, 49459, 49463);
INSERT INTO spell_script_names VALUES(49427, 'spell_oculus_ride_ruby_emerald_amber_drake_que');
INSERT INTO spell_script_names VALUES(49459, 'spell_oculus_ride_ruby_emerald_amber_drake_que');
INSERT INTO spell_script_names VALUES(49463, 'spell_oculus_ride_ruby_emerald_amber_drake_que');
DELETE FROM spell_script_names WHERE ScriptName='spell_oculus_call_ruby_emerald_amber_drake' AND spell_id IN(49345, 49461, 49462);
INSERT INTO spell_script_names VALUES(49345, 'spell_oculus_call_ruby_emerald_amber_drake');
INSERT INTO spell_script_names VALUES(49461, 'spell_oculus_call_ruby_emerald_amber_drake');
INSERT INTO spell_script_names VALUES(49462, 'spell_oculus_call_ruby_emerald_amber_drake');


-- delete all shit
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(22517,28276,27641,28183,28236,28239,29888) AND `map`=578 );
DELETE FROM creature WHERE id IN(22517,28276,28236,28239,29888) AND `map`=578;

-- orbs, portals, etc.
UPDATE gameobject_template SET flags = flags | 16 WHERE entry IN(193995, 189986);

-- cache of eregos (191349,193603) and spotlight (191351)
UPDATE gameobject_template SET flags=0 WHERE entry IN(191349,193603);
DELETE FROM gameobject WHERE id IN(191349,193603,191351);
REPLACE INTO `gameobject` VALUES (NULL, 191349, 578, 1, 1, 1015.06, 1051.09, 605.619, 0.017452, 0, 0, 0, 1, -608400, 0, 1, 0);
REPLACE INTO `gameobject` VALUES (NULL, 193603, 578, 2, 1, 1015.06, 1051.09, 605.619, 0.017452, 0, 0, 0, 1, -608400, 0, 1, 0);

-- Cache of the Ley-Guardian (52676) // item reward for random heroic
REPLACE INTO gameobject_loot_template VALUES(24524, 52676, 100, 1, 0, 1, 1);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=4 AND SourceGroup=24524 AND SourceEntry=52676;
INSERT INTO conditions VALUES (4, 24524, 52676, 0, 0, 1, 0, 72221, 0, 0, 0, 0, 0, '', 'Loot Cache of the Ley-Guardian only when aura Luck of the Draw applied');
DELETE FROM item_loot_template WHERE entry=52676;
INSERT INTO item_loot_template VALUES(52676, 1, 100, 1, 0, -526760, 1); 
INSERT INTO item_loot_template VALUES(52676, 43953, 5, 1, 0, 1, 1); 
DELETE FROM reference_loot_template WHERE entry=526760;
INSERT INTO reference_loot_template VALUES(526760, 36921, 0, 1, 1, 1, 3);
INSERT INTO reference_loot_template VALUES(526760, 36933, 0, 1, 1, 1, 3);
INSERT INTO reference_loot_template VALUES(526760, 36930, 0, 1, 1, 1, 3);
INSERT INTO reference_loot_template VALUES(526760, 36918, 0, 1, 1, 1, 3);
INSERT INTO reference_loot_template VALUES(526760, 36927, 0, 1, 1, 1, 3);
INSERT INTO reference_loot_template VALUES(526760, 36924, 0, 1, 1, 1, 3);


-- drakes
REPLACE INTO creature_template VALUES(27657, 0, 0, 0, 0, 0, 24742, 0, 0, 0, "Verdisa", "", "", 0, 80, 80, 2, 35, 1, 1, 1.42857, 1, 1, 422, 586, 0, 642, 7.5, 2400, 0, 1, 163842, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 2, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 1, 15, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 0, 2, "npc_oculus_drakegiver", 12340);
REPLACE INTO creature_template VALUES(27658, 0, 0, 0, 0, 0, 24759, 0, 0, 0, "Belgaristrasz", "", "", 0, 80, 80, 2, 35, 3, 1, 1.42857, 1, 1, 422, 586, 0, 642, 7.5, 2400, 0, 1, 163842, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 2, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 1, 15, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 0, 2, "npc_oculus_drakegiver", 12340);
REPLACE INTO creature_template VALUES(27659, 0, 0, 0, 0, 0, 24746, 0, 0, 0, "Eternos", "", "", 0, 80, 80, 2, 35, 1, 1, 1.42857, 1, 1, 422, 586, 0, 642, 7.5, 2400, 0, 1, 163842, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 2, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 1, 15, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 0, 2, "npc_oculus_drakegiver", 12340);
REPLACE INTO creature_template VALUES(27692, 0, 0, 0, 0, 0, 25853, 0, 0, 0, "Emerald Drake", "", "vehichleCursor", 0, 80, 80, 2, 35, 0, 3, 3, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 2, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 50328, 50341, 0, 0, 0, 0, 0, 0, 0, 70, 0, 0, "", 0, 5, 1, 5.95238, 1, 1, 0, 0, 0, 0, 0, 0, 0, 113, 1, 0, 0, "npc_oculus_drake", 12340);
REPLACE INTO creature_template VALUES(27755, 0, 0, 0, 0, 0, 25852, 0, 0, 0, "Amber Drake", "", "vehichleCursor", 0, 80, 80, 2, 35, 0, 3, 3, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 2, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 49840, 49838, 0, 0, 0, 0, 0, 0, 0, 70, 0, 0, "", 0, 5, 1, 5.95238, 1, 1, 0, 0, 0, 0, 0, 0, 0, 113, 1, 0, 0, "npc_oculus_drake", 12340);
REPLACE INTO creature_template VALUES(27756, 0, 0, 0, 0, 0, 25854, 0, 0, 0, "Ruby Drake", "", "vehichleCursor", 0, 80, 80, 2, 35, 0, 3, 3, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 2, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 50232, 50240, 0, 0, 0, 0, 0, 0, 0, 70, 0, 0, "", 0, 5, 1, 5.95238, 1, 1, 0, 0, 0, 0, 0, 0, 0, 113, 1, 0, 0, "npc_oculus_drake", 12340);
REPLACE INTO creature_template_addon VALUES(27692, 0, 0, 50331648, 257, 0, "59553");
REPLACE INTO creature_template_addon VALUES(27755, 0, 0, 50331648, 257, 0, "59553");
REPLACE INTO creature_template_addon VALUES(27756, 0, 0, 50331648, 257, 0, "50248 59553");
REPLACE INTO spell_proc_event VALUES(50240, 0, 0, 0, 0, 0, 0, 28, 0, 0, 0);
REPLACE INTO spell_proc_event VALUES(49592, 0, 0, 0, 0, 0, 664232, 262144, 0, 100, 0);
DELETE FROM npc_spellclick_spells WHERE npc_entry IN(27692, 27755, 27756);


-- centrifuges
REPLACE INTO creature_template VALUES(27641, 30905, 0, 0, 0, 0, 24943, 0, 0, 0, "Centrifuge Construct", "", "", 0, 79, 79, 2, 16, 0, 1, 1.14286, 1.24, 1, 404, 564, 0, 582, 7.5, 2400, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 334, 494, 95, 9, 32776, 27641, 0, 27641, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 4, 1, 1, 0, 0, 0, 0, 0, 0, 0, 73, 1, 0, 0, "", 12340);
REPLACE INTO creature_template VALUES(30905, 0, 0, 0, 0, 0, 24943, 0, 0, 0, "Centrifuge Construct (1)", "", "", 0, 80, 81, 2, 16, 0, 1, 1.14286, 1.24, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 9, 32776, 30905, 0, 27641, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 80, 1, 0, 0, "", 1);
REPLACE INTO creature_template_addon VALUES(27641, 0, 0, 0, 0, 0, "50088");
REPLACE INTO creature_template_addon VALUES(30905, 0, 0, 0, 0, 0, "50088");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=50087;
INSERT INTO conditions VALUES(13, 1, 50087, 0, 0, 31, 0, 3, 27641, 0, 0, 0, 0, "", "");
INSERT INTO conditions VALUES(13, 1, 50087, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, "", "");
UPDATE creature SET spawntimesecs=604800 WHERE id=27641;
DELETE FROM smart_scripts WHERE entryorguid=27641 AND source_type=0;

-- other templates
REPLACE INTO creature_template VALUES(27633, 30901, 0, 0, 0, 0, 25195, 0, 0, 0, "Azure Inquisitor", "", "", 0, 79, 79, 2, 16, 0, 0.888888, 0.992063, 1, 1, 404, 564, 0, 582, 7.5, 2400, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 334, 494, 95, 2, 8, 27633, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "SmartAI", 0, 3, 1, 4, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 12340);
REPLACE INTO creature_template VALUES(27635, 30904, 0, 0, 0, 0, 25250, 0, 0, 0, "Azure Spellbinder", "", "", 0, 79, 79, 2, 16, 0, 0.888888, 1.14286, 1.08, 1, 399, 559, 0, 550, 7.5, 2400, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 331, 491, 74, 2, 8, 27635, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "SmartAI", 0, 3, 1, 4, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 12340);
REPLACE INTO creature_template VALUES(27636, 30902, 0, 0, 0, 0, 26088, 0, 0, 0, "Azure Ley-Whelp", "", "", 0, 79, 79, 2, 16, 0, 1.11111, 1.14286, 1, 0, 404, 564, 0, 582, 1, 2400, 0, 1, 32768, 2048, 8, 0, 0, 0, 0, 0, 334, 494, 95, 2, 8, 27636, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "SmartAI", 0, 3, 1, 1.2, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 12340);
REPLACE INTO creature_template VALUES(27638, 30903, 0, 0, 0, 0, 28080, 0, 0, 0, "Azure Ring Guardian", "", "", 0, 79, 79, 2, 16, 0, 2, 3, 1, 1, 399, 559, 0, 550, 7.5, 2400, 0, 2, 32768, 2048, 8, 0, 0, 0, 0, 0, 331, 491, 74, 2, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "SmartAI", 0, 4, 1, 9.52381, 5, 1, 0, 0, 0, 0, 0, 0, 0, 210, 1, 0, 0, "", 12340);
REPLACE INTO creature_template VALUES(27639, 30916, 0, 0, 0, 0, 25305, 25306, 25307, 0, "Ring-Lord Sorceress", "", "", 0, 79, 79, 2, 16, 0, 1, 1.14286, 1, 1, 399, 559, 0, 550, 7.5, 2400, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 331, 491, 74, 7, 8, 27639, 27639, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5030, 8383, "SmartAI", 0, 3, 1, 4, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 12340);
REPLACE INTO creature_template VALUES(27640, 30915, 0, 0, 0, 0, 25302, 25303, 25304, 0, "Ring-Lord Conjurer", "", "", 0, 79, 79, 2, 16, 0, 1, 1.14286, 1, 1, 399, 559, 0, 550, 7.5, 2400, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 331, 491, 74, 7, 8, 27640, 27640, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5016, 8360, "SmartAI", 0, 3, 1, 4, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 12340);
REPLACE INTO creature_template VALUES(30901, 0, 0, 0, 0, 0, 25195, 0, 0, 0, "Azure Inquisitor (1)", "", "", 0, 80, 81, 2, 16, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 2, 8, 30901, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 5, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 1);
REPLACE INTO creature_template VALUES(30902, 0, 0, 0, 0, 0, 26088, 0, 0, 0, "Azure Ley-Whelp (1)", "", "", 0, 80, 81, 2, 16, 0, 1, 1.14286, 1, 0, 464, 604, 0, 708, 1, 2000, 0, 1, 32768, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 2, 8, 30902, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 1.5, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 1);
REPLACE INTO creature_template VALUES(30903, 0, 0, 0, 0, 0, 28080, 0, 0, 0, "Azure Ring Guardian (1)", "", "", 0, 80, 81, 2, 16, 0, 2, 3, 1, 1, 425, 602, 0, 670, 13, 2000, 0, 2, 32768, 2048, 8, 0, 0, 0, 0, 0, 351, 511, 86, 2, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 4, 1, 10.5885, 10, 1, 0, 0, 0, 0, 0, 0, 0, 220, 1, 0, 0, "", 1);
REPLACE INTO creature_template VALUES(30904, 0, 0, 0, 0, 0, 25250, 0, 0, 0, "Azure Spellbinder (1)", "", "", 0, 80, 81, 2, 16, 0, 1, 1.14286, 1.08, 1, 425, 602, 0, 670, 13, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 351, 511, 86, 2, 8, 30904, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 5, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 1);
REPLACE INTO creature_template VALUES(30915, 0, 0, 0, 0, 0, 25302, 25304, 25303, 0, "Ring-Lord Conjurer (1)", "", "", 0, 80, 81, 2, 16, 0, 1, 1.14286, 1, 1, 425, 602, 0, 670, 13, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 351, 511, 86, 7, 8, 30915, 27640, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10032, 16720, "", 0, 3, 1, 5, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 1);
REPLACE INTO creature_template VALUES(30916, 0, 0, 0, 0, 0, 25305, 25307, 25306, 0, "Ring-Lord Sorceress (1)", "", "", 0, 80, 81, 2, 16, 0, 1, 1.14286, 1, 1, 425, 602, 0, 670, 13, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 351, 511, 86, 7, 8, 30916, 27639, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10060, 16766, "", 0, 3, 1, 5, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 1);


-- TC, remove some unused scripts
DELETE FROM conditions WHERE SourceTypeOrReferenceId=21 AND SourceGroup IN (27692,27755,27756);
UPDATE creature_template SET ScriptName='' WHERE ScriptName='npc_image_belgaristrasz' AND entry=28012;
DELETE FROM spell_script_names WHERE ScriptName='spell_eregos_planar_shift' AND spell_id=51162;
DELETE FROM spell_script_names WHERE ScriptName='spell_varos_centrifuge_shield' AND spell_id=50053;
DELETE FROM spell_script_names WHERE ScriptName='spell_varos_energize_core_area_enemy' AND spell_id IN(50785, 59372);
DELETE FROM spell_script_names WHERE ScriptName='spell_varos_energize_core_area_entry' AND spell_id IN(54069, 56251, 61407, 62136);




-- ###################
-- ### Drakos the Interrogator (27654)
-- ###################

REPLACE INTO creature_template VALUES(27654, 31558, 0, 0, 0, 0, 27032, 0, 0, 0, "Drakos the Interrogator", "", "", 0, 81, 81, 2, 16, 0, 1, 1.42857, 1, 1, 464, 604, 0, 708, 7.5, 2400, 0, 1, 32768, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 2, 104, 27654, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 25, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 650854271, 0+0x200000, "boss_drakos", 12340);
REPLACE INTO creature_template VALUES(31558, 0, 0, 0, 0, 0, 27032, 0, 0, 0, "Drakos the Interrogator (1)", "", "", 0, 82, 82, 2, 16, 0, 1, 1.42857, 1, 1, 488, 642, 0, 782, 13, 2000, 0, 1, 32768, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 2, 104, 31558, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 650854271, 1+0x200000, "", 1);
REPLACE INTO creature_template VALUES(28166, 0, 0, 0, 0, 0, 17612, 0, 0, 0, "Unstable Sphere", "", "", 0, 80, 80, 2, 16, 0, 2.4, 0.857143, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 33685504, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 0.8, 1, 1, 0, 0, 0, 0, 0, 0, 0, 106, 1, 0, 0, "npc_oculus_unstable_sphere", 12340);



-- ###################
-- ### Varos Cloudstrider (27447)
-- ###################

REPLACE INTO creature_template VALUES(27447, 31559, 0, 0, 0, 0, 27033, 0, 0, 0, "Varos Cloudstrider", "Azure-Lord of the Blue Dragonflight", "", 0, 81, 81, 2, 14, 0, 1, 1.42857, 1, 1, 464, 604, 0, 708, 7.5, 2400, 0, 1, 32768, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 2, 104, 27447, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 25, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 650854271, 0+0x200000, "boss_varos", 12340);
REPLACE INTO creature_template VALUES(31559, 0, 0, 0, 0, 0, 27033, 0, 0, 0, "Varos Cloudstrider (1)", "Azure-Lord of the Blue Dragonflight", "", 0, 82, 82, 2, 14, 0, 1, 1.42857, 1, 1, 488, 642, 0, 782, 13, 2000, 0, 1, 32768, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 2, 104, 31559, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 650854271, 1+0x200000, "", 1);

-- cores
REPLACE INTO creature_template VALUES(28183, 0, 0, 0, 0, 0, 28419, 0, 0, 0, "Centrifuge Core", "", "", 0, 70, 70, 2, 16, 0, 1, 1.14286, 1, 0, 252, 357, 0, 304, 1, 2000, 0, 1, 33718276, 2048, 8, 0, 0, 0, 0, 0, 215, 320, 44, 10, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "NullCreatureAI", 0, 3, 1, 1000, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, "", 12340);
REPLACE INTO creature_template_addon VALUES(28183, 0, 0, 0, 0, 0, "50798");
UPDATE creature SET spawndist=0, MovementType=0 WHERE id=28183;

-- azure ring
DELETE FROM event_scripts WHERE id IN(12229, 10665, 18454, 18455);
INSERT INTO event_scripts VALUES(12229, 0, 10, 28236, 13000, 0, 1278.195, 1123.954, 458.61, 4.8026);
INSERT INTO event_scripts VALUES(10665, 0, 10, 28236, 13000, 0, 1230.421, 1063.801, 458.61, 0.015);
INSERT INTO event_scripts VALUES(18454, 0, 10, 28236, 13000, 0, 1292.555, 1015.0, 458.51, 1.708);
INSERT INTO event_scripts VALUES(18455, 0, 10, 28236, 13000, 0, 1340.398, 1077.850, 458.61, 3.196);
REPLACE INTO creature_template VALUES(28236, 0, 0, 0, 0, 0, 28046, 0, 0, 0, "Azure Ring Captain", "", "", 0, 80, 80, 2, 16, 0, 1, 1.71429, 1, 1, 417, 582, 0, 608, 7.5, 2000, 0, 2, 33718276, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 2, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 4, 1, 10, 5, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 0, 0, "", 12340);

REPLACE INTO creature_template VALUES(28239, 31628, 0, 0, 0, 0, 11686, 0, 0, 0, "Arcane Beam", "", "", 0, 80, 80, 2, 14, 0, 2.2, 0.785714, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 33718272, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 1032, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 86, 1, 0, 0, "", 12340);
REPLACE INTO creature_template VALUES(31628, 0, 0, 0, 0, 0, 11686, 0, 0, 0, "Arcane Beam (1)", "", "", 0, 80, 80, 2, 14, 0, 2.2, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 33718272, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 1032, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 98, 1, 0, 0, "", 1);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=51024;
INSERT INTO conditions VALUES(13, 1, 51024, 0, 0, 31, 0, 3, 28239, 0, 0, 0, 0, "", "");
INSERT INTO conditions VALUES(13, 1, 51024, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, "", "");

-- energize cores
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(61407,62136,56251,54069);
INSERT INTO conditions VALUES(13, 1, 61407, 0, 0, 31, 0, 3, 28183, 0, 0, 0, 0, "", "");
INSERT INTO conditions VALUES(13, 1, 62136, 0, 0, 31, 0, 3, 28183, 0, 0, 0, 0, "", "");
INSERT INTO conditions VALUES(13, 1, 56251, 0, 0, 31, 0, 3, 1, 0, 0, 0, 0, "", ""); -- creature entry 1 to not target anyone
INSERT INTO conditions VALUES(13, 1, 54069, 0, 0, 31, 0, 3, 28183, 0, 0, 0, 0, "", "");
INSERT INTO conditions VALUES(13, 1, 61407, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, "", "");
INSERT INTO conditions VALUES(13, 1, 62136, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, "", "");
INSERT INTO conditions VALUES(13, 1, 56251, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, "", "");
INSERT INTO conditions VALUES(13, 1, 54069, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, "", "");



-- ###################
-- ### Mage-Lord Urom (27655)
-- ###################

REPLACE INTO creature_template VALUES(27655, 31560, 0, 0, 0, 0, 25010, 0, 0, 0, "Mage-Lord Urom", "", "", 0, 81, 81, 2, 16, 0, 1, 1.42857, 1, 1, 425, 602, 0, 670, 7.5, 2400, 0, 2, 32768, 2048, 8, 0, 0, 0, 0, 0, 351, 511, 86, 7, 104, 27655, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5707, 9511, "", 0, 3, 1, 25, 15, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 650854271, 0+0x200000, "boss_urom", 12340);
REPLACE INTO creature_template VALUES(31560, 0, 0, 0, 0, 0, 25010, 0, 0, 0, "Mage-Lord Urom (1)", "", "", 0, 82, 82, 2, 16, 0, 1, 1.42857, 1, 1, 463, 640, 0, 726, 13, 2000, 0, 2, 32768, 2048, 8, 0, 0, 0, 0, 0, 360, 520, 91, 7, 104, 31560, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11414, 19022, "", 0, 3, 1, 32, 20, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 650854271, 1+0x200000, "", 1);

-- spell_target_position
REPLACE INTO spell_target_position VALUES(50476, 0, 578, 968.66, 1042.53, 527.32, 0.077);
REPLACE INTO spell_target_position VALUES(50495, 0, 578, 1164.02, 1170.85, 527.321, 3.66);
REPLACE INTO spell_target_position VALUES(50496, 0, 578, 1118.31, 1080.38, 508.361, 4.25);
REPLACE INTO spell_target_position VALUES(51112, 0, 578, 1103.69, 1048.76, 512.279, 1.16);

-- summons templates
REPLACE INTO creature_template VALUES(27650, 30906, 0, 0, 0, 0, 25146, 0, 0, 0, "Phantasmal Air", "", "", 0, 79, 79, 2, 16, 0, 1, 1.14286, 1, 1, 404, 564, 0, 582, 7.5, 2400, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 334, 494, 95, 4, 8, 27650, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "SmartAI", 0, 3, 1, 4, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 12340);
REPLACE INTO creature_template VALUES(30906, 0, 0, 0, 0, 0, 25146, 0, 0, 0, "Phantasmal Air (1)", "", "", 0, 80, 80, 2, 16, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 4, 8, 30906, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 5, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 1);
REPLACE INTO creature_template VALUES(27645, 30907, 0, 0, 0, 0, 25147, 0, 0, 0, "Phantasmal Cloudscraper", "", "", 0, 79, 79, 2, 16, 0, 1, 1.14286, 1, 1, 399, 559, 0, 550, 7.5, 2400, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 331, 491, 74, 1, 8, 27645, 0, 70212, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "SmartAI", 0, 3, 1, 4, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 12340);
REPLACE INTO creature_template VALUES(30907, 0, 0, 0, 0, 0, 25147, 0, 0, 0, "Phantasmal Cloudscraper (1)", "", "", 0, 80, 81, 2, 16, 0, 1, 1.14286, 1, 1, 425, 602, 0, 670, 13, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 351, 511, 86, 1, 8, 30907, 0, 70212, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 5, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 1);
REPLACE INTO creature_template VALUES(27651, 30908, 0, 0, 0, 0, 25148, 0, 0, 0, "Phantasmal Fire", "", "", 0, 79, 79, 2, 16, 0, 1, 1.14286, 1, 1, 404, 564, 0, 582, 7.5, 2400, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 334, 494, 95, 4, 8, 27651, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "SmartAI", 0, 3, 1, 4, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 12340);
REPLACE INTO creature_template VALUES(30908, 0, 0, 0, 0, 0, 25148, 0, 0, 0, "Phantasmal Fire (1)", "", "", 0, 80, 81, 2, 16, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 4, 8, 30908, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 5, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 1);
REPLACE INTO creature_template VALUES(27642, 30909, 0, 0, 0, 0, 25145, 0, 0, 0, "Phantasmal Mammoth", "", "", 0, 79, 79, 2, 16, 0, 1, 1.14286, 1, 1, 404, 564, 0, 582, 7.5, 2400, 0, 1, 32832, 2048, 9, 0, 0, 0, 0, 0, 334, 494, 95, 1, 8, 27642, 0, 70212, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "SmartAI", 0, 3, 1, 4, 5, 1, 0, 42104, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 12340);
REPLACE INTO creature_template VALUES(30909, 0, 0, 0, 0, 0, 25145, 0, 0, 0, "Phantasmal Mammoth (1)", "", "", 0, 80, 80, 2, 16, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 1, 8, 30909, 0, 70212, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 5, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 1);
REPLACE INTO creature_template VALUES(27649, 30910, 0, 0, 0, 0, 25149, 0, 0, 0, "Phantasmal Murloc", "", "", 0, 79, 79, 2, 16, 0, 1, 1.14286, 1, 1, 404, 564, 0, 582, 7.5, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 334, 494, 95, 7, 8, 27649, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "SmartAI", 0, 3, 1, 4, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 12340);
REPLACE INTO creature_template VALUES(30910, 0, 0, 0, 0, 0, 25149, 0, 0, 0, "Phantasmal Murloc (1)", "", "", 0, 80, 80, 2, 16, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 8, 30910, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 5, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 1);
REPLACE INTO creature_template VALUES(27648, 30911, 0, 0, 0, 0, 25150, 0, 0, 0, "Phantasmal Naga", "", "", 0, 79, 79, 2, 16, 0, 1, 1.14286, 1, 1, 404, 564, 0, 582, 7.5, 2400, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 334, 494, 95, 7, 8, 27648, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "SmartAI", 0, 3, 1, 4, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 12340);
REPLACE INTO creature_template VALUES(30911, 0, 0, 0, 0, 0, 25150, 0, 0, 0, "Phantasmal Naga (1)", "", "", 0, 80, 80, 2, 16, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 8, 30911, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 5, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 1);
REPLACE INTO creature_template VALUES(27647, 30912, 0, 0, 0, 0, 25151, 0, 0, 0, "Phantasmal Ogre", "", "", 0, 79, 79, 2, 16, 0, 1, 1.14286, 1, 1, 399, 559, 0, 550, 7.5, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 331, 491, 74, 7, 8, 27647, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "SmartAI", 0, 3, 1, 4, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 12340);
REPLACE INTO creature_template VALUES(30912, 0, 0, 0, 0, 0, 25151, 0, 0, 0, "Phantasmal Ogre (1)", "", "", 0, 80, 81, 2, 16, 0, 1, 1.14286, 1, 1, 425, 602, 0, 670, 13, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 351, 511, 86, 7, 8, 30912, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 5, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 1);
REPLACE INTO creature_template VALUES(27653, 30913, 0, 0, 0, 0, 25152, 0, 0, 0, "Phantasmal Water", "", "", 0, 79, 79, 2, 16, 0, 1, 1.28968, 1, 1, 399, 559, 0, 550, 7.5, 2400, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 331, 491, 74, 4, 8, 27653, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "SmartAI", 0, 3, 1, 4, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 12340);
REPLACE INTO creature_template VALUES(30913, 0, 0, 0, 0, 0, 25152, 0, 0, 0, "Phantasmal Water (1)", "", "", 0, 81, 81, 2, 16, 0, 1, 1.14286, 1, 1, 425, 602, 0, 670, 13, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 351, 511, 86, 4, 8, 30913, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 5, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 1);
REPLACE INTO creature_template VALUES(27644, 30914, 0, 0, 0, 0, 25153, 0, 0, 0, "Phantasmal Wolf", "", "", 0, 79, 79, 2, 16, 0, 1, 1.14286, 1, 1, 404, 564, 0, 582, 7.5, 2000, 0, 1, 32832, 2048, 9, 0, 0, 0, 0, 0, 334, 494, 95, 1, 8, 27644, 0, 70212, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "SmartAI", 0, 3, 1, 4, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 12340);
REPLACE INTO creature_template VALUES(30914, 0, 0, 0, 0, 0, 25153, 0, 0, 0, "Phantasmal Wolf (1)", "", "", 0, 80, 81, 2, 16, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 1, 8, 30914, 0, 70212, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 5, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 1);
SET @P_Murloc             := 27649;
SET @P_Cloudscraper       := 27645;
SET @P_Mammoth            := 27642;
SET @P_Wolf               := 27644;
SET @P_Air                := 27650;
SET @P_Water              := 27653;
SET @P_Fire               := 27651;
SET @P_Ogre               := 27647;
SET @P_Naga               := 27648;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` IN (@P_Murloc,@P_Cloudscraper,@P_Mammoth,@P_Wolf,@P_Air,@P_Water,@P_Fire,@P_Ogre,@P_Naga);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@P_Murloc,0,0,0,0,0,100,0,1000,3000,13000,16000,11,54074,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Phantasmal Murloc - IC - Cast poison'),
(@P_Naga,0,0,0,0,0,100,2,9000,12000,13000,16000,11,50732,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Phantasmal Naga - IC /Normal/ - Cast Water Tomb'),
(@P_Naga,0,1,0,0,0,100,4,9000,12000,13000,16000,11,59261,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Phantasmal Naga - IC /Heroic/ - Cast Water Tomb'),
(@P_Naga,0,2,0,0,0,100,2,1000,3000,9000,12000,11,49711,0,0,0,0,0,5,0,0,0,0,0,0,0, 'Phantasmal Naga - IC /Normal/ - Cast Water Tomb'),
(@P_Naga,0,3,0,0,0,100,4,1000,3000,9000,12000,11,59260,0,0,0,0,0,5,0,0,0,0,0,0,0, 'Phantasmal Naga - IC /Heroic/ - Cast Water Tomb'),
(@P_Ogre,0,0,0,2,0,100,0,30,30,20000,24000,11,50730,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Phantasmal Ogre - On 30% - Cast Bloodlust at 30% HP'),
(@P_Ogre,0,1,0,0,0,100,0,3000,7000,9000,12000,11,50731,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Phantasmal Ogre - IC - Cast Mace Smash'),
(@P_Cloudscraper,0,0,0,0,0,100,4,3000,5000,4000,6000,11,59223,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Phantasmal Cloudscraper - IC /Heroic/ - Cast Chain Lightning'),
(@P_Cloudscraper,0,1,0,0,0,100,2,3000,7000,9000,12000,11,59220,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Phantasmal Cloudscraper - IC /Normal/ - Cast Chain Lightning'),
(@P_Cloudscraper,0,2,0,0,0,100,2,7000,10000,12000,15000,11,15588,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Phantasmal Cloudscraper - IC /Normal/ - Cast Thunderclap'),
(@P_Cloudscraper,0,3,0,0,0,100,4,7000,10000,12000,15000,11,59217,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Phantasmal Cloudscraper - IC /Heroic/ - Cast Thunderclap'),
(@P_Mammoth,0,0,0,9,0,100,0,8,25,2000,2500,11,32323,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Phantasmal Mammoth - IC - Cast Charge'),
(@P_Mammoth,0,1,0,0,0,100,0,4000,7000,12000,15000,11,59274,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Phantasmal Mammoth - IC - Cast Trample'),
(@P_Wolf,0,0,0,0,0,100,2,10000,13000,18000,24000,11,50728,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Phantasmal Wolf - IC /Normal/ - Cast Furious Howl'),
(@P_Wolf,0,1,0,0,0,100,4,10000,13000,18000,24000,11,59274,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Phantasmal Wolf - IC /Heroic/ - Cast Furious Howl'),
(@P_Wolf,0,2,0,0,0,100,2,4000,9000,9000,12000,11,50729,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Phantasmal Wolf - IC /Normal/ - Cast Carnivorous Bite'),
(@P_Wolf,0,3,0,0,0,100,4,4000,9000,9000,12000,11,59269,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Phantasmal Wolf - IC /Heroic/ - Cast Carnivorous Bite'),
(@P_Air,0,0,0,4,0,100,5,0,0,0,0,11,20545,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Phantasmal Air - On aggro /Heroic/ - Cast Lightning Shield'),
(@P_Air,0,1,0,4,0,100,3,0,0,0,0,11,25020,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Phantasmal Air - On aggro /Normal/ - Cast Lightning Shield'),
(@P_Fire,0,0,0,0,0,100,2,3000,8000,5000,9000,11,50744,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Phantasmal Fire - IC /Normla/ - Cast Blaze'),
(@P_Fire,0,1,0,0,0,100,4,3000,8000,5000,9000,11,59225,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Phantasmal Fire - IC /Heroic/ - Cast Blaze'),
(@P_Water,0,0,0,4,0,100,3,0,0,0,0,11,37924,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Phantasmal Water - On aggro - Cast Water Bolt Volley'),
(@P_Water,0,1,0,4,0,100,5,0,0,0,0,11,59266,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Phantasmal Water - On aggro - Cast Water Bolt Volley'),
(@P_Water,0,2,0,9,1,100,2,0,35,3400,4800,11,37924,64,0,0,0,0,2,0,0,0,0,0,0,0, 'Phantasmal Water - In range - Cast Water Bolt Volley'),
(@P_Water,0,3,0,9,1,100,4,0,35,3400,4800,11,59266,64,0,0,0,0,2,0,0,0,0,0,0,0, 'Phantasmal Water - In range - Cast Water Bolt Volley');



-- ###################
-- ### Ley-Guardian Eregos (27656)
-- ###################

DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=27656);
REPLACE INTO creature_template_addon VALUES(27656, 0, 0, 50331648, 1, 0, '');
REPLACE INTO creature_template_addon VALUES(31561, 0, 0, 50331648, 1, 0, '');
DELETE FROM linked_respawn WHERE linkedGuid=100221;
DELETE FROM creature WHERE id=27656;
INSERT INTO creature VALUES(NULL, 27656, 578, 3, 1, 27034, 0, 1077.04, 1086.21, 655.497, 4.18879, 86400, 50, 0, 2997590, 81620, 1, 0, 0, 0);
REPLACE INTO creature_template VALUES(27656, 31561, 0, 0, 0, 0, 27034, 0, 0, 0, "Ley-Guardian Eregos", "", "", 0, 81, 81, 2, 16, 0, 1.6, 3.0, 1.25, 1, 425, 602, 0, 670, 7.5, 2000, 0, 2, 32768, 2048, 8, 0, 0, 0, 0, 0, 351, 511, 86, 2, 96, 27656, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 4, 1, 230, 20, 1, 0, 0, 0, 0, 0, 0, 0, 212, 1, 650854271, 0+0x200000, "boss_eregos", 12340);
REPLACE INTO creature_template VALUES(31561, 0, 0, 0, 0, 0, 27034, 0, 0, 0, "Ley-Guardian Eregos (1)", "", "", 0, 82, 82, 2, 16, 0, 1.6, 3.0, 1.25, 1, 463, 640, 0, 726, 13, 2000, 0, 2, 32768, 2048, 8, 0, 0, 0, 0, 0, 360, 520, 91, 2, 96, 31561, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 4, 1, 287.5, 25, 1, 0, 43668, 0, 0, 0, 0, 0, 221, 1, 650854271, 1+0x200000, "", 1);

-- planar anomaly
REPLACE INTO creature_template VALUES(30879, 0, 0, 0, 0, 0, 28107, 0, 0, 0, "Planar Anomaly", "", "", 0, 80, 80, 2, 14, 0, 2.75, 2.75, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 33685504, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "SmartAI", 0, 4, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 0, 0, "", 12340);
DELETE FROM creature_template_addon WHERE entry=30879;
DELETE FROM smart_scripts WHERE entryorguid IN(30879) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (30879, 0, 0, 0, 60, 0, 100, 1, 15500, 15500, 15500, 15500, 11, 57976, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Planar Anomaly explosion after 16 secs');

-- ley-guardian whelp
REPLACE INTO creature_template VALUES(28276, 30991, 0, 0, 0, 0, 26089, 0, 0, 0, "Greater Ley-Whelp", "", "", 0, 79, 79, 2, 16, 0, 1.11111, 1.14286, 1, 1, 404, 564, 0, 582, 7.5, 2000, 0, 1, 32768, 2048, 8, 0, 0, 0, 0, 0, 334, 494, 95, 2, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "SmartAI", 0, 4, 1, 3.1746, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 12340);
REPLACE INTO creature_template VALUES(30991, 0, 0, 0, 0, 0, 26089, 0, 0, 0, "Greater Ley-Whelp (1)", "", "", 0, 80, 80, 2, 16, 0, 1.11111, 1.14286, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 32768, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 2, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 4, 1, 3.96825, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 1);
DELETE FROM smart_scripts WHERE entryorguid IN(28276, 30991) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (28276, 0, 0, 0, 0, 0, 100, 2, 6000, 10000, 6000, 10000, 11, 62249, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Greater Lay-Whelp (Normal) - Cast Arcane Bolt');
INSERT INTO `smart_scripts` VALUES (28276, 0, 1, 0, 0, 0, 100, 4, 6000, 10000, 6000, 10000, 11, 62250, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Greater Lay-Whelp (Heroic) - Cast Arcane Bolt');



-- ###################
-- ### REPUTATION
-- ###################

-- NORMAL:
DELETE FROM `creature_onkill_reputation` WHERE creature_id IN (27654, 27656, 27655, 27447, 27633, 27636, 28236, 27638, 27635, 27641, 28276, 27650, 27645, 27651, 27642, 27649, 27648, 27647, 27653, 27644, 30879, 27640, 27639, 28153);
INSERT INTO `creature_onkill_reputation` (`creature_id`, `RewOnKillRepFaction1`, `RewOnKillRepFaction2`, `MaxStanding1`, `IsTeamAward1`, `RewOnKillRepValue1`, `MaxStanding2`, `IsTeamAward2`, `RewOnKillRepValue2`, `TeamDependent`) VALUES 
(27654, 1037, 1052, 7, 0, 250, 7, 0, 250, 1), -- Drakos the interrogator
(27656, 1037, 1052, 7, 0, 250, 7, 0, 250, 1), -- Ley Guardian Eregos
(27655, 1037, 1052, 7, 0, 250, 7, 0, 250, 1), -- Mage lord urom
(27447, 1037, 1052, 7, 0, 250, 7, 0, 250, 1), -- Varos cloudstrider
(27633, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(27636, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(28236, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(27638, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(27635, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(27641, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(28276, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(27650, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(27645, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(27651, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(27642, 1037, 1052, 7, 0, 5, 7, 0, 5, 1), 
(27649, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(27648, 1037, 1052, 7, 0, 5, 7, 0, 5, 1), 
(27647, 1037, 1052, 7, 0, 5, 7, 0, 5, 1),
(27653, 1037, 1052, 7, 0, 5, 7, 0, 5, 1),
(27644, 1037, 1052, 7, 0, 5, 7, 0, 5, 1),
(30879, 1037, 1052, 7, 0, 5, 7, 0, 5, 1),
(27640, 1037, 1052, 7, 0, 5, 7, 0, 5, 1),
(27639, 1037, 1052, 7, 0, 5, 7, 0, 5, 1),
(28153, 1037, 1052, 7, 0, 5, 7, 0, 5, 1);

-- HEROIC:
DELETE FROM `creature_onkill_reputation` WHERE creature_id IN (31558, 31561, 31560, 31559, 30901, 30902, 30903, 30904, 30905, 30991, 30906, 30907, 30908, 30909, 30910, 30911, 30912, 30913, 30914, 30915, 30916, 30917);
INSERT INTO `creature_onkill_reputation` (`creature_id`, `RewOnKillRepFaction1`, `RewOnKillRepFaction2`, `MaxStanding1`, `IsTeamAward1`, `RewOnKillRepValue1`, `MaxStanding2`, `IsTeamAward2`, `RewOnKillRepValue2`, `TeamDependent`) VALUES 
(31558, 1037, 1052, 7, 0, 250, 7, 0, 250, 1), -- Drakos the interrogator
(31561, 1037, 1052, 7, 0, 250, 7, 0, 250, 1), -- Ley Guardian Eregos
(31560, 1037, 1052, 7, 0, 250, 7, 0, 250, 1), -- Mage lord urom
(31559, 1037, 1052, 7, 0, 250, 7, 0, 250, 1), -- Varos cloudstrider
(30901, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(30902, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(30903, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(30904, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(30905, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(30991, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(30906, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(30907, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(30908, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(30909, 1037, 1052, 7, 0, 5, 7, 0, 5, 1), 
(30910, 1037, 1052, 7, 0, 25, 7, 0, 25, 1), 
(30911, 1037, 1052, 7, 0, 5, 7, 0, 5, 1), 
(30912, 1037, 1052, 7, 0, 5, 7, 0, 5, 1),
(30913, 1037, 1052, 7, 0, 5, 7, 0, 5, 1),
(30914, 1037, 1052, 7, 0, 5, 7, 0, 5, 1),
(30915, 1037, 1052, 7, 0, 5, 7, 0, 5, 1),
(30916, 1037, 1052, 7, 0, 5, 7, 0, 5, 1),
(30917, 1037, 1052, 7, 0, 5, 7, 0, 5, 1);



-- ###################
-- ### ACHIEVEMENTS
-- ###################

-- The Oculus (487)
DELETE FROM disables WHERE sourceType=4 AND entry IN(203,205,204,206);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(203,205,204,206);
INSERT INTO achievement_criteria_data VALUES(203, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(205, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(204, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(206, 12, 0, 0, "");

-- Heroic: The Oculus (498)
DELETE FROM disables WHERE sourceType=4 AND entry IN(6859,6860,6861,6862);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(6859,6860,6861,6862);
INSERT INTO achievement_criteria_data VALUES(6859, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(6860, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(6861, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(6862, 12, 1, 0, "");

-- Make It Count (1868)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7145);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7145);
INSERT INTO achievement_criteria_data VALUES(7145, 12, 1, 0, "");

-- Experienced Drake Rider (1871)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7177,7178,7179);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7177,7178,7179);
INSERT INTO achievement_criteria_data VALUES(7177, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7177, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7178, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7178, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7179, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7179, 18, 0, 0, "");

-- Amber Void (2046)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7325);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7325);
INSERT INTO achievement_criteria_data VALUES(7325, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7325, 18, 0, 0, "");

-- Emerald Void (2045)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7324);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7324);
INSERT INTO achievement_criteria_data VALUES(7324, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7324, 18, 0, 0, "");

-- Ruby Void (2044)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7323);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7323);
INSERT INTO achievement_criteria_data VALUES(7323, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7323, 18, 0, 0, "");
