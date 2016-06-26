
-- -------------------------------------------
-- GRIZZLY HILLS
-- -------------------------------------------
-- Subject to Interpretation (11991)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=47110;
INSERT INTO conditions VALUES (13, 1, 47110, 0, 0, 31, 1, 4, 0, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES (13, 1, 47110, 0, 0, 36, 1, 0, 0, 0, 0, 0, 0, '', '');
UPDATE quest_template SET SpecialFlags=2 WHERE Id=11991;
REPLACE INTO creature_template_addon VALUES(26500, 0, 0, 0, 65536, 0, "43167 47119");
DELETE FROM creature WHERE id IN(26500);
INSERT INTO creature VALUES (NULL, 26500, 571, 1, 1, 0, 0, 3386.21, -1805.46, 115.058, 4.96401, 600, 0, 0, 6986, 0, 0, 0, 0, 0);
DELETE FROM spell_script_names WHERE spell_id IN(47110);
INSERT INTO spell_script_names VALUES(47110, "spell_image_of_drakuru_reagent_check");
UPDATE creature_loot_template SET ChanceOrQuestChance = ABS(ChanceORQuestChance) WHERE item=35799;

-- Sacrifices Must Be Made (12007)
REPLACE INTO creature_template_addon VALUES(26543, 0, 0, 0, 65536, 0, "43167 47119");
DELETE FROM creature WHERE id IN(26543);
INSERT INTO creature VALUES (NULL, 26543, 571, 1, 1, 0, 0, 4244.1, -2025, 238.25, 1.39, 600, 0, 0, 6986, 0, 0, 0, 0, 0);
UPDATE creature_questender SET id=26543 WHERE quest=12007;
UPDATE creature_queststarter SET id=26500 WHERE quest=12007;
UPDATE creature_queststarter SET id=26543 WHERE quest=12042; -- for next quest
UPDATE gameobject_template SET ScriptName="go_seer_of_zebhalak" WHERE entry=188458;
UPDATE creature_template SET npcflag=2 WHERE entry=26543;
UPDATE creature_loot_template SET ChanceOrQuestChance = ABS(ChanceORQuestChance) WHERE item=35836;

-- My Heart is in Your Hands (12802)
UPDATE quest_template SET SpecialFlags=2 WHERE Id=12802;
REPLACE INTO creature_template_addon VALUES(26701, 0, 0, 0, 65536, 0, "43167 47119");
DELETE FROM creature WHERE id=26701;
INSERT INTO creature VALUES (NULL, 26701, 571, 1, 1, 0, 0, 4524.31, -3472.71, 228.132, 0.776044, 600, 0, 0, 6986, 0, 0, 0, 0, 0);
UPDATE creature_questender SET id=26701 WHERE quest=12802;
UPDATE creature_template SET npcflag=2 WHERE entry=26701;
UPDATE creature_loot_template SET ChanceOrQuestChance = ABS(ChanceORQuestChance) WHERE item=36743;

-- Voices From the Dust (12068)
REPLACE INTO creature_template_addon VALUES(26787, 0, 0, 0, 65536, 0, "43167 47119");
UPDATE creature_questender SET id=26787 WHERE quest=12068;
UPDATE creature_queststarter SET id=26701 WHERE quest=12068;
UPDATE creature_template SET npcflag=2, AIName='' WHERE entry=26787;
DELETE FROM smart_scripts WHERE entryorguid=26787 AND source_type=0;
UPDATE creature_loot_template SET ChanceOrQuestChance = ABS(ChanceORQuestChance) WHERE item=36758;

-- Steady as a Rock? (12014)
DELETE FROM spell_script_names WHERE spell_id IN(47130);
INSERT INTO spell_script_names VALUES(47130, "spell_q12014_steady_as_a_rock");

-- Riding the Red Rocket (12432)
-- Riding the Red Rocket (12437)
UPDATE creature SET curhealth=4920 WHERE id=27593;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=18 AND SourceGroup IN(27593); -- GROUP NOT ENTRY!
INSERT INTO conditions VALUES(18, 27593, 49177, 0, 0, 2, 0, 37664, 1, 0, 0, 0, 0, '', '');
UPDATE creature_template SET AIName="", ScriptName="npc_riding_the_red_rocket" WHERE entry=27593;

-- A Dark Influence (12220)
UPDATE creature_template SET flags_extra=130, AIName='SmartAI' WHERE entry IN(27263, 27264, 27265);
DELETE FROM smart_scripts WHERE entryorguid IN(27263, 27264, 27265) AND source_type=0;
INSERT INTO smart_scripts VALUES (27263, 0, 0, 0, 8, 0, 100, 0, 48218, 0, 0, 0, 33, 27263, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'kill credit on spell hit');
INSERT INTO smart_scripts VALUES (27264, 0, 0, 0, 8, 0, 100, 0, 48218, 0, 0, 0, 33, 27264, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'kill credit on spell hit');
INSERT INTO smart_scripts VALUES (27265, 0, 0, 0, 8, 0, 100, 0, 48218, 0, 0, 0, 33, 27265, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'kill credit on spell hit');

-- In the Name of Loken (12204), fix for Softening the Blow (11998)
UPDATE smart_scripts SET action_param1=643 WHERE entryorguid=2648400 AND source_type=9 AND id=6;

-- Seared Scourge (12029)
DELETE FROM spell_script_names WHERE spell_id IN(47214);

-- Runes of Compulsion (12093)
UPDATE creature_template SET faction=1954, AIName='SmartAI' WHERE entry IN(26920, 26921, 26922, 26923);
DELETE FROM smart_scripts WHERE entryorguid=26820 AND source_type=0;
INSERT INTO smart_scripts VALUES (26820, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 1000, 1000, 11, 47463, 2, 0, 0, 0, 0, 11, 26785, 30, 0, 0, 0, 0, 0, 'Iron Rune-Weaver - On spawn & reset - Channel Rune-Weaver Channel on Directional Rune');
INSERT INTO smart_scripts VALUES (26820, 0, 1, 0, 0, 0, 100, 0, 4000, 7000, 10000, 16000, 11, 52713, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune-Weaver - Combat - Cast Rune Weaving on victim');
UPDATE creature_template SET flags_extra=130, AIName='SmartAI' WHERE entry=26785;
DELETE FROM smart_scripts WHERE entryorguid IN(-111145, -111146, -111147, -202405) AND source_type=0;
INSERT INTO smart_scripts VALUES (-111145, 0, 0, 0, 60, 0, 100, 0, 5000, 5000, 300000, 300000, 12, 26920, 4, 30000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Directional Rune - On Update OOC in Phase 4 - Summon Overseer Durval');
INSERT INTO smart_scripts VALUES (-111146, 0, 0, 0, 60, 0, 100, 0, 5000, 5000, 300000, 300000, 12, 26921, 4, 30000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Directional Rune - On Update OOC in Phase 4 - Summon Overseer Korgen');
INSERT INTO smart_scripts VALUES (-111147, 0, 0, 0, 60, 0, 100, 0, 5000, 5000, 300000, 300000, 12, 26922, 4, 30000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Directional Rune - On Update OOC in Phase 4 - Summon Overseer Lochli');
INSERT INTO smart_scripts VALUES (-202405, 0, 0, 0, 60, 0, 100, 0, 5000, 5000, 300000, 300000, 12, 26923, 4, 30000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Directional Rune - On Update OOC in Phase 4 - Summon Overseer Brunon');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry IN(-111145, -111146, -111147, -202405);
INSERT INTO conditions VALUES(22, 1, -111145, 0, 0, 29, 1, 26820, 30, 0, 1, 0, 0, '', 'no npc near');
INSERT INTO conditions VALUES(22, 1, -111146, 0, 0, 29, 1, 26820, 30, 0, 1, 0, 0, '', 'no npc near');
INSERT INTO conditions VALUES(22, 1, -111147, 0, 0, 29, 1, 26820, 30, 0, 1, 0, 0, '', 'no npc near');
INSERT INTO conditions VALUES(22, 1, -202405, 0, 0, 29, 1, 26820, 30, 0, 1, 0, 0, '', 'no npc near');
DELETE FROM smart_scripts WHERE entryorguid IN(26920, 26921, 26922, 26923) AND source_type=0;
INSERT INTO smart_scripts VALUES (26920, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Overseer Durval - On Just Summoned - Say');
INSERT INTO smart_scripts VALUES (26920, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 47693, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Overseer Durval - On Link - Cast Spawn - Blue Lightning');
INSERT INTO smart_scripts VALUES (26920, 0, 2, 0, 0, 0, 100, 0, 5000, 9000, 8000, 11000, 11, 52715, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Overseer Durval - In Combat - Cast Rune of Destruction');
INSERT INTO smart_scripts VALUES (26921, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Overseer Korgan - On Just Summoned - Say');
INSERT INTO smart_scripts VALUES (26921, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 47693, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Overseer Korgan - On Link - Cast Spawn - Blue Lightning');
INSERT INTO smart_scripts VALUES (26921, 0, 2, 0, 0, 0, 100, 0, 3000, 5000, 7000, 9000, 11, 32018, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Overseer Korgan - In Combat - Cast Call Lightning');
INSERT INTO smart_scripts VALUES (26921, 0, 3, 0, 2, 0, 100, 0, 0, 30, 12000, 16000, 11, 52714, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Overseer Korgan - Between 0-30% Health - Cast Revitalizing Rune');
INSERT INTO smart_scripts VALUES (26922, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Overseer Lochli - On Just Summoned - Say');
INSERT INTO smart_scripts VALUES (26922, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 47693, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Overseer Lochli - On Link - Cast Spawn - Blue Lightning');
INSERT INTO smart_scripts VALUES (26922, 0, 2, 0, 0, 0, 100, 0, 8000, 12000, 11000, 15000, 11, 52717, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Overseer Lochli - In Combat - Cast Thunderstorm');
INSERT INTO smart_scripts VALUES (26923, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Overseer Brunon - On Just Summoned - Say');
INSERT INTO smart_scripts VALUES (26923, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 47693, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Overseer Brunon - On Link - Cast Spawn - Blue Lightning');
DELETE FROM creature_text WHERE entry IN (26920, 26921, 26922, 26923);
INSERT INTO creature_text VALUES (26920, 0, 0, 'You''ll pay for this!', 12, 0, 100, 25, 0, 0, 0, 'Overseer Durval');
INSERT INTO creature_text VALUES (26920, 0, 1, 'Fool! You''ll never get away with this!', 12, 0, 100, 25, 0, 0, 0, 'Overseer Durval');
INSERT INTO creature_text VALUES (26920, 0, 2, 'You dare to defy the sons of iron?', 12, 0, 100, 25, 0, 0, 0, 'Overseer Durval');
INSERT INTO creature_text VALUES (26920, 0, 3, 'What do you think you''re doing?', 12, 0, 100, 25, 0, 0, 0, 'Overseer Durval');
INSERT INTO creature_text VALUES (26921, 0, 0, 'You''ll pay for this!', 12, 0, 100, 25, 0, 0, 0, 'Overseer Korgan');
INSERT INTO creature_text VALUES (26921, 0, 1, 'Fool! You''ll never get away with this!', 12, 0, 100, 25, 0, 0, 0, 'Overseer Korgan');
INSERT INTO creature_text VALUES (26921, 0, 2, 'You dare to defy the sons of iron?', 12, 0, 100, 25, 0, 0, 0, 'Overseer Korgan');
INSERT INTO creature_text VALUES (26921, 0, 3, 'What do you think you''re doing?', 12, 0, 100, 25, 0, 0, 0, 'Overseer Korgan');
INSERT INTO creature_text VALUES (26922, 0, 0, 'You''ll pay for this!', 12, 0, 100, 25, 0, 0, 0, 'Overseer Lochli');
INSERT INTO creature_text VALUES (26922, 0, 1, 'Fool! You''ll never get away with this!', 12, 0, 100, 25, 0, 0, 0, 'Overseer Lochli');
INSERT INTO creature_text VALUES (26922, 0, 2, 'You dare to defy the sons of iron?', 12, 0, 100, 25, 0, 0, 0, 'Overseer Lochli');
INSERT INTO creature_text VALUES (26922, 0, 3, 'What do you think you''re doing?', 12, 0, 100, 25, 0, 0, 0, 'Overseer Lochli');
INSERT INTO creature_text VALUES (26923, 0, 0, 'You''ll pay for this!', 12, 0, 100, 25, 0, 0, 0, 'Overseer Brunon');
INSERT INTO creature_text VALUES (26923, 0, 1, 'Fool! You''ll never get away with this!', 12, 0, 100, 25, 0, 0, 0, 'Overseer Brunon');
INSERT INTO creature_text VALUES (26923, 0, 2, 'You dare to defy the sons of iron?', 12, 0, 100, 25, 0, 0, 0, 'Overseer Brunon');
INSERT INTO creature_text VALUES (26923, 0, 3, 'What do you think you''re doing?', 12, 0, 100, 25, 0, 0, 0, 'Overseer Brunon');

-- Free At Last (12099)
DELETE FROM creature_text WHERE entry=26783;
INSERT INTO creature_text VALUES(26783, 0, 0, 'I thought I was doomed. Thank you for freeing me.', 12, 0, 100, 0, 0, 0, 0, 'Free At Last (12099)');
INSERT INTO creature_text VALUES(26783, 0, 1, 'You have my gratitude.', 12, 0, 100, 0, 0, 0, 0, 'Free At Last (12099)');
INSERT INTO creature_text VALUES(26783, 0, 2, "I never thought I'd be free from that terrible spell!", 12, 0, 100, 0, 0, 0, 0, 'Free At Last (12099)');
INSERT INTO creature_text VALUES(26783, 0, 3, 'Thank you, small one.', 12, 0, 100, 0, 0, 0, 0, 'Free At Last (12099)');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=47604;
INSERT INTO conditions VALUES (17, 0, 47604, 0, 0, 31, 1, 3, 26417, 0, 0, 0, 0, '', 'Requires Runed Giant');
INSERT INTO conditions VALUES (17, 0, 47604, 0, 1, 31, 1, 3, 26872, 0, 0, 0, 0, '', 'Requires Weakened Giant');
UPDATE creature_template SET AIName='SmartAI' WHERE entry=26417;
UPDATE creature_template SET minlevel=74, maxlevel=74, faction=1771 WHERE entry=26872;
DELETE FROM smart_scripts WHERE entryorguid=26417 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(26417*100, 26417*100+1) AND source_type=9;
INSERT INTO smart_scripts VALUES (26417, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 47329, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Cast Spell');
INSERT INTO smart_scripts VALUES (26417, 0, 1, 0, 8, 0, 100, 0, 47604, 0, 0, 0, 87, 26417*100, 26417*100+1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Run random timed list');
INSERT INTO smart_scripts VALUES (26417, 0, 2, 0, 0, 0, 100, 1, 10000, 10000, 0, 0, 11, 49717, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC - cast spell');
INSERT INTO smart_scripts VALUES (26417, 0, 3, 0, 0, 0, 100, 0, 5000, 6000, 15000, 16000, 11, 55196, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC - cast spell');
INSERT INTO smart_scripts VALUES (26417*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 36, 26783, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Update Entry');
INSERT INTO smart_scripts VALUES (26417*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 33, 26783, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Kill credit');
INSERT INTO smart_scripts VALUES (26417*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (26417*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Despawn');
INSERT INTO smart_scripts VALUES (26417*100+1, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 36, 26872, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Update Entry');

-- Filling the Cages (11984)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=47042;
INSERT INTO conditions VALUES (17, 0, 47042, 0, 0, 31, 1, 3, 26425, 0, 0, 0, 0, '', 'Spell Assemble Cage can only be cast on Drakkari Warrior');
INSERT INTO conditions VALUES (17, 0, 47042, 0, 1, 31, 1, 3, 26447, 0, 0, 0, 0, '', 'Spell Assemble Cage can only be cast on Drakkari Shaman');
INSERT INTO conditions VALUES (17, 0, 47042, 0, 0, 29, 0, 32663, 30, 0, 0, 0, 0, '', 'Spell Assemble Cage requires Budd nearby');
INSERT INTO conditions VALUES (17, 0, 47042, 0, 1, 29, 0, 32663, 30, 0, 0, 0, 0, '', 'Spell Assemble Cage requires Budd nearby');
UPDATE creature_template SET AIName='SmartAI' WHERE entry IN(26425, 26447);
DELETE FROM smart_scripts WHERE entryorguid IN(26425, 26447) AND source_type=0;
INSERT INTO smart_scripts VALUES(26425, 0, 0, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 52309, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On HP Update - Cast Spell');
INSERT INTO smart_scripts VALUES(26425, 0, 1, 2, 8, 0, 100, 1, 47042, 0, 0, 0, 11, 48342, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Cast Spell');
INSERT INTO smart_scripts VALUES(26425, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 11, 47045, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Cast Spell');
INSERT INTO smart_scripts VALUES(26425, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Despawn');
INSERT INTO smart_scripts VALUES(26447, 0, 0, 0, 0, 0, 100, 0, 1000, 2000, 4000, 5000, 11, 9532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'On IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES(26447, 0, 1, 2, 8, 0, 100, 1, 47042, 0, 0, 0, 11, 48342, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Cast Spell');
INSERT INTO smart_scripts VALUES(26447, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 11, 47045, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Cast Spell');
INSERT INTO smart_scripts VALUES(26447, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Despawn');
DELETE FROM smart_scripts WHERE entryorguid=32663 AND source_type=0;
INSERT INTO smart_scripts VALUES(32663, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 11, 47014, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Budd pet - On summon - Spellcast');
INSERT INTO smart_scripts VALUES(32663, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 11, 47025, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Budd pet - On summon - Spellcast');
INSERT INTO smart_scripts VALUES(32663, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Budd pet - On summon - Set react defensive');
INSERT INTO smart_scripts VALUES(32663, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Budd pet - On summon - Follow');
INSERT INTO smart_scripts VALUES(32663, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 600000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Budd pet - On summon - Despawn timed');
INSERT INTO smart_scripts VALUES(32663, 0, 5, 0, 60, 0, 100, 0, 5000, 5000, 15000, 15000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Budd pet - Frequently - Say random line');

-- The Horse Hollerer (12415)
-- Mounting Up (12414)
UPDATE creature_template SET spell1=49285, AIName='SmartAI' WHERE entry=26472;
DELETE FROM smart_scripts WHERE entryorguid=26472 AND source_type=0;
INSERT INTO smart_scripts VALUES (26472, 0, 0, 1, 8, 0, 100, 0, 49319, 0, 0, 0, 11, 49323, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - cast at invoker');
INSERT INTO smart_scripts VALUES (26472, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - despawn');
INSERT INTO smart_scripts VALUES (26472, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 25, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - flee');
INSERT INTO smart_scripts VALUES (26472, 0, 3, 0, 29, 0, 100, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Combat Move On Charmed');
INSERT INTO smart_scripts VALUES (26472, 0, 4, 0, 31, 0, 100, 0, 49285, 0, 2000, 2000, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Despawn on spell hit target');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=49266;
INSERT INTO conditions VALUES (17, 0, 49266, 0, 0, 31, 1, 3, 26472, 0, 0, 0, 0, '', 'Spell Dangle Wild Carrot can be casted only on Highland Mustang');
DELETE FROM spell_linked_spell WHERE spell_trigger=49266;
INSERT INTO spell_linked_spell VALUES(49266, 49282, 1, 'Ride Highland Mustang');

-- Life or Death (12296)
REPLACE INTO smart_scripts VALUES (27482, 0, 7, 0, 25, 0, 100, 0, 0, 0, 0, 0, 19, 128, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Remove Unit Flag');

-- Ursoc, the Bear God (12236)
-- Ursoc, the Bear God (12249)
UPDATE quest_template SET NextQuestIdChain=0 WHERE Id=12249;
DELETE FROM creature_text WHERE entry=27328;
INSERT INTO creature_text VALUES (27328, 0, 0, "Ursoc, brother of Ursol and guardian to the furbolg tribes! Show yourself!", 12, 0, 100, 0, 0, 0, 0, 'Tur Ragepaw - say 0');
INSERT INTO creature_text VALUES (27328, 1, 0, "Stay behind me, $N. I will do my best to protect you.", 12, 0, 100, 0, 0, 0, 0, 'Tur Ragepaw - say 1');
INSERT INTO creature_text VALUES (27328, 2, 0, 'Urychlim konec tohoto besneni, $N.', 12, 0, 100, 0, 0, 0, 0, 'Tur Ragepaw - say 2');
INSERT INTO creature_text VALUES (27328, 3, 0, "I will watch over you and your allies, $N.", 12, 0, 100, 0, 0, 0, 0, 'Tur Ragepaw - say 3');
INSERT INTO creature_text VALUES (27328, 4, 0, 'Reset', 14, 0, 100, 0, 0, 0, 0, 'Tur Ragepaw - DEBUG 1');
DELETE FROM gossip_menu WHERE entry IN (9496, 9496+1);
INSERT INTO gossip_menu VALUES (9496, 12785),(9496+1, 12785+2);
DELETE FROM gossip_menu_option WHERE menu_id IN (9496, 9496+1);
INSERT INTO gossip_menu_option VALUES (9496, 0, 0, "We have the purified ashes of Vordrassil's sapling.  If we can subdue Ursoc, we might be able to heal his soul.", 1, 1, 9496+1, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (9496+1, 0, 0, "Assume your druidic bear form, Tur.", 1, 1, 0, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (9496+1, 1, 0, "Help us subdue him.", 1, 1, 0, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (9496+1, 2, 0, "We could use a healer.", 1, 1, 0, 0, 0, 0, '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=9496;
INSERT INTO conditions VALUES (15, 9496, 0, 0, 0, 9, 0, 12249, 0, 0, 0, 0, 0, '', 'Ursoc, medvedi buh - check for accepted quest');
INSERT INTO conditions VALUES (15, 9496, 0, 0, 1, 9, 0, 12236, 0, 0, 0, 0, 0, '', 'Ursoc, medvedi buh - check for accepted quest');
INSERT INTO conditions VALUES (15, 9496, 0, 0, 0, 2, 0, 37307, 1, 0, 0, 0, 0, '', "Don't show gossip unless player have Purified Ashes of Vordrassil");
INSERT INTO conditions VALUES (15, 9496, 0, 0, 1, 2, 0, 37307, 1, 0, 0, 0, 0, '', "Don't show gossip unless player have Purified Ashes of Vordrassil");
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=26633);
DELETE FROM creature WHERE id=26633;
UPDATE creature SET phaseMask=1 WHERE id=27328;
UPDATE creature_template SET faction=1771, AIName='SmartAI' WHERE entry=26633;
UPDATE creature_template SET faction=2068 WHERE entry=26633;
DELETE FROM smart_scripts WHERE source_type=0 AND entryorguid=26633;
INSERT INTO smart_scripts VALUES
(26633, 0, 0, 0, 0, 0, 100, 0, 15000, 20000, 50000, 60000, 11, 52560, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ursoc - IC - Cast Summon Blood of the Old God'),
(26633, 0, 1, 0, 0, 0, 100, 0, 10000, 13000, 21000, 25000, 11, 52583, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ursoc - IC - Cast Old Gods Influence'),
(26633, 0, 2, 0, 0, 0, 100, 0, 3000, 6000, 9000, 12000, 11, 52581, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ursoc - IC - Cast Crunch Armor'),
(26633, 0, 3, 4, 8, 0, 100, 0, 48549, 0, 0, 0, 12, 27373, 3, 25000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ursoc - On Spellhit - Summon Spirit of Ursoc'),
(26633, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ursoc - Link - Despawn Self'),
(26633, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 114077, 27328, 0, 0, 0, 0, 0, 'Ursoc - On Death - Set Data 1 1 to Tur'),
(26633, 0, 7, 0, 38, 0, 100, 0, 1, 1, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ursoc - On Set Data 1 1 - Despawn Self');
UPDATE creature_template SET gossip_menu_id=9496, faction=35, unit_flags=0, AIName='SmartAI', speed_run=1 WHERE entry=27328;
DELETE FROM smart_scripts WHERE source_type=0 AND entryorguid=27328;
DELETE FROM smart_scripts WHERE source_type=9 AND entryorguid BETWEEN 27328*100 AND 27328*100+4;
INSERT INTO smart_scripts VALUES
(27328, 0, 0, 0, 1, 0, 100, 1, 2000, 2000, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - On OOC Update - Set Passive'),
(27328, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - On Link - Close Gossip'),
(27328, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 120, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - On Link - Despawn Self'),
(27328, 0, 3, 1, 62, 0, 100, 0, 9496+1, 0, 0, 0, 80, 27328*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - On Gossip Select - Run Script 0'),
(27328, 0, 4, 1, 62, 0, 100, 0, 9496+1, 1, 0, 0, 80, 27328*100+1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - On Gossip Select - Run Script 1'),
(27328, 0, 5, 1, 62, 0, 100, 0, 9496+1, 2, 0, 0, 80, 27328*100+2, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - On Gossip Select - Run Script 2'),
(27328, 0, 6, 0, 40, 0, 100, 0, 17, 27328, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - On WP Reached - Say Text 0'),
(27328, 0, 7, 13, 40, 0, 100, 0, 18, 27328, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - On AI Init - Set Aggressive'),
(27328, 0, 8, 2, 6, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 26633, 200, 0, 0, 0, 0, 0, 'Tur Ragepaw - On Death - Set Data 1 1 to Ursoc'),
(27328, 0, 11, 0, 38, 0, 100, 0, 1, 1, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - OOC - Despawn on ursoc data'),
(27328, 0, 13, 0, 61, 0, 100, 0, 0, 0, 0, 0, 12, 26633, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 4891.94, -3843.95, 337.55, 2.97, 'Tur Ragepaw - On WP Reached - Spawn Ursoc'),
(27328, 0, 14, 0, 1, 0, 100, 0, 2000, 2000, 0, 0, 80, 27328*100+3, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - OOC - Run Script 3'),
-- bear
(27328, 0, 23, 0, 0, 1, 100, 0, 1000, 1000, 4000, 4000, 11, 52504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - IC - Cast Lacerate'),
(27328, 0, 24, 0, 0, 1, 100, 0, 3000, 3000, 4000, 4000, 11, 52506, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - IC - Cast Maul'),
(27328, 0, 25, 0, 0, 1, 100, 0, 0, 0, 20000, 20000, 11, 6795, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - IC - Cast Growl'),
(27328, 0, 26, 0, 2, 1, 100, 0, 0, 50, 20000, 20000, 80, 27328*100+4, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - on %HP - time event 4'),
(27328*100+4, 9, 1, 0, 0, 0, 100, 1, 0, 0, 0, 0, 28, 48368, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - time event 4 - remove bear form on self'),
(27328*100+4, 9, 2, 0, 0, 0, 100, 1, 100, 100, 0, 0, 11, 52551, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - time event 4 - cast lifebloom on self'),
(27328*100+4, 9, 3, 0, 0, 0, 100, 1, 1000, 1000, 0, 0, 11, 52551, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - time event 4 - cast lifebloom on self'),
(27328*100+4, 9, 4, 0, 0, 0, 100, 1, 1000, 1000, 0, 0, 11, 52551, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - time event 4 - cast lifebloom on self'),
(27328*100+4, 9, 5, 0, 0, 0, 100, 1, 500, 500, 0, 0, 11, 48368, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - time event 4 - cast bear form on self'),
(27328*100+4, 9, 6, 0, 0, 0, 100, 1, 100, 100, 0, 0, 11, 52507, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - time event 4 - cast bear form buff on self'),
-- moonkin
-- (27328, 0, 34, 0, 0, 2, 100, 0, 1000, 1000, 1500, 1500, 11, 52501, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - IC - Cast Wrath'),
(27328, 0, 35, 0, 0, 2, 100, 0, 0, 0, 13000, 13000, 11, 52502, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - IC - Cast Moonfire'),
(27328, 0, 37, 38, 9, 2, 100, 0, 0, 30, 1500, 2000, 11, 52501, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - IC - Cast Wrath on target'),
(27328, 0, 38, 0, 61, 2, 100, 0, 0, 0, 0, 0, 40, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - linked - sheat weapon on self'),
(27328, 0, 44, 45, 3, 2, 100, 0, 0, 15, 0, 0, 11, 29166, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - on %mana - cast innervate on self'),
(27328, 0, 45, 0, 61, 2, 100, 0, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - linked - sheat weapon on self'),
-- tree
-- (27328, 0, 53, 0, 0, 4, 100, 0, 1000, 1000, 2500, 3000, 11, 52554, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - IC - Cast Nourish'),
(27328, 0, 54, 0, 0, 4, 100, 0, 0, 0, 4000, 6000, 11, 52551, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - IC - Cast Lifebloom'),
(27328, 0, 56, 57, 9, 4, 100, 0, 0, 30, 2500, 3000, 11, 52554, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - IC - Cast Nourish on target'),
(27328, 0, 57, 0, 61, 4, 100, 0, 0, 0, 0, 0, 40, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - linked - sheat weapon on self'),
(27328, 0, 63, 64, 3, 4, 100, 0, 0, 15, 10000, 10000, 11, 29166, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - on %mana - cast innervate on self'),
(27328, 0, 64, 0, 61, 4, 100, 0, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - linked - sheat weapon on self'),
-- script bear
(27328*100, 9, 0, 0, 1, 0, 100, 0, 0, 0, 0, 0, 11, 48368, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Tur - On Script - Cast Bear Form"),
(27328*100, 9, 1, 0, 1, 0, 100, 0, 0, 0, 0, 0, 11, 52507, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Tur - On Script - Cast Ragepaw's Presence"),
(27328*100, 9, 2, 0, 1, 0, 100, 0, 2000, 2000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Tur - On Script - Say text 3"),
(27328*100, 9, 3, 0, 1, 0, 100, 0, 0, 0, 0, 0, 2, 1770, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - On Script - Set Faction'),
-- (27328*100, 9, 4, 0, 1, 0, 100, 0, 0, 0, 0, 0, 71, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - On Script - Set Weapon'),
(27328*100, 9, 5, 0, 1, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - On Script - Set Phase 1'),
(27328*100, 9, 6, 0, 1, 0, 100, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - On Script - Remove Gossip Flag'),
(27328*100, 9, 7, 0, 1, 0, 100, 0, 8000, 8000, 0, 0, 53, 1, 27328, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - On Script - Start WP Movement'),
(27328*100, 9, 8, 0, 1, 0, 100, 0, 0, 0, 0, 0, 41, 600000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - On Script - Despawn Self in time'),
-- script moonkin
(27328*100+1, 9, 0, 0, 1, 0, 100, 0, 0, 0, 0, 0, 11, 48369, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Tur - On Script - Cast mondkin"),
(27328*100+1, 9, 1, 0, 1, 0, 100, 0, 0, 0, 0, 0, 11, 52503, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Tur - On Script - Cast Empowered Moonkin Aura"),
(27328*100+1, 9, 2, 0, 1, 0, 100, 0, 2000, 2000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Tur - On Script - Say text 2"),
(27328*100+1, 9, 3, 0, 1, 0, 100, 0, 0, 0, 0, 0, 2, 1770, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - On Script - Set Faction'),
-- (27328*100+1, 9, 4, 0, 1, 0, 100, 0, 0, 0, 0, 0, 71, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - On Script - Set Weapon'),
(27328*100+1, 9, 5, 0, 1, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - On Script - Set Phase 2'),
(27328*100+1, 9, 6, 0, 1, 0, 100, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - On Script - Remove Gossip Flag'),
(27328*100+1, 9, 7, 0, 1, 0, 100, 0, 8000, 8000, 0, 0, 53, 1, 27328, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - On Script - Start WP Movement'),
(27328*100+1, 9, 8, 0, 1, 0, 100, 0, 0, 0, 0, 0, 41, 600000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - On Script - Despawn Self in time'),
-- script tree
(27328*100+2, 9, 0, 0, 1, 0, 100, 0, 0, 0, 0, 0, 11, 48371, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Tur - On Script - Cast Tree of Life"),
(27328*100+2, 9, 1, 0, 1, 0, 100, 0, 0, 0, 0, 0, 28, 34123, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Tur - Remove Aura Tree of Life"),
(27328*100+2, 9, 2, 0, 1, 0, 100, 0, 0, 0, 0, 0, 11, 52553, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Tur - On Script - Cast Empowered Tree of Life"),
(27328*100+2, 9, 3, 0, 1, 0, 100, 0, 2000, 2000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Tur - On Script - Say text 1"),
(27328*100+2, 9, 4, 0, 1, 0, 100, 0, 0, 0, 0, 0, 2, 1770, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - On Script - Set Faction'),
-- (27328*100+2, 9, 5, 0, 1, 0, 100, 0, 0, 0, 0, 0, 71, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - On Script - Set Weapon'),
(27328*100+2, 9, 6, 0, 1, 0, 100, 0, 0, 0, 0, 0, 22, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - On Script - Set Phase 3'),
(27328*100+2, 9, 7, 0, 1, 0, 100, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - On Script - Remove Gossip Flag'),
(27328*100+2, 9, 8, 0, 1, 0, 100, 0, 8000, 8000, 0, 0, 53, 1, 27328, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - On Script - Start WP Movement'),
(27328*100+2, 9, 9, 0, 1, 0, 100, 0, 0, 0, 0, 0, 41, 600000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - On Script - Despawn Self in time'),
-- script respawn
(27328*100+3, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - On Script - Remove Aura All Auras'),
(27328*100+3, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 82, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tur Ragepaw - On Script - Add Gossip Flag');

DELETE FROM waypoints WHERE entry=27328;
INSERT INTO waypoints VALUES (27328, 1, 4674.4, -3873.15, 330.561, 'Tur Ragepaw'),(27328, 2, 4674.46, -3866.89, 329.246, 'Tur Ragepaw'),(27328, 3, 4673.88, -3866.08, 329.222, 'Tur Ragepaw'),(27328, 4, 4672.47, -3865.6, 328.498, 'Tur Ragepaw'),(27328, 5, 4672.15, -3865.48, 328.646, 'Tur Ragepaw'),(27328, 6, 4672.61, -3863.96, 328.316, 'Tur Ragepaw'),(27328, 7, 4673.65, -3862.96, 328.13, 'Tur Ragepaw'),(27328, 8, 4684.61, -3858.28, 327.406, 'Tur Ragepaw'),(27328, 9, 4708.5, -3848.28, 327.683, 'Tur Ragepaw'),(27328, 10, 4725.16, -3847.27, 330.066, 'Tur Ragepaw'),(27328, 11, 4737.86, -3846.77, 331.398, 'Tur Ragepaw'),
(27328, 12, 4751.12, -3846.35, 333.464, 'Tur Ragepaw'),(27328, 13, 4768.89, -3845.35, 333.872, 'Tur Ragepaw'),(27328, 14, 4787.34, -3843.56, 333.92, 'Tur Ragepaw'),(27328, 15, 4808.69, -3836.07, 336.295, 'Tur Ragepaw'),(27328, 16, 4828.49, -3834.72, 337.858, 'Tur Ragepaw'),(27328, 17, 4845.89, -3835.52, 338.634, 'Tur Ragepaw'),(27328, 18, 4859.34, -3842.23, 338.559, 'Tur Ragepaw'),(27328, 19, 4887.68, -3843.54, 337.535, 'Tur Ragepaw');

-- Anatoly Will Talk (12330)
DELETE FROM smart_scripts WHERE entryorguid IN(27626, 27627) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=27626*100 AND source_type=9;
INSERT INTO smart_scripts VALUES
(27626, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 28, 49138, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tatjana''s Horse - On spawn - Remove aura Mount Tatjana''s Horse'),
(27626, 0, 1, 2, 8, 0, 100, 0, 49135, 0, 0, 0, 2, 1812, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tatjana''s Horse - On spellhit Tatjana Ping - Set faction'),
(27626, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tatjana''s Horse - On spellhit Tatjana Ping - Stop autoattack'),
(27626, 0, 4, 0, 8, 0, 100, 0, 49138, 0, 0, 0, 80, 27626*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tatjana''s Horse - On spellhit Mount Tatjana''s Horse (phase 1) - Run script'),
(27626, 0, 5, 6, 40, 0, 100, 0, 19, 0, 0, 0, 28, 49138, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tatjana''s Horse - On WP 19 reached - Remove aura Mount Tatjana''s Horse'),
(27626, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 15, 12330, 0, 0, 0, 0, 0, 21, 2, 0, 0, 0, 0, 0, 0, 'Tatjana''s Horse - On WP 19 reached - Quest credit'),
(27626, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 9, 26971, 0, 30, 0, 0, 0, 0, 'Tatjana''s Horse - On WP 19 reached - Set data 0 1'),
(27626, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tatjana''s Horse - On WP 19 reached - Despawn'),
(27626, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 0, 2, 0, 0, 0, 0, 9, 27627, 0, 30, 0, 0, 0, 0, 'Tatjana''s Horse - On WP 19 reached - Set data 0 1'),
(27627, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, 43671, 0, 0, 0, 0, 0, 9, 27626, 0, 5, 0, 0, 0, 0, 'Tatjana - On respawn - Spellcast Ride Vehicle'),
(27627, 0, 1, 2, 8, 0, 100, 0, 49134, 0, 0, 0, 11, 49135, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tatjana - On spellhit Tranquilizer Dart - Spellcast Tatjana Ping'),
(27627, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 18, 256+512+131072+262144, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tatjana - On spellhit Tranquilizer Dart - Set unit_flags'),
(27627, 0, 3, 0, 0, 0, 100, 0, 2000, 6000, 9000, 12000, 11, 32009, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tatjana - On update IC - Spellcast Cutdown'),
(27627, 0, 4, 0, 38, 0, 100, 0, 0, 1, 0, 0, 41, 15000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tatjana - On data set 0 1 - Despawn after 15 seconds'),
(27627, 0, 5, 0, 38, 0, 100, 0, 0, 2, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tatjana - On data set 0 2 - Set home position'),
(27626*100, 9, 0, 0, 0, 0, 100, 0, 500, 500, 0, 0, 53, 1, 27626, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tatjana''s Horse script - Start WP movement'),
(27626*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tatjana''s Horse script - Set faction');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=27626;
INSERT INTO conditions VALUES (22, 5, 27626, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Run action if invoker is player');

-- The Captive Prospectors (12180)
UPDATE gameobject_template SET data2=30000 WHERE entry=188554;

-- Escape from Silverbrook (12308)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=48682;
INSERT INTO conditions VALUES (13, 2, 48682, 0, 0, 31, 0, 3, 27417, 0, 0, 0, 0, '', 'Target Silverbrook Worgen');
DELETE FROM smart_scripts WHERE entryorguid=27409 AND source_type=0;
INSERT INTO smart_scripts VALUES (27409, 0, 0, 1, 27, 0, 100, 0, 0, 0, 0, 0, 80, 2740900, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Ducal's Horse - On Passenger Boarded - Run Script");
INSERT INTO smart_scripts VALUES (27409, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Ducal's Horse - On Passenger Boarded - Set Reactstate Passive");
INSERT INTO smart_scripts VALUES (27409, 0, 2, 5, 40, 0, 100, 0, 103, 0, 0, 0, 86, 50473, 2, 21, 10, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Ducal's Horse - On Waypoint 103 Reached - Cross Cast 'Escape from Silverbrook Credit'");
INSERT INTO smart_scripts VALUES (27409, 0, 3, 0, 40, 0, 100, 0, 37, 0, 0, 0, 97, 25, 10, 0, 0, 0, 0, 1, 0, 0, 0, 4063.24, -2261.99, 215.989, 0, "Ducal's Horse - On Waypoint 37 Reached - Jump To Pos");
INSERT INTO smart_scripts VALUES (27409, 0, 4, 0, 40, 0, 100, 0, 75, 0, 0, 0, 97, 25, 10, 0, 0, 0, 0, 1, 0, 0, 0, 3900.4, -2743.33, 219.152, 0, "Ducal's Horse - On Waypoint 75 Reached - Jump To Pos");
INSERT INTO smart_scripts VALUES (27409, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 28, 48678, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Ducal's Horse - On Waypoint 103 Reached - Remove Aura 'Mount Ducal's Horse'");
INSERT INTO smart_scripts VALUES (27409, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Ducal's Horse - On Waypoint 103 Reached - Despawn In 5000 ms");
INSERT INTO smart_scripts VALUES (27409, 0, 7, 0, 28, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Ducal's Horse - On Passenger Removed - Force Despawn");
DELETE FROM smart_scripts WHERE entryorguid=27417 AND source_type=0;
INSERT INTO smart_scripts VALUES (27417, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 27409, 60, 0, 0, 0, 0, 0, 'Silverbrook Worgen - On Just Summoned - Start Attacking');
INSERT INTO smart_scripts VALUES (27417, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 36589, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Silverbrook Worgen - On Aggro - Cast Dash');
INSERT INTO smart_scripts VALUES (27417, 0, 2, 0, 7, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Silverbrook Worgen - On Evade - Despawn');

-- Blackout (12154)
UPDATE creature_template SET AIName='SmartAI' WHERE entry=27075;
DELETE FROM smart_scripts WHERE entryorguid=27075 AND source_type=0;
INSERT INTO smart_scripts VALUES (27075, 0, 0, 0, 8, 0, 100, 0, 47935, 0, 0, 0, 33, 27075, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Kill Monster Credit');

-- See You on the Other Side (12121)
DELETE FROM smart_scripts WHERE entryorguid=27199 AND source_type=0;
INSERT INTO smart_scripts VALUES (27199, 0, 0, 0, 54, 0, 100, 1, 0, 0, 0, 0, 44, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Warlord Jin'arrak - On Just Summoned - Set Phase 3");
INSERT INTO smart_scripts VALUES (27199, 0, 1, 3, 38, 0, 100, 0, 0, 2, 0, 0, 80, 2719901, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Warlord Jin'arrak - On Data Set 0 2 - Run Script");
INSERT INTO smart_scripts VALUES (27199, 0, 2, 3, 38, 0, 100, 0, 0, 1, 0, 0, 80, 2719900, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Warlord Jin'arrak - On Data Set 0 1 - Run Script");
INSERT INTO smart_scripts VALUES (27199, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 5, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Warlord Jin'arrak - On Data Set - Play Emote 15");
INSERT INTO smart_scripts VALUES (27199, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Warlord Jin'arrak - On Data Set - Set React Passive");

-- Always Seeking Solvent (12434)
-- Always Seeking Solvent (12446)
DELETE FROM creature_queststarter WHERE quest IN(12434, 12446);
INSERT INTO creature_queststarter VALUES (27565, 12434);
INSERT INTO creature_queststarter VALUES (27495, 12446);
DELETE FROM creature_questender WHERE quest IN(12434, 12446);
INSERT INTO creature_questender VALUES (27565, 12434);
INSERT INTO creature_questender VALUES (27495, 12446);
UPDATE quest_template SET PrevQuestId=12433, RequiredRaces=690 WHERE Id=12434;
UPDATE quest_template SET PrevQuestId=12443, RequiredRaces=1101 WHERE Id=12446;

-- Dun-da-Dun-tah! (12082)
UPDATE gameobject_template SET flags=34 WHERE entry IN(188465, 188487);
DELETE FROM smart_scripts WHERE entryorguid IN (24405, 26814, 26865, 26867, 26871) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=26812 AND source_type=0 AND id BETWEEN 9 AND 18;
DELETE FROM smart_scripts WHERE entryorguid IN (24405*100, 26814*100, 26814*100+1, 26814*100+2, 26814*100+3, 26814*100+4, 26865*100) AND source_type=9;
INSERT INTO smart_scripts VALUES (24405, 0, 0, 0, 38, 0, 100, 0, 0, 1, 0, 0, 80, 24405*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Adarrah - On Data Set 0 1 - Run script');
INSERT INTO smart_scripts VALUES (24405, 0, 1, 0, 40, 0, 100, 0, 6, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Adarrah - On WP Reached - Despawn');
INSERT INTO smart_scripts VALUES (24405*100, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 5, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Adarrah script - Play emote');
INSERT INTO smart_scripts VALUES (24405*100, 9, 1, 0, 0, 0, 100, 0, 1900, 1900, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Adarrah script - Say line');
INSERT INTO smart_scripts VALUES (24405*100, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 53, 1, 24405, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Adarrah script - Start WP movement');
INSERT INTO smart_scripts VALUES (26812, 0, 9, 0, 0, 0, 100, 0, 0, 0, 3400, 4800, 11, 9734, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ancient Drakkari Soothsayer - In Combat - Cast Holy Smite');
INSERT INTO smart_scripts VALUES (26814, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On Respawn - Reset Faction');
INSERT INTO smart_scripts VALUES (26814, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 145, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On Respawn - No Event Phase Reset');
INSERT INTO smart_scripts VALUES (26814, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 71, 0, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On Respawn - Remove Equip');
INSERT INTO smart_scripts VALUES (26814, 0, 3, 4, 19, 0, 100, 0, 12082, 0, 0, 0, 80, 26814*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On Quest Accept - Run Script 0');
INSERT INTO smart_scripts VALUES (26814, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On Quest Accept - Store Target');
INSERT INTO smart_scripts VALUES (26814, 0, 5, 6, 40, 0, 100, 0, 7, 26814, 0, 0, 54, 8500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On WP 7 Reached - Pause WP movement 8.5 seconds');
INSERT INTO smart_scripts VALUES (26814, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 6000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On WP 7 Reached - Say Line 1');
INSERT INTO smart_scripts VALUES (26814, 0, 7, 0, 52, 0, 100, 0, 1, 26814, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On Text Over - Say Line 2');
INSERT INTO smart_scripts VALUES (26814, 0, 8, 9, 40, 0, 100, 0, 9, 26814, 0, 0, 54, 12000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On WP 9 reached - Pause WP movement 12 seconds');
INSERT INTO smart_scripts VALUES (26814, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 26814*100+1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On WP 9 reached - Run script 1');
INSERT INTO smart_scripts VALUES (26814, 0, 10, 11, 40, 0, 100, 0, 11, 26814, 0, 0, 54, 18000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On WP 11 reached - Pause WP movement 18 seconds');
INSERT INTO smart_scripts VALUES (26814, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 26814*100+2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On WP 11 reached - Run script 2');
INSERT INTO smart_scripts VALUES (26814, 0, 12, 13, 40, 0, 100, 0, 13, 26814, 0, 0, 54, 4600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On WP 13 reached - Pause WP movement 4.5 seconds');
INSERT INTO smart_scripts VALUES (26814, 0, 13, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 4, 4600, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On WP 13 reached - Say line');
INSERT INTO smart_scripts VALUES (26814, 0, 14, 0, 52, 0, 100, 0, 4, 26814, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On text over - Say line');
INSERT INTO smart_scripts VALUES (26814, 0, 15, 0, 40, 0, 100, 0, 16, 26814, 0, 0, 131, 1, 0, 0, 0, 0, 0, 20, 188480, 50, 0, 0, 0, 0, 0, 'Harrison Jones - On WP 16 reached - Set Gameobject State Grizzly Hills - FireDoor01');
INSERT INTO smart_scripts VALUES (26814, 0, 16, 17, 40, 0, 100, 0, 17, 26814, 0, 0, 54, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On WP 17 reached - Say line');
INSERT INTO smart_scripts VALUES (26814, 0, 17, 0, 61, 0, 100, 0, 0, 0, 0, 0, 12, 26865, 4, 40000, 0, 0, 0, 8, 0, 0, 0, 4906.587, -4818.92, 32.63929, 2.530727, 'Harrison Jones - On WP 17 reached - Summon Tecahuna');
INSERT INTO smart_scripts VALUES (26814, 0, 18, 0, 40, 0, 100, 0, 18, 26814, 0, 0, 80, 26814*100+3, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On WP 18 reached - Run script');
INSERT INTO smart_scripts VALUES (26814, 0, 19, 20, 6, 0, 100, 0, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 20, 188480, 50, 0, 0, 0, 0, 0, 'Harrison Jones - On Death - Set Gameobject State Grizzly Hills - FireDoor01');
INSERT INTO smart_scripts VALUES (26814, 0, 20, 0, 61, 0, 100, 0, 0, 0, 0, 0, 6, 12082, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On Death - Fail quest');
INSERT INTO smart_scripts VALUES (26814, 0, 22, 23, 56, 0, 100, 0, 17, 26814, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On WP 17 resumed - Say line');
INSERT INTO smart_scripts VALUES (26814, 0, 23, 0, 61, 0, 100, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On WP 17 resumed - Set run');
INSERT INTO smart_scripts VALUES (26814, 0, 24, 0, 38, 0, 100, 0, 0, 1, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On data set 0 1 - Set event phase 1');
INSERT INTO smart_scripts VALUES (26814, 0, 25, 0, 1, 1, 100, 1, 1000, 1000, 0, 0, 80, 26814*100+4, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - Out of Combat (phase 1) - Run script');
INSERT INTO smart_scripts VALUES (26814, 0, 26, 27, 40, 0, 100, 0, 21, 26814*10, 0, 0, 54, 6000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On WP 21 reached - Pause WP movement 6 seconds');
INSERT INTO smart_scripts VALUES (26814, 0, 27, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On WP 21 reached - Say line');
INSERT INTO smart_scripts VALUES (26814, 0, 28, 29, 56, 0, 100, 0, 21, 26814*10, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On WP 21 resumed - Set run');
INSERT INTO smart_scripts VALUES (26814, 0, 29, 0, 61, 0, 100, 0, 0, 0, 0, 0, 15, 12082, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On WP 21 resumed - Quest credit');
INSERT INTO smart_scripts VALUES (26814, 0, 30, 0, 40, 0, 100, 0, 25, 26814*10, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On WP 25 reached - Despawn');
INSERT INTO smart_scripts VALUES (26814, 0, 31, 0, 4, 0, 100, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On aggro - Set reaction hostile');
INSERT INTO smart_scripts VALUES (26865, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 80, 26865*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tecahuna - Just summoned - Run script');
INSERT INTO smart_scripts VALUES (26865, 0, 1, 2, 6, 0, 100, 0, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 20, 188480, 100, 0, 0, 0, 0, 0, 'Tecahuna - On Death - Set Gameobject State Grizzly Hills - FireDoor01');
INSERT INTO smart_scripts VALUES (26865, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 19, 26814, 100, 0, 0, 0, 0, 0, 'Tecahuna - On Death - Set data 0 1 Harrison Jones');
INSERT INTO smart_scripts VALUES (26865, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 26867, 100, 0, 0, 0, 0, 0, 'Tecahuna - On Death/Evade - Despawn Target');
INSERT INTO smart_scripts VALUES (26865, 0, 4, 3, 7, 0, 100, 0, 0, 0, 0, 0, 41, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tecahuna - On Evade - Despawn');
INSERT INTO smart_scripts VALUES (26865, 0, 5, 0, 0, 0, 100, 0, 20000, 20000, 25000, 25000, 11, 47601, 0, 2, 0, 0, 0, 11, 26867, 60, 0, 0, 0, 0, 0, 'Tecahuna - In Combat - Cast Cosmetic - Tecahuna Spirit Beam');
INSERT INTO smart_scripts VALUES (26865, 0, 7, 0, 0, 0, 100, 0, 0, 0, 8000, 9000, 11, 47629, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tecahuna - In Combat - Cast Tecahuna Venom Spit');
INSERT INTO smart_scripts VALUES (26865*100, 9, 0, 0, 0, 0, 100, 0, 15300, 15300, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tecahuna Script - Remove unit_flags IMMUNE_TO_PC, IMMUNE_TO_NPC');
INSERT INTO smart_scripts VALUES (26865*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 26814, 30, 0, 0, 0, 0, 0, 'Tecahuna Script - Attack Start');
INSERT INTO smart_scripts VALUES (26867, 0, 0, 1, 8, 0, 100, 0, 47601, 0, 0, 0, 67, 1, 3000, 3000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Mummy Effect Bunny - On spellhit Cosmetic - Create Timed Event');
INSERT INTO smart_scripts VALUES (26867, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 4000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mummy Effect Bunny - On spellhit Cosmetic - Despawn');
INSERT INTO smart_scripts VALUES (26867, 0, 2, 0, 59, 0, 100, 0, 1, 0, 0, 0, 11, 47602, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mummy Effect Bunny - On Timed Event - Tecahuna Spirit Beam - Spellcast Summon Ancient Drakkari King');
INSERT INTO smart_scripts VALUES (26871, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 5000, 7000, 11, 52466, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ancient Drakkari King - In Combat - Cast Drakkari Curse');
INSERT INTO smart_scripts VALUES (26871, 0, 1, 0, 54, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Ancient Drakkari King - Is Summoned - Attack Start');
INSERT INTO smart_scripts VALUES (26814*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones script 0 - Say line');
INSERT INTO smart_scripts VALUES (26814*100, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 9, 0, 0, 0, 0, 0, 0, 20, 188465, 5, 0, 0, 0, 0, 0, 'Harrison Jones script 0 - Activate Harrison''s Cage');
INSERT INTO smart_scripts VALUES (26814*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 250, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones script 0 - Set faction');
INSERT INTO smart_scripts VALUES (26814*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 71, 0, 2, 0, 2081, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones script 0 - Equip');
INSERT INTO smart_scripts VALUES (26814*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones script 0 - Remove npcflag gossip');
INSERT INTO smart_scripts VALUES (26814*100, 9, 5, 0, 0, 0, 100, 0, 2500, 2500, 0, 0, 53, 0, 26814, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Harrison Jones script 0 - Start WP movement');
INSERT INTO smart_scripts VALUES (26814*100+1, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 17, 133, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones script 1 - Play emote');
INSERT INTO smart_scripts VALUES (26814*100+1, 9, 1, 0, 0, 0, 100, 0, 2500, 2500, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones script 1 - Stop emote');
INSERT INTO smart_scripts VALUES (26814*100+1, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones script 1 - Say line');
INSERT INTO smart_scripts VALUES (26814*100+1, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 20, 188487, 5, 0, 0, 0, 0, 0, 'Harrison Jones script 1 - Activate Adarra''s Cage');
INSERT INTO smart_scripts VALUES (26814*100+1, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 19, 24405, 5, 0, 0, 0, 0, 0, 'Harrison Jones script 1 - Set data 0 1 Adarra');
INSERT INTO smart_scripts VALUES (26814*100+2, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 6.143559, 'Harrison Jones script 2 - Set orientation');
INSERT INTO smart_scripts VALUES (26814*100+2, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones script 2 - Set unit_field_bytes1 (kneel)');
INSERT INTO smart_scripts VALUES (26814*100+2, 9, 2, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 4.677482, 'Harrison Jones script 2 - Set orientation');
INSERT INTO smart_scripts VALUES (26814*100+2, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones script 2 - Remove unit_field_bytes1 (kneel)');
INSERT INTO smart_scripts VALUES (26814*100+2, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 71, 0, 1, 32246, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones script 2 - Equip');
INSERT INTO smart_scripts VALUES (26814*100+2, 9, 5, 0, 0, 0, 100, 0, 2500, 2500, 0, 0, 5, 36, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones script 2 - Play emote');
INSERT INTO smart_scripts VALUES (26814*100+2, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 4, 12827, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones script 2 - Play sound');
INSERT INTO smart_scripts VALUES (26814*100+2, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 47533, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones script 2 - Spellcast Camera Shake');
INSERT INTO smart_scripts VALUES (26814*100+2, 9, 8, 0, 0, 0, 100, 0, 2500, 2500, 0, 0, 5, 36, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones script 2 - Play emote');
INSERT INTO smart_scripts VALUES (26814*100+2, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 4, 12827, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones script 2 - Play sound');
INSERT INTO smart_scripts VALUES (26814*100+2, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 47533, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones script 2 - Spellcast Camera Shake');
INSERT INTO smart_scripts VALUES (26814*100+2, 9, 11, 0, 0, 0, 100, 0, 2500, 2500, 0, 0, 5, 36, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones script 2 - Play emote');
INSERT INTO smart_scripts VALUES (26814*100+2, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 4, 12827, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones script 2 - Play sound');
INSERT INTO smart_scripts VALUES (26814*100+2, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 47533, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones script 2 - Spellcast Camera Shake');
INSERT INTO smart_scripts VALUES (26814*100+2, 9, 14, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 26867, 2, 300000, 0, 0, 0, 8, 0, 0, 0, 4902.228, -4827.556, 32.61251, 2.443461, 'Harrison Jones script 2 - Summon Mummy Effect Bunny');
INSERT INTO smart_scripts VALUES (26814*100+2, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 26867, 2, 300000, 0, 0, 0, 8, 0, 0, 0, 4876.608, -4805.581, 32.58254, 6.178465, 'Harrison Jones script 2 - Summon Mummy Effect Bunny');
INSERT INTO smart_scripts VALUES (26814*100+2, 9, 16, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 26867, 2, 300000, 0, 0, 0, 8, 0, 0, 0, 4877.39, -4815.752, 32.58345, 0.1570796, 'Harrison Jones script 2 - Summon Mummy Effect Bunny');
INSERT INTO smart_scripts VALUES (26814*100+2, 9, 17, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 26867, 2, 300000, 0, 0, 0, 8, 0, 0, 0, 4883.104, -4823.975, 32.58836, 0.8726646, 'Harrison Jones script 2 - Summon Mummy Effect Bunny');
INSERT INTO smart_scripts VALUES (26814*100+2, 9, 18, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 26867, 2, 300000, 0, 0, 0, 8, 0, 0, 0, 4892.313, -4828.58, 32.59582, 1.570796, 'Harrison Jones script 2 - Summon Mummy Effect Bunny');
INSERT INTO smart_scripts VALUES (26814*100+2, 9, 19, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 26867, 2, 300000, 0, 0, 0, 8, 0, 0, 0, 4908.681, -4794.352, 32.67061, 3.979351, 'Harrison Jones script 2 - Summon Mummy Effect Bunny');
INSERT INTO smart_scripts VALUES (26814*100+2, 9, 20, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 26867, 2, 300000, 0, 0, 0, 8, 0, 0, 0, 4899.539, -4789.862, 32.59812, 4.764749, 'Harrison Jones script 2 - Summon Mummy Effect Bunny');
INSERT INTO smart_scripts VALUES (26814*100+2, 9, 21, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 26867, 2, 300000, 0, 0, 0, 8, 0, 0, 0, 4889.959, -4790.646, 32.59848, 5.201081, 'Harrison Jones script 2 - Summon Mummy Effect Bunny');
INSERT INTO smart_scripts VALUES (26814*100+2, 9, 22, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 26867, 2, 300000, 0, 0, 0, 8, 0, 0, 0, 4914.76, -4813.242, 32.58661, 3.01942, 'Harrison Jones script 2 - Summon Mummy Effect Bunny');
INSERT INTO smart_scripts VALUES (26814*100+2, 9, 23, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 26867, 2, 300000, 0, 0, 0, 8, 0, 0, 0, 4914.13, -4802.799, 32.66964, 3.420845, 'Harrison Jones script 2 - Summon Mummy Effect Bunny');
INSERT INTO smart_scripts VALUES (26814*100+3, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones script 3 - Say line');
INSERT INTO smart_scripts VALUES (26814*100+3, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones script 3 - Set homeposition');
INSERT INTO smart_scripts VALUES (26814*100+3, 9, 2, 0, 0, 0, 100, 0, 7200, 7200, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones script 3 - Say line');
INSERT INTO smart_scripts VALUES (26814*100+3, 9, 3, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones script 3 - Start attack');
INSERT INTO smart_scripts VALUES (26814*100+4, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones script 4 - Set event phase 0');
INSERT INTO smart_scripts VALUES (26814*100+4, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 53, 1, 26814*10, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Harrison Jones script 4 - Start WP movement');

-- Souls at Unrest (12159)
UPDATE creature_template SET AIName='SmartAI' WHERE entry=26891;
DELETE FROM smart_scripts WHERE entryorguid=26891 AND source_type=0;
INSERT INTO smart_scripts VALUES (26891, 0, 0, 0, 9, 0, 100, 0, 0, 5, 8000, 11000, 11, 48374, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Undead Miner - Within 0-5 Range - Cast Puncture Wound');
INSERT INTO smart_scripts VALUES (26891, 0, 1, 0, 0, 0, 100, 0, 5000, 7000, 6000, 9000, 11, 52608, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Undead Miner - In Combat - Cast Throw Lantern');
INSERT INTO smart_scripts VALUES (26891, 0, 2, 0, 8, 0, 100, 0, 48974, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Undead Miner - On Spell Hit - Despawn');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=48974;
INSERT INTO conditions VALUES (17, 0, 48974, 0, 0, 31, 1, 3, 26891, 0, 0, 0, 0, '', 'Requires Undead Miner');
INSERT INTO conditions VALUES (17, 0, 48974, 0, 0, 36, 1, 0, 0, 0, 1, 0, 0, '', 'Requires Dead Target');
