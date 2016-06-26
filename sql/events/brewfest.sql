REPLACE INTO game_event VALUES(24, "2014-09-21 00:01:00", "2020-12-31 06:00:00", 525600, 21600, 372, "Brewfest", 0);
-- QUEST
-- Chug and Chuck! (12022)
-- Chug and Chuck! (12191)
UPDATE creature_template SET AIName='SmartAI' WHERE entry=24108;
DELETE FROM smart_scripts WHERE entryorguid IN(24108) AND source_type=0;
INSERT INTO smart_scripts VALUES(24108, 0, 0, 0, 8, 0, 100, 0, 42436, 0, 0, 0, 33, 24108, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Spell Hit - Kill Credit");
-- Catch the Wild Wolpertinger! (11117)
-- Catch the Wild Wolpertinger! (11431)
DELETE FROM creature_queststarter WHERE quest IN(11117, 11431);
DELETE FROM creature_questender WHERE quest IN(11117, 11431);
DELETE FROM game_event_creature_quest WHERE quest IN(11117, 11431);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=41621;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=18 AND SourceEntry=32907;
DELETE FROM spell_script_names WHERE spell_id IN(41621);
INSERT INTO spell_script_names VALUES(41621, "spell_q11117_catch_the_wild_wolpertinger");
UPDATE creature_template SET AIName="SmartAI" WHERE entry=23487;
DELETE FROM smart_scripts WHERE entryorguid IN(23487) AND source_type=0;
INSERT INTO smart_scripts VALUES(23487, 0, 0, 1, 8, 0, 100, 0, 41621, 0, 0, 0, 56, 32906, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Add item on spell cast");
INSERT INTO smart_scripts VALUES(23487, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Forced Despawn linked");
INSERT INTO smart_scripts VALUES(23487, 0, 2, 0, 25, 0, 100, 0, 41621, 0, 0, 0, 11, 39707, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast spell on reset");
-- Pink Elekks On Parade (11120)
-- Pink Elekks On Parade (11118)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=41985;
INSERT INTO conditions VALUES (17, 0, 41985, 0, 0, 31, 1, 3, 23531, 0, 0, 0, 0, '', 'Brewfest - target pink elekk entry');
INSERT INTO conditions VALUES (17, 0, 41985, 0, 0, 36, 1, 0, 0, 0, 0, 0, 0, '', 'Brewfest - target pink elekk alive');
INSERT INTO conditions VALUES (17, 0, 41985, 0, 1, 31, 1, 3, 23529, 0, 0, 0, 0, '', 'Brewfest - target pink elekk entry');
INSERT INTO conditions VALUES (17, 0, 41985, 0, 1, 36, 1, 0, 0, 0, 0, 0, 0, '', 'Brewfest - target pink elekk alive');
INSERT INTO conditions VALUES (17, 0, 41985, 0, 2, 31, 1, 3, 23530, 0, 0, 0, 0, '', 'Brewfest - target pink elekk entry');
INSERT INTO conditions VALUES (17, 0, 41985, 0, 2, 36, 1, 0, 0, 0, 0, 0, 0, '', 'Brewfest - target pink elekk alive');
INSERT INTO conditions VALUES (17, 0, 41985, 0, 3, 31, 1, 3, 23527, 0, 0, 0, 0, '', 'Brewfest - target pink elekk entry');
INSERT INTO conditions VALUES (17, 0, 41985, 0, 3, 36, 1, 0, 0, 0, 0, 0, 0, '', 'Brewfest - target pink elekk alive');
INSERT INTO conditions VALUES (17, 0, 41985, 0, 4, 31, 1, 3, 23528, 0, 0, 0, 0, '', 'Brewfest - target pink elekk entry');
INSERT INTO conditions VALUES (17, 0, 41985, 0, 4, 36, 1, 0, 0, 0, 0, 0, 0, '', 'Brewfest - target pink elekk alive');
INSERT INTO conditions VALUES (17, 0, 41985, 0, 5, 31, 1, 3, 23507, 0, 0, 0, 0, '', 'Brewfest - target pink elekk entry');
INSERT INTO conditions VALUES (17, 0, 41985, 0, 5, 36, 1, 0, 0, 0, 0, 0, 0, '', 'Brewfest - target pink elekk alive');
UPDATE creature_template SET AIName="SmartAI" WHERE entry IN(23531, 23529, 23530, 23527, 23528, 23507);
DELETE FROM smart_scripts WHERE entryorguid IN(23531, 23529, 23530, 23527, 23528, 23507) AND source_type=0;
INSERT INTO smart_scripts VALUES(23531, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 36440, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Reset spell cast");
INSERT INTO smart_scripts VALUES(23531, 0, 1, 2, 8, 0, 100, 0, 44654, 0, 0, 0, 33, 23531, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Add item on spell cast");
INSERT INTO smart_scripts VALUES(23531, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Forced Despawn linked");
INSERT INTO smart_scripts VALUES(23529, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 36440, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Reset spell cast");
INSERT INTO smart_scripts VALUES(23529, 0, 1, 2, 8, 0, 100, 0, 44654, 0, 0, 0, 33, 23529, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Add item on spell cast");
INSERT INTO smart_scripts VALUES(23529, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Forced Despawn linked");
INSERT INTO smart_scripts VALUES(23530, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 36440, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Reset spell cast");
INSERT INTO smart_scripts VALUES(23530, 0, 1, 2, 8, 0, 100, 0, 44654, 0, 0, 0, 33, 23530, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Add item on spell cast");
INSERT INTO smart_scripts VALUES(23530, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Forced Despawn linked");
INSERT INTO smart_scripts VALUES(23527, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 36440, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Reset spell cast");
INSERT INTO smart_scripts VALUES(23527, 0, 1, 2, 8, 0, 100, 0, 44654, 0, 0, 0, 33, 23527, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Add item on spell cast");
INSERT INTO smart_scripts VALUES(23527, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Forced Despawn linked");
INSERT INTO smart_scripts VALUES(23528, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 36440, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Reset spell cast");
INSERT INTO smart_scripts VALUES(23528, 0, 1, 2, 8, 0, 100, 0, 44654, 0, 0, 0, 33, 23528, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Add item on spell cast");
INSERT INTO smart_scripts VALUES(23528, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Forced Despawn linked");
INSERT INTO smart_scripts VALUES(23507, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 36440, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Reset spell cast");
INSERT INTO smart_scripts VALUES(23507, 0, 1, 2, 8, 0, 100, 0, 44654, 0, 0, 0, 33, 23507, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Add item on spell cast");
INSERT INTO smart_scripts VALUES(23507, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Forced Despawn linked");
-- Now This is Ram Racing... Almost. (11318)
-- Now This is Ram Racing... Almost. (11409)
UPDATE quest_template SET SourceSpellId=43883 WHERE Id IN(11318, 11409);
DELETE FROM spell_script_names WHERE spell_id IN(42924, 43310, 42992, 42993, 42994, 43332, 43450);
INSERT INTO spell_script_names VALUES(43310, "spell_brewfest_main_ram_buff");
INSERT INTO spell_script_names VALUES(42992, "spell_brewfest_ram_fatigue");
INSERT INTO spell_script_names VALUES(42993, "spell_brewfest_ram_fatigue");
INSERT INTO spell_script_names VALUES(42994, "spell_brewfest_ram_fatigue");
INSERT INTO spell_script_names VALUES(43332, "spell_brewfest_ram_fatigue");
INSERT INTO spell_script_names VALUES(43450, "spell_brewfest_apple_trap");
-- There and Back Again (11412)
-- There and Back Again (11122)
-- Additional Work scripts
DELETE FROM creature WHERE id=24527;
INSERT INTO creature VALUES(240001, 24527, 1, 1, 1, 0, 0, 837.666, -4508.81, 6.14751, 0.401426, 120, 0, 0, 1003, 0, 0, 0, 0, 0);
DELETE FROM creature WHERE id=24364;
INSERT INTO creature VALUES(240002, 24364, 0, 1, 1, 0, 0, -5609.83, -459.056, 404.633, 5.3058, 120, 0, 0, 1003, 0, 0, 0, 0, 0);
REPLACE INTO game_event_creature VALUES(24, 240001);
REPLACE INTO game_event_creature VALUES(24, 240002);
UPDATE creature_template SET ScriptName="npc_brewfest_keg_thrower" WHERE entry IN(24527, 24364);
UPDATE creature_template SET unit_flags=4864, ScriptName="npc_brewfest_keg_reciver" WHERE entry IN(24497, 23558);
UPDATE creature SET spawntimesecs=300 WHERE id IN(24497, 23558);
UPDATE quest_template SET SourceSpellId=43883 WHERE Id IN(11412, 11122);
UPDATE quest_template SET SpecialFlags=0 WHERE Id=11122;
REPLACE INTO gameobject VALUES(240000, 186331, 0, 1, 1, -5505.47, -522.894, 398.064, 3.26363, 0, 0, 0.998139, -0.0609795, 300, 0, 1, 0);
REPLACE INTO game_event_gameobject VALUES(24, 240000);

-- Bark for Drohn's Distillery! (11407)
-- Bark for T'chali's Voodoo Brewery! (11408)
-- Bark for the Barleybrews! (11293)
-- Bark for the Thunderbrews! (11294)
UPDATE quest_template SET SourceSpellId=43883 WHERE Id IN(11407, 11408, 11293, 11294);
DELETE FROM creature WHERE id IN(24202, 24203, 24204, 24205);
INSERT INTO creature VALUES (240003, 24202, 0, 1, 1, 0, 0, -4916.68, -948.674, 501.512, 5.39792, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (240004, 24202, 1, 1, 1, 0, 0, 1634.64, -4404, 16.189, 6.247, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (240005, 24203, 0, 1, 1, 0, 0, -4970.77, -1209.34, 501.829, 4.54968, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (240006, 24203, 1, 1, 1, 0, 0, 1946.27, -4686.62, 25.4058, 5.20635, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (240007, 24204, 0, 1, 1, 0, 0, -4689.64, -1234.32, 501.659, 0.767981, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (240008, 24204, 1, 1, 1, 0, 0, 1930.64, -4292.17, 26.1137, 1.61315, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (240009, 24205, 0, 1, 1, 0, 0, -4663.33, -963.828, 500.375, 2.0796, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (240010, 24205, 1, 1, 1, 0, 0, 1576.72, -4196.79, 41.14, 2.08832, 300, 0, 0, 1, 0, 0, 0, 0, 0);
REPLACE INTO game_event_creature VALUES(24, 240003),(24, 240004),(24, 240005),(24, 240006),(24, 240007),(24, 240008),(24, 240009),(24, 240010);
UPDATE creature_template SET unit_flags=33554432, ScriptName="npc_brewfest_bark_trigger" WHERE entry IN(24202, 24203, 24204, 24205);
-- Add daily flag to daily quests
UPDATE quest_template SET SpecialFlags = 1 WHERE Id IN(11407, 11408, 11293, 11294, 12192, 12020);
-- Another Year, Another Souvenir.
-- Did Someone Say "Souvenir?"
-- Say, There Wouldn't Happen to be a Souvenir This Year, Would There?
REPLACE INTO game_event_creature VALUES(24, 152120);
DELETE FROM creature_queststarter WHERE quest IN(13931, 11413, 12194, 13932, 11321, 12193);
DELETE FROM creature_questender WHERE quest IN(13931, 11413, 12194, 13932, 11321, 12193);
DELETE FROM game_event_creature_quest WHERE quest IN(13931, 11413, 12194, 13932, 11321, 12193);
INSERT INTO game_event_creature_quest VALUES (24, 24495, 13931),(24, 23710, 13932);
INSERT INTO creature_questender VALUES(24495, 13931),(23710, 13932);



-- NPC
-- Coren Direbrew
DELETE FROM item_loot_template WHERE entry=54535;
INSERT INTO item_loot_template VALUES(54535, 49426, 100, 1, 1, 2, 2);
INSERT INTO item_loot_template VALUES(54535, 33977, 4, 1, 0, 1, 1);
INSERT INTO item_loot_template VALUES(54535, 37828, 4, 1, 0, 1, 1);
INSERT INTO item_loot_template VALUES(54535, 37863, 8, 1, 0, 1, 1);
INSERT INTO item_loot_template VALUES(54535, 48663, 8, 1, 0, 1, 1);
INSERT INTO item_loot_template VALUES(54535, 49120, 8, 1, 0, 1, 1);

DELETE FROM creature WHERE id=23872;
INSERT INTO creature VALUES(240000, 23872, 230, 1, 1, 0, 0, 881.614, -174.045, -43.9252, 5.25006, 7200, 0, 0, 160000, 0, 0, 0, 0, 0);
REPLACE INTO game_event_creature VALUES(24, 240000);
UPDATE creature_template SET ScriptName="npc_coren_direbrew", npcflag=3 WHERE entry=23872;
DELETE FROM creature_loot_template WHERE entry IN(26822, 26764);
UPDATE creature_template SET lootid=0, ScriptName="npc_coren_direbrew_sisters" WHERE entry IN(26822, 26764);
UPDATE quest_template SET Flags=136, specialFlags=25 WHERE Id=25483; -- df and seasonal
UPDATE quest_template SET PrevQuestId=0 WHERE Id IN(12491, 12492);
DELETE FROM creature_loot_template WHERE item IN(38280, 38281);
REPLACE INTO creature_loot_template VALUES(23872, 38280, 100, 1, 1, 1, 1);
REPLACE INTO creature_loot_template VALUES(23872, 38281, 100, 1, 2, 1, 1);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=1 AND SourceEntry IN(38280, 38281);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=47310;
INSERT INTO conditions VALUES (13, 5, 47310, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Coren\'s disarm, target players');
-- Month Club
DELETE FROM creature WHERE id IN(27478, 27489);
-- Ray'ma <Brew of the Month Club>
INSERT INTO creature VALUES(240013, 27489, 1, 1, 1, 0, 0, 1473.72, -4207.13, 42.959, 4.53175, 600, 0, 0, 2215, 0, 0, 0, 0, 0);
-- Larkin Thunderbrew <Brew of the Month Club>
INSERT INTO creature VALUES(240014, 27478, 0, 1, 1, 0, 1, -4847.09, -866.293, 501.923, 1.67552, 600, 0, 0, 2215, 0, 0, 0, 0, 0);
REPLACE INTO game_event_creature VALUES(24, 240013);
REPLACE INTO game_event_creature VALUES(24, 240014);


-- VENDORS
-- Blix Fixwidget <Token Redeemer> (24495)
REPLACE INTO npc_vendor VALUES(24495, 0, 46707, 0, 0, 2275);
REPLACE INTO npc_vendor VALUES(24495, 0, 37737, 0, 0, 2276);
REPLACE INTO npc_vendor VALUES(24495, 0, 37599, 0, 0, 2276);
REPLACE INTO npc_vendor VALUES(24495, 0, 33863, 0, 0, 2276);
REPLACE INTO npc_vendor VALUES(24495, 0, 33862, 0, 0, 2276);
-- Belbi Quikswitch <Token Redeemer> (23710)
REPLACE INTO npc_vendor VALUES(23710, 0, 46707, 0, 0, 2275);
REPLACE INTO npc_vendor VALUES(23710, 0, 37736, 0, 0, 2276);
REPLACE INTO npc_vendor VALUES(23710, 0, 32233, 0, 0, 0);

-- ITEMS
DELETE FROM spell_script_names WHERE spell_id=41920;
INSERT INTO spell_script_names VALUES(41920, "spell_brewfest_fill_keg");
DELETE FROM spell_script_names WHERE spell_id IN(41946, 41921, 41943, 41944, 41945);
INSERT INTO spell_script_names VALUES(41946, "spell_brewfest_unfill_keg");
INSERT INTO spell_script_names VALUES(41921, "spell_brewfest_unfill_keg");
INSERT INTO spell_script_names VALUES(41943, "spell_brewfest_unfill_keg");
INSERT INTO spell_script_names VALUES(41944, "spell_brewfest_unfill_keg");
INSERT INTO spell_script_names VALUES(41945, "spell_brewfest_unfill_keg");

-- EVENTS
-- Dark Iron Attack
DELETE FROM gameobject_questender WHERE id IN(189989, 189990);
DELETE FROM gameobject_queststarter WHERE id IN(189989, 189990);
REPLACE INTO gameobject_queststarter VALUES(189989, 12020);
REPLACE INTO gameobject_queststarter VALUES(189990, 12192);
UPDATE quest_template SET PrevQuestId=0 WHERE Id=12020;
DELETE FROM creature WHERE id=23703; -- dark iron event generator
INSERT INTO creature VALUES (240011, 23703, 0, 1, 1, 0, 0, -5159.52, -598.13, 398.138, 0.244922, 300, 0, 0, 37800, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (240012, 23703, 1, 1, 1, 0, 0, 1199.48, -4300.39, 21.3984, 4.88501, 300, 0, 0, 37800, 0, 0, 0, 0, 0);
REPLACE INTO game_event_creature VALUES(24, 240011);
REPLACE INTO game_event_creature VALUES(24, 240012);
UPDATE creature_template SET ScriptName="npc_dark_iron_attack_generator", modelid1=16925, modelid2=0 WHERE entry=23703;
DELETE FROM spell_script_names WHERE spell_id=42300;
INSERT INTO spell_script_names VALUES(42300, "spell_brewfest_add_mug");
DELETE FROM spell_script_names WHERE spell_id=42436;
INSERT INTO spell_script_names VALUES(42436, "spell_brewfest_toss_mug");
REPLACE INTO creature_template_addon VALUES(23700, 0, 0, 0, 4097, 0, "42761");
REPLACE INTO creature_template_addon VALUES(23702, 0, 0, 0, 4097, 0, "42761");
REPLACE INTO creature_template_addon VALUES(23706, 0, 0, 0, 4097, 0, "42761");
REPLACE INTO creature_template_addon VALUES(24372, 0, 0, 0, 4097, 0, "42761");
REPLACE INTO creature_template_addon VALUES(24373, 0, 0, 0, 4097, 0, "42761");
UPDATE creature_template SET minlevel=6, maxlevel=6, AIName="NullCreatureAI", RegenHealth=0, faction=35 WHERE entry IN(23700, 23702, 23706, 24372, 24373);
UPDATE creature_template SET modelid1=16925, modelid2=0, ScriptName="npc_dark_iron_attack_mole_machine" WHERE entry=23894;
UPDATE creature_template SET ScriptName="npc_dark_iron_guzzler", unit_flags=128+512, mechanic_immune_mask=650854267 WHERE entry=23709;
-- Attack Keg targets
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=42393;
INSERT INTO conditions VALUES (13, 1, 42393, 0, 0, 31, 0, 3, 23700, 0, 0, 0, 0, '', 'Brewfest Keg attack - target barrels');
INSERT INTO conditions VALUES (13, 1, 42393, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Brewfest Keg attack - target barrels');
INSERT INTO conditions VALUES (13, 1, 42393, 0, 1, 31, 0, 3, 23702, 0, 0, 0, 0, '', 'Brewfest Keg attack - target barrels');
INSERT INTO conditions VALUES (13, 1, 42393, 0, 1, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Brewfest Keg attack - target barrels');
INSERT INTO conditions VALUES (13, 1, 42393, 0, 2, 31, 0, 3, 23706, 0, 0, 0, 0, '', 'Brewfest Keg attack - target barrels');
INSERT INTO conditions VALUES (13, 1, 42393, 0, 2, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Brewfest Keg attack - target barrels');
INSERT INTO conditions VALUES (13, 1, 42393, 0, 3, 31, 0, 3, 24372, 0, 0, 0, 0, '', 'Brewfest Keg attack - target barrels');
INSERT INTO conditions VALUES (13, 1, 42393, 0, 3, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Brewfest Keg attack - target barrels');
INSERT INTO conditions VALUES (13, 1, 42393, 0, 4, 31, 0, 3, 24373, 0, 0, 0, 0, '', 'Brewfest Keg attack - target barrels');
INSERT INTO conditions VALUES (13, 1, 42393, 0, 4, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Brewfest Keg attack - target barrels');
-- Fix barrels collision
UPDATE gameobject_template SET ScriptName="" WHERE entry IN(186183, 186184, 186185, 186186, 186187);
-- Sampler targets (support for Chug and Chuck! quest)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=42436;
INSERT INTO conditions VALUES (13, 1, 42436, 0, 0, 31, 0, 3, 24108, 0, 0, 0, 0, '', 'Brewfest Keg attack - target sampler');
INSERT INTO conditions VALUES (13, 1, 42436, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Brewfest Keg attack - target sampler');
INSERT INTO conditions VALUES (13, 1, 42436, 0, 1, 31, 0, 3, 23709, 0, 0, 0, 0, '', 'Brewfest Keg attack - target sampler');
INSERT INTO conditions VALUES (13, 1, 42436, 0, 1, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Brewfest Keg attack - target sampler');
-- Knockback aura trigger
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=42674;
INSERT INTO conditions VALUES (13, 1, 42674, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Brewfest - knockback aura target players');
INSERT INTO conditions VALUES (13, 1, 42674, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Brewfest - knockback aura target players');
DELETE FROM spell_linked_spell WHERE spell_trigger=42674;
INSERT INTO spell_linked_spell VALUES(42674, 42299, 1, "Dark Iron knockback aura");
-- Report Death
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=42655;
INSERT INTO conditions VALUES (13, 1, 42655, 0, 0, 31, 0, 3, 23703, 0, 0, 0, 0, '', 'Brewfest - keg attack, report death');
INSERT INTO conditions VALUES (13, 1, 42655, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Brewfest - keg attack, report death');
-- Drunken Master
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=42695;
INSERT INTO conditions VALUES (13, 1, 42695, 0, 0, 31, 0, 3, 23709, 0, 0, 0, 0, '', 'Brewfest - drunken master');
INSERT INTO conditions VALUES (13, 1, 42695, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Brewfest - drunken master');
UPDATE creature_template SET ScriptName="npc_brewfest_super_brew_trigger", modelid1=16925, modelid2=0, flags_extra=130 WHERE entry=23808;
-- Dark Iron Herald
UPDATE creature_template SET AIName="SmartAI", ScriptName="", modelid1=16925, modelid2=0 WHERE entry=24536;
DELETE FROM creature_text WHERE entry=24536;
INSERT INTO creature_text VALUES(24536, 0, 0, "Oh, we're from Blackrock Mountain,", 12, 0, 100, 0, 0, 0, 0, "Dark Iron Herald - Brewfest Dark Iron Attack");
INSERT INTO creature_text VALUES(24536, 1, 0, "We've come ta drink yer brew!", 12, 0, 100, 0, 0, 0, 0, "Dark Iron Herald - Brewfest Dark Iron Attack");
INSERT INTO creature_text VALUES(24536, 2, 0, "Dark Iron dwarves, they do not lie,", 12, 0, 100, 0, 0, 0, 0, "Dark Iron Herald - Brewfest Dark Iron Attack");
INSERT INTO creature_text VALUES(24536, 3, 0, "And so yeh know it's true!", 12, 0, 100, 0, 0, 0, 0, "Dark Iron Herald - Brewfest Dark Iron Attack");
INSERT INTO creature_text VALUES(24536, 4, 0, "Yeh will not try our bitter,", 12, 0, 100, 0, 0, 0, 0, "Dark Iron Herald - Brewfest Dark Iron Attack");
INSERT INTO creature_text VALUES(24536, 5, 0, "Yeh will not serve our ale!", 12, 0, 100, 0, 0, 0, 0, "Dark Iron Herald - Brewfest Dark Iron Attack");
INSERT INTO creature_text VALUES(24536, 6, 0, "But have Brewfest without our lot?", 12, 0, 100, 0, 0, 0, 0, "Dark Iron Herald - Brewfest Dark Iron Attack");
INSERT INTO creature_text VALUES(24536, 7, 0, "Just try it, and ye'll fail!", 12, 0, 100, 0, 0, 0, 0, "Dark Iron Herald - Brewfest Dark Iron Attack");
INSERT INTO creature_text VALUES(24536, 8, 0, "So lift a mug to Coren,", 12, 0, 100, 0, 0, 0, 0, "Dark Iron Herald - Brewfest Dark Iron Attack");
INSERT INTO creature_text VALUES(24536, 9, 0, "And Hurley Blackbreath too!", 12, 0, 100, 0, 0, 0, 0, "Dark Iron Herald - Brewfest Dark Iron Attack");
INSERT INTO creature_text VALUES(24536, 10, 0, "This drink is weak, without much kick,", 12, 0, 100, 0, 0, 0, 0, "Dark Iron Herald - Brewfest Dark Iron Attack");
INSERT INTO creature_text VALUES(24536, 11, 0, "But oi! At least it's brew!", 12, 0, 100, 0, 0, 0, 0, "Dark Iron Herald - Brewfest Dark Iron Attack");
INSERT INTO creature_text VALUES(24536, 12, 0, "We'll drink yer stout and lager,", 12, 0, 100, 0, 0, 0, 0, "Dark Iron Herald - Brewfest Dark Iron Attack");
INSERT INTO creature_text VALUES(24536, 13, 0, "Drain all the pints and kegs!", 12, 0, 100, 0, 0, 0, 0, "Dark Iron Herald - Brewfest Dark Iron Attack");
INSERT INTO creature_text VALUES(24536, 14, 0, "We'll drink and brawl and brawl and drink,", 12, 0, 100, 0, 0, 0, 0, "Dark Iron Herald - Brewfest Dark Iron Attack");
INSERT INTO creature_text VALUES(24536, 15, 0, "'til we can't feel our legs!", 12, 0, 100, 0, 0, 0, 0, "Dark Iron Herald - Brewfest Dark Iron Attack");
INSERT INTO creature_text VALUES(24536, 16, 0, "And when the brew's all missin'", 12, 0, 100, 0, 0, 0, 0, "Dark Iron Herald - Brewfest Dark Iron Attack");
INSERT INTO creature_text VALUES(24536, 17, 0, "Ta Shadowforge we'll hop", 12, 0, 100, 0, 0, 0, 0, "Dark Iron Herald - Brewfest Dark Iron Attack");
INSERT INTO creature_text VALUES(24536, 18, 0, "A bitter toast ta Ragnaros...", 12, 0, 100, 0, 0, 0, 0, "Dark Iron Herald - Brewfest Dark Iron Attack");
INSERT INTO creature_text VALUES(24536, 19, 0, "... but bring him not a drop!", 12, 0, 100, 0, 0, 0, 0, "Dark Iron Herald - Brewfest Dark Iron Attack");

DELETE FROM smart_scripts WHERE entryorguid IN(24536) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(24536*100) AND source_type=9;
INSERT INTO smart_scripts VALUES(24536, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 80, 24536*100, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "run timed actionlist linked");
INSERT INTO smart_scripts VALUES(24536*100, 9, 0, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(24536*100, 9, 1, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(24536*100, 9, 2, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(24536*100, 9, 3, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(24536*100, 9, 4, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(24536*100, 9, 5, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(24536*100, 9, 6, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(24536*100, 9, 7, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(24536*100, 9, 8, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(24536*100, 9, 9, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(24536*100, 9, 10, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(24536*100, 9, 11, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(24536*100, 9, 12, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 12, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(24536*100, 9, 13, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 13, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(24536*100, 9, 14, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(24536*100, 9, 15, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(24536*100, 9, 16, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(24536*100, 9, 17, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 17, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(24536*100, 9, 18, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 18, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(24536*100, 9, 19, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 19, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text");

-- Achievements
REPLACE INTO achievement_reward VALUES(2796, 0, 0, 0, 27487, "Welcome to the Brew of the Month Club!", "$N,$B$BWelcome to the Brew of the Month club! This club is dedicated to bringing you some of the finest brew in all the realms.$B$BEvery month a new brew will be mailed directly to you. If you enjoy that brew and want more, talk to the Brew of the Month club members there.$B$BAgain, welcome to the club, $N.$B$B- Brew of the Month Club", 0);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(9859, 9860, 9861, 9862);
DELETE FROM disables WHERE sourceType=4 AND entry IN(9859, 9860, 9861, 9862);

-- Brew of the Month mail items
REPLACE INTO mail_loot_template VALUES(212, 37898, 100, 1, 0, 1, 1);
REPLACE INTO mail_loot_template VALUES(213, 37489, 100, 1, 0, 1, 1);
REPLACE INTO mail_loot_template VALUES(214, 37900, 100, 1, 0, 1, 1);
REPLACE INTO mail_loot_template VALUES(215, 37901, 100, 1, 0, 1, 1);
REPLACE INTO mail_loot_template VALUES(216, 37902, 100, 1, 0, 1, 1);
REPLACE INTO mail_loot_template VALUES(217, 37903, 100, 1, 0, 1, 1);
REPLACE INTO mail_loot_template VALUES(218, 37904, 100, 1, 0, 1, 1);
REPLACE INTO mail_loot_template VALUES(219, 37905, 100, 1, 0, 1, 1);
REPLACE INTO mail_loot_template VALUES(220, 37906, 100, 1, 0, 1, 1);
REPLACE INTO mail_loot_template VALUES(221, 37907, 100, 1, 0, 1, 1);
REPLACE INTO mail_loot_template VALUES(222, 37908, 100, 1, 0, 1, 1);
REPLACE INTO mail_loot_template VALUES(223, 37909, 100, 1, 0, 1, 1);

-- Cleanups
DELETE FROM creature WHERE id=27215 AND guid=200002; -- double spawn
