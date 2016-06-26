-- pvp titles, achievements (Challenger, Gladiator, Duelist, Rival)
DELETE FROM achievement_reward WHERE entry IN(2090, 2091, 2092, 2093);
-- delete reward by mail: merciless, vengeful, brutal, deadly, furious, relentless, wrathful
UPDATE achievement_reward SET title_A=0, title_H=0, item=0 WHERE entry IN(418, 419, 420, 3336, 3436, 3758, 4599);
DELETE FROM achievement_reward WHERE entry IN(418, 419, 420, 3336, 3436, 3758, 4599);

-- Challenger (2090)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7408, 9719, 9720, 13006, 9721, 13007, 10878);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7408, 9719, 9720, 13006, 9721, 13007, 10878);
INSERT INTO achievement_criteria_data VALUES(7408, 23, 42, 0, '');
INSERT INTO achievement_criteria_data VALUES(9719, 23, 43, 0, '');
INSERT INTO achievement_criteria_data VALUES(9720, 23, 44, 0, '');
INSERT INTO achievement_criteria_data VALUES(13006, 23, 45, 0, '');
INSERT INTO achievement_criteria_data VALUES(9721, 23, 167, 0, '');
INSERT INTO achievement_criteria_data VALUES(13007, 23, 169, 0, '');
INSERT INTO achievement_criteria_data VALUES(10878, 23, 177, 0, '');

-- Gladiator (2091)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7412, 10881, 12999, 13000);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7412, 10881, 12999, 13000);
INSERT INTO achievement_criteria_data VALUES(7412, 23, 42, 0, '');
INSERT INTO achievement_criteria_data VALUES(10881, 23, 167, 0, '');
INSERT INTO achievement_criteria_data VALUES(12999, 23, 169, 0, '');
INSERT INTO achievement_criteria_data VALUES(13000, 23, 177, 0, '');

-- Duelist (2092)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7415, 7416, 13001, 13002, 13003);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7415, 7416, 13001, 13002, 13003);
INSERT INTO achievement_criteria_data VALUES(7415, 23, 42, 0, '');
INSERT INTO achievement_criteria_data VALUES(7416, 23, 43, 0, '');
INSERT INTO achievement_criteria_data VALUES(13001, 23, 167, 0, '');
INSERT INTO achievement_criteria_data VALUES(13002, 23, 169, 0, '');
INSERT INTO achievement_criteria_data VALUES(13003, 23, 177, 0, '');

-- Rival (2093)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7418, 7419, 9718, 13004, 10879, 13005);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7418, 7419, 9718, 13004, 10879, 13005);
INSERT INTO achievement_criteria_data VALUES(7418, 23, 42, 0, '');
INSERT INTO achievement_criteria_data VALUES(7419, 23, 43, 0, '');
INSERT INTO achievement_criteria_data VALUES(9718, 23, 44, 0, '');
INSERT INTO achievement_criteria_data VALUES(13004, 23, 167, 0, '');
INSERT INTO achievement_criteria_data VALUES(10879, 23, 169, 0, '');
INSERT INTO achievement_criteria_data VALUES(13005, 23, 177, 0, '');

-- Bloodthirsty Berserker (233)
DELETE FROM achievement_criteria_data WHERE criteria_id=3684;
DELETE FROM disables WHERE sourceType=4 AND entry=3684;
INSERT INTO achievement_criteria_data VALUES(3684, 5, 23505, 0, ""); -- Berserker buff
INSERT INTO achievement_criteria_data VALUES(3684, 20, 566, 0, ""); -- Eye of The Storm

-- To the Looter Go the Spoils (1166)
UPDATE creature_loot_template SET ChanceOrQuestChance=0.5 WHERE item=18228;
DELETE FROM creature_loot_template WHERE entry=1 AND item=18228;
INSERT INTO creature_loot_template VALUES(1, 18228, 1, 1, 0, 1, 1);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=1 AND SourceGroup=1 AND SourceEntry IN(18228);
INSERT INTO conditions VALUES(1, 1, 18228, 0, 0, 22, 0, 30, 0, 0, 0, 0, 0, '', 'Requires map Alterac Valley');

-- Stormtrooper (213)
DELETE FROM achievement_criteria_data WHERE criteria_id=3685;
DELETE FROM disables WHERE sourceType=4 AND entry IN(3685);
INSERT INTO achievement_criteria_data VALUES(3685, 7, 34976, 0, ""); -- Flag Carrier aura (EYE)

-- Supreme Defender (206)
DELETE FROM achievement_criteria_data WHERE criteria_id=3698;
DELETE FROM disables WHERE sourceType=4 AND entry IN(3698);
INSERT INTO achievement_criteria_data VALUES(3698, 7, 23335, 0, ""); -- Alliance Flag Carrier aura (WSG)

-- Supreme Defender (1252)
DELETE FROM achievement_criteria_data WHERE criteria_id=3699;
DELETE FROM disables WHERE sourceType=4 AND entry IN(3699);
INSERT INTO achievement_criteria_data VALUES(3699, 7, 23333, 0, ""); -- Horde Flag Carrier aura (WSG)

-- Take a Chill Pill (1258)
DELETE FROM achievement_criteria_data WHERE criteria_id=3879;
DELETE FROM disables WHERE sourceType=4 AND entry IN(3879);
INSERT INTO achievement_criteria_data VALUES(3879, 7, 23505, 0, ""); -- Berserker buff
INSERT INTO achievement_criteria_data VALUES(3879, 20, 566, 0, ""); -- Eye of The Storm

-- Not So Fast (1259)
DELETE FROM achievement_criteria_data WHERE criteria_id=3880;
DELETE FROM disables WHERE sourceType=4 AND entry IN(3880);
INSERT INTO achievement_criteria_data VALUES(3880, 7, 23451, 0, ""); -- Speed buff
INSERT INTO achievement_criteria_data VALUES(3880, 20, 489, 0, ""); -- Warsong Gluch

-- Bombs Away (1275)
DELETE FROM achievement_criteria_data WHERE criteria_id=3922;
DELETE FROM disables WHERE sourceType=4 AND entry IN(3922);
INSERT INTO achievement_criteria_data VALUES(3922, 0, 0, 0, "");

-- Blade's Edge Bomberman (1276)
DELETE FROM achievement_criteria_data WHERE criteria_id=3923;
DELETE FROM disables WHERE sourceType=4 AND entry IN(3923);
INSERT INTO achievement_criteria_data VALUES(3923, 0, 0, 0, "");

-- Rapid Defense (1277)
DELETE FROM achievement_criteria_data WHERE criteria_id=3924;
DELETE FROM disables WHERE sourceType=4 AND entry IN(3924);
INSERT INTO achievement_criteria_data VALUES(3924, 0, 0, 0, "");

-- World Wide Winner (699)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(608, 609, 610, 5809, 5810);
DELETE FROM disables WHERE sourceType=4 AND entry IN(608, 609, 610, 5809, 5810);
INSERT INTO achievement_criteria_data VALUES(608, 9, 80, 0, ""); -- target with level 80, should be self but there is no criteria (but it should work for arenas well)
INSERT INTO achievement_criteria_data VALUES(609, 9, 80, 0, "");
INSERT INTO achievement_criteria_data VALUES(610, 9, 80, 0, "");
INSERT INTO achievement_criteria_data VALUES(5809, 9, 80, 0, "");
INSERT INTO achievement_criteria_data VALUES(5810, 9, 80, 0, "");

-- 5 vs 5 victories (362)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(5726, 8602, 8601, 8600, 8599);
DELETE FROM disables WHERE sourceType=4 AND entry IN(5726, 8602, 8601, 8600, 8599);
INSERT INTO achievement_criteria_data VALUES(5726, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(8602, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(8601, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(8600, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(8599, 0, 0, 0, "");

-- 3 vs 3 victories (364)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(5727, 8607, 8608, 8609, 8610);
DELETE FROM disables WHERE sourceType=4 AND entry IN(5726, 8607, 8608, 8609, 8610);
INSERT INTO achievement_criteria_data VALUES(5727, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(8607, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(8608, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(8609, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(8610, 0, 0, 0, "");

-- 2 vs 2 victories (366)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(5728, 8615, 8616, 8617, 8618);
DELETE FROM disables WHERE sourceType=4 AND entry IN(5726, 8615, 8616, 8617, 8618);
INSERT INTO achievement_criteria_data VALUES(5728, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(8615, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(8616, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(8617, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(8618, 0, 0, 0, "");

-- Circle of Blood victories (104)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(5734);
DELETE FROM disables WHERE sourceType=4 AND entry IN(5734);
INSERT INTO achievement_criteria_data VALUES(5734, 0, 0, 0, "");

-- Ring of Trials victories (100)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(5735);
DELETE FROM disables WHERE sourceType=4 AND entry IN(5735);
INSERT INTO achievement_criteria_data VALUES(5735, 0, 0, 0, "");

-- Ruins of Lordaeron victories (102)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(5736);
DELETE FROM disables WHERE sourceType=4 AND entry IN(5736);
INSERT INTO achievement_criteria_data VALUES(5736, 0, 0, 0, "");

-- Ring of Valor victories (1546)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(5737);
DELETE FROM disables WHERE sourceType=4 AND entry IN(5737);
INSERT INTO achievement_criteria_data VALUES(5737, 0, 0, 0, "");

-- Dalaran Sewers victories (1548)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(5738);
DELETE FROM disables WHERE sourceType=4 AND entry IN(5738);
INSERT INTO achievement_criteria_data VALUES(5738, 0, 0, 0, "");

-- Arenas won (837)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(5739, 8588, 8590, 8587, 8589);
DELETE FROM disables WHERE sourceType=4 AND entry IN(5739, 8588, 8590, 8587, 8589);
INSERT INTO achievement_criteria_data VALUES(5739, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(8588, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(8587, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(8589, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(8590, 0, 0, 0, "");

-- Leeeeeeeeeeeeeroy! (2188)
UPDATE gameobject_template SET data3=15745 WHERE entry=175124;
UPDATE creature_template SET unit_flags=0 WHERE entry=10161;

-- Friend or Fowl (1254)
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (23801,24746,29594);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (23801,24746,29594) AND source_type=0 AND event_type=6;
INSERT INTO `smart_scripts` VALUES
(23801,0,0,0,6,0,100,1,0,0,0,0,85,25281,2,0,0,0,0,7,0,0,0,0,0,0,0,'Turkey - Cast Marker on death'),
(24746,0,0,0,6,0,100,1,0,0,0,0,85,25281,2,0,0,0,0,7,0,0,0,0,0,0,0,'Fjord Turkey - Cast Marker on death'),
(29594,0,1,0,6,0,100,1,0,0,0,0,85,25281,2,0,0,0,0,7,0,0,0,0,0,0,0,'Angry Turkey - Cast Marker on death');

-- Defense of the Ancients (2200)
DELETE FROM achievement_criteria_data WHERE criteria_id=7740;
DELETE FROM disables WHERE sourceType=4 AND entry IN(7740);
INSERT INTO achievement_criteria_data VALUES(7740, 11, 0, 0, "achievement_sa_defense_of_the_ancients");

-- Defense of the Ancients (1757)
DELETE FROM achievement_criteria_data WHERE criteria_id=7636;
DELETE FROM disables WHERE sourceType=4 AND entry IN(7636);
INSERT INTO achievement_criteria_data VALUES(7636, 11, 0, 0, "achievement_sa_defense_of_the_ancients");

-- Mine Sweeper (1428)
DELETE FROM achievement_criteria_data WHERE criteria_id=5258;
DELETE FROM disables WHERE sourceType=4 AND entry IN(5258);
INSERT INTO achievement_criteria_data VALUES(5258, 0, 0, 0, "");
DELETE FROM spell_script_names WHERE spell_id IN(54355, 57099);
INSERT INTO spell_script_names VALUES(54355, "spell_gen_mine_sweeper");
INSERT INTO spell_script_names VALUES(57099, "spell_gen_mine_sweeper");

-- Higher Learning (1956)
UPDATE gameobject_template SET data11=1, AIName='SmartGameObjectAI', ScriptName='' WHERE entry IN (192708, 192706, 192871, 192905, 192710, 192886, 192869, 192880, 192895, 192713, 192889, 192890, 192894, 192884, 192866, 192891, 192872, 192881, 192709 ,192883 ,192651, 192888, 192711, 192653 ,192887, 192652, 192865, 192874 ,192868, 192870, 192885, 192867, 192882, 192707, 192896);
DELETE FROM smart_scripts WHERE source_type=1 AND entryorguid IN (192708, 192706, 192871, 192905, 192710, 192886, 192869, 192880, 192895, 192713, 192889, 192890, 192894, 192884, 192866, 192891, 192872, 192881, 192709 ,192883 ,192651, 192888, 192711, 192653 ,192887, 192652, 192865, 192874 ,192868, 192870, 192885, 192867, 192882, 192707, 192896);
INSERT INTO smart_scripts VALUES (192708, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192708, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192706, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192706, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192871, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192871, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192905, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192905, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192710, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192710, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192886, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192886, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192869, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192869, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192880, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192880, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192895, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192895, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192713, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192713, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192889, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192889, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192890, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192890, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192894, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192894, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192884, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192884, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192866, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192866, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192891, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192891, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192872, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192872, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192881, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192881, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192709, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192709, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192883, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192883, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192651, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192651, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192888, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192888, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192711, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192711, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192653, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192653, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192887, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192887, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192652, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192652, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192865, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192865, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192874, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192874, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192868, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192868, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192870, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192870, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192885, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192885, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192867, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192867, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192882, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192882, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192707, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192707, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');
INSERT INTO smart_scripts VALUES (192896, 1, 0, 0, 64, 0, 100, 1, 0, 0, 0, 0, 67, 1, 240000, 240000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (192896, 1, 1, 0, 59, 0, 100, 1, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Higher Learning - Timed Event Triggered - Set Loot State');

-- Dinner Impossible (1785)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(6626, 6627, 6628, 6629, 6630);
DELETE FROM disables WHERE sourceType=4 AND entry IN(6626, 6627, 6628, 6629, 6630);
INSERT INTO achievement_criteria_data VALUES(6626, 20, 30, 0, "");
INSERT INTO achievement_criteria_data VALUES(6627, 20, 529, 0, "");
INSERT INTO achievement_criteria_data VALUES(6628, 20, 489, 0, "");
INSERT INTO achievement_criteria_data VALUES(6629, 20, 607, 0, "");
INSERT INTO achievement_criteria_data VALUES(6630, 20, 566, 0, "");
