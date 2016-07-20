
-- -------------------------------------------
-- ZUL'DRAK
-- -------------------------------------------

-- Lab Work (12557)
UPDATE gameobject_loot_template SET ChanceOrQuestChance=100 WHERE item IN(38386, 38339, 38340, 38346);
DELETE FROM spell_script_names WHERE spell_id IN(51060, 51068, 51088, 51094);
INSERT INTO spell_script_names VALUES(51060, "spell_gen_have_item_auras");
INSERT INTO spell_script_names VALUES(51068, "spell_gen_have_item_auras");
INSERT INTO spell_script_names VALUES(51088, "spell_gen_have_item_auras");
INSERT INTO spell_script_names VALUES(51094, "spell_gen_have_item_auras");

-- So Far, So Bad (12669)
UPDATE gameobject_template SET data1=15 WHERE entry=190731;

-- It Rolls Downhill (12673)
DELETE FROM creature_text WHERE entry=28750;
INSERT INTO creature_text VALUES (28750, 0, 0, 'Mphmm rmphhimm rrhumghph?', 12, 0, 100, 1, 0, 0, 0, 'Blight Geist');
INSERT INTO creature_text VALUES (28750, 0, 1, 'Mhrrumph rummrhum phurr!', 12, 0, 100, 1, 0, 0, 0, 'Blight Geist');
REPLACE INTO creature_template_addon VALUES (28750, 0, 0, 0, 1, 0, '');
UPDATE creature_template SET spell1=52245, AIName='SmartAI' WHERE entry=28750;
DELETE FROM smart_scripts WHERE entryorguid=28750 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=28750*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (28750, 0, 0, 3, 8, 0, 100, 0, 52245, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 20, 190716, 25, 0, 2, 0, 0, 0, 'Blight Geist - On Spellhit - Store Target');
INSERT INTO smart_scripts VALUES (28750, 0, 1, 3, 8, 0, 100, 0, 52245, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 20, 190939, 25, 0, 2, 0, 0, 0, 'Blight Geist - On Spellhit - Store Target');
INSERT INTO smart_scripts VALUES (28750, 0, 2, 3, 8, 0, 100, 0, 52245, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 20, 190940, 25, 0, 2, 0, 0, 0, 'Blight Geist - On Spellhit - Store Target');
INSERT INTO smart_scripts VALUES (28750, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 2, 0, 0, 0, 'Blight Geist - On Spell Hit - Move To Position');
INSERT INTO smart_scripts VALUES (28750, 0, 4, 0, 34, 0, 100, 0, 8, 1, 0, 0, 80, 28750*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blight Geist - Movement Inform - Run Script');
INSERT INTO smart_scripts VALUES (28750, 0, 5, 0, 8, 0, 100, 0, 52244, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blight Geist - On Spellhit - Say Line 0');
INSERT INTO smart_scripts VALUES (28750, 0, 6, 0, 8, 0, 100, 0, 52252, 0, 0, 0, 11, 52243, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blight Geist - On Spellhit - Cast Orange Radiation, Small');
INSERT INTO smart_scripts VALUES (28750, 0, 7, 8, 34, 0, 100, 0, 8, 2, 0, 0, 11, 61456, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blight Geist - Movement Inform - Cast Evil Teleport Visual Only');
INSERT INTO smart_scripts VALUES (28750, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 11, 52248, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blight Geist - Movement Inform - Cast Kill Credit - Blighted Geist');
INSERT INTO smart_scripts VALUES (28750, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blight Geist - Movement Inform - Despawn');
INSERT INTO smart_scripts VALUES (28750*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Blight Geist - On Script - Set Orientation');
INSERT INTO smart_scripts VALUES (28750*100, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 5, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blight Geist - On Script - Play Emote');
INSERT INTO smart_scripts VALUES (28750*100, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 99, 3, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Blight Geist - On Script - Set Loot State');
INSERT INTO smart_scripts VALUES (28750*100, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 69, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6174.282, -2017.246, 245.1156, 0, 'Blight Geist - On Script - Move To Position');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=28750;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=52245;
INSERT INTO conditions VALUES (17, 0, 52245, 0, 0, 30, 0, 190716, 20, 0, 0, 0, 0, '', 'Allow Cast if Gameobject in Range');
INSERT INTO conditions VALUES (17, 0, 52245, 0, 1, 30, 0, 190939, 20, 0, 0, 0, 0, '', 'Allow Cast if Gameobject in Range');
INSERT INTO conditions VALUES (17, 0, 52245, 0, 2, 30, 0, 190940, 20, 0, 0, 0, 0, '', 'Allow Cast if Gameobject in Range');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=52247;
INSERT INTO conditions VALUES (13, 1, 52247, 0, 0, 31, 0, 5, 190716, 0, 0, 0, 0, '', 'Target Blight Crystal');
INSERT INTO conditions VALUES (13, 1, 52247, 0, 1, 31, 0, 5, 190939, 0, 0, 0, 0, '', 'Target Blight Crystal');
INSERT INTO conditions VALUES (13, 1, 52247, 0, 2, 31, 0, 5, 190940, 0, 0, 0, 0, '', 'Target Blight Crystal');

-- Congratulations! (12604)
UPDATE quest_template SET RewardSpellCast=53707, SourceSpellId=51573 WHERE Id=12501; -- Troll Patrol quest
DELETE FROM spell_linked_spell WHERE spell_trigger=51573;
INSERT INTO spell_linked_spell VALUES(51573, 53712, 1, 'On patrol - trigger clear spell');
INSERT INTO spell_linked_spell VALUES(51573, 53713, 1, 'On patrol - trigger clear spell');
INSERT INTO spell_linked_spell VALUES(51573, 53715, 1, 'On patrol - trigger clear spell');
INSERT INTO spell_linked_spell VALUES(51573, 53716, 1, 'On patrol - trigger clear spell');
DELETE FROM conditions WHERE SourceEntry IN(12604) AND SourceTypeOrReferenceId IN(19, 20);
INSERT INTO conditions VALUES(19, 0, 12604, 0, 0, 1, 0, 51573, 0, 0, 0, 0, 0, "", 'Congratulations quest, requires on patrol aura');
INSERT INTO conditions VALUES(19, 0, 12604, 0, 0, 1, 0, 53707, 0, 0, 0, 0, 0, "", 'Congratulations quest, requires additional dummy aura');
INSERT INTO conditions VALUES(20, 0, 12604, 0, 0, 1, 0, 51573, 0, 0, 0, 0, 0, "", 'Congratulations quest, requires on patrol aura');
INSERT INTO conditions VALUES(20, 0, 12604, 0, 0, 1, 0, 53707, 0, 0, 0, 0, 0, "", 'Congratulations quest, requires additional dummy aura');

-- Pa'Troll (12596), set correct set of quests
UPDATE quest_template SET PrevQuestId=-12596, NextQuestId=0, ExclusiveGroup=0, NextQuestIdChain=0, SpecialFlags=0 WHERE Id IN(12557, 12597, 12598, 12599);
UPDATE quest_template SET SourceSpellId=51515 WHERE Id=12596;
UPDATE quest_template SET PrevQuestId=0, NextQuestId=12555, ExclusiveGroup=-12583, NextQuestIdChain=12555 WHERE Id=12606; -- wrong old template, counted as pa'troll task which is wrong!
DELETE FROM spell_linked_spell WHERE spell_trigger=51515;
INSERT INTO spell_linked_spell VALUES(51515, 51506, 1, 'Clear patrol quests - trigger clear spell');
INSERT INTO spell_linked_spell VALUES(51515, 51509, 1, 'Clear patrol quests - trigger clear spell');

-- Troll Patrol: Whatdya Want, a Medal? (12519)
DELETE FROM npc_spellclick_spells WHERE npc_entry=28162;
INSERT INTO npc_spellclick_spells VALUES(28162, 51026, 1, 0);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=18 AND SourceGroup=28162;
INSERT INTO conditions VALUES (18, 28162, 51026, 0, 0, 8, 0, 12519, 0, 0, 1, 0, 0, '', 'Forbidden rewarded quest for spellclick');
INSERT INTO conditions VALUES (18, 28162, 51026, 0, 0, 9, 0, 12519, 0, 0, 0, 0, 0, '', 'Required quest active for spellclick');
DELETE FROM spell_scripts WHERE id=51026;
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=28162;
DELETE FROM smart_scripts WHERE entryorguid=28162 AND source_type=0;
INSERT INTO smart_scripts VALUES (28162, 0, 0, 1, 8, 0, 100, 0, 51026, 0, 0, 0, 11, 50737, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Corpse - On Spell Hit - Cast Create Drakkari Medallion');
INSERT INTO smart_scripts VALUES (28162, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Corpse - On Spell Hit - Despawn');

-- Troll Patrol: Done to Death (12568)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=51276;
INSERT INTO conditions VALUES (13, 1, 51276, 0, 0, 31, 0, 3, 28156, 0, 0, 0, 0, '', '');
UPDATE creature_template SET AIName="SmartAI" WHERE entry=28156;
DELETE FROM smart_scripts WHERE entryorguid=28156 AND source_type=0;
INSERT INTO smart_scripts VALUES (28156, 0, 0, 1, 8, 0, 100, 0, 51276, 0, 0, 0, 33, 28316, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Kill credit on spell hit");
INSERT INTO smart_scripts VALUES (28156, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Forced despawn linked");
INSERT INTO smart_scripts VALUES (28156, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 59216, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast spell linked");

-- Troll Patrol: Can You Dig It? (12588)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=51333;
INSERT INTO conditions VALUES (13, 1, 51333, 0, 0, 31, 0, 3, 28330, 0, 0, 0, 0, '', 'Target Ancient Dirt KC Bunny');
DELETE FROM gameobject WHERE id=190550;
UPDATE creature_template SET unit_flags=33554432, flags_extra=128, AIName='SmartAI', ScriptName='' WHERE entry=28330;
DELETE FROM smart_scripts WHERE entryorguid=28330 AND source_type=0;
INSERT INTO smart_scripts VALUES(28330, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 50, 190550, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Ancient Dirt KC Bunny - On Respawn - Summon Gameobject");
INSERT INTO smart_scripts VALUES(28330, 0, 1, 2, 8, 0, 100, 0, 51333, 0, 0, 0, 33, 28330, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Ancient Dirt KC Bunny - On Spell Hit - Kill Credit");
INSERT INTO smart_scripts VALUES(28330, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 20, 190550, 5, 0, 0, 0, 0, 0, "Ancient Dirt KC Bunny - On Spell Hit - Despawn Gameobject");
INSERT INTO smart_scripts VALUES(28330, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Ancient Dirt KC Bunny - On Spell Hit - Despawn Self");

-- Troll Patrol: The Alchemist's Apprentice (12541)
UPDATE gameobject_loot_template SET ChanceOrQuestChance=100 WHERE item IN(38336, 39669, 38342, 38340, 38344, 38369, 38396, 38398, 38338, 38386, 38341, 38384, 38397, 38381, 38337, 38393, 38339, 39668, 39670, 38346, 38379, 38345, 38343, 38370);
UPDATE gameobject SET spawntimesecs=30 WHERE id IN(190459,190461,190462,190463,190464,190465,190466,190467,190468,190469,190470,190471,190472,190473,190474,190476,190477,190478,190479,190480,190481,190482,191180,191181,191182);
UPDATE creature_template SET ScriptName='npc_finklestein' WHERE entry=28205;
UPDATE gameobject_template SET ScriptName='go_finklestein_cauldron' WHERE entry=190498;
-- TC
DELETE FROM spell_script_names WHERE ScriptName='spell_random_ingredient_aura' AND spell_id IN(51015, 51154, 51157);
DELETE FROM spell_script_names WHERE ScriptName='spell_random_ingredient' AND spell_id IN(51105, 51107, 51134);
DELETE FROM spell_script_names WHERE ScriptName='spell_pot_check' AND spell_id=51046;
DELETE FROM spell_script_names WHERE ScriptName='spell_fetch_ingredient_aura'; -- Too many ids



-- Setting the Stage (12672)
DELETE FROM gameobject WHERE id=190717;
INSERT INTO gameobject VALUES (NULL, 190717, 571, 1, 2, 5658.46, -4065.84, 353.109, 3.2456, 0, 0, 0.998648, -0.0519802, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 190717, 571, 1, 2, 5640.36, -4067.2, 352.51, 3.29666, 0, 0, 0.996996, -0.077456, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 190717, 571, 1, 2, 5639.93, -4102.82, 352.579, 0.0254741, 0, 0, 0.0127367, 0.999919, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 190717, 571, 1, 2, 5658.44, -4103.1, 352.523, 6.23424, 0, 0, 0.0244702, -0.999701, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 190717, 571, 1, 2, 5674.33, -4103.09, 352.463, 0.15133, 0, 0, 0.0755928, 0.997139, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 190717, 571, 1, 2, 5640.38, -4128.02, 352.559, 6.00936, 0, 0, 0.136485, -0.990642, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 190717, 571, 1, 2, 5659.26, -4128.18, 352.592, 6.08383, 0, 0, 0.0995127, -0.995036, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 190717, 571, 1, 2, 5672.43, -4128.94, 352.414, 0.10302, 0, 0, 0.0514872, 0.998674, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 190717, 571, 1, 2, 5655.2, -4163.65, 352.459, 6.24483, 0, 0, 0.0191764, -0.999816, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 190717, 571, 1, 2, 5675.39, -4163.33, 352.486, 0.137434, 0, 0, 0.0686629, 0.99764, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 190717, 571, 1, 2, 5763.38, -4163.95, 352.882, 6.06646, 0, 0, 0.108151, -0.994135, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 190717, 571, 1, 2, 5786.82, -4164.42, 352.414, 0.0110331, 0, 0, 0.00551652, 0.999985, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 190717, 571, 1, 2, 5752.56, -4129.18, 353.174, 6.069, 0, 0, 0.106888, -0.994271, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 190717, 571, 1, 2, 5770.42, -4128.87, 352.527, 0.0538505, 0, 0, 0.026922, 0.999638, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 190717, 571, 1, 2, 5790.12, -4129.02, 353.044, 6.24363, 0, 0, 0.0197764, -0.999804, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 190717, 571, 1, 2, 5787.65, -4104.49, 352.464, 0.0181494, 0, 0, 0.00907458, 0.999959, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 190717, 571, 1, 2, 5771.09, -4103.79, 352.434, 0.00636768, 0, 0, 0.00318383, 0.999995, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 190717, 571, 1, 2, 5752.44, -4104.06, 352.569, 6.11926, 0, 0, 0.081871, -0.996643, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 190717, 571, 1, 2, 5767.57, -4068.78, 352.693, 6.13787, 0, 0, 0.0725938, -0.997362, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 190717, 571, 1, 2, 5784.72, -4068.95, 352.63, 6.20248, 0, 0, 0.0403418, -0.999186, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 190717, 571, 1, 2, 5814.9, -4117.41, 353.163, 3.02751, 0, 0, 0.998374, 0.0570104, 120, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 190717, 571, 1, 2, 5627.08, -4116.07, 353.162, 6.26427, 0, 0, 0.0094576, -0.999955, 120, 100, 1, 0);

-- The Leaders at Jin'Alai (12622)
UPDATE creature SET spawntimesecs=10 WHERE id IN(28494, 28495, 28496);

-- Sabotage (12676)
UPDATE creature_template SET AIName='SmartAI' WHERE entry=28780;
DELETE FROM smart_scripts WHERE entryorguid IN(28780) AND source_type=0;
INSERT INTO smart_scripts VALUES (28780, 0, 0, 0, 60, 0, 100, 1, 500, 1000, 0, 0, 33, 28777, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Killmonster credit for summoner');
INSERT INTO smart_scripts VALUES (28780, 0, 1, 2, 60, 0, 100, 1, 5000, 6000, 0, 0, 11, 52324, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'cast spell on update');
INSERT INTO smart_scripts VALUES (28780, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 11, 52329, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'cast spell linked');
INSERT INTO smart_scripts VALUES (28780, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 11, 52325, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'cast spell linked');
INSERT INTO smart_scripts VALUES (28780, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 11, 52330, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'cast spell linked');
INSERT INTO smart_scripts VALUES (28780, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 52332, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'cast spell linked');
INSERT INTO smart_scripts VALUES (28780, 0, 6, 0, 60, 0, 100, 1, 4800, 4800, 0, 0, 99, 3, 0, 0, 0, 0, 0, 20, 190731, 15, 0, 0, 0, 0, 0, 'deactivate GO');

-- Disclosure (12710)
-- remake areatriggers!
DELETE FROM areatrigger_scripts WHERE entry IN(5051, 5061);
DELETE FROM smart_scripts WHERE entryorguid IN(5051, 5061) AND source_type=2;
REPLACE INTO areatrigger_teleport VALUES(5080, "Zul'drak - Voltarus, upper floor -> middle", 571, 6159.16, -2028.6, 408.168, 3.74088);
REPLACE INTO areatrigger_teleport VALUES(5051, "Zul'drak - Voltarus, base floor -> middle", 571, 6159.16, -2028.6, 408.168, 3.74088);
REPLACE INTO areatrigger_teleport VALUES(5061, "Zul'drak - Voltarus, middle floor -> base", 571, 6175.6, -2008.78, 245.255, 1.49857);
DELETE FROM areatrigger_teleport WHERE id=5079;
REPLACE INTO areatrigger_scripts VALUES(5079, 'at_voltarus_middle'); -- middle floor -> upper
DELETE FROM gameobject WHERE id IN(190948, 190949);
INSERT INTO gameobject VALUES (NULL, 190948, 571, 1, 1, 6260.48, -1960.04, 484.782, -2.49582, 0, 0, -0.948324, 0.317305, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (NULL, 190949, 571, 1, 1, 6260.49, -1960.04, 484.782, -2.49582, 0, 0, -0.948324, 0.317305, 300, 0, 1, 0);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(52839, -52839, 52775, -52775);
INSERT INTO spell_linked_spell VALUES(-52839, 52775, 0, 'Disclosure quest, summon malmortis');
UPDATE creature_template SET minlevel=80, maxlevel=80, AIName='SmartAI' WHERE entry=28948;
DELETE FROM smart_scripts WHERE entryorguid IN(28948) AND source_type=0;
INSERT INTO smart_scripts VALUES (28948, 0, 0, 1, 60, 0, 100, 1, 1000, 1000, 0, 0, 53, 0, 28948, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'start escort');
INSERT INTO smart_scripts VALUES (28948, 0, 1, 4, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 28948, 100, 0, 0, 0, 0, 0, 'Set data linked');
INSERT INTO smart_scripts VALUES (28948, 0, 2, 3, 38, 0, 100, 1, 1, 1, 0, 0, 33, 28929, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Killmonster credit on data set');
INSERT INTO smart_scripts VALUES (28948, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 500, 500, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'forcedespawn linked');
INSERT INTO smart_scripts VALUES (28948, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'say text linked');
INSERT INTO smart_scripts VALUES (28948, 0, 5, 0, 40, 0, 100, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'say text 1 on wp reach');
INSERT INTO smart_scripts VALUES (28948, 0, 6, 0, 40, 0, 100, 0, 3, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'say text 2 on wp reach');
INSERT INTO smart_scripts VALUES (28948, 0, 7, 0, 40, 0, 100, 0, 5, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'say text 3 on wp reach');
INSERT INTO smart_scripts VALUES (28948, 0, 8, 9, 40, 0, 100, 0, 6, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'say text 4 on wp reach');
INSERT INTO smart_scripts VALUES (28948, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 54, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'stop escort linked');
INSERT INTO smart_scripts VALUES (28948, 0, 10, 0, 40, 0, 100, 0, 7, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'say text 5 on wp reach');
INSERT INTO smart_scripts VALUES (28948, 0, 11, 0, 40, 0, 100, 0, 9, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'say text 6 on wp reach');
INSERT INTO smart_scripts VALUES (28948, 0, 12, 0, 40, 0, 100, 0, 12, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'say text 7 on wp reach');
INSERT INTO smart_scripts VALUES (28948, 0, 13, 0, 40, 0, 100, 0, 14, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'say text 8 on wp reach');
INSERT INTO smart_scripts VALUES (28948, 0, 14, 15, 40, 0, 100, 0, 16, 0, 0, 0, 1, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'say text 9 on wp reach');
INSERT INTO smart_scripts VALUES (28948, 0, 15, 0, 61, 0, 100, 0, 0, 0, 0, 0, 54, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'stop escort linked');
INSERT INTO smart_scripts VALUES (28948, 0, 16, 0, 40, 0, 100, 0, 17, 0, 0, 0, 1, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'say text 10 on wp reach');
INSERT INTO smart_scripts VALUES (28948, 0, 17, 0, 40, 0, 100, 0, 18, 0, 0, 0, 1, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'say text 11 on wp reach');
INSERT INTO smart_scripts VALUES (28948, 0, 18, 0, 40, 0, 100, 0, 19, 0, 0, 0, 1, 12, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'say text 12 on wp reach');
INSERT INTO smart_scripts VALUES (28948, 0, 19, 0, 40, 0, 100, 0, 21, 0, 0, 0, 1, 13, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'say text 13 on wp reach');
INSERT INTO smart_scripts VALUES (28948, 0, 20, 21, 40, 0, 100, 0, 23, 0, 0, 0, 1, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'say text 14 on wp reach');
INSERT INTO smart_scripts VALUES (28948, 0, 21, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set data linked');
DELETE FROM creature_text WHERE entry IN (28948);
INSERT INTO creature_text VALUES
(28948, 0, 0, "Ahh... there you are. The master told us you'd be arriving soon.", 12, 0, 100, 1, 0, 0, 0, 'Malmortis text'),
(28948, 1, 0, "Please, follow me, $N. There is much for you to see...", 12, 0, 100, 1, 0, 0, 0, 'Malmortis text'),
(28948, 2, 0, "You should feel honored. You are the first of the master's prospects to be shown our operation.", 12, 0, 100, 1, 0, 0, 0, 'Malmortis text'),
(28948, 3, 0, "The things I show you now must never be spoken of outside Voltarus. The world shall come to know our secret soon enough!", 12, 0, 100, 1, 0, 0, 0, 'Malmortis text'),
(28948, 4, 0, "Here lie our stores of blight crystal, without which our project would be impossible.", 12, 0, 100, 1, 0, 0, 0, 'Malmortis text'),
(28948, 5, 0, "I understand that you are to thank for the bulk of our supply.", 12, 0, 100, 1, 0, 0, 0, 'Malmortis text'),
(28948, 6, 0, "These trolls are among those you exposed on the battlefield. Masterfully done, indeed....", 12, 0, 100, 1, 0, 0, 0, 'Malmortis text'),
(28948, 7, 0, "We feel it best to position them here, where they might come in terms with their impending fate.", 12, 0, 100, 1, 0, 0, 0, 'Malmortis text'),
(28948, 8, 0, "This is their destiny....", 12, 0, 100, 1, 0, 0, 0, 'Malmortis text'),
(28948, 9, 0, "The blight slowly seeps into their bodies, gradually preparing them for their conversion.", 12, 0, 100, 1, 0, 0, 0, 'Malmortis text'),
(28948, 10, 0, "This special preparation grants them unique powers far greater than they would otherwise know.", 12, 0, 100, 1, 0, 0, 0, 'Malmortis text'),
(28948, 11, 0, "Soon, the master will grant them the dark gift, making them fit to server the Lich King for eternity!", 12, 0, 100, 1, 0, 0, 0, 'Malmortis text'),
(28948, 12, 0, "Stay for as long as you like, $N. Glory in the fruits of your labor!", 12, 0, 100, 1, 0, 0, 0, 'Malmortis text'),
(28948, 13, 0, "Your service has been invaluable in fulfilling the master's plan. May you forever grow in power....", 12, 0, 100, 1, 0, 0, 0, 'Malmortis text'),
(28948, 14, 0, "Farewell.", 12, 0, 100, 1, 0, 0, 0, 'Malmortis text');
DELETE FROM waypoints WHERE entry=28948;
INSERT INTO waypoints VALUES (28948, 1, 6236.44, -1977.78, 484.782, 'malmortis'),(28948, 2, 6239.19, -2000.98, 484.92, 'malmortis'),(28948, 3, 6263.43, -2031.08, 485.075, 'malmortis'),(28948, 4, 6250.13, -2050.53, 484.875, 'malmortis'),(28948, 5, 6159.67, -2107.64, 485.085, 'malmortis'),
(28948, 6, 6121.99, -2053.64, 484.782, 'malmortis'),(28948, 7, 6086.62, -2000.3, 485.095, 'malmortis'),(28948, 8, 6061.7, -1995.35, 485.267, 'malmortis'),(28948, 9, 6059.67, -2007.91, 485.363, 'malmortis'),(28948, 10, 6056.47, -2025.2, 473.338, 'malmortis'),
(28948, 11, 6066.6, -2036.44, 473.745, 'malmortis'),(28948, 12, 6073.39, -2027.96, 473.338, 'malmortis'),(28948, 13, 6077.52, -2012.09, 461.492, 'malmortis'),(28948, 14, 6080.12, -1998.34, 461.311, 'malmortis'),(28948, 15, 6107.05, -2010.62, 461.307, 'malmortis'),
(28948, 16, 6154.38, -1982.7, 460.694, 'malmortis'),(28948, 17, 6188.35, -1979.59, 460.63, 'malmortis'),(28948, 18, 6220.27, -2003.44, 461.301, 'malmortis'),(28948, 19, 6258.04, -2034.15, 461.308, 'malmortis'),(28948, 20, 6271.21, -2036.64, 461.31, 'malmortis'),
(28948, 21, 6273.59, -2025.11, 461.31, 'malmortis'),(28948, 22, 6277.02, -2007.7, 473.337, 'malmortis'),(28948, 23, 6286.52, -1997.88, 473.806, 'malmortis'),(28948, 24, 6293.5, -2010.19, 473.337, 'malmortis'),(28948, 25, 6289.93, -2027.52, 485.363, 'malmortis');

-- Feedin' Da Goolz (12652)
UPDATE creature_template SET AIName='', ScriptName='npc_feedin_da_goolz', flags_extra=130 WHERE entry=28591;
DELETE FROM smart_scripts WHERE entryorguid=28591 AND source_type=0;

-- Gluttonous Lurkers (12527)
UPDATE creature_template SET AIName='SmartAI' WHERE entry=28202;
DELETE FROM smart_scripts WHERE source_type=0 AND entryorguid=28202;
INSERT INTO smart_scripts VALUES(28202, 0, 0, 0, 8, 0, 100, 0, 50926, 0, 1000, 1000, 41, 600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Zul''Drak Rat - Despawn on Spell Dummy');
UPDATE creature_template SET AIName='SmartAI' WHERE entry IN (28203,28145);
DELETE FROM smart_scripts WHERE entryorguid IN (28145,28203) AND source_type=0;
INSERT INTO smart_scripts VALUES(28145, 0, 0, 0, 0, 0, 100, 0, 5000, 5000, 17000, 27000, 11, 54470, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'In Combat - Cast Venemous Bite');
INSERT INTO smart_scripts VALUES(28145, 0, 1, 2, 23, 0, 100, 1, 50894, 5, 100, 200, 41, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On 5 stacks of 50894 - Despawn');
INSERT INTO smart_scripts VALUES(28145, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 50928, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Link With Event 1 - Summon Gorged Basilisk');
INSERT INTO smart_scripts VALUES(28203, 0, 0, 1, 8, 0, 100, 0, 50918, 0, 0, 0, 11, 50919, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Cast 50919 On Invoker');
INSERT INTO smart_scripts VALUES(28203, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Link With Event 0 - Despawn');
-- TC script remove
DELETE FROM spell_script_names WHERE spell_id=50894;

-- Tails Up (13549)
DELETE FROM creature_text WHERE entry=29327;
INSERT INTO creature_text VALUES(29327, 0, 0, 'It''s an angry male!', 42, 0, 100, 0, 0, 0, 0, 'Frost Leopard');
INSERT INTO creature_text VALUES(29327, 1, 0, 'It''s a female.', 42, 0, 100, 0, 0, 0, 0, 'Frost Leopard');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(29327, 33010);
UPDATE creature SET spawndist=0, MovementType=0 WHERE id=29327;
DELETE FROM smart_scripts WHERE entryorguid IN(29327, 33010) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN (2932700, 2932701, 2932702, 2932703) AND source_type=9;
INSERT INTO smart_scripts VALUES (33010, 0, 0, 1, 60, 0, 100, 257, 0, 0, 0, 0, 29, 3, 180, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Female Frost Leopard - On Update - Set Follow');
INSERT INTO smart_scripts VALUES (33010, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 60000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Female Frost Leopard - On Update - Despawn');
INSERT INTO smart_scripts VALUES (29327, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 8000, 11000, 11, 54668, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Frost Leopard - In Combat - Cast Rake');
INSERT INTO smart_scripts VALUES (29327, 0, 1, 2, 25, 0, 100, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frost Leopard - On Reset - Set Faction Back');
INSERT INTO smart_scripts VALUES (29327, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frost Leopard - On Reset - Set Phase');
INSERT INTO smart_scripts VALUES (29327, 0, 3, 0, 8, 1, 100, 1, 62105, 0, 0, 0, 80, 2932700, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frost Leopard - On Spellhit - Run Script');
INSERT INTO smart_scripts VALUES (29327, 0, 4, 6, 62, 0, 100, 0, 54000, 0, 0, 0, 88, 2932701, 2932702, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frost Leopard - On Gossip Select - Run Random Script');
INSERT INTO smart_scripts VALUES (29327, 0, 5, 0, 4, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frost Leopard - On Aggro - Set Phase');
INSERT INTO smart_scripts VALUES (29327, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frost Leopard - Linked - Remove all auras');
INSERT INTO smart_scripts VALUES (2932700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 52742, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frost Leopard - On Script - Cast Sleep');
INSERT INTO smart_scripts VALUES (2932700, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frost Leopard - On Script - Set Faction Friendly');
INSERT INTO smart_scripts VALUES (2932700, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frost Leopard - On Script - Set npc_flag Gossip');
INSERT INTO smart_scripts VALUES (2932701, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frost Leopard - On Script 1 - Say Line 0');
INSERT INTO smart_scripts VALUES (2932701, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frost Leopard - On Script 1 - Restore Faction');
INSERT INTO smart_scripts VALUES (2932701, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 28, 52742, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frost Leopard - On Script 1 - Remove Aura');
INSERT INTO smart_scripts VALUES (2932701, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 20, 0, 0, 0, 0, 0, 0, 'Frost Leopard - On Script 1 - Attack Start');
INSERT INTO smart_scripts VALUES (2932702, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 33, 33005, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Frost Leopard - On Script 2 - Quest Credit');
INSERT INTO smart_scripts VALUES (2932702, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frost Leopard - On Script 2 - Say Line 1');
INSERT INTO smart_scripts VALUES (2932702, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 62108, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frost Leopard - On Script 2 - Cast Tails up: Summon Female Frost Leopard');
INSERT INTO smart_scripts VALUES (2932702, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frost Leopard - On Script 2 - Forced Despawn');
DELETE FROM creature_text WHERE entry=29319;
INSERT INTO creature_text VALUES(29319, 0, 0, 'It''s an angry male!', 42, 0, 100, 0, 0, 0, 0, 'Icepaw Bear');
INSERT INTO creature_text VALUES(29319, 1, 0, 'It''s a female.', 42, 0, 100, 0, 0, 0, 0, 'Icepaw Bear');
UPDATE creature_template SET unit_flags=0, AIName='SmartAI', ScriptName='' WHERE entry IN(29319, 33010);
UPDATE creature SET spawndist=0, MovementType=0 WHERE id=29319;
DELETE FROM smart_scripts WHERE entryorguid IN(29319, 33011) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN (2931900, 2931901, 2931902, 2931903) AND source_type=9;
INSERT INTO smart_scripts VALUES (33011, 0, 0, 1, 60, 0, 100, 257, 0, 0, 0, 0, 29, 3, 180, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Female Icepaw Bear - On Update - Set Follow');
INSERT INTO smart_scripts VALUES (33011, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 60000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Female Icepaw Bear - On Update - Despawn');
INSERT INTO smart_scripts VALUES (29319, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 8000, 11000, 11, 54632, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Icepaw Bear - In Combat - Cast Claws of Ice');
INSERT INTO smart_scripts VALUES (29319, 0, 1, 2, 25, 0, 100, 0, 0, 0, 0, 0, 2, 1990, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Icepaw Bear - On Reset - Set Faction Back');
INSERT INTO smart_scripts VALUES (29319, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Icepaw Bear - On Reset - Set Phase');
INSERT INTO smart_scripts VALUES (29319, 0, 3, 0, 8, 1, 100, 1, 62105, 0, 0, 0, 80, 2931900, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Icepaw Bear - On Spellhit - Run Script');
INSERT INTO smart_scripts VALUES (29319, 0, 4, 6, 62, 0, 100, 0, 55000, 0, 0, 0, 88, 2931901, 2931902, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Icepaw Bear - On Gossip Select - Run Random Script');
INSERT INTO smart_scripts VALUES (29319, 0, 5, 0, 4, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Icepaw Bear - On Aggro - Set Phase');
INSERT INTO smart_scripts VALUES (29319, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Icepaw Bear - Linked - Remove all auras');
INSERT INTO smart_scripts VALUES (2931900, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 52742, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Icepaw Bear - On Script - Cast Sleep');
INSERT INTO smart_scripts VALUES (2931900, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Icepaw Bear - On Script - Set Faction Friendly');
INSERT INTO smart_scripts VALUES (2931900, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Icepaw Bear - On Script - Set npc_flag Gossip');
INSERT INTO smart_scripts VALUES (2931901, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Icepaw Bear - On Script 1 - Say Line 0');
INSERT INTO smart_scripts VALUES (2931901, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Icepaw Bear - On Script 1 - Restore Faction');
INSERT INTO smart_scripts VALUES (2931901, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 28, 52742, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Icepaw Bear - On Script 1 - Remove Aura');
INSERT INTO smart_scripts VALUES (2931901, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 20, 0, 0, 0, 0, 0, 0, 'Icepaw Bear - On Script 1 - Attack Start');
INSERT INTO smart_scripts VALUES (2931902, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 33, 33006, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Icepaw Bear - On Script 2 - Quest Credit');
INSERT INTO smart_scripts VALUES (2931902, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Icepaw Bear - On Script 2 - Say Line 1');
INSERT INTO smart_scripts VALUES (2931902, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 62116, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Icepaw Bear - On Script 2 - Cast Tails up: Summon Female Icepaw Bear');
INSERT INTO smart_scripts VALUES (2931902, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Icepaw Bear - On Script 2 - Forced Despawn');

-- In Search Of Answers (12902)
UPDATE gameobject_template SET flags=0 WHERE entry=191766;

-- Betrayal (12713)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=51966;
INSERT INTO conditions VALUES (17, 0, 51966, 0, 0, 29, 0, 28998, 70, 0, 1, 60, 0, '', 'Requires no npc in range');
DELETE FROM creature WHERE id=28750 AND position_z>570; -- mobs which shouldnt be there
DELETE FROM creature WHERE guid=98865 AND id=28960;
UPDATE creature_template SET AIName='SmartAI' WHERE entry=28503;
DELETE FROM smart_scripts WHERE entryorguid=28503 AND source_type=0;
INSERT INTO smart_scripts VALUES (28503, 0, 0, 0, 62, 0, 100, 0, 9731, 0, 0, 0, 11, 52863, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Select - Cast at Invoker');
REPLACE INTO spell_target_position VALUES(52863, 0, 571, 6153.85, -2013.47, 590.88, 0);
DELETE FROM creature WHERE id=28998;
INSERT INTO creature VALUES(NULL, 28998, 571, 1, 1, 0, 0, 6173.8, -2018.22, 590.879, 2.96344, 300, 0, 0, 550001, 0, 0, 0, 0, 0);
UPDATE creature_template SET unit_flags=4, faction=974, AIName='', ScriptName='npc_overlord_drakuru_betrayal' WHERE entry=28998;
REPLACE INTO creature_model_info VALUES(28126, 1, 3, 0, 0);
UPDATE creature_template SET unit_flags=0, spell1=54135, spell2=54132, spell3=54136, AIName='PassiveAI' WHERE entry=28931;
DELETE FROM spell_linked_spell WHERE spell_trigger=-52010;
INSERT INTO spell_linked_spell VALUES(-52010, -51966, 0, 'Remove Scourge Disguise');
DELETE FROM creature_text WHERE entry=28998;
INSERT INTO creature_text VALUES(28998, 0, 0, "Behold, mon! We be creatin' da greatest Scourge army ever seen!", 12, 0, 100, 0, 0, 14023, 0, 'Overlord Drakuru, Betrayal');
INSERT INTO creature_text VALUES(28998, 1, 0, "These be da first of many! We shall sweep across Zul'Drak like da wind....", 12, 0, 100, 0, 0, 14024, 0, 'Overlord Drakuru, Betrayal');
INSERT INTO creature_text VALUES(28998, 2, 0, "Disguise Failing! Avoid Scourge Contact!", 41, 0, 100, 0, 0, 0, 0, 'Overlord Drakuru, Betrayal');
INSERT INTO creature_text VALUES(28998, 3, 0, "What treachery is this?! You be payin' for this deceit with your life, mon!", 12, 0, 100, 0, 0, 14025, 0, 'Overlord Drakuru, Betrayal');
INSERT INTO creature_text VALUES(28998, 4, 0, "Your betrayal not gunna be slowin' me down none, mon.", 14, 0, 100, 0, 0, 14030, 0, 'Overlord Drakuru, Betrayal');
INSERT INTO creature_text VALUES(28998, 4, 1, "Ya done turned your back on destiny, mon. Now you gonna die!", 14, 0, 100, 0, 0, 14029, 0, 'Overlord Drakuru, Betrayal');
INSERT INTO creature_text VALUES(28998, 4, 2, "I never needed ya, mon. I can crush Zul'Drak without ya!", 14, 0, 100, 0, 0, 14031, 0, 'Overlord Drakuru, Betrayal');
INSERT INTO creature_text VALUES(28998, 4, 3, "Fool! Ya coulda been havin' great power, mon!", 14, 0, 100, 0, 0, 14026, 0, 'Overlord Drakuru, Betrayal');
INSERT INTO creature_text VALUES(28998, 4, 4, "How could dis be? Da Lich King said he be havin' great plans for you, mon...", 14, 0, 100, 0, 0, 14027, 0, 'Overlord Drakuru, Betrayal');
INSERT INTO creature_text VALUES(28998, 4, 5, "I shoulda known not to be trustin' nobody!", 14, 0, 100, 0, 0, 14028, 0, 'Overlord Drakuru, Betrayal');
INSERT INTO creature_text VALUES(28998, 5, 0, "ENOUGH!", 14, 0, 100, 0, 0, 14020, 0, 'Overlord Drakuru, Betrayal');
INSERT INTO creature_text VALUES(28998, 6, 0, "Dis foolish treachery has cost ya your destiny!", 14, 0, 100, 0, 0, 14021, 0, 'Overlord Drakuru, Betrayal');
INSERT INTO creature_text VALUES(28998, 7, 0, "Master, dis mortal scum be double-crossin' us. Dey must be made to suffer!", 12, 0, 100, 0, 0, 14022, 0, 'Overlord Drakuru, Betrayal');
-- Lich King used in Cleansing Drak'Tharon (12238) quest also
DELETE FROM conditions WHERE SourceEntry=28498 AND SourceTypeOrReferenceId=22;
INSERT INTO conditions VALUES(22, 1, 28498, 0, 0, 29, 0, 28998, 100, 0, 1, 0, 0, '', 'Only execute SAI if no npc nearby');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(54209);
INSERT INTO conditions VALUES (13, 1, 54209, 0, 0, 31, 0, 3, 28960, 0, 0, 0, 0, '', '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(54236);
INSERT INTO conditions VALUES (13, 1, 54236, 0, 0, 31, 0, 3, 28998, 0, 0, 0, 0, '', '');
DELETE FROM creature_text WHERE entry=28498 AND groupid>=7;
INSERT INTO creature_text VALUES(28498, 7, 0, "You have failed me, Drakuru!", 12, 0, 100, 0, 0, 14762, 0, 'Lich King, Betrayal');
INSERT INTO creature_text VALUES(28498, 8, 0, "It is you who should suffer. Be content that your death is a quick one....", 12, 0, 100, 0, 0, 14763, 0, 'Lich King, Betrayal');
INSERT INTO creature_text VALUES(28498, 9, 0, "As for you...", 12, 0, 100, 0, 0, 14764, 0, 'Lich King, Betrayal');
INSERT INTO creature_text VALUES(28498, 10, 0, "I spare your insignificant life as a reward for this amusing betrayal. There may yet be a shred of potential in you.", 12, 0, 100, 0, 0, 14765, 0, 'Lich King, Betrayal');
INSERT INTO creature_text VALUES(28498, 11, 0, "Be warned...", 12, 0, 100, 0, 0, 14766, 0, 'Lich King, Betrayal');
INSERT INTO creature_text VALUES(28498, 12, 0, "When next we meet I shall require much more to justify your life.", 12, 0, 100, 0, 0, 14767, 0, 'Lich King, Betrayal');

-- Cleansing Drak'Tharon (12238)
UPDATE smart_scripts SET target_type=1 WHERE entryorguid=2849800 AND target_type=23;

-- Wooly Justice (12707)
UPDATE creature_template SET AIName='SmartAI', spell1=52601, spell2=52603 WHERE entry=28851;
DELETE FROM smart_scripts WHERE entryorguid=28851 AND source_type=0;
INSERT INTO smart_scripts VALUES (28851, 0, 0, 0, 8, 0, 100, 0, 52596, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,  'Enraged Mammoth - On hit by spell from medallion - Change faction to friendly');
INSERT INTO smart_scripts VALUES (28851, 0, 1, 0, 1, 0, 100, 0, 10000, 10000, 10000, 10000, 2, 1924, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,  'Enraged Mammoth - On OOC for 10 sec - Change faction to back to normal');
UPDATE creature_template SET AIName='SmartAI' WHERE entry=28861;
DELETE FROM smart_scripts WHERE entryorguid=28861 AND source_type=0;
INSERT INTO smart_scripts VALUES (28861, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 33, 28876, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0,  'Mam''toth desciple - On death - Give credit to invoker,  if Tampered');
INSERT INTO smart_scripts VALUES (28861, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 28, 52607, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,  'Mam''toth desciple - On reset - Remove aura from trample');
DELETE FROM conditions WHERE SourceEntry=52596 AND SourceTypeOrReferenceId=17;
INSERT INTO conditions VALUES (17, 0, 52596, 0, 0, 31, 1, 3, 28851, 0, 0, 0, 0, '',  'Medallion of Mam''toth can hit only Enraged Mammoths');
DELETE FROM conditions WHERE SourceEntry=52603 AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES (13, 1, 52603, 0, 0, 31, 0, 3, 28861, 0, 0, 0, 0, '',  'Trample effect 1 can hit only hit Desciple of Mam''toth');
INSERT INTO conditions VALUES (13, 2, 52603, 0, 0, 31, 0, 3, 28861, 0, 0, 0, 0, '',  'Trample effect 2 can hit only hit Desciple of Mam''toth');
DELETE FROM conditions WHERE SourceEntry=28861 AND SourceTypeOrReferenceId=22;
INSERT INTO conditions VALUES (22, 1, 28861, 0, 0, 1, 1, 52607, 0, 0, 0, 0, 0, '',  'Mam''toth desciple 1st event is valid only,  if has Tampered aura credit');
DELETE FROM conditions WHERE SourceEntry=52607 AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES (13, 1, 52607, 0, 0, 31, 0, 3, 28861, 0, 0, 0, 0, '',  'TAura effect can hit only Desciple of Mam''toth');

-- Bringing Down Heb'Jin (12662)
DELETE FROM event_scripts WHERE id=18773;
DELETE FROM creature WHERE guid=117079 AND id=28636;
INSERT INTO creature VALUES (117079, 28636, 571, 1, 1, 0, 0, 5988.72, -3878.04, 417.15, 2.35619, 300, 0, 0, 11379, 0, 0, 0, 0, 0);
DELETE FROM creature WHERE guid=117301 AND id=28639;
INSERT INTO creature VALUES (117301, 28639, 571, 1, 1, 0, 0, 5984.55, -3882.62, 417.438, 1.91986, 300, 0, 0, 11379, 0, 0, 0, 0, 0);
DELETE FROM creature_text WHERE entry=28636;
INSERT INTO creature_text VALUES(28636, 0, 0, "Who's that beatin' on my drum?", 14, 0, 100, 0, 0, 0, 0, "Heb'Jin");
INSERT INTO creature_text VALUES(28636, 1, 0, "I'm gonna come down there and kill you good, $r", 14, 0, 100, 0, 0, 0, 0, "Heb'Jin");
INSERT INTO creature_text VALUES(28636, 2, 0, "Now you gonna die!", 14, 0, 100, 0, 0, 0, 0, "Heb'Jin");
UPDATE gameobject_template SET AIName='SmartGameObjectAI' WHERE entry=190695;
DELETE FROM smart_scripts WHERE entryorguid=190695 AND source_type=1;
INSERT INTO smart_scripts VALUES(190695, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 117301, 28639, 0, 0, 0, 0, 0, 'On Gossip Hello - Set Data');
UPDATE creature_template SET AIName='SmartAI' WHERE entry=28636;
REPLACE INTO creature_template_addon VALUES(28639, 0, 0, 50331648, 0, 0, '');
UPDATE creature_template SET speed_run=2, InhabitType=4, AIName='SmartAI' WHERE entry=28639;
DELETE FROM smart_scripts WHERE entryorguid IN(28636, 28639) AND source_type=0;
INSERT INTO smart_scripts VALUES(28636, 0, 0, 0, 0, 0, 100, 0, 5000, 5000, 15000, 15000, 11, 12734, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES(28636, 0, 1, 0, 0, 0, 100, 0, 2000, 2000, 13000, 13000, 11, 15548, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES(28636, 0, 2, 0, 0, 0, 100, 0, 9000, 9000, 10000, 10000, 11, 12555, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES(28636, 0, 3, 0, 38, 0, 100, 1, 1, 2, 0, 0, 1, 1, 0, 0, 0, 0, 0, 18, 150, 0, 0, 0, 0, 0, 0, 'On Data Set - Talk');
INSERT INTO smart_scripts VALUES(28636, 0, 4, 5, 38, 0, 100, 1, 1, 3, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Talk');
INSERT INTO smart_scripts VALUES(28636, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'On Data Set - Attack Start');
INSERT INTO smart_scripts VALUES(28636, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Set Home Position');
INSERT INTO smart_scripts VALUES(28636, 0, 7, 0, 7, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 5988.72, -3878.04, 417.15, 2.35619, 'On Evade - Set Home Position');
INSERT INTO smart_scripts VALUES(28639, 0, 0, 0, 38, 0, 100, 1, 1, 1, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Set Phase');
INSERT INTO smart_scripts VALUES(28639, 0, 1, 0, 60, 1, 100, 1, 500, 500, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 28636, 20, 0, 0, 0, 0, 0, 'On Update - Talk');
INSERT INTO smart_scripts VALUES(28639, 0, 2, 0, 60, 1, 100, 1, 5000, 5000, 0, 0, 45, 1, 2, 0, 0, 0, 0, 19, 28636, 20, 0, 0, 0, 0, 0, 'On Update - Set Data');
INSERT INTO smart_scripts VALUES(28639, 0, 3, 0, 60, 1, 100, 1, 6000, 6000, 0, 0, 86, 46598, 0, 19, 28636, 20, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Cross Cast');
INSERT INTO smart_scripts VALUES(28639, 0, 4, 0, 60, 1, 100, 1, 8000, 8000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 5926, -3813, 363, 0, 'On Update - Move To Pos');
INSERT INTO smart_scripts VALUES(28639, 0, 5, 0, 60, 1, 100, 1, 21000, 21000, 0, 0, 45, 1, 3, 0, 0, 0, 0, 19, 28636, 20, 0, 0, 0, 0, 0, 'On Update - Set Data');
INSERT INTO smart_scripts VALUES(28639, 0, 6, 7, 60, 1, 100, 1, 23000, 23000, 0, 0, 28, 46598, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Remove Aura');
INSERT INTO smart_scripts VALUES(28639, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'On Update - Attack Start');
INSERT INTO smart_scripts VALUES(28639, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Set Home Position');
INSERT INTO smart_scripts VALUES(28639, 0, 9, 0, 7, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 5984.55, -3882.62, 417.438, 1.91986, 'On Evade - Set Home Position');

-- Foundation for Revenge (12668)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=52242;
INSERT INTO conditions VALUES (13, 1, 52242, 0, 0, 31, 0, 3, 28724, 0, 0, 0, 0, '', '');
DELETE FROM smart_scripts WHERE entryorguid IN(28747, 28748) AND source_type=0;
INSERT INTO smart_scripts VALUES (28747, 0, 0, 0, 0, 0, 100, 0, 6000, 15000, 15000, 20000, 11, 54601, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cast Serpent Form on self');
INSERT INTO smart_scripts VALUES (28747, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 54594, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Cast Serpent Strike on victim');
INSERT INTO smart_scripts VALUES (28747, 0, 2, 3, 6, 0, 100, 0, 0, 0, 0, 0, 33, 28713, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Killmonster credit on kill');
INSERT INTO smart_scripts VALUES (28747, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 52242, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cast spell linked');
INSERT INTO smart_scripts VALUES (28748, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 54594, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Cast Serpent Strike on victim');
INSERT INTO smart_scripts VALUES (28748, 0, 2, 3, 6, 0, 100, 0, 0, 0, 0, 0, 33, 28713, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Killmonster credit on kill');
INSERT INTO smart_scripts VALUES (28748, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 52242, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cast spell linked');
DELETE FROM conditions WHERE SourceEntry IN(28747, 28748) AND SourceTypeOrReferenceId=22;
INSERT INTO conditions VALUES(22, 3, 28747, 0, 0, 1, 1, 52222, 0, 0, 0, 0, 0, '', 'Only execute SAI if me has Aura 52222');
INSERT INTO conditions VALUES(22, 3, 28748, 0, 0, 1, 1, 52222, 0, 0, 0, 0, 0, '', 'Only execute SAI if me has Aura 52222');

-- The Champion of Anguish (12948)
REPLACE INTO smart_scripts VALUES (30022, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 15, 12948, 0, 0, 0, 0, 0, 18, 50, 0, 0, 0, 0, 0, 0, "Vladof the Butcher - On Just Died - Quest Credit 'The Champion of Anguish' (No Repeat)");

-- You Can Run, But You Can't Hide (12629)
DELETE FROM npc_spellclick_spells WHERE npc_entry=29856;
INSERT INTO npc_spellclick_spells VALUES (29856, 55364, 1, 0);
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=29856;
DELETE FROM smart_scripts WHERE entryorguid=29856 AND source_type=0;
INSERT INTO smart_scripts VALUES (29856, 0, 0, 1, 8, 0, 100, 0, 55364, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Gooey Ghoul Drool - On Spellhit 'Create Ghoul Drool Cover' - Despawn Instant");
INSERT INTO smart_scripts VALUES (29856, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 85, 55363, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Gooey Ghoul Drool - On Spellhit 'Create Ghoul Drool Cover' - Invoker Cast");

-- Zero Tolerance (12686)
UPDATE creature_template SET AIName='SmartAI' WHERE entry=28802;
DELETE FROM smart_scripts WHERE source_type=0 AND entryorguid=28802;
INSERT INTO smart_scripts VALUES (28802, 0, 0, 0, 0, 0, 100, 0, 4000, 4800, 12000, 14000, 11, 50361, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Servant of Drakuru - IC - Cast Rot Armor');
INSERT INTO smart_scripts VALUES (28802, 0, 1, 2, 29, 0, 100, 0, 0, 0, 0, 0, 67, 1, 180000, 180000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ' Servant of Drakuru - On charm - Run Timed Event');
INSERT INTO smart_scripts VALUES (28802, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 36, 28805, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ' Servant of Drakuru - On charm - Update entry Self');
INSERT INTO smart_scripts VALUES (28802, 0, 3, 0, 59, 0, 100, 0, 1, 0, 0, 0, 36, 28802, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ' Hand of Drakuru - On Timed Event - Update entry');
UPDATE creature_model_info SET bounding_radius=1.24, combat_reach=4 WHERE modelid=26924;
UPDATE creature_template SET faction=42, AIName='' WHERE entry=28805;
DELETE FROM smart_scripts WHERE source_type=0 AND entryorguid=28805;

-- The Storm King's Vengeance (12919)
DELETE FROM smart_scripts WHERE entryorguid IN(29884, 29647) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(29647*100) AND source_type=9;
INSERT INTO smart_scripts VALUES (29647, 0, 0, 1, 62, 0, 100, 0, 9852, 2, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Gymer - On Gossip Option Select - Close Gossip');
INSERT INTO smart_scripts VALUES (29647, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gymer - On Link - Say');
INSERT INTO smart_scripts VALUES (29647, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 85, 55568, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Gymer - On Link - Invoker Cast');
INSERT INTO smart_scripts VALUES (29647, 0, 3, 0, 1, 0, 100, 0, 10000, 20000, 30000, 40000, 1, 1, 5000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gymer - OOC - Say Random');
INSERT INTO smart_scripts VALUES (29884, 0, 0, 1, 27, 0, 100, 1, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gymer - On Passenger boarded - Say');
INSERT INTO smart_scripts VALUES (29884, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gymer - On Link - Say');
INSERT INTO smart_scripts VALUES (29884, 0, 2, 0, 28, 0, 100, 1, 0, 0, 0, 0, 1, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gymer - On Passenger Removed - Say');
INSERT INTO smart_scripts VALUES (29884, 0, 3, 4, 54, 0, 100, 1, 0, 0, 0, 0, 11, 55461, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gymer - On Spawn - Cast Storm Aura');
INSERT INTO smart_scripts VALUES (29884, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gymer - On Spawn - Set React Passive');

-- The Amphitheater of Anguish: Yggdras! (12932)
-- The Amphitheater of Anguish: Yggdras! (12954)
DELETE FROM creature_queststarter WHERE quest=12954;
DELETE FROM creature_questender WHERE quest=12954;
INSERT INTO creature_queststarter VALUES (30007, 12954);
INSERT INTO creature_questender VALUES (30007, 12954);
UPDATE quest_template SET ExclusiveGroup=0 WHERE ExclusiveGroup=12932;
UPDATE quest_template SET PrevQuestId=12974 WHERE Id=12954;
DELETE FROM conditions WHERE SourceEntry IN(12932, 12954) AND SourceTypeOrReferenceId IN(19, 20);
INSERT INTO conditions VALUES(19, 0, 12932, 0, 0, 8, 0, 9977, 0, 0, 1, 0, 0, "", "The Amphitheater of Anguish: Yggdras! - Requires no The Ring of Blood: The Final Challenge");
INSERT INTO conditions VALUES(20, 0, 12932, 0, 0, 8, 0, 9977, 0, 0, 1, 0, 0, "", "The Amphitheater of Anguish: Yggdras! - Requires no The Ring of Blood: The Final Challenge");

-- Defending Your Title (13423)
-- Taking on All Challengers (12971)
UPDATE creature_template SET faction=2109 WHERE entry=30012;

-- I Sense a Disturbance (12665)
UPDATE smart_scripts SET action_param2=2 WHERE entryorguid=28401 AND action_type=11 AND action_param1=52187;

-- The Key of Warlord Zol'Maz (12712)
UPDATE creature_template SET flags_extra=0, AIName='SmartAI', ScriptName='' WHERE entry=28927;
DELETE FROM smart_scripts WHERE entryorguid IN(28927, 28902) AND source_type=0;
INSERT INTO smart_scripts VALUES (28927, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Enchanted Tiki Dervish - On Just Summoned - Store Targetlist');
INSERT INTO smart_scripts VALUES (28927, 0, 1, 2, 60, 0, 100, 257, 2000, 2000, 0, 0, 45, 0, 1, 0, 0, 0, 0, 19, 28902, 50, 0, 0, 0, 0, 0, 'Enchanted Tiki Dervish - On Update - Set Data 0 1');
INSERT INTO smart_scripts VALUES (28927, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 28902, 50, 0, 0, 0, 0, 0, 'Enchanted Tiki Dervish - On Update - Send Target 1');
INSERT INTO smart_scripts VALUES (28927, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 3, 0, 25749, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Enchanted Tiki Dervish - On Update - Morph To Model 25749');
INSERT INTO smart_scripts VALUES (28902, 0, 0, 0, 38, 0, 100, 0, 0, 1, 0, 0, 1, 1, 7000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Warlord Zol''Maz - On Data Set 0 1 - Say Line 1');
INSERT INTO smart_scripts VALUES (28902, 0, 1, 2, 52, 0, 100, 0, 1, 28902, 0, 0, 1, 2, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Warlord Zol''Maz - On Text 1 Over - Say Line 2');
INSERT INTO smart_scripts VALUES (28902, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Warlord Zol''Maz - On Text 1 Over - Remove Unit Flags');
INSERT INTO smart_scripts VALUES (28902, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Warlord Zol''Maz - On Text 1 Over - Start Attacking');
INSERT INTO smart_scripts VALUES (28902, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 14, 57571, 190784, 1, 0, 0, 0, 0, 'Warlord Zol''Maz - On Text 1 Over - Set Gameobject State');
INSERT INTO smart_scripts VALUES (28902, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 131, 1, 0, 0, 0, 0, 0, 14, 57571, 190784, 1, 0, 0, 0, 0, 'Warlord Zol''Maz - On Just Died - Set Gameobject State');
INSERT INTO smart_scripts VALUES (28902, 0, 6, 0, 25, 0, 100, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Warlord Zol''Maz - On Reset - Set Unit Flags');
INSERT INTO smart_scripts VALUES (28902, 0, 7, 0, 21, 0, 100, 0, 0, 0, 0, 0, 131, 1, 0, 0, 0, 0, 0, 14, 57571, 190784, 1, 0, 0, 0, 0, 'Warlord Zol''Maz - On Reached Home - Set Gameobject State');
INSERT INTO smart_scripts VALUES (28902, 0, 10, 0, 9, 0, 100, 0, 8, 25, 0, 0, 11, 32323, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Warlord Zol''Maz - Within Range 8-25yd - Cast Charge');
INSERT INTO smart_scripts VALUES (28902, 0, 11, 12, 2, 0, 100, 1, 0, 20, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Warlord Zol''Maz - Between 0-20% Health - Cast Enrage');
INSERT INTO smart_scripts VALUES (28902, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Warlord Zol''Maz - Between 0-20% Health - Say Line 0');
INSERT INTO smart_scripts VALUES (28902, 0, 13, 0, 0, 0, 100, 0, 12000, 12000, 20000, 20000, 11, 54670, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Warlord Zol''Maz - In Combat - Cast Decapitate');
INSERT INTO smart_scripts VALUES (28902, 0, 14, 0, 2, 0, 100, 1, 0, 35, 0, 0, 11, 40546, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Warlord Zol''Maz - Between Health 0-35% - Cast Retaliation');
