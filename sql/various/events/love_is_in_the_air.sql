
-- Fix game_event entry
UPDATE game_event SET start_time='2014-02-04 00:01:00', holiday=423, length=20160 WHERE eventEntry=8;

-- Vendor
UPDATE item_template SET BuyCount=5 WHERE entry IN(34258, 22200, 49859, 49857, 49858, 49861, 49856, 49860, 22218);

-- Heart-Shaped box loot
DELETE FROM creature_loot_template WHERE item=50250;
DELETE FROM creature_loot_template WHERE mincountOrRef=-50011;
DELETE FROM item_loot_template WHERE entry=54537;
INSERT INTO item_loot_template VALUES(54537, 49927, 100, 1, 0, 5, 10);
INSERT INTO item_loot_template VALUES(54537, 50250, 0.1, 1, 0, 1, 1);
INSERT INTO item_loot_template VALUES(54537, 1, 15, 1, 0, -50011, 1);

-- ------------------------
-- Quests
-- ------------------------
-- Uncommon scents (24804)
UPDATE creature_template SET npcflag=2 WHERE entry=38293;
DELETE FROM creature_queststarter WHERE quest=24804;
INSERT INTO creature_queststarter VALUES(38293, 24804);
DELETE FROM creature_questender WHERE quest=24804;
INSERT INTO creature_questender VALUES(38066, 24804);

-- Uncommon scents (24805)
UPDATE creature_template SET npcflag=2 WHERE entry=38295;
DELETE FROM creature_queststarter WHERE quest=24805;
INSERT INTO creature_queststarter VALUES(38295, 24805);
DELETE FROM creature_questender WHERE quest=24805;
INSERT INTO creature_questender VALUES(37172, 24805);

-- Something stinks (24536)
-- Something stinks (24655)
UPDATE quest_template SET SourceSpellId=71520 WHERE Id IN(24536, 24655);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=71520;
INSERT INTO conditions VALUES(13, 1, 71520, 0, 0, 31, 0, 3, 68, 0, 0, 0, 0, '', 'Love in the air - heavy perfume pulse');
INSERT INTO conditions VALUES(13, 1, 71520, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Love in the air - heavy perfume pulse');
INSERT INTO conditions VALUES(13, 1, 71520, 0, 1, 31, 0, 3, 3296, 0, 0, 0, 0, '', 'Love in the air - heavy perfume pulse');
INSERT INTO conditions VALUES(13, 1, 71520, 0, 1, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Love in the air - heavy perfume pulse');
DELETE FROM spell_script_names WHERE spell_id=70192;
DELETE FROM spell_linked_spell WHERE spell_trigger=70192;
INSERT INTO spell_linked_spell VALUES (70192, -71507, 1, 'Remove Heavily Perfumed on Fragrant Air Analysis hit');
INSERT INTO spell_linked_spell VALUES (70192, 71508, 1, 'Add Recently Analyzed on Fragrant Air Analysis hit');


-- Pilfering Perfume (24656)
-- Pilfering Perfume (24541)
DELETE FROM creature_queststarter WHERE quest=24656;
INSERT INTO creature_queststarter VALUES(38066, 24656);
DELETE FROM creature_questender WHERE quest=24656;
INSERT INTO creature_questender VALUES(38066, 24656);
UPDATE quest_template SET SourceSpellId=71450 WHERE Id IN(24656, 24541);
UPDATE creature_template SET ScriptName="npc_love_in_air_supply_sentry" WHERE entry=38065 OR entry=37671;
UPDATE creature_template SET AIName='SmartAI' WHERE entry IN(38066, 37172);
DELETE FROM smart_scripts WHERE entryorguid IN(38066, 37172) AND source_type=0;
INSERT INTO smart_scripts VALUES(38066, 0, 0, 1, 62, 0, 100, 0, 10976, 0, 0, 0, 85, 71450, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select - cast at invoker");
INSERT INTO smart_scripts VALUES(37172, 0, 0, 1, 62, 0, 100, 0, 10976, 0, 0, 0, 85, 71450, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select - cast at invoker");
INSERT INTO smart_scripts VALUES(38066, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Linked - Close gossip");
INSERT INTO smart_scripts VALUES(37172, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Linked - Close gossip");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=10976;
INSERT INTO conditions VALUES (15, 10976, 0, 0, 0, 9, 0, 24656, 0, 0, 0, 0, 0, '', 'Show gossip option if player has quest Pilfering Perfume');
INSERT INTO conditions VALUES (15, 10976, 0, 0, 1, 9, 0, 24541, 0, 0, 0, 0, 0, '', 'Show gossip option if player has quest Pilfering Perfume');

-- Fireworks At The Gilded Rose (24848)
DELETE FROM creature_queststarter WHERE quest=24848;
INSERT INTO creature_queststarter VALUES(38066, 24848);
DELETE FROM creature_questender WHERE quest=24848;
INSERT INTO creature_questender VALUES(38325, 24848);
UPDATE creature_template SET npcflag=2 WHERE entry=38325;

-- Hot On The Trail (24849)
-- Hot On The Trail (24851)
DELETE FROM creature_queststarter WHERE quest=24849;
INSERT INTO creature_queststarter VALUES(38325, 24849);
DELETE FROM creature_questender WHERE quest=24849;
INSERT INTO creature_questender VALUES(38325, 24849);
UPDATE creature_template SET faction=35, modelid1=17612, modelid2=0, ScriptName="npc_love_in_air_snivel" WHERE entry IN(38340, 38341, 38342);
UPDATE creature_template SET ScriptName="npc_love_in_air_snivel_real" WHERE entry IN(38334, 38335, 38336, 38337, 38338, 38339);
REPLACE INTO spell_target_position VALUES(71712, 2, 0, -8920, 626, 99.53, 0.26);
REPLACE INTO spell_target_position VALUES(71744, 2, 0, -8814, 662, 95.43, 4.7);
REPLACE INTO spell_target_position VALUES(71751, 2, 0, -8748, 653, 105.1, 0.8);
REPLACE INTO spell_target_position VALUES(71762, 2, 1, 1621, -4372, 12.13, 3.9);
REPLACE INTO spell_target_position VALUES(71763, 2, 1, 1689, -4451, 19.1, 5.6);
REPLACE INTO spell_target_position VALUES(71765, 2, 1, 1765, -4344, -7.8, 3.4);
DELETE FROM areatrigger_scripts WHERE entry IN(5714, 5715, 5716, 5710, 5712, 5711);
DELETE FROM smart_scripts WHERE entryorguid IN(5714, 5715, 5716, 5710, 5712, 5711) and source_type=2;

-- Crushing the Crown quests
UPDATE creature_template SET modelid1=17612, modelid2=0, flags_extra=130 WHERE entry=38035;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=71599;
INSERT INTO conditions VALUES(13, 1, 71599, 0, 0, 31, 0, 3, 38035, 0, 0, 0, 0, '', 'Love in the air - chemical wagon');
DELETE FROM spell_script_names WHERE spell_id IN(71599);
DELETE FROM disables WHERE sourceType=7 AND entry=201716;
INSERT INTO disables VALUES(7, 201716, 0, '', '', '');

-- Man on the Inside (24792)
-- Man on the Inside (24793)
UPDATE quest_template SET PrevQuestId=24657 WHERE Id=24792; -- ally
UPDATE quest_template SET PrevQuestId=24576 WHERE Id=24793; -- horde

-- Something is in the Air (and it Ain't Love) (24745)
DELETE FROM creature_questender WHERE quest=24745;
INSERT INTO creature_questender VALUES(38066, 24745);

-- You've Been Served (14488)
UPDATE quest_template SET RequestItemsText="I don't remember ordering a cleaning service... why yes, I am Apothecary Hummel.$b$b...wait, what is the meaning of this? You think these meaningless papers can stop me? Hah!", OfferRewardText="What we do here is none of your business..." WHERE Id=14488;


-- ------------------------
-- Boss
-- ------------------------
DELETE FROM spell_linked_spell WHERE spell_trigger=68529;
INSERT INTO spell_linked_spell VALUES(68529, -68530, 0, "Perfume Immune - Cologne remove");
DELETE FROM spell_linked_spell WHERE spell_trigger=68530;
INSERT INTO spell_linked_spell VALUES(68530, -68529, 0, "Cologne Immune - Perfume remove");
UPDATE creature_template SET ScriptName="npc_love_in_air_hummel" WHERE entry=36296;
UPDATE creature_template SET ScriptName="npc_love_in_air_hummel_helper" WHERE entry IN(36565, 36272);
DELETE FROM spell_script_names WHERE spell_id IN(68529, 68530);
INSERT INTO spell_script_names VALUES(68529, "spell_love_in_air_perfume_immune");
INSERT INTO spell_script_names VALUES(68530, "spell_love_in_air_perfume_immune");
REPLACE INTO creature_template_addon VALUES(36296, 0, 0, 0, 1, 0, "68589"); -- hummel
REPLACE INTO creature_template_addon VALUES(36565, 0, 0, 0, 1, 0, "68946"); -- baster
DELETE FROM spell_script_names WHERE spell_id IN(68614, 68798);
INSERT INTO spell_script_names VALUES(68614, "spell_love_in_air_periodic_perfumes");
INSERT INTO spell_script_names VALUES(68798, "spell_love_in_air_periodic_perfumes");


-- ------------------------
-- Achievements
-- ------------------------
-- Be Mine! (1701)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(6324, 6325, 6326, 6327, 6328, 6329, 6330, 6331);
DELETE FROM disables WHERE sourceType=4 AND entry IN(6324, 6325, 6326, 6327, 6328, 6329, 6330, 6331);
INSERT INTO achievement_criteria_data VALUES(6324, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(6325, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(6326, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(6327, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(6328, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(6329, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(6330, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(6331, 0, 0, 0, "");

-- Charming (260)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12846);
DELETE FROM disables WHERE sourceType=4 AND entry IN(12846);
INSERT INTO achievement_criteria_data VALUES(12846, 0, 0, 0, "");

-- Fistful of Love (1699)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(6312, 6302, 6313, 6314, 6315, 6316, 6318, 6317, 6319, 6320, 6321);
DELETE FROM disables WHERE sourceType=4 AND entry IN(6312, 6302, 6313, 6314, 6315, 6316, 6318, 6317, 6319, 6320, 6321);
INSERT INTO achievement_criteria_data VALUES(6312, 2, 9, 7, "");
INSERT INTO achievement_criteria_data VALUES(6302, 2, 6, 2, "");
INSERT INTO achievement_criteria_data VALUES(6313, 2, 6, 1, "");
INSERT INTO achievement_criteria_data VALUES(6314, 2, 5, 4, "");
INSERT INTO achievement_criteria_data VALUES(6315, 2, 7, 2, "");
INSERT INTO achievement_criteria_data VALUES(6316, 2, 11, 6, "");
INSERT INTO achievement_criteria_data VALUES(6318, 2, 1, 5, "");
INSERT INTO achievement_criteria_data VALUES(6317, 2, 4, 8, "");
INSERT INTO achievement_criteria_data VALUES(6319, 2, 8, 10, "");
INSERT INTO achievement_criteria_data VALUES(6320, 2, 2, 11, "");
INSERT INTO achievement_criteria_data VALUES(6321, 2, 3, 3, "");

-- Flirt With Disaster (1279)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(3931, 12859);
DELETE FROM disables WHERE sourceType=4 AND entry IN(3931, 12859);
INSERT INTO achievement_criteria_data VALUES(3931, 1, 9099, 0, "");
INSERT INTO achievement_criteria_data VALUES(3931, 5, 70233, 0, "");
INSERT INTO achievement_criteria_data VALUES(3931, 15, 3, 0, "");
INSERT INTO achievement_criteria_data VALUES(3931, 7, 27571, 0, "");
INSERT INTO achievement_criteria_data VALUES(12859, 1, 9099, 0, "");
INSERT INTO achievement_criteria_data VALUES(12859, 5, 70233, 0, "");
INSERT INTO achievement_criteria_data VALUES(12859, 15, 3, 0, "");

-- Flirt With Disaster (1280)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(3929, 4227);
DELETE FROM disables WHERE sourceType=4 AND entry IN(3929, 4227);
INSERT INTO achievement_criteria_data VALUES(3929, 1, 8403, 0, "");
INSERT INTO achievement_criteria_data VALUES(3929, 5, 70233, 0, "");
INSERT INTO achievement_criteria_data VALUES(3929, 15, 3, 0, "");
INSERT INTO achievement_criteria_data VALUES(3929, 7, 27571, 0, "");
INSERT INTO achievement_criteria_data VALUES(4227, 1, 8403, 0, "");
INSERT INTO achievement_criteria_data VALUES(4227, 5, 70233, 0, "");
INSERT INTO achievement_criteria_data VALUES(4227, 15, 3, 0, "");

-- I Pitied The Fool (1704)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(6343, 6344, 6345, 6346, 6347);
DELETE FROM disables WHERE sourceType=4 AND entry IN(6343, 6344, 6345, 6346, 6347);
INSERT INTO achievement_criteria_data VALUES(6343, 1, 16111, 0, "");
INSERT INTO achievement_criteria_data VALUES(6343, 6, 4197, 0, "");
INSERT INTO achievement_criteria_data VALUES(6344, 1, 16111, 0, "");
INSERT INTO achievement_criteria_data VALUES(6344, 6, 2177, 0, "");
INSERT INTO achievement_criteria_data VALUES(6345, 1, 16111, 0, "");
INSERT INTO achievement_criteria_data VALUES(6345, 6, 3421, 0, "");
INSERT INTO achievement_criteria_data VALUES(6346, 1, 16111, 0, "");
INSERT INTO achievement_criteria_data VALUES(6346, 6, 4100, 0, "");
INSERT INTO achievement_criteria_data VALUES(6347, 1, 16111, 0, "");
INSERT INTO achievement_criteria_data VALUES(6347, 6, 3456, 0, "");

-- Lonely? (1291)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(4071, 5787);
DELETE FROM disables WHERE sourceType=4 AND entry IN(4071, 5787);
INSERT INTO achievement_criteria_data VALUES(4071, 5, 45123, 0, "");
INSERT INTO achievement_criteria_data VALUES(4071, 6, 4395, 0, "");
INSERT INTO achievement_criteria_data VALUES(5787, 6, 4395, 0, "");

-- Tough Love (4624)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12992);
DELETE FROM disables WHERE sourceType=4 AND entry IN(12992);
INSERT INTO achievement_criteria_data VALUES(12992, 0, 0, 0, "");

-- ------------------------
-- CREATURE SPAWNS
-- ------------------------
DELETE FROM creature_addon WHERE guid IN(SELECT guid from game_event_creature WHERE eventEntry=8);
DELETE FROM creature WHERE guid IN(SELECT guid FROM game_event_creature WHERE eventEntry=8);
DELETE FROM creature WHERE guid BETWEEN 244500 AND 244636;
INSERT INTO creature VALUES (244500, 22239, 530, 1, 1, 0, 0, -3980.7, -11635.6, -139, 4.8, 600, 0, 0, 550, 0, 2, 0, 0, 0);
INSERT INTO creature VALUES (244501, 37675, 1, 1, 1, 0, 0, -1224.81, 67.5514, 130.815, 3.13043, 300, 0, 0, 1716, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244502, 16005, 0, 1, 1, 0, 0, -8814.19, 614.452, 95.1064, 2.43581, 600, 0, 0, 35, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244503, 16105, 0, 1, 1, 0, 0, -8869.25, 650.809, 95.8618, 5.12972, 600, 0, 0, 38, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244504, 16106, 0, 1, 1, 0, 0, -8691.85, 840.514, 98.6851, 2.19234, 600, 0, 0, 25, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244505, 16002, 0, 1, 1, 0, 0, -8863.74, 655.115, 96.1093, 5.7172, 600, 0, 0, 38, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244506, 16107, 0, 1, 1, 0, 0, 90.2991, -1723.58, 220.193, 3.63373, 600, 0, 0, 25, 0, 0, 0, 0, 0);
-- INSERT INTO creature VALUES (244507, 16008, 1, 1, 1, 0, 0, -1272.05, 45.5033, 128.816, 1.70451, 600, 0, 0, 25, 0, 0, 0, 0, 0); removed in 2010 year
-- INSERT INTO creature VALUES (244508, 16007, 1, 1, 1, 0, 0, 1623.25, -4401.9, 12.5705, 3.15874, 600, 0, 0, 2000, 0, 0, 0, 0, 0); removed in 2010 year
-- INSERT INTO creature VALUES (244509, 16003, 0, 1, 1, 0, 0, 2052.22, 294.354, 56.9512, 3.27529, 600, 0, 0, 310, 0, 0, 0, 0, 0); removed in 2010 year
INSERT INTO creature VALUES (244510, 16009, 0, 1, 1, 0, 0, -4924.22, -972.334, 501.482, 2.14681, 600, 0, 0, 7600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244511, 16001, 1, 1, 1, 0, 0, 9941.54, 2493.25, 1317.43, 3.98979, 600, 0, 0, 25, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244512, 16108, 0, 1, 1, 0, 0, 1595.41, 230.539, -52.1545, 4.63121, 600, 0, 0, 25, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244513, 16109, 0, 1, 1, 0, 0, 1678.2, 196.21, -62.173, 6.27787, 600, 0, 0, 25, 230, 0, 0, 0, 0);
INSERT INTO creature VALUES (244514, 16085, 0, 1, 1, 0, 0, -8428.88, 329.376, 121.329, 2.89341, 300, 0, 0, 1557, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244515, 37172, 1, 1, 1, 0, 0, 1658.82, -4392.51, 23.3589, 4.6346, 300, 0, 0, 955, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244516, 37675, 1, 1, 1, 0, 0, 1651.95, -4436.06, 19.1667, 1.5205, 300, 0, 0, 1716, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244517, 37674, 530, 1, 1, 0, 0, -4005.55, -11844.8, 1.43003, 4.79643, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244518, 37674, 0, 1, 1, 0, 0, -4918.13, -982.624, 502.699, 2.499, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244519, 37674, 0, 1, 1, 0, 0, -8868.67, 636.356, 97.0308, 0.908268, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244520, 37674, 1, 1, 1, 0, 0, 9868.93, 2492.6, 1317.12, 6.214, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244521, 37674, 530, 1, 1, 0, 0, 9613.2, -7184.04, 15.5297, 1.871, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244522, 37674, 0, 1, 1, 0, 0, 1629.43, 239.687, 65.095, 0.0213735, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244523, 37674, 1, 1, 1, 0, 0, -1224.64, 68.9846, 130.974, 3.13043, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244524, 37674, 1, 1, 1, 0, 0, 1654.56, -4435.7, 19.1524, 1.54799, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244525, 37675, 0, 1, 1, 0, 0, -8869.92, 637.543, 97.0305, 0.751188, 300, 0, 0, 1716, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244526, 37675, 1, 1, 1, 0, 0, 9869.15, 2493.99, 1317.12, 6.2572, 300, 0, 0, 1716, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244527, 37675, 530, 1, 1, 0, 0, 9611.19, -7184.62, 15.5277, 1.84743, 300, 0, 0, 1716, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244528, 37675, 0, 1, 1, 0, 0, 1629.41, 241.08, 65.0948, 6.18282, 300, 0, 0, 1716, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244529, 37675, 0, 1, 1, 0, 0, -4919.62, -983.631, 502.699, 2.24375, 300, 0, 0, 1716, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244530, 37675, 530, 1, 1, 0, 0, -4003.71, -11844.7, 1.44597, 4.73753, 300, 0, 0, 1716, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244531, 37887, 0, 1, 1, 0, 0, -8864.01, 635.646, 96.0818, 1.97249, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244532, 38032, 571, 1, 1, 0, 0, 5562.6, 52.7611, 148.023, 2.35235, 30, 0, 0, 9940, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244533, 38032, 571, 1, 1, 0, 0, 5577.75, 75.6327, 148.413, 1.00147, 30, 0, 0, 9940, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244534, 38032, 571, 1, 1, 0, 0, 5578.91, 93.6562, 151.453, 0.907219, 30, 0, 0, 9940, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244535, 38032, 571, 1, 1, 0, 0, 5604.51, 73.2304, 149.666, 5.6039, 30, 0, 0, 9940, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244536, 38032, 571, 1, 1, 0, 0, 5576.47, 21.2221, 147.859, 3.57051, 30, 0, 0, 9940, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244537, 38032, 571, 1, 1, 0, 0, 5545.75, 7.1756, 146.18, 3.57051, 30, 0, 0, 9940, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244538, 38032, 571, 1, 1, 0, 0, 5517.56, 0.325575, 148.243, 3.29483, 30, 0, 0, 9940, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244539, 38032, 571, 1, 1, 0, 0, 5493.37, 1.40435, 148.043, 2.9414, 30, 0, 0, 9940, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244540, 38032, 571, 1, 1, 0, 0, 5483.65, -24.6906, 148.632, 4.41402, 30, 0, 0, 9940, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244541, 38032, 571, 1, 1, 0, 0, 5480.42, -46.4207, 150.948, 4.71797, 30, 0, 0, 9940, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244542, 38032, 571, 1, 1, 0, 0, 5490.42, 25.9105, 148.037, 1.53711, 30, 0, 0, 9940, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244543, 38032, 571, 1, 1, 0, 0, 5517.81, 39.9906, 150.179, 0.35901, 30, 0, 0, 9940, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244544, 38032, 571, 1, 1, 0, 0, 5560.51, 26.0842, 147.293, 0.621334, 30, 0, 0, 9940, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244545, 38035, 571, 1, 1, 0, 0, 5525.21, 35.5649, 148.918, 0.00558376, 60, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244546, 38035, 571, 1, 1, 0, 0, 5586.44, 36.157, 148.304, 2.49451, 60, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244547, 38035, 571, 1, 1, 0, 0, 5610.19, 67.2452, 149.648, 1.10907, 60, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244548, 38039, 1, 1, 1, 0, 0, 9871.16, 2488.28, 1315.88, 0.547356, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244549, 38040, 530, 1, 1, 0, 0, -4010.12, -11846.9, 0.135113, 5.42082, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244550, 38041, 0, 1, 1, 0, 0, -4915.43, -979.532, 501.448, 2.31443, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244551, 38042, 1, 1, 1, 0, 0, 1648.48, -4434.6, 17.6364, 1.10031, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244552, 38043, 530, 1, 1, 0, 0, 9617.42, -7181.72, 14.2958, 2.39329, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244553, 38044, 1, 1, 1, 0, 0, -1223.83, 62.5435, 129.123, 3.29929, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244554, 38045, 0, 1, 1, 0, 0, 1630.48, 236.085, 63.2574, 0.382657, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244555, 38066, 0, 1, 1, 0, 0, -8867.86, 652.647, 97.0113, 4.84704, 300, 0, 0, 955, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244556, 38293, 1, 1, 1, 0, 0, 9885.37, 2494.31, 1315.92, 3.01351, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244557, 38293, 0, 1, 1, 0, 0, -4932.9, -995.348, 501.441, 0.720067, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244558, 38295, 1, 1, 1, 0, 0, -1239.7, 55.8489, 127.02, 0.969017, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244559, 38295, 0, 1, 1, 0, 0, 1637.74, 256.223, 62.5927, 4.55312, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244560, 38295, 530, 1, 1, 0, 0, 9585.78, -7182.34, 14.2411, 0.268784, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244561, 38325, 0, 1, 1, 0, 0, -8881.19, 669.006, 105.834, 0.696214, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244562, 38328, 1, 1, 1, 0, 0, 1776.14, -4507.72, 27.7458, 0.701323, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244563, 38035, 0, 1, 1, 0, 0, -51.7072, 1147.06, 66.2442, 6.0002, 60, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244564, 36885, 33, 1, 1, 0, 0, -207.869, 2174.97, 79.7664, 0.661457, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244565, 36885, 33, 1, 1, 0, 0, -200.286, 2201.67, 79.765, 0.537364, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244566, 36885, 33, 1, 1, 0, 0, -220.323, 2207.68, 79.7636, 3.0687, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244567, 37917, 0, 1, 1, 0, 0, -78.1933, 1155.44, 64.1348, 3.65579, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244568, 37917, 0, 1, 1, 0, 0, -99.1899, 1143.58, 61.9249, 3.65579, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244569, 37917, 0, 1, 1, 0, 0, -70.0067, 1126.23, 65.5446, 5.87061, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244570, 37917, 0, 1, 1, 0, 0, -40.5129, 1132.35, 66.9879, 0.2236, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244571, 38208, 33, 1, 1, 0, 0, -234.669, 2154.3, 90.6247, 4.46749, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244573, 36296, 33, 1, 1, 0, 0, -208.723, 2218.5, 79.7633, 5.16886, 86400, 0, 0, 269000, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244575, 38342, 0, 1, 1, 0, 0, -8754.09, 657.778, 105.091, 0.199051, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244576, 38342, 1, 1, 1, 0, 0, 1762.65, -4345.06, -7.83994, 3.73924, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244577, 38341, 0, 1, 1, 0, 0, -8806.15, 664.605, 96.2, 1.56172, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244578, 38341, 1, 1, 1, 0, 0, 1674.65, -4440.01, 19.1696, 5.34538, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244579, 38340, 1, 1, 1, 0, 0, 1619.91, -4376.93, 12.2511, 0.575657, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244580, 38340, 0, 1, 1, 0, 0, -8911.16, 625.834, 99.5227, 3.65088, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244581, 37214, 0, 1, 1, 0, 0, -9447.59, 521.985, 56.1219, 4.45034, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244582, 37214, 0, 1, 1, 0, 0, -9461.04, 512.112, 55.8756, 3.59818, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244583, 37214, 0, 1, 1, 0, 0, -9479.33, 525.887, 55.2184, 2.14127, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244584, 37214, 0, 1, 1, 0, 0, -9471.57, 536.639, 54.108, 0.793523, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244585, 37214, 0, 1, 1, 0, 0, -9459.73, 534.487, 54.9696, 5.97165, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244586, 37214, 1, 1, 1, 0, 0, 1278.46, -4095.97, 28.5179, 6.00276, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244587, 37214, 1, 1, 1, 0, 0, 1273.4, -4103.99, 27.8146, 4.13351, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244588, 37214, 1, 1, 1, 0, 0, 1263.1, -4104.66, 26.5895, 3.20674, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244589, 37214, 1, 1, 1, 0, 0, 1252.12, -4093.07, 24.2136, 1.55034, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244590, 37214, 1, 1, 1, 0, 0, 1261.55, -4082.01, 24.5336, 0.679332, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244591, 37917, 1, 1, 1, 0, 0, 4861.5, 143.397, 53.5891, 1.77494, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244592, 37917, 1, 1, 1, 0, 0, 4867.09, 123.556, 54.625, 1.10736, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244593, 37917, 1, 1, 1, 0, 0, 4860, 109.204, 53.8496, 0.467256, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244594, 37917, 1, 1, 1, 0, 0, 4844.9, 102.68, 50.0936, 3.43999, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244595, 37917, 1, 1, 1, 0, 0, 4845.3, 115.292, 51.258, 3.43999, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244596, 38023, 1, 1, 1, 0, 0, 6777.68, -4889.84, 776.667, 0.746511, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244597, 38023, 1, 1, 1, 0, 0, 6767.71, -4899.06, 775.43, 5.72986, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244598, 38023, 1, 1, 1, 0, 0, 6754.64, -4890.56, 774.717, 4.87221, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244599, 38023, 1, 1, 1, 0, 0, 6754.5, -4875.5, 773.386, 6.14062, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244600, 38023, 1, 1, 1, 0, 0, 6763.25, -4871.99, 775.183, 0.473977, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244601, 38030, 530, 1, 1, 0, 0, -1792, 4835.44, 5.75526, 4.05103, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244602, 38030, 530, 1, 1, 0, 0, -1786.21, 4846.14, 3.9133, 4.90948, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244603, 38030, 530, 1, 1, 0, 0, -1789.11, 4860.69, 1.08418, 5.7255, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244604, 38030, 530, 1, 1, 0, 0, -1800.26, 4865.74, 1.76724, 0.246567, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244605, 38030, 530, 1, 1, 0, 0, -1809.55, 4858.05, 1.6643, 0.850539, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244606, 38035, 0, 1, 1, 0, 0, -9462.46, 525.975, 55.3952, 4.44641, 60, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244607, 38035, 1, 1, 1, 0, 0, 1269.73, -4095.83, 27.2461, 0.383236, 60, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244608, 38035, 530, 1, 1, 0, 0, -1800.57, 4849.58, 3.67941, 0.732729, 60, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244609, 38035, 1, 1, 1, 0, 0, 6767.76, -4880.77, 776.832, 0.473977, 60, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244610, 38035, 1, 1, 1, 0, 0, 4851.07, 137.164, 52.3573, 3.32611, 60, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244611, 38016, 0, 1, 1, 0, 0, 107.836, -2394.64, 123.766, 1.71859, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244612, 38016, 0, 1, 1, 0, 0, 112.257, -2406.06, 125.159, 2.12857, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244613, 38016, 0, 1, 1, 0, 0, 117.312, -2415.86, 124.574, 1.81912, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244614, 38016, 0, 1, 1, 0, 0, 112.321, -2385.37, 121.337, 0.933974, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244615, 38016, 0, 1, 1, 0, 0, 122.685, -2379.58, 120.969, 0.401474, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244616, 38006, 1, 1, 1, 0, 0, -3408.24, -4205.45, 11.7024, 5.33848, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244617, 38006, 1, 1, 1, 0, 0, -3415.67, -4199.13, 10.9447, 0.380259, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244618, 38006, 1, 1, 1, 0, 0, -3425.3, -4205.48, 11.087, 0.747825, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244619, 38006, 1, 1, 1, 0, 0, -3407.75, -4217.59, 11.4111, 4.59863, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244620, 38006, 1, 1, 1, 0, 0, -3423.44, -4223.1, 10.3878, 3.34749, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244621, 37984, 0, 1, 1, 0, 0, -396.98, 152.02, 72.7445, 0.0802893, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244622, 37984, 0, 1, 1, 0, 0, -414.333, 151.165, 72.7544, 5.28748, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244623, 37984, 0, 1, 1, 0, 0, -421.118, 161.632, 73.0552, 3.81093, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244624, 37984, 0, 1, 1, 0, 0, -407.15, 172.323, 76.8851, 3.50463, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244625, 37984, 0, 1, 1, 0, 0, -382.121, 161.213, 77.0395, 0.982712, 30, 0, 0, 356, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244626, 38035, 0, 1, 1, 0, 0, 121.643, -2401.57, 123.532, 1.69738, 60, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244627, 38035, 1, 1, 1, 0, 0, -3418.81, -4212.7, 10.3292, 0.932394, 60, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244628, 38035, 0, 1, 1, 0, 0, -402.274, 163.143, 75.6627, 3.65071, 60, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244629, 37715, 1, 1, 1, 0, 0, 1349.47, -4641.45, 53.5287, 3.1282, 300, 0, 0, 1003, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244630, 37715, 0, 1, 1, 0, 0, -8401.37, 1246.34, 5.2303, 5.97131, 300, 0, 0, 1003, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244631, 38065, 0, 1, 1, 0, 0, -9028.75, 351.111, 93.004, 4.99164, 180, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244632, 38065, 0, 1, 1, 0, 0, -9033.74, 358.078, 93.4561, 3.12414, 180, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244633, 38065, 0, 1, 1, 0, 0, -9033.66, 352.778, 93.0811, 4.03171, 180, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244634, 37671, 1, 1, 1, 0, 1, 1395.09, -4482.19, 31.3414, 3.41801, 180, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244635, 37671, 1, 1, 1, 0, 1, 1395.8, -4495.27, 31.5498, 2.42998, 180, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (244636, 37671, 1, 1, 1, 0, 1, 1393.56, -4487.77, 31.4434, 2.97897, 180, 0, 0, 12600, 0, 0, 0, 0, 0);

DELETE FROM game_event_creature WHERE eventEntry=8;
REPLACE INTO game_event_creature VALUES(8, 244500),(8, 244501),(8, 244502),(8, 244503),(8, 244504),(8, 244505),(8, 244506), -- (8, 244507),(8, 244508),(8, 244509), removed in 2010 year
(8, 244510),(8, 244511),(8, 244512),(8, 244513),(8, 244514),(8, 244515),(8, 244516),(8, 244517),(8, 244518),(8, 244519),
(8, 244520),(8, 244521),(8, 244522),(8, 244523),(8, 244524),(8, 244525),(8, 244526),(8, 244527),(8, 244528),(8, 244529),(8, 244530),
(8, 244531),(8, 244532),(8, 244533),(8, 244534),(8, 244535),(8, 244536),(8, 244537),(8, 244538),(8, 244539),(8, 244540),(8, 244541),
(8, 244542),(8, 244543),(8, 244544),(8, 244545),(8, 244546),(8, 244547),(8, 244548),(8, 244549),(8, 244550),(8, 244551),(8, 244552),
(8, 244553),(8, 244554),(8, 244555),(8, 244556),(8, 244557),(8, 244558),(8, 244559),(8, 244560),(8, 244561),(8, 244562),(8, 244563),
(8, 244564),(8, 244565),(8, 244566),(8, 244567),(8, 244568),(8, 244569),(8, 244570),(8, 244571),(8, 244573),
(8, 244575),(8, 244576),(8, 244577),(8, 244578),(8, 244579),(8, 244580),(8, 244581),(8, 244582),(8, 244583),(8, 244584),(8, 244585),
(8, 244586),(8, 244587),(8, 244588),(8, 244589),(8, 244590),(8, 244591),(8, 244592),(8, 244593),(8, 244594),(8, 244595),(8, 244596),
(8, 244597),(8, 244598),(8, 244599),(8, 244600),(8, 244601),(8, 244602),(8, 244603),(8, 244604),(8, 244605),(8, 244606),(8, 244607),
(8, 244608),(8, 244609),(8, 244610),(8, 244611),(8, 244612),(8, 244613),(8, 244614),(8, 244615),(8, 244616),(8, 244617),(8, 244618),
(8, 244619),(8, 244620),(8, 244621),(8, 244622),(8, 244623),(8, 244624),(8, 244625),(8, 244626),(8, 244627),(8, 244628),(8, 244629),
(8, 244630),(8, 244631),(8, 244632),(8, 244633),(8, 244634),(8, 244635),(8, 244636);

-- GAMEOBJECTS
DELETE FROM gameobject WHERE guid IN(SELECT guid FROM game_event_gameobject WHERE eventEntry=8);
DELETE FROM gameobject WHERE guid BETWEEN 241100 AND 242328;
INSERT INTO gameobject VALUES (241100, 181018, 0, 1, 1, -8800.71, 664.397, 97.7356, 2.89725, 0, 0, 0.992546, 0.121868, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241101, 181020, 0, 1, 1, -8805.12, 868.183, 109.955, 2.18166, 0, 0, 0.88701, 0.461749, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241102, 181016, 0, 1, 1, -8839.07, 545.266, 96.8377, 1.01229, 0, 0, 0.484809, 0.87462, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241103, 181020, 0, 1, 1, -8883.68, 758.493, 105.122, -0.907571, 0, 0, -0.438371, 0.898794, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241104, 181060, 0, 1, 1, -8859.98, 649.945, 100.919, 1.58825, 0, 0, 0.713251, 0.700909, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241105, 181019, 0, 1, 1, -8919.73, 636.243, 100.627, -2.07694, 0, 0, -0.861629, 0.507539, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241106, 181060, 0, 1, 1, -8863.06, 649.095, 97.6071, 1.23918, 0, 0, 0.580701, 0.814117, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241107, 181016, 0, 1, 1, -8879.18, 649.492, 96.0198, 0.488692, 0, 0, 0.241922, 0.970296, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241108, 181060, 0, 1, 1, -8857.41, 651.69, 97.6205, -0.802851, 0, 0, -0.390731, 0.920505, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241109, 181018, 0, 1, 1, -8902.26, 621.338, 101.596, -2.6529, 0, 0, -0.970296, 0.241922, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241110, 181060, 0, 1, 1, -8858.56, 648.477, 100.919, -3.00197, 0, 0, -0.997564, 0.0697546, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241111, 181060, 0, 1, 1, -8857.76, 645.929, 97.5954, -3.00197, 0, 0, -0.997564, 0.0697546, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241112, 181060, 0, 1, 1, -8856.1, 648.363, 97.6085, 0.610865, 0, 0, 0.300706, 0.953717, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241113, 181060, 0, 1, 1, -8920.49, 636.273, 100.627, -2.60054, 0, 0, -0.96363, 0.267239, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241114, 181025, 0, 1, 1, -9085.24, 418.316, 121.565, -2.49582, 0, 0, -0.948324, 0.317305, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241115, 181014, 0, 1, 1, -9094.49, 429.216, 99.0901, -0.820305, 0, 0, -0.398749, 0.91706, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241116, 181015, 0, 1, 1, 1595.84, 240.163, -52.1429, 0.890118, 0, 0, 0.430511, 0.902585, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241117, 181015, 530, 1, 1, -2059.59, 5316.22, -37.3235, -1.0472, 0, 0, -0.500001, 0.866025, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241118, 181015, 530, 1, 1, -2035.19, 5275.62, -38.9744, 0.541052, 0, 0, 0.267238, 0.96363, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241119, 181015, 0, 1, 1, -9081.59, 440.823, 93.2959, 5.35912, 0, 0, 0.445769, -0.895148, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241120, 181015, 0, 1, 1, -9062.69, 415.789, 93.2961, 2.21282, 0, 0, 0.894097, 0.447874, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241121, 181015, 0, 1, 1, -9003.58, 466.834, 97.1185, 2.1293, 0, 0, 0.874619, 0.48481, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241122, 181015, 0, 1, 1, -8973.18, 490.654, 97.0779, 2.19912, 0, 0, 0.891008, 0.453988, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241123, 181015, 0, 1, 1, -9106.58, 422.097, 93.7786, -2.49582, 0, 0, -0.948324, 0.317305, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241124, 181016, 0, 1, 1, -8861.03, 658.585, 96.7187, -0.802851, 0, 0, -0.390731, 0.920505, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241125, 181017, 0, 1, 1, -8860.68, 662.838, 101.16, -0.925024, 0, 0, -0.446198, 0.894934, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241126, 181017, 0, 1, 1, -8841.08, 658.815, 101.888, -2.61799, 0, 0, -0.965925, 0.258821, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241127, 181017, 0, 1, 1, -8871.9, 682.277, 102.292, -0.994838, 0, 0, -0.477159, 0.878817, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241128, 181019, 0, 1, 1, -8856.15, 671.781, 98.8406, -0.314159, 0, 0, -0.156434, 0.987688, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241129, 181016, 0, 1, 1, -8856.85, 661.656, 97.1286, -0.977384, 0, 0, -0.469471, 0.882948, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241130, 181021, 0, 1, 1, -4984.71, -859.337, 524.799, -2.46091, 0, 0, -0.942641, 0.333809, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241131, 181016, 0, 1, 1, -4997.85, -880.69, 501.659, 0.715585, 0, 0, 0.350207, 0.936672, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241132, 181021, 0, 1, 1, -4974.65, -871.542, 524.529, -2.44346, 0, 0, -0.939692, 0.342021, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241133, 181021, 0, 1, 1, -4994.78, -847.123, 524.522, -2.46091, 0, 0, -0.942641, 0.333809, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241134, 181021, 0, 1, 1, -5013.39, -862.519, 524.679, 0.698132, 0, 0, 0.34202, 0.939693, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241135, 181016, 0, 1, 1, -4980.03, -865.875, 501.659, -2.54818, 0, 0, -0.956305, 0.292372, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241136, 181016, 0, 1, 1, -4990.29, -853.343, 501.659, -2.44346, 0, 0, -0.939692, 0.342021, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241137, 181016, 0, 1, 1, -5000.16, -841.309, 501.659, -2.46091, 0, 0, -0.942641, 0.333809, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241138, 181016, 0, 1, 1, -5008.32, -868.188, 501.659, 0.767945, 0, 0, 0.374607, 0.927184, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241139, 181021, 0, 1, 1, -4993.28, -886.917, 524.6, 0.680678, 0, 0, 0.333807, 0.942642, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241140, 181060, 0, 1, 1, -4839.09, -874.047, 511.14, 2.26893, 0, 0, 0.906308, 0.422617, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241141, 181019, 0, 1, 1, -4846.32, -864.108, 502.844, -0.802851, 0, 0, -0.390731, 0.920505, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241142, 181060, 0, 1, 1, -4843.25, -874.554, 511.14, -2.49582, 0, 0, -0.948324, 0.317305, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241143, 181017, 0, 1, 1, -4849.92, -877.536, 506.389, -1.39626, 0, 0, -0.642786, 0.766046, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241144, 181060, 0, 1, 1, -4844.49, -874.748, 511.14, 1.98968, 0, 0, 0.838672, 0.544637, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241145, 181060, 0, 1, 1, -4841.93, -874.424, 511.14, -1.0472, 0, 0, -0.500001, 0.866025, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241146, 181018, 0, 1, 1, -4897.69, -1002.05, 510.054, 2.07694, 0, 0, 0.861629, 0.507539, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241147, 181017, 0, 1, 1, -4899.03, -982.314, 510.777, 2.28638, 0, 0, 0.909961, 0.414694, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241148, 181060, 0, 1, 1, -4877.75, -999.527, 506.958, -3.05433, 0, 0, -0.999048, 0.0436174, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241149, 181018, 0, 1, 1, -4888.82, -994.738, 510.049, 2.32129, 0, 0, 0.91706, 0.398748, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241150, 181019, 0, 1, 1, -4877.42, -986.308, 504.758, -0.575959, 0, 0, -0.284016, 0.95882, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241151, 181019, 0, 1, 1, -4899.35, -1004.48, 504.758, -0.680679, 0, 0, -0.333807, 0.942641, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241152, 181018, 0, 1, 1, -4879.83, -987.33, 509.983, 2.14675, 0, 0, 0.878816, 0.477161, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241153, 181019, 0, 1, 1, -4881.06, -989.323, 504.758, -1.02974, 0, 0, -0.492422, 0.870357, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241154, 181019, 0, 1, 1, -4905.37, -979.254, 503.518, -0.541052, 0, 0, -0.267238, 0.96363, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241155, 181019, 0, 1, 1, -4886.38, -993.683, 504.758, 2.32129, 0, 0, 0.91706, 0.398748, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241156, 181025, 0, 1, 1, -4700.94, -958.901, 510.295, 0.820305, 0, 0, 0.398749, 0.91706, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241157, 181017, 0, 1, 1, -4868.57, -1144.73, 510.407, 0.383972, 0, 0, 0.190809, 0.981627, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241158, 181017, 0, 1, 1, -4804.96, -1180.35, 510.459, 1.5708, 0, 0, 0.707108, 0.707106, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241159, 181025, 0, 1, 1, -4928.49, -902.764, 510.451, -0.994838, 0, 0, -0.477159, 0.878817, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241160, 181021, 0, 1, 1, -4634.71, -1025.57, 514.933, 1.8675, 0, 0, 0.803856, 0.594824, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241161, 181017, 0, 1, 1, -4730.89, -1063.31, 508.738, -2.61799, 0, 0, -0.965925, 0.258821, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241162, 181025, 0, 1, 1, -4684.72, -1205.31, 510.45, 2.35619, 0, 0, 0.923879, 0.382686, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241163, 181017, 0, 1, 1, -4974.48, -1033.47, 510.385, 2.77507, 0, 0, 0.983255, 0.182237, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241164, 181025, 0, 1, 1, -4878.06, -879.947, 510.242, -1.25664, 0, 0, -0.587786, 0.809016, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241165, 181017, 0, 1, 1, -4614.04, -1114.48, 509.55, -2.94961, 0, 0, -0.995396, 0.095844, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241166, 181020, 0, 1, 1, -8803.75, 653.544, 97.3249, -1.79769, 0, 0, -0.782608, 0.622514, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241167, 181014, 0, 1, 1, -8852.53, 539.681, 117.809, 0.244346, 0, 0, 0.121869, 0.992546, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241168, 181020, 0, 1, 1, -8842.43, 716.519, 109.501, 2.02458, 0, 0, 0.848048, 0.52992, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241169, 181020, 0, 1, 1, -8743.36, 695.376, 110.7, 0.628319, 0, 0, 0.309017, 0.951056, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241170, 181020, 0, 1, 1, -8740.8, 579.024, 109.82, -0.785398, 0, 0, -0.382683, 0.92388, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241171, 181060, 0, 1, 1, -8859.7, 652.545, 97.6087, 1.62316, 0, 0, 0.725376, 0.688353, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241172, 181060, 0, 1, 1, -8907.8, 612.974, 100.613, -2.67035, 0, 0, -0.972369, 0.233447, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241173, 181060, 0, 1, 1, -8858.01, 647.785, 99.5508, 2.58309, 0, 0, 0.961262, 0.275636, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241174, 181060, 0, 1, 1, -8857.6, 648.729, 99.5508, -1.65806, 0, 0, -0.737276, 0.675591, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241175, 181060, 0, 1, 1, -8933.73, 628.958, 100.634, 2.00713, 0, 0, 0.843392, 0.537299, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241176, 181018, 0, 1, 1, -8910.36, 636.253, 101.55, -2.61799, 0, 0, -0.965925, 0.258821, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241177, 181060, 0, 1, 1, -8862.61, 650.263, 97.6093, -3.12414, 0, 0, -0.999962, 0.0087262, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241178, 181060, 0, 1, 1, -8860.49, 649.388, 100.919, 0.017453, 0, 0, 0.00872639, 0.999962, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241179, 181060, 0, 1, 1, -8861.36, 645.959, 97.5999, -1.0821, 0, 0, -0.515036, 0.857168, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241180, 181060, 0, 1, 1, -8855.97, 649.273, 97.6137, 1.06465, 0, 0, 0.507538, 0.861629, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241181, 181015, 0, 1, 1, -8893.99, 578.844, 92.8094, 0.680678, 0, 0, 0.333807, 0.942642, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241182, 181015, 0, 1, 1, -9085.16, 396.496, 93.5758, -2.46091, 0, 0, -0.942641, 0.333809, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241183, 181014, 0, 1, 1, -8948.45, 539.271, 109.32, -2.47837, 0, 0, -0.945519, 0.325567, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241184, 181015, 0, 1, 1, -8884.23, 566.347, 92.8298, 0.715585, 0, 0, 0.350207, 0.936672, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241185, 181014, 0, 1, 1, -8935.14, 522.536, 109.389, -2.47837, 0, 0, -0.945519, 0.325567, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241186, 181015, 0, 1, 1, -9018.08, 485.234, 97.1197, -0.855212, 0, 0, -0.414694, 0.909961, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241187, 181014, 0, 1, 1, -9075.37, 407.018, 98.6196, 2.25148, 0, 0, 0.902586, 0.430509, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241188, 181016, 0, 1, 1, -5018.23, -855.977, 501.659, 0.680678, 0, 0, 0.333807, 0.942642, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241189, 181021, 0, 1, 1, -5003.33, -874.714, 524.838, 0.680678, 0, 0, 0.333807, 0.942642, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241190, 181060, 0, 1, 1, -4840.76, -874.337, 511.14, 2.96706, 0, 0, 0.996195, 0.0871556, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241191, 181060, 0, 1, 1, -4837.73, -873.987, 511.14, -2.68781, 0, 0, -0.97437, 0.22495, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241192, 181019, 0, 1, 1, -4895.29, -1001.13, 504.758, -3.01942, 0, 0, -0.998135, 0.0610484, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241193, 181019, 0, 1, 1, -4890.23, -996.799, 504.758, 0.418879, 0, 0, 0.207912, 0.978148, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241194, 181019, 0, 1, 1, -4900.67, -975.41, 503.491, 2.70526, 0, 0, 0.976296, 0.21644, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241195, 181060, 0, 1, 1, -4888.35, -1008.27, 506.958, 1.88496, 0, 0, 0.809018, 0.587783, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241196, 181060, 0, 1, 1, -4885.09, -1005.57, 506.958, 0.069813, 0, 0, 0.0348994, 0.999391, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241197, 181060, 0, 1, 1, -4875.53, -997.696, 506.958, -0.471239, 0, 0, -0.233445, 0.97237, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241198, 181017, 0, 1, 1, -4732.77, -1146.49, 507.539, 2.6529, 0, 0, 0.970296, 0.241922, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241199, 181025, 0, 1, 1, -4931.61, -1206.36, 509.64, -2.32129, 0, 0, -0.91706, 0.398748, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241200, 181017, 0, 1, 1, -4989.78, -1117.28, 508.186, -2.96706, 0, 0, -0.996195, 0.0871556, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241201, 181017, 0, 1, 1, -5041.65, -1166.19, 508.227, 0.314159, 0, 0, 0.156434, 0.987688, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241202, 181017, 0, 1, 1, -4880.1, -957.773, 509.628, 1.93731, 0, 0, 0.824125, 0.566409, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241203, 181025, 0, 1, 1, -4971.15, -937.866, 510.349, -0.750491, 0, 0, -0.366501, 0.930418, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241204, 181017, 0, 1, 1, -5030.98, -1153.9, 509.76, -1.27409, 0, 0, -0.594823, 0.803857, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241205, 181017, 0, 1, 1, -4612.88, -1093.26, 509.641, 3.05433, 0, 0, 0.999048, 0.0436174, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241206, 181017, 0, 1, 1, -5017.75, -1125.04, 509.957, 0.191986, 0, 0, 0.0958456, 0.995396, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241207, 181017, 0, 1, 1, -4601.88, -1010.22, 509.911, 1.81514, 0, 0, 0.78801, 0.615662, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241208, 181017, 0, 1, 1, -4847.69, -1162.96, 508.747, 0.837758, 0, 0, 0.406737, 0.913545, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241209, 181017, 0, 1, 1, -4798.37, -908.976, 503.25, 1.5708, 0, 0, 0.707108, 0.707106, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241210, 181025, 0, 1, 1, -5003.48, -983.329, 510.498, -0.488692, 0, 0, -0.241922, 0.970296, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241211, 181017, 0, 1, 1, -4591.77, -999.464, 508.207, -2.84489, 0, 0, -0.989016, 0.147808, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241212, 181025, 0, 1, 1, -4672.9, -992.939, 510.192, 0.575959, 0, 0, 0.284016, 0.95882, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241213, 181025, 0, 1, 1, -4959.71, -1172.35, 509.83, -2.58309, 0, 0, -0.961262, 0.275636, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241214, 181025, 0, 1, 1, -4720.98, -1235.2, 510.423, 2.1293, 0, 0, 0.874619, 0.48481, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241215, 181017, 0, 1, 1, -4707.57, -948.41, 509.872, 0.907571, 0, 0, 0.438371, 0.898794, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241216, 181017, 0, 1, 1, -4927.71, -1279.47, 509.796, 2.6529, 0, 0, 0.970296, 0.241922, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241217, 181017, 0, 1, 1, -4765.77, -913.387, 508.234, 1.32645, 0, 0, 0.615661, 0.788011, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241218, 181020, 0, 1, 1, -8822.07, 652.003, 95.9321, -1.0821, 0, 0, -0.515036, 0.857168, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241219, 181020, 0, 1, 1, -8811.8, 808.563, 110.495, -2.49582, 0, 0, -0.948324, 0.317305, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241220, 181055, 0, 1, 1, -8862.35, 489.578, 122.263, -2.46091, 0, 0, -0.942641, 0.333809, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241221, 181016, 0, 1, 1, -8833.52, 541.753, 96.9853, 0.942478, 0, 0, 0.453991, 0.891006, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241222, 181017, 0, 1, 1, -8906.31, 628.792, 106.67, -2.63545, 0, 0, -0.968148, 0.250379, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241223, 181019, 0, 1, 1, -8933.17, 629.211, 100.613, 0.017453, 0, 0, 0.00872639, 0.999962, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241224, 181060, 0, 1, 1, -8856.87, 651.243, 97.6127, -0.959931, 0, 0, -0.461749, 0.887011, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241225, 181060, 0, 1, 1, -8861.12, 649.861, 99.5508, -2.1293, 0, 0, -0.874619, 0.48481, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241226, 181060, 0, 1, 1, -8858.38, 652.086, 97.6133, -0.453786, 0, 0, -0.224951, 0.97437, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241227, 181060, 0, 1, 1, -8860.27, 650.596, 99.5508, 2.30383, 0, 0, 0.913544, 0.406739, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241228, 181060, 0, 1, 1, -8862.32, 646.846, 97.6005, 2.82743, 0, 0, 0.987688, 0.156436, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241229, 181060, 0, 1, 1, -8859.86, 647.929, 100.919, 0.977384, 0, 0, 0.469471, 0.882948, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241230, 181060, 0, 1, 1, -8856.46, 647.413, 97.6089, 2.42601, 0, 0, 0.936673, 0.350206, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241231, 181060, 0, 1, 1, -8919.41, 636.825, 100.62, 0.017453, 0, 0, 0.00872639, 0.999962, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241232, 181020, 0, 1, 1, -8811.44, 655.375, 97.0114, -1.81514, 0, 0, -0.78801, 0.615662, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241233, 181060, 0, 1, 1, -8860.19, 645.501, 97.5955, -2.6529, 0, 0, -0.970296, 0.241922, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241234, 181060, 0, 1, 1, -8906.8, 613.516, 100.627, -1.32645, 0, 0, -0.615661, 0.788011, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241235, 181060, 0, 1, 1, -8920.23, 606.277, 100.627, -1.88496, 0, 0, -0.809018, 0.587783, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241236, 181019, 0, 1, 1, -8907.3, 613.16, 100.627, -2.89725, 0, 0, -0.992546, 0.121868, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241237, 181060, 0, 1, 1, -8860.51, 648.487, 100.919, 0.226893, 0, 0, 0.113203, 0.993572, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241238, 181060, 0, 1, 1, -8860.32, 647.253, 99.5508, -1.16937, 0, 0, -0.551937, 0.833886, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241239, 181060, 0, 1, 1, -8861.47, 648.844, 99.5508, -2.79253, 0, 0, -0.984808, 0.173647, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241240, 181060, 0, 1, 1, -8859.06, 647.953, 100.919, -2.25148, 0, 0, -0.902586, 0.430509, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241241, 181060, 0, 1, 1, -8862.29, 651.178, 97.6053, -2.1293, 0, 0, -0.874619, 0.48481, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241242, 181060, 0, 1, 1, -8858.69, 647.248, 99.5508, -2.53073, 0, 0, -0.953717, 0.300705, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241243, 181021, 0, 1, 1, -4641.6, -1178.9, 515.026, -2.05949, 0, 0, -0.857168, 0.515037, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241244, 181017, 0, 1, 1, -4691.64, -1183.9, 509.915, -0.733038, 0, 0, -0.358368, 0.93358, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241245, 181060, 0, 1, 1, -8862.92, 648.115, 97.5961, 3.08923, 0, 0, 0.999657, 0.0261783, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241246, 181060, 0, 1, 1, -8856.95, 646.507, 97.6371, 0.890118, 0, 0, 0.430511, 0.902585, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241247, 181060, 0, 1, 1, -8856.4, 650.419, 97.5945, 1.85005, 0, 0, 0.798636, 0.601815, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241248, 181060, 0, 1, 1, -8858.51, 649.38, 100.919, -0.837758, 0, 0, -0.406737, 0.913545, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241249, 181060, 0, 1, 1, -8859.13, 650.743, 99.5508, 1.46608, 0, 0, 0.669132, 0.743144, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241250, 181016, 0, 1, 1, -8874.09, 640.259, 96.0894, 0.541052, 0, 0, 0.267238, 0.96363, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241251, 181060, 0, 1, 1, -8858.38, 650.422, 99.5508, -1.13446, 0, 0, -0.537298, 0.843393, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241252, 181060, 0, 1, 1, -8860.68, 652.186, 97.5913, -2.80998, 0, 0, -0.986286, 0.165048, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241253, 181060, 0, 1, 1, -8858.82, 645.576, 97.6209, -1.09956, 0, 0, -0.5225, 0.852639, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241254, 181060, 0, 1, 1, -8861.11, 647.936, 99.5508, 2.14675, 0, 0, 0.878816, 0.477161, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241255, 181060, 0, 1, 1, -8861.33, 651.786, 97.6117, 2.72271, 0, 0, 0.978147, 0.207914, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241256, 181060, 0, 1, 1, -8859.11, 649.941, 100.919, 1.44862, 0, 0, 0.662619, 0.748957, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241257, 181060, 0, 1, 1, -8932.71, 629.542, 100.627, -0.331612, 0, 0, -0.165047, 0.986286, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241258, 181019, 0, 1, 1, -8920.66, 606.056, 100.606, 1.0472, 0, 0, 0.500001, 0.866025, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241259, 181060, 0, 1, 1, -8857.83, 649.636, 99.5508, -0.925024, 0, 0, -0.446198, 0.894934, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241260, 181060, 0, 1, 1, -8859.47, 646.978, 99.5508, -1.76278, 0, 0, -0.771624, 0.636079, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241261, 181060, 0, 1, 1, -8920.95, 605.589, 100.62, -1.64061, 0, 0, -0.731354, 0.681998, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241262, 181022, 530, 1, 1, -1915.55, 5296.89, 0.817524, -1.6057, 0, 0, -0.719339, 0.694659, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241263, 181014, 530, 1, 1, -1851.91, 5256.4, -31.2439, -1.55334, 0, 0, -0.700908, 0.713252, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241264, 181022, 530, 1, 1, -1902.35, 5293.58, 0.857056, -2.51327, 0, 0, -0.951056, 0.309019, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241265, 181022, 530, 1, 1, -1990.08, 5210.79, -44.3673, 1.50098, 0, 0, 0.681997, 0.731355, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241266, 181015, 0, 1, 1, -9046.63, 428.583, 93.2955, 2.30383, 0, 0, 0.913544, 0.406739, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241267, 181015, 0, 1, 1, -9066.78, 452.947, 93.2955, -0.767945, 0, 0, -0.374607, 0.927184, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241268, 181016, 530, 1, 1, -2043.99, 5269.15, -39.1957, -0.191986, 0, 0, -0.0958456, 0.995396, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241269, 181022, 530, 1, 1, -2090.42, 5316.59, -37.3235, -0.034907, 0, 0, -0.0174526, 0.999848, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241270, 181022, 530, 1, 1, -1990.25, 5266.93, -42.2252, -1.95477, 0, 0, -0.829038, 0.559192, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241271, 181016, 530, 1, 1, -1778.04, 5263.37, -38.8098, -1.29154, 0, 0, -0.601814, 0.798637, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241272, 181025, 530, 1, 1, -1681.29, 5145.89, -15.7896, 2.21657, 0, 0, 0.894935, 0.446197, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241273, 181014, 530, 1, 1, -1646.27, 5194.14, -18.7777, 2.53073, 0, 0, 0.953717, 0.300705, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241274, 181016, 530, 1, 1, -1769.64, 5268, -38.8098, 3.10669, 0, 0, 0.999848, 0.0174505, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241275, 181055, 530, 1, 1, -1960.27, 5271.78, -26.9706, -2.05949, 0, 0, -0.857168, 0.515037, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241276, 181016, 530, 1, 1, -1845.35, 5128.06, -38.8549, -2.40855, 0, 0, -0.93358, 0.35837, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241277, 181022, 530, 1, 1, -1959.46, 5260.69, -38.8396, -3.01942, 0, 0, -0.998135, 0.0610484, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241278, 181018, 530, 1, 1, -1751.6, 5168.99, -35.2921, -1.50098, 0, 0, -0.681997, 0.731355, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241279, 181022, 530, 1, 1, -1832.6, 5277.45, -12.4281, 1.74533, 0, 0, 0.766045, 0.642787, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241280, 181022, 530, 1, 1, -1755.32, 5315.89, -12.4281, 2.28638, 0, 0, 0.909961, 0.414694, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241281, 181025, 530, 1, 1, -1629.16, 5213.76, -17.4348, 2.47837, 0, 0, 0.945519, 0.325567, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241282, 181016, 530, 1, 1, -1856.03, 5128.53, -38.8556, -0.575959, 0, 0, -0.284016, 0.95882, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241283, 181019, 530, 1, 1, -1929.34, 5312.43, -11.1455, -1.53589, 0, 0, -0.694658, 0.71934, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241284, 181022, 530, 1, 1, -1788.93, 5253.06, -40.2092, -1.29154, 0, 0, -0.601814, 0.798637, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241285, 181016, 530, 1, 1, -1653.31, 5205.2, -38.8578, -1.51844, 0, 0, -0.688356, 0.725373, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241286, 181016, 530, 1, 1, -1767.46, 5264.79, -38.8237, -2.26893, 0, 0, -0.906308, 0.422617, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241287, 181055, 530, 1, 1, -1760.91, 5171.57, -17.2613, 1.8675, 0, 0, 0.803856, 0.594824, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241288, 181025, 530, 1, 1, -2109.01, 5318.35, -16.8746, 0.122173, 0, 0, 0.0610485, 0.998135, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241289, 181025, 530, 1, 1, -2001.1, 5173.34, -16.6093, 0.872665, 0, 0, 0.422618, 0.906308, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241290, 181019, 530, 1, 1, -1899.23, 5148.15, -37.5036, -3.07178, 0, 0, -0.999391, 0.0348993, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241291, 181019, 530, 1, 1, -2062.13, 5316.04, -35.8235, 0.541052, 0, 0, 0.267238, 0.96363, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241292, 181019, 530, 1, 1, -1937.6, 5316.97, -11.1455, -2.74017, 0, 0, -0.979925, 0.199366, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241293, 181055, 530, 1, 1, -1774.86, 5267.38, -27.0181, -1.02974, 0, 0, -0.492422, 0.870357, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241294, 181055, 530, 1, 1, -1852.58, 5113.24, -27.4532, 1.50098, 0, 0, 0.681997, 0.731355, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241295, 181020, 530, 1, 1, -1785.04, 5286.28, -7.83177, 2.09439, 0, 0, 0.866024, 0.500002, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241296, 181016, 530, 1, 1, -1748.06, 5178, -40.2092, 1.46608, 0, 0, 0.669132, 0.743144, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241297, 181022, 530, 1, 1, -1873.24, 5269.36, -12.4281, 1.48353, 0, 0, 0.67559, 0.737277, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241298, 181025, 530, 1, 1, -1880.74, 5115.03, -17.3779, 1.43117, 0, 0, 0.656059, 0.75471, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241299, 181016, 530, 1, 1, -1957.02, 5267.33, -38.8098, -2.1293, 0, 0, -0.874619, 0.48481, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241300, 181020, 530, 1, 1, -1948.56, 5289.85, -7.48382, 1.0472, 0, 0, 0.500001, 0.866025, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241301, 181022, 530, 1, 1, -1970.11, 5267.57, -38.8413, -1.46608, 0, 0, -0.669132, 0.743144, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241302, 181055, 530, 1, 1, -1645.07, 5192.24, -27.4254, 2.56563, 0, 0, 0.958819, 0.284017, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241303, 181016, 530, 1, 1, -1658.77, 5196.1, -38.8613, 0.226893, 0, 0, 0.113203, 0.993572, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241304, 181019, 530, 1, 1, -1794.67, 5314.32, -11.1455, -2.84489, 0, 0, -0.989016, 0.147808, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241305, 181016, 530, 1, 1, -1776.81, 5259.49, -38.8315, -0.20944, 0, 0, -0.104529, 0.994522, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241306, 181025, 530, 1, 1, -1914.49, 5119.9, -16.3917, 1.3439, 0, 0, 0.622513, 0.782609, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241307, 181016, 530, 1, 1, -1965.48, 5271.96, -38.8098, -0.366519, 0, 0, -0.182235, 0.983255, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241308, 181019, 530, 1, 1, -1802.65, 5309.42, -11.1455, -0.541052, 0, 0, -0.267238, 0.96363, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241309, 181025, 530, 1, 1, -1661.08, 5169.22, -17.297, 2.47837, 0, 0, 0.945519, 0.325567, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241310, 181014, 530, 1, 1, -1851.13, 5115.18, -20.3448, 1.46608, 0, 0, 0.669132, 0.743144, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241311, 181025, 530, 1, 1, -1607.47, 5251.37, -16.2881, 2.72271, 0, 0, 0.978147, 0.207914, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241312, 181025, 530, 1, 1, -3855.36, -11639.2, -293.878, -2.47837, 0, 0, -0.945519, 0.325567, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241313, 181025, 530, 1, 1, -3783.92, -11674.6, -93.7094, -3.03687, 0, 0, -0.998629, 0.0523374, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241314, 181019, 530, 1, 1, -4026.65, -11731.5, -150.8, 2.60054, 0, 0, 0.96363, 0.267239, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241315, 181022, 530, 1, 1, -3935.25, -11599.7, -138.455, -0.628319, 0, 0, -0.309017, 0.951056, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241316, 181014, 530, 1, 1, -4011.89, -11672.1, -97.3294, 0.034907, 0, 0, 0.0174526, 0.999848, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241317, 181022, 530, 1, 1, -3903.5, -11599.6, -137.786, -2.35619, 0, 0, -0.923879, 0.382686, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241318, 181022, 530, 1, 1, -3862, -11617.4, -136.833, -1.3439, 0, 0, -0.622513, 0.782609, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241319, 181022, 530, 1, 1, -3988.48, -11651.2, -139.043, 0.383972, 0, 0, 0.190809, 0.981627, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241320, 181025, 530, 1, 1, -3915.05, -11411.2, -111.863, -0.191986, 0, 0, -0.0958456, 0.995396, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241321, 181022, 530, 1, 1, -3657.6, -11491.4, -119.097, 1.98968, 0, 0, 0.838672, 0.544637, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241322, 181027, 530, 1, 1, -3794.8, -11366.1, -138.605, -0.314159, 0, 0, -0.156434, 0.987688, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241323, 181027, 530, 1, 1, -3822.31, -11399.6, -139.054, -2.98451, 0, 0, -0.996917, 0.0784606, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241324, 181014, 530, 1, 1, -3785.23, -11420.6, -122.395, -2.05949, 0, 0, -0.857168, 0.515037, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241325, 181022, 530, 1, 1, -3903.45, -11420.8, -132.774, 0.191986, 0, 0, 0.0958456, 0.995396, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241326, 181022, 530, 1, 1, -3753.63, -11517.7, -134.327, 2.09439, 0, 0, 0.866024, 0.500002, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241327, 181022, 530, 1, 1, -3732.54, -11501, -134.029, 2.37365, 0, 0, 0.927184, 0.374606, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241328, 181027, 530, 1, 1, -3745.38, -11403.9, -138.167, 2.32129, 0, 0, 0.91706, 0.398748, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241329, 181025, 530, 1, 1, -3848.6, -11508.4, -128.93, 0.733038, 0, 0, 0.358368, 0.93358, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241330, 181022, 530, 1, 1, -4120.5, -11437.1, -130.379, -1.44862, 0, 0, -0.662619, 0.748957, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241331, 181016, 530, 1, 1, -4008.93, -11351, -122.814, -2.07694, 0, 0, -0.861629, 0.507539, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241332, 181022, 530, 1, 1, -4016.02, -11510.5, -141.07, 2.87979, 0, 0, 0.991445, 0.130528, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241333, 181022, 530, 1, 1, -4144.75, -11423.6, -130.672, -2.80998, 0, 0, -0.986286, 0.165048, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241334, 181016, 530, 1, 1, -4150.39, -11469.8, -130.923, 2.70526, 0, 0, 0.976296, 0.21644, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241335, 181016, 530, 1, 1, -3979.87, -11369.4, -122.542, 1.37881, 0, 0, 0.636078, 0.771625, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241336, 181025, 530, 1, 1, -4097.35, -11552.9, -124.006, 1.88496, 0, 0, 0.809018, 0.587783, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241337, 181022, 530, 1, 1, -4105.22, -11544.5, -135.782, 1.6057, 0, 0, 0.719339, 0.694659, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241338, 181016, 530, 1, 1, -3988.78, -11386.5, -122.712, -0.977384, 0, 0, -0.469471, 0.882948, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241339, 181022, 530, 1, 1, -4122.2, -11707.3, -142.921, 1.8326, 0, 0, 0.793355, 0.60876, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241340, 181016, 530, 1, 1, -4229.96, -11608.4, -126.283, 0.837758, 0, 0, 0.406737, 0.913545, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241341, 181022, 530, 1, 1, -4102.17, -11696.3, -142.664, 2.46091, 0, 0, 0.942641, 0.333809, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241342, 181016, 530, 1, 1, -4204.82, -11678.5, -143.192, 0.401426, 0, 0, 0.199368, 0.979925, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241343, 181025, 530, 1, 1, -4066.7, -11607.9, -129.409, -2.18166, 0, 0, -0.88701, 0.461749, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241344, 181016, 530, 1, 1, -4194.74, -11728.5, -143.451, -3.03687, 0, 0, -0.998629, 0.0523374, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241345, 181016, 530, 1, 1, -4209.64, -11675.4, -143.244, -0.383972, 0, 0, -0.190809, 0.981627, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241346, 181022, 530, 1, 1, -2160.86, 5510.71, 50.6184, 0.087266, 0, 0, 0.0436192, 0.999048, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241347, 181027, 530, 1, 1, -2137.63, 5515.58, 48.8234, -2.70526, 0, 0, -0.976296, 0.21644, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241348, 181018, 530, 1, 1, -2241.45, 5521.86, 71.3778, -1.95477, 0, 0, -0.829038, 0.559192, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241349, 181018, 530, 1, 1, -1878.37, 5489.22, -7.27279, -1.71042, 0, 0, -0.754709, 0.65606, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241350, 181055, 530, 1, 1, -1712.13, 5480.59, -1.88464, 2.04204, 0, 0, 0.852641, 0.522496, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241351, 181055, 530, 1, 1, -1799.06, 5457.25, 1.84576, 0.471239, 0, 0, 0.233445, 0.97237, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241352, 181055, 530, 1, 1, -1890.6, 5347.04, 7.48526, -1.91986, 0, 0, -0.819151, 0.573577, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241353, 181022, 530, 1, 1, -1971.56, 5543.56, -12.4281, -0.785398, 0, 0, -0.382683, 0.92388, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241354, 181055, 530, 1, 1, -1944.98, 5457.33, 7.48845, 2.79253, 0, 0, 0.984808, 0.173647, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241355, 181055, 530, 1, 1, -1837.67, 5500.06, 7.75819, 1.20428, 0, 0, 0.566407, 0.824125, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241356, 181055, 530, 1, 1, -1844.25, 5491.67, 7.61545, 1.25664, 0, 0, 0.587786, 0.809016, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241357, 181055, 530, 1, 1, -1780.94, 5402.12, 7.49757, -0.296706, 0, 0, -0.147809, 0.989016, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241358, 181018, 530, 1, 1, -1819.39, 5465.01, -5.34651, -2.32129, 0, 0, -0.91706, 0.398748, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241359, 181022, 530, 1, 1, -1770.18, 5653.32, 130.298, -2.54818, 0, 0, -0.956305, 0.292372, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241360, 181027, 530, 1, 1, -1806.01, 5872.18, 128.392, 0.628319, 0, 0, 0.309017, 0.951056, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241361, 181027, 530, 1, 1, -1590.15, 5743.51, 128.392, 0.034907, 0, 0, 0.0174526, 0.999848, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241362, 181027, 530, 1, 1, -1842.6, 5851.38, 128.392, 2.23402, 0, 0, 0.898794, 0.438372, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241363, 181027, 530, 1, 1, -1653.34, 5787.46, 128.392, 0.925024, 0, 0, 0.446198, 0.894934, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241364, 181055, 530, 1, 1, -2013.85, 5671.15, 104.976, -2.68781, 0, 0, -0.97437, 0.22495, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241365, 181027, 530, 1, 1, -1876.27, 5853.06, 128.392, -1.32645, 0, 0, -0.615661, 0.788011, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241366, 181027, 530, 1, 1, -1816.2, 5733.48, 128.392, 1.06465, 0, 0, 0.507538, 0.861629, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241367, 181022, 530, 1, 1, -2050.71, 5478.4, 54.0608, 0.226893, 0, 0, 0.113203, 0.993572, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241368, 181022, 530, 1, 1, -2063.06, 5662.04, 51.2669, -1.15192, 0, 0, -0.54464, 0.83867, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241369, 181017, 530, 1, 1, -2128.88, 5392.15, 61.9466, -0.279253, 0, 0, -0.139173, 0.990268, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241370, 181022, 530, 1, 1, -2042.6, 5503.58, 54.0677, -0.698132, 0, 0, -0.34202, 0.939693, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241371, 181027, 530, 1, 1, -2130.38, 5510.7, 48.7748, -2.35619, 0, 0, -0.923879, 0.382686, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241372, 181017, 530, 1, 1, -2129.46, 5389.03, 61.9608, 2.89725, 0, 0, 0.992546, 0.121868, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241373, 181025, 530, 1, 1, -1604.81, 5444.83, -17.9287, -2.96706, 0, 0, -0.996195, 0.0871556, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241374, 181019, 530, 1, 1, -1728.95, 5422.56, -11.1455, 0.802851, 0, 0, 0.390731, 0.920505, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241375, 181019, 530, 1, 1, -1729.21, 5431.98, -11.1455, -3.12414, 0, 0, -0.999962, 0.0087262, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241376, 181016, 530, 1, 1, -2039, 5348.27, -39.6072, -2.42601, 0, 0, -0.936673, 0.350206, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241377, 181022, 530, 1, 1, -1674.44, 5406.26, -40.406, -0.122173, 0, 0, -0.0610485, 0.998135, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241378, 181016, 530, 1, 1, -1671.69, 5430.75, -38.8296, -0.994838, 0, 0, -0.477159, 0.878817, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241379, 181025, 530, 1, 1, -3861.94, -11726.7, -264.663, 2.42601, 0, 0, 0.936673, 0.350206, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241380, 181022, 530, 1, 1, -2148.99, 5544.24, 50.5961, -0.715585, 0, 0, -0.350207, 0.936672, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241381, 181019, 530, 1, 1, -3918.32, -11545.5, -149.044, 0.471239, 0, 0, 0.233445, 0.97237, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241382, 181022, 530, 1, 1, -3974.52, -11624.7, -138.876, -1.37881, 0, 0, -0.636078, 0.771625, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241383, 181014, 530, 1, 1, -3866.91, -11587.1, -96.3765, 1.22173, 0, 0, 0.573576, 0.819152, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241384, 181019, 530, 1, 1, -3743.69, -11697.8, -104.624, -3.10669, 0, 0, -0.999848, 0.0174505, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241385, 181016, 530, 1, 1, -3931.24, -11649.4, -135.003, 1.71042, 0, 0, 0.754709, 0.65606, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241386, 181014, 530, 1, 1, -4014.81, -11671.7, -97.8474, 3.07178, 0, 0, 0.999391, 0.0348993, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241387, 181018, 530, 1, 1, -3758.17, -11705.3, -100.718, 0.087266, 0, 0, 0.0436192, 0.999048, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241388, 181019, 530, 1, 1, -3740.33, -11688.6, -104.605, -1.309, 0, 0, -0.608763, 0.793352, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241389, 181025, 530, 1, 1, -3964.06, -11674.8, -216.94, 0.10472, 0, 0, 0.0523361, 0.99863, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241390, 181025, 530, 1, 1, -3662.13, -11454, -113.087, -2.94961, 0, 0, -0.995396, 0.095844, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241391, 181022, 530, 1, 1, -3843.45, -11503.5, -139.097, 0.785398, 0, 0, 0.382683, 0.92388, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241392, 181025, 530, 1, 1, -3905.15, -11333.2, -121.921, -1.09956, 0, 0, -0.5225, 0.852639, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241393, 181027, 530, 1, 1, -3756.68, -11382.5, -138.219, 0.314159, 0, 0, 0.156434, 0.987688, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241394, 181025, 530, 1, 1, -3822.29, -11521.8, -128.501, 1.46608, 0, 0, 0.669132, 0.743144, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241395, 181022, 530, 1, 1, -3821.2, -11515.7, -138.644, 1.51844, 0, 0, 0.688356, 0.725373, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241396, 181022, 530, 1, 1, -3898.61, -11445.4, -132.852, 0.10472, 0, 0, 0.0523361, 0.99863, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241397, 181027, 530, 1, 1, -3788.14, -11452.6, -138.854, 1.02974, 0, 0, 0.492422, 0.870357, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241398, 181025, 530, 1, 1, -3905.57, -11457.8, -112.987, 1.11701, 0, 0, 0.529919, 0.848048, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241399, 181027, 530, 1, 1, -3769.16, -11443.2, -138.595, 1.46608, 0, 0, 0.669132, 0.743144, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241400, 181022, 530, 1, 1, -3968.96, -11453.9, -136.772, 1.69297, 0, 0, 0.748956, 0.66262, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241401, 181022, 530, 1, 1, -4030.15, -11520.6, -141.262, 1.65806, 0, 0, 0.737276, 0.675591, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241402, 181016, 530, 1, 1, -3987.21, -11495.5, -137.144, 2.25148, 0, 0, 0.902586, 0.430509, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241403, 181014, 530, 1, 1, -4022.1, -11517.6, -123.535, 2.1293, 0, 0, 0.874619, 0.48481, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241404, 181016, 530, 1, 1, -4149.01, -11480.6, -130.894, -0.383972, 0, 0, -0.190809, 0.981627, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241405, 181025, 530, 1, 1, -4091.52, -11339.2, -129.598, -1.01229, 0, 0, -0.484809, 0.87462, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241406, 181022, 530, 1, 1, -4019.3, -11367.6, -123.678, -1.72788, 0, 0, -0.760407, 0.649446, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241407, 181022, 530, 1, 1, -4000.54, -11392.8, -123.377, -3.12414, 0, 0, -0.999962, 0.0087262, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241408, 181022, 530, 1, 1, -3973.86, -11427.1, -136.736, -2.44346, 0, 0, -0.939692, 0.342021, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241409, 181016, 530, 1, 1, -3990.31, -11353.1, -122.603, -0.802851, 0, 0, -0.390731, 0.920505, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241410, 181017, 530, 1, 1, -4213.73, -11685.4, -130.823, 0.942478, 0, 0, 0.453991, 0.891006, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241411, 181016, 530, 1, 1, -4196.21, -11595.3, -125.408, 1.23918, 0, 0, 0.580701, 0.814117, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241412, 181016, 530, 1, 1, -4155.24, -11635.5, -98.1756, -0.907571, 0, 0, -0.438371, 0.898794, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241413, 181016, 530, 1, 1, -4180.39, -11587, -123.98, -0.663225, 0, 0, -0.325568, 0.945519, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241414, 181016, 530, 1, 1, -4253.19, -11675.3, -143.765, -1.6057, 0, 0, -0.719339, 0.694659, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241415, 181016, 530, 1, 1, -4163.96, -11666.7, -143.258, -1.6057, 0, 0, -0.719339, 0.694659, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241416, 181016, 530, 1, 1, -4225.97, -11648.1, -143.864, -0.401426, 0, 0, -0.199368, 0.979925, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241417, 181016, 530, 1, 1, -4154.53, -11704.8, -143.319, -0.296706, 0, 0, -0.147809, 0.989016, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241418, 181016, 530, 1, 1, -4200.81, -11604.3, -125.62, 0.471239, 0, 0, 0.233445, 0.97237, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241419, 181055, 530, 1, 1, -1836.34, 5366.17, 1.70427, -1.15192, 0, 0, -0.54464, 0.83867, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241420, 181020, 530, 1, 1, -1735.22, 5482.75, -5.75612, 2.33874, 0, 0, 0.920505, 0.390732, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241421, 181055, 530, 1, 1, -1891.23, 5493.7, 1.68948, 2.00713, 0, 0, 0.843392, 0.537299, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241422, 181055, 530, 1, 1, -1899.79, 5489.58, 1.69476, 2.04204, 0, 0, 0.852641, 0.522496, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241423, 181055, 530, 1, 1, -1928.54, 5402.78, 1.63635, -2.67035, 0, 0, -0.972369, 0.233447, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241424, 181055, 530, 1, 1, -1927.29, 5449.41, 7.55945, 2.80998, 0, 0, 0.986286, 0.165048, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241425, 181014, 530, 1, 1, -1922.03, 5479.75, -9.39029, 2.9147, 0, 0, 0.993572, 0.113203, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241426, 181018, 530, 1, 1, -1848.54, 5370.87, -7.43418, 1.55334, 0, 0, 0.700908, 0.713252, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241427, 181027, 530, 1, 1, -1818.45, 5777.39, 128.392, 1.11701, 0, 0, 0.529919, 0.848048, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241428, 181025, 530, 1, 1, -1805.76, 5740.25, 183.839, -2.25148, 0, 0, -0.902586, 0.430509, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241429, 181025, 530, 1, 1, -1725.36, 5731.83, 185.426, 1.76278, 0, 0, 0.771624, 0.636079, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241430, 181027, 530, 1, 1, -1578.03, 5685.57, 128.392, 0.855211, 0, 0, 0.414693, 0.909961, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241431, 181020, 530, 1, 1, -1738.64, 5649.23, 134.234, 1.51844, 0, 0, 0.688356, 0.725373, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241432, 181055, 530, 1, 1, -1749.12, 5825.38, 154.661, -0.296706, 0, 0, -0.147809, 0.989016, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241433, 181027, 530, 1, 1, -1934.56, 5818.96, 128.392, 0.872665, 0, 0, 0.422618, 0.906308, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241434, 181055, 530, 1, 1, -1663.9, 5690.38, 136.355, 2.53073, 0, 0, 0.953717, 0.300705, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241435, 181017, 530, 1, 1, -2130.48, 5385.97, 61.9326, -0.226893, 0, 0, -0.113203, 0.993572, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241436, 181027, 530, 1, 1, -2122.91, 5522.92, 48.7609, -0.2618, 0, 0, -0.130526, 0.991445, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241437, 181022, 530, 1, 1, -2055.19, 5638.79, 51.2669, 1.5708, 0, 0, 0.707108, 0.707106, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241438, 181017, 530, 1, 1, -2036.9, 5584.01, 61.2659, 2.63545, 0, 0, 0.968148, 0.250379, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241439, 181018, 530, 1, 1, -2074.97, 5487.17, 69.042, 0.122173, 0, 0, 0.0610485, 0.998135, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241440, 181025, 530, 1, 1, -2108.51, 5552.2, 90.3296, -0.802851, 0, 0, -0.390731, 0.920505, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241441, 181018, 530, 1, 1, -2032.99, 5591.94, 58.0987, 2.58309, 0, 0, 0.961262, 0.275636, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241442, 181014, 530, 1, 1, -1683.75, 5519.37, -16.1639, 0.453786, 0, 0, 0.224951, 0.97437, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241443, 181014, 530, 1, 1, -2045.59, 5339.43, -16.0999, -2.68781, 0, 0, -0.97437, 0.22495, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241444, 181055, 530, 1, 1, -1678.58, 5425.51, -27.1223, 0.034907, 0, 0, 0.0174526, 0.999848, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241445, 181020, 530, 1, 1, -1699.82, 5426.39, -7.90853, 3.14159, 0, 0, 1, 1.26759e-006, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241446, 181018, 530, 1, 1, -3740.87, -11676.4, -98.6888, -1.15192, 0, 0, -0.54464, 0.83867, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241447, 181022, 530, 1, 1, -3970.78, -11722.9, -138.836, 1.51844, 0, 0, 0.688356, 0.725373, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241448, 181016, 530, 1, 1, -3938.11, -11702, -135.276, 1.50098, 0, 0, 0.681997, 0.731355, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241449, 181022, 530, 1, 1, -3985.05, -11695.9, -139.366, -0.541052, 0, 0, -0.267238, 0.96363, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241450, 181016, 530, 1, 1, -3928.31, -11712.5, -135.206, -1.13446, 0, 0, -0.537298, 0.843393, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241451, 181025, 530, 1, 1, -3942.77, -11633, -199.473, -0.785398, 0, 0, -0.382683, 0.92388, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241452, 181019, 530, 1, 1, -3919.78, -11545.5, -149.061, 0.10472, 0, 0, 0.0523361, 0.99863, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241453, 181016, 530, 1, 1, -3943.49, -11689.1, -135.289, 0.610865, 0, 0, 0.300706, 0.953717, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241454, 181027, 530, 1, 1, -3807.17, -11439.6, -139.028, 1.43117, 0, 0, 0.656059, 0.75471, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241455, 181025, 530, 1, 1, -3666.97, -11418.3, -113.767, -2.94961, 0, 0, -0.995396, 0.095844, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241456, 181022, 530, 1, 1, -3640.53, -11468.6, -118.809, 3.01942, 0, 0, 0.998135, 0.0610484, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241457, 181027, 530, 1, 1, -3774.08, -11374, -138.391, -1.72788, 0, 0, -0.760407, 0.649446, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241458, 181027, 530, 1, 1, -3754.07, -11431.4, -138.373, 2.09439, 0, 0, 0.866024, 0.500002, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241459, 181027, 530, 1, 1, -3816.79, -11421.2, -139.071, -1.01229, 0, 0, -0.484809, 0.87462, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241460, 181025, 530, 1, 1, -4142.5, -11540, -124.575, 0.837758, 0, 0, 0.406737, 0.913545, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241461, 181016, 530, 1, 1, -4070.25, -11542.5, -138.655, -1.72788, 0, 0, -0.760407, 0.649446, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241462, 181022, 530, 1, 1, -4127.21, -11534.9, -136.013, 0.628319, 0, 0, 0.309017, 0.951056, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241463, 181016, 530, 1, 1, -4072.73, -11547.7, -138.704, 0.977384, 0, 0, 0.469471, 0.882948, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241464, 181016, 530, 1, 1, -3979.76, -11500.8, -137.077, -0.034907, 0, 0, -0.0174526, 0.999848, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241465, 181014, 530, 1, 1, -3991.59, -11552.5, -122.169, -0.942478, 0, 0, -0.453991, 0.891006, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241466, 181016, 530, 1, 1, -4178.04, -11713.5, -143.602, 0.785398, 0, 0, 0.382683, 0.92388, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241467, 181016, 530, 1, 1, -4244.82, -11658, -143.625, 1.72788, 0, 0, 0.760407, 0.649446, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241468, 181016, 530, 1, 1, -4207.49, -11645, -143.677, 0.10472, 0, 0, 0.0523361, 0.99863, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241469, 181016, 530, 1, 1, -4185.57, -11653.1, -143.449, -1.23918, 0, 0, -0.580701, 0.814117, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241470, 181025, 530, 1, 1, -4036.07, -11724.3, -125.336, 2.19912, 0, 0, 0.891008, 0.453988, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241471, 181022, 530, 1, 1, -4129.01, -11606.8, -139.121, -2.07694, 0, 0, -0.861629, 0.507539, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241472, 181016, 530, 1, 1, -4065.43, -11688.8, -142.188, 0.383972, 0, 0, 0.190809, 0.981627, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241473, 181018, 530, 1, 1, -2152.76, 5556.38, 56.7827, -0.680679, 0, 0, -0.333807, 0.942641, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241474, 181027, 530, 1, 1, -2137.1, 5523.46, 48.7886, 0.994838, 0, 0, 0.477159, 0.878817, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241475, 181055, 530, 1, 1, -1801.54, 5407.85, 7.50799, -0.2618, 0, 0, -0.130526, 0.991445, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241476, 181055, 530, 1, 1, -1835.98, 5512.57, 7.71273, 1.309, 0, 0, 0.608763, 0.793352, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241477, 181014, 530, 1, 1, -1913.36, 5372.71, -8.98531, -2.05949, 0, 0, -0.857168, 0.515037, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241478, 181020, 530, 1, 1, -1744.36, 5500.14, -5.79974, -1.46608, 0, 0, -0.669132, 0.743144, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241479, 181055, 530, 1, 1, -1935.77, 5455.92, 7.52349, 2.75762, 0, 0, 0.981627, 0.190809, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241480, 181018, 530, 1, 1, -1994.47, 5375.46, -5.8507, -0.802851, 0, 0, -0.390731, 0.920505, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241481, 181018, 530, 1, 1, -2030.6, 5346.62, 4.62407, 0.471239, 0, 0, 0.233445, 0.97237, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241482, 181055, 530, 1, 1, -2017.71, 5378.45, -1.3333, -1.06465, 0, 0, -0.507538, 0.861629, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241483, 181014, 530, 1, 1, -1788.14, 5434.84, -9.16044, -0.279253, 0, 0, -0.139173, 0.990268, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241484, 181018, 530, 1, 1, -1808.96, 5444.12, -5.37707, -2.98451, 0, 0, -0.996917, 0.0784606, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241485, 181027, 530, 1, 1, -1809.44, 5713.65, 128.392, -2.56563, 0, 0, -0.958819, 0.284017, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241486, 181027, 530, 1, 1, -1680.33, 5852.64, 128.392, -2.77507, 0, 0, -0.983255, 0.182237, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241487, 181027, 530, 1, 1, -1746.6, 5680.22, 128.392, -1.85005, 0, 0, -0.798636, 0.601815, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241488, 181027, 530, 1, 1, -1801.58, 5805.58, 128.392, 3.14159, 0, 0, 1, 1.26759e-006, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241489, 181027, 530, 1, 1, -1605.82, 5726.71, 128.392, 2.80998, 0, 0, 0.986286, 0.165048, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241490, 181014, 530, 1, 1, -1823.32, 5586.12, 70.5835, -2.94961, 0, 0, -0.995396, 0.095844, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241491, 181027, 530, 1, 1, -1748.45, 5867.35, 128.392, -0.20944, 0, 0, -0.104529, 0.994522, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241492, 181055, 530, 1, 1, -1815.83, 5572.96, 43.6028, -1.91986, 0, 0, -0.819151, 0.573577, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241493, 181027, 530, 1, 1, -1908.6, 5810.32, 128.392, 2.02458, 0, 0, 0.848048, 0.52992, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241494, 181017, 530, 1, 1, -2035.57, 5586.85, 61.2448, -0.506145, 0, 0, -0.25038, 0.968148, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241495, 181017, 530, 1, 1, -2038.49, 5581.26, 61.2448, -0.506145, 0, 0, -0.25038, 0.968148, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241496, 181025, 530, 1, 1, -2132.69, 5479.24, 90.53, 0.314159, 0, 0, 0.156434, 0.987688, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241497, 181018, 530, 1, 1, -2041.48, 5576.19, 58.1513, 2.63545, 0, 0, 0.968148, 0.250379, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241498, 181018, 530, 1, 1, -2066.62, 5515.95, 69.0169, -0.767945, 0, 0, -0.374607, 0.927184, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241499, 181027, 530, 1, 1, -2123.15, 5515.09, 48.8095, -0.994838, 0, 0, -0.477159, 0.878817, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241500, 181016, 530, 1, 1, -1694.05, 5524.4, -40.3726, 1.95477, 0, 0, 0.829038, 0.559192, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241501, 181016, 530, 1, 1, -2035.2, 5336.3, -41.1791, 1.43117, 0, 0, 0.656059, 0.75471, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241502, 181019, 530, 1, 1, -1728.32, 5505.17, -8.59806, -0.401426, 0, 0, -0.199368, 0.979925, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241503, 181016, 530, 1, 1, -2034.28, 5338.98, -39.5669, -2.9147, 0, 0, -0.993572, 0.113203, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241504, 181022, 530, 1, 1, -1894.68, 5582.58, -12.4281, -1.37881, 0, 0, -0.636078, 0.771625, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241505, 181014, 530, 1, 1, -1868.24, 5505.88, -9.41111, 1.13446, 0, 0, 0.537298, 0.843393, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241506, 181022, 530, 1, 1, -1728.79, 5341.39, -12.4281, 2.49582, 0, 0, 0.948324, 0.317305, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241507, 181014, 530, 1, 1, -1805.69, 5381.32, -10.5112, -0.15708, 0, 0, -0.0784593, 0.996917, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241508, 181055, 530, 1, 1, -1827.95, 5370.52, 1.71148, -1.02974, 0, 0, -0.492422, 0.870357, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241509, 181055, 530, 1, 1, -1889.78, 5355.28, 7.54016, -1.8326, 0, 0, -0.793355, 0.60876, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241510, 181018, 530, 1, 1, -1985.63, 5358.4, -5.78986, 1.76278, 0, 0, 0.771624, 0.636079, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241511, 181055, 530, 1, 1, -1997.6, 5338.07, -1.49292, 2.00713, 0, 0, 0.843392, 0.537299, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241512, 181055, 530, 1, 1, -1731.91, 5520.3, -1.93907, -1.11701, 0, 0, -0.529919, 0.848048, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241513, 181020, 530, 1, 1, -1721.56, 5649.61, 133.669, 1.50098, 0, 0, 0.681997, 0.731355, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241514, 181025, 530, 1, 1, -1937.85, 5844.37, 174.749, -1.16937, 0, 0, -0.551937, 0.833886, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241515, 181027, 530, 1, 1, -1693.72, 5760.1, 128.392, 0.279253, 0, 0, 0.139173, 0.990268, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241516, 181055, 530, 1, 1, -1812.53, 5583.48, 120.571, -1.85005, 0, 0, -0.798636, 0.601815, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241517, 181027, 530, 1, 1, -1847.44, 5826.24, 128.392, 0.418879, 0, 0, 0.207912, 0.978148, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241518, 181027, 530, 1, 1, -1820, 5834.81, 128.392, 0.349066, 0, 0, 0.173648, 0.984808, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241519, 181027, 530, 1, 1, -1637.91, 5746.33, 128.392, 1.81514, 0, 0, 0.78801, 0.615662, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241520, 181020, 530, 1, 1, -1748.65, 5816.41, 153.454, -2.18166, 0, 0, -0.88701, 0.461749, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241521, 181027, 530, 1, 1, -1733, 5692.91, 128.392, 0.349066, 0, 0, 0.173648, 0.984808, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241522, 181027, 530, 1, 1, -1715.05, 5696.39, 128.392, 3.10669, 0, 0, 0.999848, 0.0174505, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241523, 181027, 530, 1, 1, -2129.13, 5527.38, 48.872, 0.453786, 0, 0, 0.224951, 0.97437, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241524, 181016, 530, 1, 1, -1676.44, 5420.81, -38.8098, -1.71042, 0, 0, -0.754709, 0.65606, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241525, 181019, 530, 1, 1, -1721.6, 5491.37, -8.50778, -2.6529, 0, 0, -0.970296, 0.241922, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241526, 181016, 530, 1, 1, -1695.16, 5519.63, -39.9827, 0.087266, 0, 0, 0.0436192, 0.999048, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241527, 181016, 530, 1, 1, -1671.23, 5419.22, -38.8372, 1.01229, 0, 0, 0.484809, 0.87462, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241528, 181016, 530, 1, 1, -1690.31, 5510, -40.003, 0.698132, 0, 0, 0.34202, 0.939693, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241529, 181022, 530, 1, 1, -2139.51, 5380.51, 51.2669, 3.00197, 0, 0, 0.997564, 0.0697546, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241530, 181018, 530, 1, 1, -2169.22, 5503.56, 55.6647, 0.226893, 0, 0, 0.113203, 0.993572, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241531, 181022, 530, 1, 1, -2134.33, 5401.41, 51.2669, 2.77507, 0, 0, 0.983255, 0.182237, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241532, 181018, 530, 1, 1, -2229.14, 5527.6, 71.4264, -0.366519, 0, 0, -0.182235, 0.983255, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241533, 181018, 530, 1, 1, -2213.88, 5572.59, 71.3411, -0.191986, 0, 0, -0.0958456, 0.995396, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241534, 181025, 530, 1, 1, -3840.37, -11683.5, -278.931, 3.07178, 0, 0, 0.999391, 0.0348993, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241535, 181019, 530, 1, 1, -3744.04, -11692.4, -104.606, -2.86234, 0, 0, -0.990268, 0.139173, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241536, 181014, 530, 1, 1, -3868.66, -11590.5, -95.2881, -2.05949, 0, 0, -0.857168, 0.515037, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241537, 181016, 530, 1, 1, -3891.19, -11640.6, -134.491, 1.29154, 0, 0, 0.601814, 0.798637, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241538, 181025, 530, 1, 1, -3905.84, -11628.6, -302.981, -0.10472, 0, 0, -0.0523361, 0.99863, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241539, 181016, 530, 1, 1, -4065.59, -11664.2, -142.101, 0.226893, 0, 0, 0.113203, 0.993572, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241540, 181016, 530, 1, 1, -4167.56, -11641.1, -98.394, 1.13446, 0, 0, 0.537298, 0.843393, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241541, 181022, 530, 1, 1, -4158, -11597.3, -138.91, -1.44862, 0, 0, -0.662619, 0.748957, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241542, 181025, 530, 1, 1, -3855.82, -11639.5, -169.809, -2.32129, 0, 0, -0.91706, 0.398748, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241543, 181018, 530, 1, 1, -3759.18, -11686.5, -100.743, -0.10472, 0, 0, -0.0523361, 0.99863, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241544, 181019, 530, 1, 1, -3739.73, -11701.3, -104.592, 2.44346, 0, 0, 0.939692, 0.342021, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241545, 181025, 530, 1, 1, -3802.61, -11620.2, -92.7153, -1.53589, 0, 0, -0.694658, 0.71934, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241546, 181016, 530, 1, 1, -3943.94, -11674.1, -135.239, -2.68781, 0, 0, -0.97437, 0.22495, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241547, 181016, 530, 1, 1, -3919.52, -11642, -134.831, 0.20944, 0, 0, 0.104529, 0.994522, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241548, 181014, 530, 1, 1, -3966.45, -11587.6, -97.8169, 2.16421, 0, 0, 0.882948, 0.469471, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241549, 181016, 530, 1, 1, -3939.98, -11660.9, -135.145, -2.40855, 0, 0, -0.93358, 0.35837, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241550, 181025, 530, 1, 1, -3794.91, -11730.6, -93.0703, 2.11185, 0, 0, 0.870356, 0.492423, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241551, 181022, 530, 1, 1, -1854.36, 5590.51, -12.4281, -1.67552, 0, 0, -0.743146, 0.669129, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241552, 181018, 530, 1, 1, -1907.78, 5394.67, -5.28488, 0.802851, 0, 0, 0.390731, 0.920505, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241553, 181055, 530, 1, 1, -1883.6, 5366.06, 7.45777, -1.88496, 0, 0, -0.809018, 0.587783, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241554, 181018, 530, 1, 1, -1825.73, 5382.07, -7.43947, 2.33874, 0, 0, 0.920505, 0.390732, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241555, 181014, 530, 1, 1, -1939.43, 5424.04, -7.21451, 2.89725, 0, 0, 0.992546, 0.121868, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241556, 181055, 530, 1, 1, -1803.72, 5465.47, 1.85631, 0.575959, 0, 0, 0.284016, 0.95882, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241557, 181014, 530, 1, 1, -1860.15, 5353.87, -8.76788, -2.09439, 0, 0, -0.866024, 0.500002, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241558, 181055, 530, 1, 1, -1791.01, 5407.31, 7.59955, -0.383972, 0, 0, -0.190809, 0.981627, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241559, 181018, 530, 1, 1, -1918.4, 5415.82, -5.38689, 0.139626, 0, 0, 0.0697563, 0.997564, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241560, 181022, 530, 1, 1, -1996.99, 5518.17, -12.4281, -0.593412, 0, 0, -0.292372, 0.956305, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241561, 181014, 530, 1, 1, -1799.89, 5581.87, 70.7193, -0.855212, 0, 0, -0.414694, 0.909961, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241562, 181027, 530, 1, 1, -1641, 5810.85, 128.392, -2.16421, 0, 0, -0.882948, 0.469471, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241563, 181055, 530, 1, 1, -1729.52, 5621.41, 133.746, -1.51844, 0, 0, -0.688356, 0.725373, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241564, 181055, 530, 1, 1, -1730.33, 5649.34, 136.299, 1.58825, 0, 0, 0.713251, 0.700909, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241565, 181055, 530, 1, 1, -1653.5, 5684.1, 136.717, 2.68781, 0, 0, 0.97437, 0.22495, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241566, 181027, 530, 1, 1, -1695.73, 5734.96, 128.392, 1.55334, 0, 0, 0.700908, 0.713252, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241567, 181020, 530, 1, 1, -1867.04, 5666.15, 133.531, 1.39626, 0, 0, 0.642786, 0.766046, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241568, 181055, 530, 1, 1, -1718.13, 5815.12, 154.798, 2.77507, 0, 0, 0.983255, 0.182237, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241569, 181022, 530, 1, 1, -1726.98, 5770.61, 146.44, -2.05949, 0, 0, -0.857168, 0.515037, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241570, 181022, 530, 1, 1, -1962.95, 5684.21, 117.663, 2.98451, 0, 0, 0.996917, 0.0784606, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241571, 181025, 530, 1, 1, -1596.01, 5391.45, -17.6645, -3.07178, 0, 0, -0.999391, 0.0348993, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241572, 181025, 530, 1, 1, -1586.88, 5351.19, -16.5735, -3.00197, 0, 0, -0.997564, 0.0697546, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241573, 181019, 530, 1, 1, -3924.43, -11545.5, -149.111, 2.60054, 0, 0, 0.96363, 0.267239, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241574, 181016, 530, 1, 1, -3905.64, -11638.8, -134.663, -0.418879, 0, 0, -0.207912, 0.978148, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241575, 181025, 530, 1, 1, -3897.79, -11618.4, -185.584, -1.58825, 0, 0, -0.713251, 0.700909, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241576, 181025, 530, 1, 1, -3949.17, -11719.7, -231.763, 0.663225, 0, 0, 0.325568, 0.945519, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241577, 181016, 530, 1, 1, -3877.95, -11647.4, -134.368, -1.6057, 0, 0, -0.719339, 0.694659, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241578, 181014, 530, 1, 1, -3966.36, -11588.2, -97.234, -0.977384, 0, 0, -0.469471, 0.882948, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241579, 181019, 530, 1, 1, -3913.77, -11545.5, -148.998, 0.471239, 0, 0, 0.233445, 0.97237, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241580, 181055, 530, 1, 1, -1924.2, 5394.32, 1.63551, -2.67035, 0, 0, -0.972369, 0.233447, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241581, 181014, 530, 1, 1, -1813.67, 5487.48, -9.94172, 1.13446, 0, 0, 0.537298, 0.843393, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241582, 181018, 530, 1, 1, -1698.84, 5512.11, 4.84271, -2.51327, 0, 0, -0.951056, 0.309019, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241583, 181018, 530, 1, 1, -1902.04, 5477.41, -7.33749, -0.645772, 0, 0, -0.317305, 0.948324, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241584, 181025, 530, 1, 1, -1723.07, 5711.83, 183.974, -1.62316, 0, 0, -0.725376, 0.688353, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241585, 181025, 530, 1, 1, -1791.87, 5754.81, 185.447, 0.872665, 0, 0, 0.422618, 0.906308, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241586, 181022, 530, 1, 1, -1769.01, 5784.69, 146.44, -1.78024, 0, 0, -0.777147, 0.629319, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241587, 181055, 530, 1, 1, -1813.81, 5580.23, 91.5256, -1.90241, 0, 0, -0.814116, 0.580702, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241588, 181027, 530, 1, 1, -1726.28, 5702.68, 128.392, 1.29154, 0, 0, 0.601814, 0.798637, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241589, 181055, 530, 1, 1, -1879.47, 5639.65, 133.58, -1.74533, 0, 0, -0.766045, 0.642787, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241590, 181020, 530, 1, 1, -1884.1, 5668.7, 133.853, 1.32645, 0, 0, 0.615661, 0.788011, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241591, 181025, 530, 1, 1, -1541.19, 5653.44, 172.244, -2.82743, 0, 0, -0.987688, 0.156436, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241592, 181016, 530, 1, 1, -2042.17, 5349.12, -41.0618, -0.331612, 0, 0, -0.165047, 0.986286, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241593, 181019, 530, 1, 1, -2000.53, 5353.68, -8.16344, 3.01942, 0, 0, 0.998135, 0.0610484, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241594, 181019, 530, 1, 1, -2007.51, 5367.37, -8.094, 1.76278, 0, 0, 0.771624, 0.636079, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241595, 181016, 530, 1, 1, -1676.31, 5430.35, -38.8098, -1.02974, 0, 0, -0.492422, 0.870357, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241596, 181027, 530, 1, 1, -1597.85, 5709.49, 128.392, 2.60054, 0, 0, 0.96363, 0.267239, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241597, 181055, 530, 1, 1, -1875.54, 5667.1, 136.477, 1.44862, 0, 0, 0.662619, 0.748957, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241598, 181025, 530, 1, 1, -1559.04, 5704.92, 173.526, -2.84489, 0, 0, -0.989016, 0.147808, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241599, 181027, 530, 1, 1, -1864.09, 5831.06, 128.392, -0.523599, 0, 0, -0.258819, 0.965926, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241600, 181027, 530, 1, 1, -1707.03, 5859.4, 128.392, 0.488692, 0, 0, 0.241922, 0.970296, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241601, 181027, 530, 1, 1, -1808.21, 5727.49, 128.392, -1.01229, 0, 0, -0.484809, 0.87462, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241602, 181027, 530, 1, 1, -1915.1, 5821.89, 128.392, 0.523599, 0, 0, 0.258819, 0.965926, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241603, 181022, 530, 1, 1, -1804.74, 5664.92, 130.256, -1.22173, 0, 0, -0.573576, 0.819152, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241604, 181022, 530, 1, 1, -1974.76, 5703.74, 117.663, -2.05949, 0, 0, -0.857168, 0.515037, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241605, 181016, 530, 1, 1, -1685.93, 5508.57, -40.3678, -2.6529, 0, 0, -0.970296, 0.241922, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241606, 181027, 530, 1, 1, -1773.5, 5867.15, 128.392, 0.087266, 0, 0, 0.0436192, 0.999048, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241607, 181020, 530, 1, 1, -1724.09, 5808.1, 152.994, -1.51844, 0, 0, -0.688356, 0.725373, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241608, 181027, 530, 1, 1, -1677.8, 5776.11, 128.392, 0.174533, 0, 0, 0.0871558, 0.996195, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241609, 181025, 530, 1, 1, -3838.58, -11819.8, -46.6697, -2.09439, 0, 0, -0.866024, 0.500002, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241610, 181022, 530, 1, 1, -4210.18, -11796.2, -133.245, 1.5708, 0, 0, 0.707108, 0.707106, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241611, 181025, 530, 1, 1, -4129.52, -11792.5, -122.023, 2.26893, 0, 0, 0.906308, 0.422617, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241612, 181017, 530, 1, 1, -4145.8, -11745.6, -124.153, 2.02458, 0, 0, 0.848048, 0.52992, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241613, 181016, 530, 1, 1, -4185.52, -11746, -132.273, 3.03687, 0, 0, 0.998629, 0.0523374, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241614, 181025, 530, 1, 1, -3845.71, -11764.6, -72.8579, -0.907571, 0, 0, -0.438371, 0.898794, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241615, 181014, 530, 1, 1, -3989.12, -11849.1, 25.7334, -2.11185, 0, 0, -0.870356, 0.492423, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241616, 181016, 530, 1, 1, -4228.95, -11818.9, -115.934, 0.802851, 0, 0, 0.390731, 0.920505, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241617, 181016, 530, 1, 1, -4161.4, -11800.6, -132.195, -1.72788, 0, 0, -0.760407, 0.649446, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241618, 181022, 530, 1, 1, -4186.29, -11803, -133.174, 0.610865, 0, 0, 0.300706, 0.953717, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241619, 181025, 530, 1, 1, -3907.01, -11840.6, -17.3894, 2.75762, 0, 0, 0.981627, 0.190809, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241620, 181019, 530, 1, 1, -4022.25, -11739.3, -150.798, 0.069813, 0, 0, 0.0348994, 0.999391, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241621, 181014, 530, 1, 1, -3864.28, -11742.7, -84.619, 2.07694, 0, 0, 0.861629, 0.507539, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241622, 181016, 530, 1, 1, -4221.81, -11830.9, -115.896, -0.977384, 0, 0, -0.469471, 0.882948, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241623, 181025, 530, 1, 1, -3906.89, -11740.7, -247.155, 1.44862, 0, 0, 0.662619, 0.748957, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241624, 181022, 530, 1, 1, -3929.13, -11744.8, -138.612, 0.628319, 0, 0, 0.309017, 0.951056, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241625, 181060, 1, 1, 1, 9908.24, 2510.89, 1316.4, 2.42601, 0, 0, 0.936673, 0.350206, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241626, 181060, 1, 1, 1, 9963.17, 2552.34, 1315.38, 3.14159, 0, 0, 1, 1.26759e-006, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241627, 181060, 1, 1, 1, 9973.12, 2550.51, 1315.55, 0.349066, 0, 0, 0.173648, 0.984808, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241628, 181060, 1, 1, 1, 9982.1, 2542.38, 1316.06, -2.02458, 0, 0, -0.848048, 0.52992, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241629, 181060, 1, 1, 1, 9984.97, 2508.03, 1316.66, 1.36136, 0, 0, 0.629322, 0.777145, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241630, 181060, 1, 1, 1, 9923.26, 2493.75, 1317.02, 3.05433, 0, 0, 0.999048, 0.0436174, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241631, 181060, 1, 1, 1, 9934.3, 2557.73, 1316.95, -1.71042, 0, 0, -0.754709, 0.65606, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241632, 181060, 1, 1, 1, 9906.71, 2539.32, 1315.74, 1.98968, 0, 0, 0.838672, 0.544637, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241633, 181060, 1, 1, 1, 9978.79, 2546.93, 1315.76, -2.23402, 0, 0, -0.898794, 0.438372, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241634, 181060, 1, 1, 1, 9971.63, 2499.95, 1315.94, 2.28638, 0, 0, 0.909961, 0.414694, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241635, 181055, 1, 1, 1, 9930.41, 2271.81, 1355.08, -1.55334, 0, 0, -0.700908, 0.713252, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241636, 181021, 1, 1, 1, 9985.94, 1978.34, 1352.14, -1.6057, 0, 0, -0.719339, 0.694659, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241637, 181055, 1, 1, 1, 9908.32, 2270.95, 1355.09, -1.55334, 0, 0, -0.700908, 0.713252, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241638, 181016, 1, 1, 1, 9952.86, 2607.13, 1316.19, -3.01942, 0, 0, -0.998135, 0.0610484, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241639, 181021, 1, 1, 1, 9892.4, 2238.72, 1343.61, -0.087267, 0, 0, -0.0436197, 0.999048, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241640, 181021, 1, 1, 1, 10014.4, 2211.14, 1343.83, 3.10669, 0, 0, 0.999848, 0.0174505, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241641, 181016, 1, 1, 1, 9939.42, 2606.72, 1316.73, -0.05236, 0, 0, -0.026177, 0.999657, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241642, 181016, 1, 1, 1, 9952.37, 2593.96, 1316.53, 3.08923, 0, 0, 0.999657, 0.0261783, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241643, 181055, 1, 1, 1, 9973.71, 2273.31, 1355.09, -1.53589, 0, 0, -0.694658, 0.71934, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241644, 181021, 1, 1, 1, 9986.28, 2022.9, 1351.84, 1.6057, 0, 0, 0.719339, 0.694659, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241645, 181027, 1, 1, 1, 9992.48, 2419.78, 1313.66, 1.06465, 0, 0, 0.507538, 0.861629, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241646, 181020, 1, 1, 1, 9696.47, 2532.07, 1339.74, 0, 0, 0, 0, 1, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241647, 181027, 1, 1, 1, 9888.75, 2392.52, 1313.66, 1.3439, 0, 0, 0.622513, 0.782609, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241648, 181027, 1, 1, 1, 9791.98, 2452.62, 1313.66, -1.27409, 0, 0, -0.594823, 0.803857, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241649, 181027, 1, 1, 1, 9816.61, 2485.6, 1313.66, 1.93731, 0, 0, 0.824125, 0.566409, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241650, 181027, 1, 1, 1, 9985.42, 2477.57, 1313.66, 2.16421, 0, 0, 0.882948, 0.469471, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241651, 181027, 1, 1, 1, 9785.54, 2582.46, 1313.66, -0.750491, 0, 0, -0.366501, 0.930418, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241652, 181060, 1, 1, 1, 9917.05, 2550.05, 1316.59, -1.85005, 0, 0, -0.798636, 0.601815, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241653, 181060, 1, 1, 1, 9918.65, 2498.42, 1316.38, -1.3439, 0, 0, -0.622513, 0.782609, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241654, 181060, 1, 1, 1, 9967.18, 2493.32, 1316.13, -0.575959, 0, 0, -0.284016, 0.95882, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241655, 181060, 1, 1, 1, 9936.7, 2484, 1316.68, -3.10669, 0, 0, -0.999848, 0.0174505, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241656, 181060, 1, 1, 1, 9923.77, 2553.71, 1316.8, -1.6057, 0, 0, -0.719339, 0.694659, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241657, 181060, 1, 1, 1, 9991.68, 2525.66, 1315.42, -0.331612, 0, 0, -0.165047, 0.986286, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241658, 181060, 1, 1, 1, 9941.61, 2481.39, 1316.35, -1.79769, 0, 0, -0.782608, 0.622514, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241659, 181060, 1, 1, 1, 9960.74, 2485.68, 1316.04, -1.67552, 0, 0, -0.743146, 0.669129, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241660, 181060, 1, 1, 1, 9928.7, 2489.73, 1317.02, 0.261799, 0, 0, 0.130526, 0.991445, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241661, 181060, 1, 1, 1, 9932.14, 2487.1, 1316.74, 2.04204, 0, 0, 0.852641, 0.522496, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241662, 181021, 1, 1, 1, 9892.59, 2223.51, 1343.63, 0.017453, 0, 0, 0.00872639, 0.999962, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241663, 181055, 1, 1, 1, 9996.89, 2273.38, 1355.08, -1.55334, 0, 0, -0.700908, 0.713252, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241664, 181055, 1, 1, 1, 9919.38, 2271.49, 1355.09, -1.53589, 0, 0, -0.694658, 0.71934, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241665, 181016, 1, 1, 1, 9939.09, 2585.65, 1316.41, -0.017453, 0, 0, -0.00872639, 0.999962, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241666, 181021, 1, 1, 1, 10014, 2226.74, 1343.69, -3.12414, 0, 0, -0.999962, 0.0087262, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241667, 181021, 1, 1, 1, 9893.36, 2207.54, 1343.76, 0.034907, 0, 0, 0.0174526, 0.999848, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241668, 181021, 1, 1, 1, 10013.6, 2242.08, 1343.91, -3.03687, 0, 0, -0.998629, 0.0523374, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241669, 181016, 1, 1, 1, 9939.75, 2594.98, 1316.24, -0.10472, 0, 0, -0.0523361, 0.99863, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241670, 181016, 1, 1, 1, 9952.15, 2585.77, 1316.13, -3.10669, 0, 0, -0.999848, 0.0174505, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241671, 181055, 1, 1, 1, 9985.81, 2272.69, 1355, -1.58825, 0, 0, -0.713251, 0.700909, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241672, 181025, 1, 1, 1, 9906.45, 2306.75, 1340.89, 1.55334, 0, 0, 0.700908, 0.713252, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241673, 181020, 1, 1, 1, 9821.78, 2252.39, 1346.21, -0.244346, 0, 0, -0.121869, 0.992546, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241674, 181020, 1, 1, 1, 9737.77, 2294.83, 1346.49, -0.698132, 0, 0, -0.34202, 0.939693, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241675, 181027, 1, 1, 1, 9791.89, 2515.96, 1313.66, 0.20944, 0, 0, 0.104529, 0.994522, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241676, 181027, 1, 1, 1, 9813.96, 2555.76, 1313.66, -1.64061, 0, 0, -0.731354, 0.681998, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241677, 181027, 1, 1, 1, 9885.83, 2408.99, 1313.66, 2.6529, 0, 0, 0.970296, 0.241922, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241678, 181027, 1, 1, 1, 10017, 2582.8, 1313.66, 2.33874, 0, 0, 0.920505, 0.390732, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241679, 181060, 1, 1, 1, 9911.52, 2545.1, 1316.08, -1.81514, 0, 0, -0.78801, 0.615662, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241680, 181060, 1, 1, 1, 9955.18, 2556.27, 1316.17, 1.39626, 0, 0, 0.642786, 0.766046, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241681, 181060, 1, 1, 1, 9986.88, 2533.89, 1315.75, -1.6057, 0, 0, -0.719339, 0.694659, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241682, 181060, 1, 1, 1, 9904.95, 2522.02, 1315.93, 1.25664, 0, 0, 0.587786, 0.809016, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241683, 181060, 1, 1, 1, 9976.07, 2506.44, 1316.5, -2.00713, 0, 0, -0.843392, 0.537299, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241684, 181027, 1, 1, 1, 9713.11, 2608.23, 1313.66, 0.698132, 0, 0, 0.34202, 0.939693, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241685, 181027, 1, 1, 1, 10040.2, 2582.51, 1313.66, -2.14675, 0, 0, -0.878816, 0.477161, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241686, 181027, 1, 1, 1, 9814.59, 2612.67, 1313.66, -1.53589, 0, 0, -0.694658, 0.71934, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241687, 181027, 1, 1, 1, 10015.5, 2398.33, 1313.66, 1.65806, 0, 0, 0.737276, 0.675591, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241688, 181027, 1, 1, 1, 9916.01, 2481.23, 1313.66, 0.541052, 0, 0, 0.267238, 0.96363, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241689, 181027, 1, 1, 1, 9990.15, 2556.42, 1313.66, -0.244346, 0, 0, -0.121869, 0.992546, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241690, 181027, 1, 1, 1, 9855.38, 2594.17, 1313.66, 0.698132, 0, 0, 0.34202, 0.939693, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241691, 181027, 1, 1, 1, 9921.48, 2386.86, 1313.66, 2.67035, 0, 0, 0.972369, 0.233447, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241692, 181027, 1, 1, 1, 9785.84, 2616.44, 1313.66, -2.84489, 0, 0, -0.989016, 0.147808, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241693, 181027, 1, 1, 1, 9750.32, 2472.94, 1313.66, 0.942478, 0, 0, 0.453991, 0.891006, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241694, 181027, 1, 1, 1, 10020.8, 2461.28, 1313.66, 2.30383, 0, 0, 0.913544, 0.406739, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241695, 181020, 1, 1, 1, 9857.45, 2344.73, 1334.97, 2.89725, 0, 0, 0.992546, 0.121868, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241696, 181027, 1, 1, 1, 9910.92, 2589, 1313.66, 0.680678, 0, 0, 0.333807, 0.942642, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241697, 181027, 1, 1, 1, 10047.5, 2525, 1313.66, 2.74017, 0, 0, 0.979925, 0.199366, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241698, 181027, 1, 1, 1, 9951.83, 2377.67, 1313.66, 2.40855, 0, 0, 0.93358, 0.35837, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241699, 181020, 1, 1, 1, 9798.35, 2309.28, 1330.56, -1.8675, 0, 0, -0.803856, 0.594824, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241700, 181027, 1, 1, 1, 9982.73, 2383.53, 1313.66, 2.77507, 0, 0, 0.983255, 0.182237, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241701, 181027, 1, 1, 1, 9722.1, 2587.24, 1313.66, -1.64061, 0, 0, -0.731354, 0.681998, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241702, 181025, 1, 1, 1, 9995.74, 2309.05, 1340.94, 1.74533, 0, 0, 0.766045, 0.642787, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241703, 181027, 1, 1, 1, 9686.7, 2619.66, 1313.66, -3.01942, 0, 0, -0.998135, 0.0610484, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241704, 181027, 1, 1, 1, 9791.99, 2473.6, 1313.66, 0.471239, 0, 0, 0.233445, 0.97237, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241705, 181027, 1, 1, 1, 9950.99, 2441.91, 1313.66, 1.32645, 0, 0, 0.615661, 0.788011, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241706, 181027, 1, 1, 1, 10017.7, 2611.61, 1313.66, 3.05433, 0, 0, 0.999048, 0.0436174, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241707, 181027, 1, 1, 1, 9884.55, 2517.38, 1313.66, -2.21657, 0, 0, -0.894935, 0.446197, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241708, 181027, 1, 1, 1, 9782.26, 2386.59, 1313.66, -1.6057, 0, 0, -0.719339, 0.694659, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241709, 181027, 1, 1, 1, 9916.19, 2415.84, 1313.66, 0.645772, 0, 0, 0.317305, 0.948324, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241710, 181027, 1, 1, 1, 9853.22, 2517.56, 1313.66, -2.09439, 0, 0, -0.866024, 0.500002, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241711, 181027, 1, 1, 1, 10016.9, 2522.34, 1313.66, 0.715585, 0, 0, 0.350207, 0.936672, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241712, 181027, 1, 1, 1, 10043.9, 2380.27, 1313.66, -1.95477, 0, 0, -0.829038, 0.559192, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241713, 181027, 1, 1, 1, 9879.48, 2611.53, 1313.66, -2.07694, 0, 0, -0.861629, 0.507539, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241714, 181027, 1, 1, 1, 9753.91, 2584.86, 1313.66, -0.471239, 0, 0, -0.233445, 0.97237, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241715, 181020, 1, 1, 1, 9695.81, 2338.86, 1340.98, 2.18166, 0, 0, 0.88701, 0.461749, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241716, 181027, 1, 1, 1, 10039.7, 2546.71, 1313.66, -2.42601, 0, 0, -0.936673, 0.350206, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241717, 181027, 1, 1, 1, 9855.78, 2612.98, 1313.66, 2.72271, 0, 0, 0.978147, 0.207914, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241718, 181027, 1, 1, 1, 10050.3, 2459.01, 1313.66, -1.15192, 0, 0, -0.54464, 0.83867, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241719, 181027, 1, 1, 1, 9817.47, 2450.54, 1313.66, 0.767945, 0, 0, 0.374607, 0.927184, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241720, 181027, 1, 1, 1, 9923, 2450.67, 1313.66, -0.715585, 0, 0, -0.350207, 0.936672, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241721, 181027, 1, 1, 1, 9816.98, 2516.38, 1313.66, 1.22173, 0, 0, 0.573576, 0.819152, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241722, 181027, 1, 1, 1, 9988.74, 2449.6, 1313.66, 1.15192, 0, 0, 0.54464, 0.83867, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241723, 181027, 1, 1, 1, 9887.99, 2548.04, 1313.66, -2.72271, 0, 0, -0.978147, 0.207914, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241724, 181027, 1, 1, 1, 10040.3, 2614.06, 1313.66, 1.41372, 0, 0, 0.649449, 0.760405, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241725, 181027, 1, 1, 1, 9848.24, 2479.29, 1313.66, 0.750492, 0, 0, 0.366501, 0.930417, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241726, 181027, 1, 1, 1, 10023, 2351.21, 1313.66, -2.19912, 0, 0, -0.891008, 0.453988, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241727, 181027, 1, 1, 1, 9987.97, 2582.2, 1313.66, 2.47837, 0, 0, 0.945519, 0.325567, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241728, 181020, 1, 1, 1, 9696.83, 2518.31, 1339.86, 0.05236, 0, 0, 0.026177, 0.999657, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241729, 181027, 1, 1, 1, 10016.5, 2549.55, 1313.66, 1.53589, 0, 0, 0.694658, 0.71934, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241730, 181019, 0, 1, 1, 1715.13, 232.002, -41.266, -1.55334, 0, 0, -0.700908, 0.713252, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241731, 181060, 0, 1, 1, 1601.56, 256.767, 60.1515, -0.488692, 0, 0, -0.241922, 0.970296, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241732, 181019, 0, 1, 1, 1715.21, 246.746, -41.2577, 2.18166, 0, 0, 0.88701, 0.461749, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241733, 181060, 0, 1, 1, 1578.87, 234.809, 60.1515, 0.541052, 0, 0, 0.267238, 0.96363, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241734, 181016, 0, 1, 1, 1589.83, 245.835, 60.1507, -0.785398, 0, 0, -0.382683, 0.92388, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241735, 181019, 0, 1, 1, 1682.87, 232.56, -41.257, 2.16421, 0, 0, 0.882948, 0.469471, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241736, 181019, 0, 1, 1, 1701.35, 237.729, -41.5009, 2.1293, 0, 0, 0.874619, 0.48481, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241737, 181019, 0, 1, 1, 1690.85, 246.782, -41.2577, 1.09956, 0, 0, 0.5225, 0.852639, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241738, 181019, 0, 1, 1, 1702.21, 246.72, -41.2573, 0.226893, 0, 0, 0.113203, 0.993572, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241739, 181060, 0, 1, 1, 1590.36, 223.334, 60.1515, -2.61799, 0, 0, -0.965925, 0.258821, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241740, 181060, 0, 1, 1, 1557.83, 253.536, -34.8079, 3.10669, 0, 0, 0.999848, 0.0174505, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241741, 181060, 0, 1, 1, 1636.66, 230.875, -40.7105, 1.20428, 0, 0, 0.566407, 0.824125, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241742, 181060, 0, 1, 1, 1587.74, 281.471, -40.7497, -0.191986, 0, 0, -0.0958456, 0.995396, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241743, 181060, 0, 1, 1, 1621.26, 270.278, -34.8406, -1.3439, 0, 0, -0.622513, 0.782609, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241744, 181060, 0, 1, 1, 1613.86, 275.428, -34.8434, -2.87979, 0, 0, -0.991445, 0.130528, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241745, 181060, 0, 1, 1, 1577.56, 205.111, -34.8439, -2.84489, 0, 0, -0.989016, 0.147808, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241746, 181060, 0, 1, 1, 1633.55, 227.21, -34.8064, -1.51844, 0, 0, -0.688356, 0.725373, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241747, 181060, 0, 1, 1, 1557.67, 227.829, -34.807, -2.3911, 0, 0, -0.930417, 0.366502, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241748, 181060, 0, 1, 1, 1572.79, 206.157, -40.7758, 2.80998, 0, 0, 0.986286, 0.165048, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241749, 181060, 0, 1, 1, 1636.74, 249.196, -40.836, 0.680678, 0, 0, 0.333807, 0.942642, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241750, 181018, 0, 1, 1, 1586.07, 250.113, -47.3099, 2.35619, 0, 0, 0.923879, 0.382686, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241751, 181015, 0, 1, 1, -8987.69, 509.24, 97.0765, -0.890118, 0, 0, -0.430511, 0.902585, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241752, 181019, 0, 1, 1, 1586.32, 277.428, -54.2526, 1.13446, 0, 0, 0.537298, 0.843393, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241753, 181019, 0, 1, 1, 1590.35, 206.828, -54.2666, 2.9147, 0, 0, 0.993572, 0.113203, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241754, 181018, 0, 1, 1, 1605.44, 249.869, -47.3329, 0.802851, 0, 0, 0.390731, 0.920505, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241755, 181019, 0, 1, 1, 1605.69, 276.238, -54.2526, -0.279253, 0, 0, -0.139173, 0.990268, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241756, 181018, 0, 1, 1, 1605.16, 230.557, -47.4507, -0.750491, 0, 0, -0.366501, 0.930418, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241757, 181018, 0, 1, 1, 1585.86, 230.646, -47.4108, -2.35619, 0, 0, -0.923879, 0.382686, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241758, 181027, 0, 1, 1, 1438, 242.31, -64.4786, -2.30383, 0, 0, -0.913544, 0.406739, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241759, 181027, 0, 1, 1, 1720.83, 336.018, -64.4786, 0.645772, 0, 0, 0.317305, 0.948324, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241760, 181027, 0, 1, 1, 1485.2, 352.151, -64.4786, 1.48353, 0, 0, 0.67559, 0.737277, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241761, 181027, 0, 1, 1, 1611.55, 269.952, -64.4786, -2.53073, 0, 0, -0.953717, 0.300705, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241762, 181027, 0, 1, 1, 1515.95, 104.481, -64.4786, 0.453786, 0, 0, 0.224951, 0.97437, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241763, 181027, 0, 1, 1, 1443.8, 285.548, -64.4786, -2.28638, 0, 0, -0.909961, 0.414694, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241764, 181027, 0, 1, 1, 1458.7, 160.822, -64.4786, -2.42601, 0, 0, -0.936673, 0.350206, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241765, 181027, 0, 1, 1, 1553.21, 89.4006, -64.4786, -2.51327, 0, 0, -0.951056, 0.309019, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241766, 181025, 0, 1, 1, 1408.34, 241.411, -50.6636, 0.017453, 0, 0, 0.00872639, 0.999962, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241767, 181027, 0, 1, 1, 1748.11, 280.002, -64.4786, 0.802851, 0, 0, 0.390731, 0.920505, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241768, 181019, 0, 1, 1, 1691.12, 232.09, -41.2572, 2.44346, 0, 0, 0.939692, 0.342021, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241769, 181060, 0, 1, 1, 1600.75, 223.21, 60.1515, -1.74533, 0, 0, -0.766045, 0.642787, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241770, 181019, 0, 1, 1, 1701.99, 232.31, -41.2565, -3.12414, 0, 0, -0.999962, 0.0087262, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241771, 181019, 0, 1, 1, 1682.74, 246.803, -41.2577, 0.069813, 0, 0, 0.0348994, 0.999391, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241772, 181025, 0, 1, 1, 1719.17, 239.088, -24.511, 0, 0, 0, 0, 1, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241773, 181019, 0, 1, 1, 1709.12, 246.94, -41.2577, -1.39626, 0, 0, -0.642786, 0.766046, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241774, 181019, 0, 1, 1, 1708.3, 231.784, -41.2571, 1.67552, 0, 0, 0.743146, 0.669129, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241775, 181060, 0, 1, 1, 1590.42, 256.867, 60.1515, -3.07178, 0, 0, -0.999391, 0.0348993, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241776, 181060, 0, 1, 1, 1579.19, 245.857, 60.1515, 1.46608, 0, 0, 0.669132, 0.743144, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241777, 181019, 0, 1, 1, 1701.38, 241.146, -41.5217, 1.309, 0, 0, 0.608763, 0.793352, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241778, 181060, 0, 1, 1, 1583.37, 202.294, -34.8428, -3.00197, 0, 0, -0.997564, 0.0697546, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241779, 181060, 0, 1, 1, 1562.17, 264.058, -40.7658, -0.837758, 0, 0, -0.406737, 0.913545, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241780, 181060, 0, 1, 1, 1566.17, 266.398, -34.8092, -2.94961, 0, 0, -0.995396, 0.095844, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241781, 181060, 0, 1, 1, 1625.44, 265.981, -34.8108, -0.226893, 0, 0, -0.113203, 0.993572, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241782, 181060, 0, 1, 1, 1613.23, 204.839, -34.8436, -1.25664, 0, 0, -0.587786, 0.809016, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241783, 181060, 0, 1, 1, 1624.88, 214.133, -34.8118, -2.70526, 0, 0, -0.976296, 0.21644, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241784, 181060, 0, 1, 1, 1630.67, 258.803, -34.8106, 1.44862, 0, 0, 0.662619, 0.748957, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241785, 181060, 0, 1, 1, 1570.24, 210.329, -34.8401, -2.49582, 0, 0, -0.948324, 0.317305, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241786, 181060, 0, 1, 1, 1633.82, 252.787, -34.8056, -1.50098, 0, 0, -0.681997, 0.731355, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241787, 181060, 0, 1, 1, 1583.94, 278.432, -34.8459, 2.74017, 0, 0, 0.979925, 0.199366, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241788, 181027, 0, 1, 1, 1704.93, 125.161, -64.4786, -2.09439, 0, 0, -0.866024, 0.500002, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241789, 181027, 0, 1, 1, 1609.73, 208.739, -64.4786, -1.29154, 0, 0, -0.601814, 0.798637, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241790, 181027, 0, 1, 1, 1634.06, 90.87, -64.4786, 2.23402, 0, 0, 0.898794, 0.438372, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241791, 181027, 0, 1, 1, 1680.95, 370.951, -64.4786, 0.907571, 0, 0, 0.438371, 0.898794, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241792, 181027, 0, 1, 1, 1672.13, 101.345, -64.4786, -1.25664, 0, 0, -0.587786, 0.809016, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241793, 181027, 0, 1, 1, 1581.26, 208.777, -64.4786, -0.663225, 0, 0, -0.325568, 0.945519, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241794, 181027, 0, 1, 1, 1481.61, 127.706, -64.4786, 1.309, 0, 0, 0.608763, 0.793352, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241795, 181027, 0, 1, 1, 1752.5, 239.586, -64.4786, -2.04204, 0, 0, -0.852641, 0.522496, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241796, 181027, 0, 1, 1, 1747.87, 199.132, -64.4786, -2.56563, 0, 0, -0.958819, 0.284017, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241797, 181027, 0, 1, 1, 1595.46, 82.8779, -64.4786, -0.174533, 0, 0, -0.0871558, 0.996195, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241798, 181016, 0, 1, 1, 1589.55, 234.288, 60.1507, 0.785398, 0, 0, 0.382683, 0.92388, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241799, 181060, 0, 1, 1, 1561.64, 217.309, -40.6901, 2.68781, 0, 0, 0.97437, 0.22495, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241800, 181060, 0, 1, 1, 1586.88, 199.268, -40.7277, -2.47837, 0, 0, -0.945519, 0.325567, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241801, 181060, 0, 1, 1, 1573.4, 274.89, -40.7745, -0.174533, 0, 0, -0.0871558, 0.996195, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241802, 181060, 0, 1, 1, 1629.16, 216.474, -40.702, 0.506145, 0, 0, 0.25038, 0.968148, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241803, 181060, 0, 1, 1, 1607.48, 202.24, -34.8466, 0.471239, 0, 0, 0.233445, 0.97237, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241804, 181060, 0, 1, 1, 1618.72, 274.337, -40.8867, 2.93215, 0, 0, 0.994522, 0.10453, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241805, 181060, 0, 1, 1, 1604.37, 281.328, -40.8098, 0.122173, 0, 0, 0.0610485, 0.998135, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241806, 181060, 0, 1, 1, 1630.29, 221.499, -34.8128, 0.331613, 0, 0, 0.165048, 0.986286, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241807, 181060, 0, 1, 1, 1560.75, 221.971, -34.8116, 0.436332, 0, 0, 0.216439, 0.976296, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241808, 181060, 0, 1, 1, 1629.66, 263.248, -40.9019, -1.69297, 0, 0, -0.748956, 0.66262, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241809, 181027, 0, 1, 1, 1582.82, 270.919, -64.4786, 1.18682, 0, 0, 0.559191, 0.829039, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241810, 181027, 0, 1, 1, 1731.75, 160.798, -64.4786, -1.69297, 0, 0, -0.748956, 0.66262, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241811, 181027, 0, 1, 1, 1596.63, 397.226, -64.4786, -0.349066, 0, 0, -0.173648, 0.984808, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241812, 181025, 0, 1, 1, 1783.2, 237.736, -50.6241, -3.12414, 0, 0, -0.999962, 0.0087262, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241813, 181027, 0, 1, 1, 1558.55, 393.236, -64.4786, -2.05949, 0, 0, -0.857168, 0.515037, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241814, 181025, 0, 1, 1, 1594.39, 52.9281, -50.7143, 1.5708, 0, 0, 0.707108, 0.707106, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241815, 181027, 0, 1, 1, 1636.53, 389.252, -64.4786, 0.383972, 0, 0, 0.190809, 0.981627, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241816, 181027, 0, 1, 1, 1521.35, 379.553, -64.4786, 0.296706, 0, 0, 0.147809, 0.989016, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241817, 181027, 0, 1, 1, 1442.43, 201.785, -64.4786, -1.62316, 0, 0, -0.725376, 0.688353, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241818, 181027, 0, 1, 1, 1459.6, 319.881, -64.4786, 1.29154, 0, 0, 0.601814, 0.798637, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241819, 181060, 0, 1, 1, 1554.78, 249.882, -40.7112, 2.23402, 0, 0, 0.898794, 0.438372, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241820, 181060, 0, 1, 1, 1636.01, 235.241, -34.8096, -1.27409, 0, 0, -0.594823, 0.803857, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241821, 181060, 0, 1, 1, 1565.89, 214.636, -34.8104, 0.314159, 0, 0, 0.156434, 0.987688, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241822, 181060, 0, 1, 1, 1570.76, 270.908, -34.8359, 1.23918, 0, 0, 0.580701, 0.814117, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241823, 181060, 0, 1, 1, 1578.06, 275.812, -34.8425, 1.37881, 0, 0, 0.636078, 0.771625, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241824, 181060, 0, 1, 1, 1554.6, 231.532, -40.7101, 2.89725, 0, 0, 0.992546, 0.121868, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241825, 181060, 0, 1, 1, 1620.63, 210.139, -34.8459, -0.20944, 0, 0, -0.104529, 0.994522, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241826, 181060, 0, 1, 1, 1560.98, 259.348, -34.8111, 2.16421, 0, 0, 0.882948, 0.469471, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241827, 181060, 0, 1, 1, 1617.92, 205.694, -40.7951, 2.42601, 0, 0, 0.936673, 0.350206, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241828, 181060, 0, 1, 1, 1607.9, 278.295, -34.8444, 1.41372, 0, 0, 0.649449, 0.760405, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241829, 181060, 0, 1, 1, 1603.55, 199.13, -40.7256, 1.78024, 0, 0, 0.777147, 0.629319, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241830, 181060, 0, 1, 1, 1636.11, 244.58, -34.8105, -2.25148, 0, 0, -0.902586, 0.430509, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241831, 181055, 1, 1, 1, 1588.31, -4108.94, 46.2348, -0.977384, 0, 0, -0.469471, 0.882948, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241832, 181016, 1, 1, 1, -1071.91, -32.9583, 141.348, -0.174533, 0, 0, -0.0871558, 0.996195, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241833, 181014, 1, 1, 1, -1185.54, 27.9683, 195.245, -0.296706, 0, 0, -0.147809, 0.989016, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241834, 181016, 1, 1, 1, -1067.54, -18.4063, 140.607, -0.523599, 0, 0, -0.258819, 0.965926, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241835, 181016, 1, 1, 1, -1304.97, 144.895, 131.385, 1.41372, 0, 0, 0.649449, 0.760405, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241836, 181014, 1, 1, 1, -1210.72, 34.2156, 192.245, 2.84489, 0, 0, 0.989016, 0.147808, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241837, 181014, 1, 1, 1, -1297.66, 192.871, 137.188, 1.65806, 0, 0, 0.737276, 0.675591, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241838, 181016, 1, 1, 1, -1202.39, 25.2032, 176.949, 0.855211, 0, 0, 0.414693, 0.909961, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241839, 181016, 1, 1, 1, -1277.25, 162.139, 131.136, 2.68781, 0, 0, 0.97437, 0.22495, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241840, 181017, 1, 1, 1, -1259.44, 39.8108, 133.912, 1.62316, 0, 0, 0.725376, 0.688353, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241841, 181016, 1, 1, 1, -1263.3, 18.5099, 128.187, 0.820305, 0, 0, 0.398749, 0.91706, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241842, 181016, 1, 1, 1, -1251.77, 20.0596, 128.187, 2.54818, 0, 0, 0.956305, 0.292372, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241843, 181016, 1, 1, 1, -1265.91, 26.0747, 128.187, -0.226893, 0, 0, -0.113203, 0.993572, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241844, 181016, 1, 1, 1, -1250.87, 27.5822, 128.187, -2.70526, 0, 0, -0.976296, 0.21644, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241845, 181060, 1, 1, 1, -1140.31, 48.5482, 147.17, 1.27409, 0, 0, 0.594823, 0.803857, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241846, 181060, 1, 1, 1, -1091.37, -1.32107, 143.954, 0.767945, 0, 0, 0.374607, 0.927184, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241847, 181060, 1, 1, 1, -1183.16, -54.9835, 165.055, 0.244346, 0, 0, 0.121869, 0.992546, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241848, 181060, 1, 1, 1, -1245.64, 137.252, 136.048, 1.41372, 0, 0, 0.649449, 0.760405, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241849, 181060, 1, 1, 1, -1234.44, 84.6758, 133.533, -2.79253, 0, 0, -0.984808, 0.173647, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241850, 181060, 1, 1, 1, -1186.31, -38.4025, 166.354, 0.959931, 0, 0, 0.461749, 0.887011, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241851, 181060, 1, 1, 1, -1114.98, 7.12733, 145.233, -1.95477, 0, 0, -0.829038, 0.559192, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241852, 181060, 1, 1, 1, -1149.42, 27.2867, 148.415, -2.84489, 0, 0, -0.989016, 0.147808, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241853, 181019, 1, 1, 1, -1290.56, 49.203, 138.795, -1.76278, 0, 0, -0.771624, 0.636079, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241854, 181016, 1, 1, 1, -1292.91, 49.4335, 129.209, -1.16937, 0, 0, -0.551937, 0.833886, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241855, 181021, 1, 1, 1, -1277.65, 49.8685, 144.238, 0.558505, 0, 0, 0.275637, 0.961262, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241856, 181017, 1, 1, 1, -1311.32, 32.3073, 135.914, 0.541052, 0, 0, 0.267238, 0.96363, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241857, 181017, 1, 1, 1, -1294.72, 40.1545, 135.862, -2.67035, 0, 0, -0.972369, 0.233447, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241858, 181016, 1, 1, 1, -1287.73, 37.0892, 129.209, 1.97222, 0, 0, 0.833885, 0.551938, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241859, 181016, 1, 1, 1, 1642.59, -4372.39, 12.7448, -2.86234, 0, 0, -0.990268, 0.139173, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241860, 181016, 1, 1, 1, 1615.25, -4371.44, 12.3255, -0.314159, 0, 0, -0.156434, 0.987688, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241861, 181014, 1, 1, 1, 1663.45, -4345.16, 38.0168, -2.37365, 0, 0, -0.927184, 0.374606, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241862, 181016, 1, 1, 1, 1622.07, -4385.72, 12.2943, 0.872665, 0, 0, 0.422618, 0.906308, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241863, 181018, 1, 1, 1, 1630.14, -4373.75, 19.1125, -2.72271, 0, 0, -0.978147, 0.207914, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241864, 181014, 1, 1, 1, 1659.33, -4346.13, 67.0861, -2.53073, 0, 0, -0.953717, 0.300705, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241865, 181016, 1, 1, 1, 1632.28, -4360.02, 12.7307, -2.30383, 0, 0, -0.913544, 0.406739, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241866, 181019, 1, 1, 1, 1640.67, -4445.25, 16.3232, 0.715585, 0, 0, 0.350207, 0.936672, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241867, 181017, 1, 1, 1, 1624.57, -4435.78, 25.7124, 2.51327, 0, 0, 0.951056, 0.309019, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241868, 181016, 1, 1, 1, 1643.54, -4444.94, 15.4065, -3.10669, 0, 0, -0.999848, 0.0174505, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241869, 181017, 1, 1, 1, 1627.62, -4431.78, 25.5626, 2.54818, 0, 0, 0.956305, 0.292372, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241870, 181019, 1, 1, 1, 1639.59, -4445.7, 16.3232, -1.36136, 0, 0, -0.629322, 0.777145, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241871, 181016, 1, 1, 1, 1638.73, -4450.24, 15.4065, 1.98968, 0, 0, 0.838672, 0.544637, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241872, 181060, 1, 1, 1, 1639.94, -4444.88, 16.3301, 1.69297, 0, 0, 0.748956, 0.66262, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241873, 181017, 1, 1, 1, 1621.98, -4439.55, 25.8617, 2.49582, 0, 0, 0.948324, 0.317305, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241874, 181021, 1, 1, 1, 1659.82, -4329.04, 75.2346, 2.68781, 0, 0, 0.97437, 0.22495, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241875, 181018, 1, 1, 1, 1434.22, -4358.4, 38.2172, -2.09439, 0, 0, -0.866024, 0.500002, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241876, 181021, 1, 1, 1, 1687.43, -4340.11, 74.9505, -0.488692, 0, 0, -0.241922, 0.970296, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241877, 181021, 1, 1, 1, 1672.88, -4320.48, 74.9852, 1.64061, 0, 0, 0.731354, 0.681998, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241878, 181018, 1, 1, 1, 1432.57, -4427.82, 38.966, 0.890118, 0, 0, 0.430511, 0.902585, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241879, 181021, 1, 1, 1, 1484.87, -4416.72, 53.1904, 0.10472, 0, 0, 0.0523361, 0.99863, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241880, 181018, 1, 1, 1, 1425.61, -4369.41, 38.829, 0.907571, 0, 0, 0.438371, 0.898794, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241881, 181021, 1, 1, 1, 1685.85, -4327.43, 74.8583, 0.698132, 0, 0, 0.34202, 0.939693, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241882, 181021, 1, 1, 1, 1661.55, -4344.48, 75.2458, -2.58309, 0, 0, -0.961262, 0.275636, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241883, 181018, 1, 1, 1, 1441.37, -4416.68, 37.9758, -2.28638, 0, 0, -0.909961, 0.414694, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241884, 181060, 1, 1, 1, 1779.42, -4313.93, 5.45587, -0.401426, 0, 0, -0.199368, 0.979925, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241885, 181018, 1, 1, 1, 1887.7, -4604.38, 41.2229, -0.191986, 0, 0, -0.0958456, 0.995396, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241886, 181018, 1, 1, 1, 1928.96, -4584.59, 41.3925, 3.03687, 0, 0, 0.998629, 0.0523374, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241887, 181018, 1, 1, 1, 1743.51, -4403.31, 46.0636, -2.6529, 0, 0, -0.970296, 0.241922, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241888, 181022, 1, 1, 1, 1858.83, -4514.74, 23.7042, -2.61799, 0, 0, -0.965925, 0.258821, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241889, 181018, 1, 1, 1, 1695.88, -4277.76, 41.1063, -2.23402, 0, 0, -0.898794, 0.438372, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241890, 181014, 1, 1, 1, -1028.03, -41.6273, 147.165, 2.60054, 0, 0, 0.96363, 0.267239, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241891, 181016, 1, 1, 1, -1059.13, -7.60406, 141.311, -0.767945, 0, 0, -0.374607, 0.927184, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241892, 181021, 1, 1, 1, 1706.77, -3929.71, 71.8858, -1.01229, 0, 0, -0.484809, 0.87462, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241893, 181018, 1, 1, 1, 1941.74, -4251.02, 50.9597, -1.67552, 0, 0, -0.743146, 0.669129, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241894, 181016, 1, 1, 1, -1190.94, 25.9335, 176.949, 2.35619, 0, 0, 0.923879, 0.382686, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241895, 181016, 1, 1, 1, -1290.7, 150.55, 129.743, 1.76278, 0, 0, 0.771624, 0.636079, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241896, 181060, 1, 1, 1, -1174.21, -75.0951, 165.661, 2.84489, 0, 0, 0.989016, 0.147808, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241897, 181020, 1, 1, 1, -1189.54, 36.9993, 180.617, -2.40855, 0, 0, -0.93358, 0.35837, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241898, 181060, 1, 1, 1, -1226.72, 80.6411, 133.715, -2.47837, 0, 0, -0.945519, 0.325567, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241899, 181020, 1, 1, 1, -1175.14, -48.8111, 167.614, 3.07178, 0, 0, 0.999391, 0.0348993, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241900, 181014, 1, 1, 1, -1236.53, -90.0243, 178.074, 0.436332, 0, 0, 0.216439, 0.976296, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241901, 181060, 1, 1, 1, -1224.42, 81.4398, 133.715, 1.58825, 0, 0, 0.713251, 0.700909, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241902, 181060, 1, 1, 1, -1226.41, 45.3912, 131.096, -2.75762, 0, 0, -0.981627, 0.190809, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241903, 181060, 1, 1, 1, -1213.21, -10.1759, 169.181, 2.00713, 0, 0, 0.843392, 0.537299, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241904, 181060, 1, 1, 1, -1292.99, 112.323, 134.367, 0.907571, 0, 0, 0.438371, 0.898794, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241905, 181060, 1, 1, 1, -1174.35, -72.6692, 165.661, 0.523599, 0, 0, 0.258819, 0.965926, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241906, 181021, 1, 1, 1, 1381.49, -4369.8, 52.8347, -3.00197, 0, 0, -0.997564, 0.0697546, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241907, 181018, 1, 1, 1, 1907.3, -4315.75, 28.5347, 0.279253, 0, 0, 0.139173, 0.990268, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241908, 181018, 1, 1, 1, 1915.1, -4371.97, 32.7758, 0.314159, 0, 0, 0.156434, 0.987688, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241909, 181018, 1, 1, 1, 1956.05, -4361.1, 33.1505, -2.87979, 0, 0, -0.991445, 0.130528, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241910, 181018, 1, 1, 1, 1656.47, -4433.01, 28.1114, 2.33874, 0, 0, 0.920505, 0.390732, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241911, 181060, 1, 1, 1, -1162.25, 29.9081, 149.03, -1.43117, 0, 0, -0.656059, 0.75471, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241912, 181014, 1, 1, 1, -1205, 134.352, 149.189, -2.42601, 0, 0, -0.936673, 0.350206, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241913, 181016, 1, 1, 1, -1399.61, -48.9439, 156.685, -2.3911, 0, 0, -0.930417, 0.366502, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241914, 181020, 1, 1, 1, -1423.93, -109.049, 167.31, -0.610865, 0, 0, -0.300706, 0.953717, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241915, 181060, 1, 1, 1, -1277, 80.4661, 131.839, 0.436332, 0, 0, 0.216439, 0.976296, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241916, 181060, 1, 1, 1, 1764.03, -4325.3, 5.91079, 0.05236, 0, 0, 0.026177, 0.999657, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241917, 181016, 1, 1, 1, 1695.3, -4321.7, 61.498, -2.54818, 0, 0, -0.956305, 0.292372, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241918, 181055, 1, 1, 1, 1965.27, -4751.63, 70.7718, 1.97222, 0, 0, 0.833885, 0.551938, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241919, 181060, 1, 1, 1, 1766.38, -4323.8, 6.09742, -1.50098, 0, 0, -0.681997, 0.731355, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241920, 181018, 1, 1, 1, 1674.43, -4334.04, 64.0697, 1.11701, 0, 0, 0.529919, 0.848048, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241921, 181060, 1, 1, 1, 1771.43, -4319.82, 6.45918, 1.51844, 0, 0, 0.688356, 0.725373, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241922, 181060, 1, 1, 1, 1776.3, -4316.4, 6.11171, 2.25148, 0, 0, 0.902586, 0.430509, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241923, 181027, 1, 1, 1, 1987.8, -4625.01, 24.5558, 2.44346, 0, 0, 0.939692, 0.342021, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241924, 181027, 1, 1, 1, 1967.51, -4664.97, 24.5558, 1.18682, 0, 0, 0.559191, 0.829039, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241925, 181060, 1, 1, 1, -1042.26, -215.809, 162.632, -2.02458, 0, 0, -0.848048, 0.52992, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241926, 181060, 1, 1, 1, -1063.76, -241.522, 162.283, 0.558505, 0, 0, 0.275637, 0.961262, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241927, 181020, 1, 1, 1, -1057.54, -259.685, 168.674, 1.71042, 0, 0, 0.754709, 0.65606, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241928, 181060, 1, 1, 1, -1114.43, 4.69217, 145.233, -1.43117, 0, 0, -0.656059, 0.75471, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241929, 181060, 1, 1, 1, -1139.33, 50.6481, 147.17, 0.05236, 0, 0, 0.026177, 0.999657, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241930, 181016, 1, 1, 1, -1385.49, -58.1903, 158.535, -2.11185, 0, 0, -0.870356, 0.492423, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241931, 181020, 1, 1, 1, -1204.61, 25.1163, 181.123, 0.750492, 0, 0, 0.366501, 0.930417, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241932, 181020, 1, 1, 1, -1085.99, 5.73009, 147.634, -2.89725, 0, 0, -0.992546, 0.121868, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241933, 181060, 1, 1, 1, -1295.13, 100.277, 133.66, 2.6529, 0, 0, 0.970296, 0.241922, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241934, 181060, 1, 1, 1, -1103.8, 21.8106, 143.861, -2.16421, 0, 0, -0.882948, 0.469471, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241935, 181060, 1, 1, 1, -1406.43, -109.242, 162.298, -1.90241, 0, 0, -0.814116, 0.580702, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241936, 181027, 1, 1, 1, 1961.35, -4645.08, 24.5558, -0.523599, 0, 0, -0.258819, 0.965926, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241937, 181018, 1, 1, 1, 1677.66, -4423.05, 28.1319, 1.5708, 0, 0, 0.707108, 0.707106, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241938, 181016, 1, 1, 1, 1650.02, -4332.94, 61.5018, 0, 0, 0, 0, 1, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241939, 181018, 1, 1, 1, 1724.71, -4416.39, 46.0725, 0.698132, 0, 0, 0.34202, 0.939693, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241940, 181018, 1, 1, 1, 2030.91, -4657.26, 37.322, -1.51844, 0, 0, -0.688356, 0.725373, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241941, 181016, 1, 1, 1, 1658.49, -4314.09, 62.0468, -0.994838, 0, 0, -0.477159, 0.878817, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241942, 181060, 1, 1, 1, 1774.14, -4317.93, 6.51081, -1.41372, 0, 0, -0.649449, 0.760405, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241943, 181018, 1, 1, 1, 1915.48, -4252.46, 50.5299, -1.50098, 0, 0, -0.681997, 0.731355, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241944, 181060, 1, 1, 1, -1066.19, -241.4, 162.283, 3.00197, 0, 0, 0.997564, 0.0697546, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241945, 181055, 1, 1, 1, 1928.31, -4248.18, 55.957, -1.48353, 0, 0, -0.67559, 0.737277, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241946, 181018, 1, 1, 1, 1712.41, -4219.7, 55.258, -1.85005, 0, 0, -0.798636, 0.601815, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241947, 181060, 1, 1, 1, -1041.59, -213.363, 162.632, -2.46091, 0, 0, -0.942641, 0.333809, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241948, 181014, 1, 1, 1, -1108.48, -10.3021, 157.776, 1.78024, 0, 0, 0.777147, 0.629319, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241949, 181060, 1, 1, 1, -1160.04, 29.3408, 149.03, 1.20428, 0, 0, 0.566407, 0.824125, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241950, 181020, 1, 1, 1, -1192.92, 22.2192, 181.24, 1.90241, 0, 0, 0.814116, 0.580702, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241951, 181027, 1, 1, 1, -1261.52, 94.5747, 127.886, 0.872665, 0, 0, 0.422618, 0.906308, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241952, 181060, 1, 1, 1, -1243.21, 137.371, 136.048, -1.29154, 0, 0, -0.601814, 0.798637, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241953, 181020, 1, 1, 1, -1248.75, -62.7547, 170.309, 0.087266, 0, 0, 0.0436192, 0.999048, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241954, 181060, 1, 1, 1, -1231.69, -43.6813, 167.769, 1.97222, 0, 0, 0.833885, 0.551938, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241955, 181060, 1, 1, 1, -1187.53, -36.2961, 166.354, -0.471239, 0, 0, -0.233445, 0.97237, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241956, 181018, 1, 1, 1, 1900.84, -4339.25, 26.3603, -0.733038, 0, 0, -0.358368, 0.93358, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241957, 181060, 1, 1, 1, 1769.25, -4321.72, 6.2909, 1.55334, 0, 0, 0.700908, 0.713252, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241958, 181018, 1, 1, 1, 1919.7, -4582.7, 41.1832, -0.314159, 0, 0, -0.156434, 0.987688, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241959, 181016, 1, 1, 1, 1675.11, -4361.82, 62.06, 1.65806, 0, 0, 0.737276, 0.675591, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241960, 181018, 1, 1, 1, 1897.01, -4606.08, 40.9014, 2.9147, 0, 0, 0.993572, 0.113203, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241961, 181016, 1, 1, 1, 1688.17, -4313.84, 61.6555, -2.28638, 0, 0, -0.909961, 0.414694, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241962, 181016, 1, 1, 1, 1675.8, -4311.48, 61.6065, -1.58825, 0, 0, -0.713251, 0.700909, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241963, 181016, 1, 1, 1, 1698.88, -4342.24, 62.0575, 2.74017, 0, 0, 0.979925, 0.199366, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241964, 181060, 1, 1, 1, -1118.3, 39.446, 144.723, -1.32645, 0, 0, -0.615661, 0.788011, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241965, 181060, 1, 1, 1, -1102.7, 19.6779, 143.861, -0.750491, 0, 0, -0.366501, 0.930418, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241966, 181060, 1, 1, 1, -1253.88, 51.9722, 129.965, 1.46608, 0, 0, 0.669132, 0.743144, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241967, 181027, 1, 1, 1, -1256.94, 101.069, 127.886, 2.19912, 0, 0, 0.891008, 0.453988, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241968, 181014, 1, 1, 1, -1180.66, -92.8976, 177.532, 2.53073, 0, 0, 0.953717, 0.300705, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241969, 181060, 1, 1, 1, -1278.87, 81.8948, 131.839, -2.58309, 0, 0, -0.961262, 0.275636, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241970, 181060, 1, 1, 1, -1292.63, 114.803, 134.367, 0.069813, 0, 0, 0.0348994, 0.999391, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241971, 181060, 1, 1, 1, -1091.03, 1.14784, 143.954, 2.61799, 0, 0, 0.965925, 0.258821, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241972, 181018, 1, 1, 1, 2011.81, -4645.75, 36.5273, -2.58309, 0, 0, -0.961262, 0.275636, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241973, 181027, 1, 1, 1, 1993.21, -4673.66, 24.5558, 2.32129, 0, 0, 0.91706, 0.398748, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241974, 181016, 1, 1, 1, 1693.92, -4351.96, 61.5084, 2.32129, 0, 0, 0.91706, 0.398748, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241975, 181027, 1, 1, 1, -1266.06, 100.961, 127.886, -1.18682, 0, 0, -0.559191, 0.829039, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241976, 181060, 1, 1, 1, -1118.2, 37.1479, 144.723, -2.68781, 0, 0, -0.97437, 0.22495, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241977, 181060, 1, 1, 1, -1192.85, -5.08306, 168.891, -1.13446, 0, 0, -0.537298, 0.843393, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241978, 181020, 1, 1, 1, -1200.74, 40.0504, 180.859, -1.3439, 0, 0, -0.622513, 0.782609, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241979, 181060, 1, 1, 1, -1183.14, -57.4883, 165.055, 0.244346, 0, 0, 0.121869, 0.992546, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241980, 181060, 1, 1, 1, -1228.75, 45.3529, 131.096, -2.51327, 0, 0, -0.951056, 0.309019, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241981, 181060, 1, 1, 1, -1236.09, -58.2324, 166.207, -3.12414, 0, 0, -0.999962, 0.0087262, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241982, 181060, 1, 1, 1, -1147.1, 26.9074, 148.415, 0.069813, 0, 0, 0.0348994, 0.999391, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241983, 181060, 1, 1, 1, -1256.15, 51.2523, 129.965, -2.77507, 0, 0, -0.983255, 0.182237, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241984, 181060, 1, 1, 1, -1236.08, 82.8995, 133.533, -2.74017, 0, 0, -0.979925, 0.199366, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241985, 181060, 1, 1, 1, -1230.7, -41.4822, 167.769, 2.60054, 0, 0, 0.96363, 0.267239, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241986, 181060, 1, 1, 1, -1193.23, -7.46246, 168.891, -0.2618, 0, 0, -0.130526, 0.991445, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241987, 181060, 1, 1, 1, -1294.23, 97.8879, 133.66, -1.32645, 0, 0, -0.615661, 0.788011, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241988, 181014, 1, 1, 1, -1123.94, 65.1875, 158.35, -1.8675, 0, 0, -0.803856, 0.594824, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241989, 181060, 1, 1, 1, -1290.47, 132.949, 134.571, -0.628319, 0, 0, -0.309017, 0.951056, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241990, 181060, 1, 1, 1, -1288.88, 130.987, 134.571, 2.04204, 0, 0, 0.852641, 0.522496, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241991, 181060, 1, 1, 1, -1213.46, -12.5487, 169.181, -1.02974, 0, 0, -0.492422, 0.870357, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241992, 181020, 1, 1, 1, -1146.22, 17.2813, 150.335, 0.488692, 0, 0, 0.241922, 0.970296, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241993, 181060, 1, 1, 1, -1407.64, -111.458, 162.298, 2.87979, 0, 0, 0.991445, 0.130528, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241994, 181060, 1, 1, 1, -1235.88, -55.7595, 166.207, -1.0472, 0, 0, -0.500001, 0.866025, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241995, 181017, 530, 1, 1, 9672.39, -7495.99, 25.6702, 1.53589, 0, 0, 0.694658, 0.71934, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241996, 181016, 530, 1, 1, 9583.93, -7474, 13.5073, 0.418879, 0, 0, 0.207912, 0.978148, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241997, 181018, 530, 1, 1, 9787.98, -7515.99, 21.1214, 1.50098, 0, 0, 0.681997, 0.731355, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241998, 181018, 530, 1, 1, 9702.63, -7494.75, 20.8742, 1.69297, 0, 0, 0.748956, 0.66262, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (241999, 181017, 530, 1, 1, 9694.37, -7495.96, 25.6203, 1.6057, 0, 0, 0.719339, 0.694659, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242000, 181018, 530, 1, 1, 9664, -7494.53, 21.3056, 1.43117, 0, 0, 0.656059, 0.75471, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242001, 181018, 530, 1, 1, 9710.68, -7517.24, 24.6095, 3.14159, 0, 0, 1, 1.26759e-006, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242002, 181017, 530, 1, 1, 9767.38, -7480.58, 28.1816, -3.08923, 0, 0, -0.999657, 0.0261783, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242003, 181018, 530, 1, 1, 9575.92, -7474.41, 20.0064, 0.750492, 0, 0, 0.366501, 0.930417, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242004, 181017, 530, 1, 1, 9683.36, -7495.41, 26.9979, 1.53589, 0, 0, 0.694658, 0.71934, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242005, 181018, 530, 1, 1, 9655.72, -7516.81, 24.749, 0.122173, 0, 0, 0.0610485, 0.998135, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242006, 181016, 530, 1, 1, 9658.9, -7492.71, 13.5224, -0.733038, 0, 0, -0.358368, 0.93358, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242007, 181018, 530, 1, 1, 9775.62, -7515.92, 21.1812, 1.39626, 0, 0, 0.642786, 0.766046, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242008, 181018, 530, 1, 1, 9799.94, -7516.06, 21.147, 1.5708, 0, 0, 0.707108, 0.707106, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242009, 181016, 530, 1, 1, 9708.06, -7493.28, 13.5236, -1.23918, 0, 0, -0.580701, 0.814117, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242010, 181017, 530, 1, 1, 9767.38, -7495.05, 28.2891, 3.05433, 0, 0, 0.999048, 0.0436174, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242011, 181025, 530, 1, 1, 9691.53, -7289.64, 19.6103, 1.53589, 0, 0, 0.694658, 0.71934, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242012, 181025, 530, 1, 1, 9677.25, -7226.38, 28.1885, -1.50098, 0, 0, -0.681997, 0.731355, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242013, 181022, 530, 1, 1, 9662.47, -7240.89, 14.3636, -1.11701, 0, 0, -0.529919, 0.848048, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242014, 181025, 530, 1, 1, 9661.73, -7289.44, 20.1413, 1.53589, 0, 0, 0.694658, 0.71934, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242015, 181016, 530, 1, 1, 9685.96, -7394.53, 11.6048, -2.47837, 0, 0, -0.945519, 0.325567, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242016, 181018, 530, 1, 1, 9788.54, -7459.79, 21.5471, -1.53589, 0, 0, -0.694658, 0.71934, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242017, 181016, 530, 1, 1, 9631.82, -7399.67, 15.6954, 1.46608, 0, 0, 0.669132, 0.743144, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242018, 181022, 530, 1, 1, 9943.32, -7191.94, 30.8752, -1.69297, 0, 0, -0.748956, 0.66262, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242019, 181022, 530, 1, 1, 9880.78, -7153.58, 30.9503, -2.53073, 0, 0, -0.953717, 0.300705, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242020, 181022, 530, 1, 1, 9821.52, -7255.12, 26.1467, -2.61799, 0, 0, -0.965925, 0.258821, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242021, 181027, 530, 1, 1, 9883.75, -7223.83, 31.8922, -0.680679, 0, 0, -0.333807, 0.942641, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242022, 181027, 530, 1, 1, 9860.64, -7225.19, 32.1409, 0.279253, 0, 0, 0.139173, 0.990268, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242023, 181027, 530, 1, 1, 9825.89, -7237.29, 27.191, 1.79769, 0, 0, 0.782608, 0.622514, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242024, 181027, 530, 1, 1, 9889.95, -7200.95, 31.8697, 0.890118, 0, 0, 0.430511, 0.902585, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242025, 181027, 530, 1, 1, 9861.69, -7203.56, 31.9816, -2.96706, 0, 0, -0.996195, 0.0871556, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242026, 181027, 530, 1, 1, 9850.55, -7216.79, 32.0508, 1.85005, 0, 0, 0.798636, 0.601815, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242027, 181017, 530, 1, 1, 9734.03, -7343.02, 35.0236, 1.90241, 0, 0, 0.814116, 0.580702, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242028, 181016, 530, 1, 1, 9875.02, -7410.74, 13.5832, 2.02458, 0, 0, 0.848048, 0.52992, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242029, 181016, 530, 1, 1, 9825.06, -7428.28, 13.6186, -2.58309, 0, 0, -0.961262, 0.275636, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242030, 181016, 530, 1, 1, 9875.17, -7428.63, 13.589, 2.25148, 0, 0, 0.902586, 0.430509, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242031, 181018, 530, 1, 1, 9813.95, -7440.06, 18.5338, 0.942478, 0, 0, 0.453991, 0.891006, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242032, 181022, 530, 1, 1, 9850.01, -7382.79, 18.6102, -1.6057, 0, 0, -0.719339, 0.694659, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242033, 181016, 530, 1, 1, 9839.54, -7451.33, 13.6458, 0.244346, 0, 0, 0.121869, 0.992546, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242034, 181018, 530, 1, 1, 9881.71, -7445.71, 18.4488, 2.49582, 0, 0, 0.948324, 0.317305, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242035, 181016, 530, 1, 1, 9825.43, -7410.53, 13.6259, 0.837758, 0, 0, 0.406737, 0.913545, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242036, 181016, 530, 1, 1, 9812.85, -7410.42, 13.6247, 1.88496, 0, 0, 0.809018, 0.587783, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242037, 181022, 530, 1, 1, 9806.04, -7431.57, 13.6187, -0.767945, 0, 0, -0.374607, 0.927184, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242038, 181020, 530, 1, 1, 9669.65, -7135.43, 35.5114, 0.017453, 0, 0, 0.00872639, 0.999962, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242039, 181018, 530, 1, 1, 9657.01, -7150.79, 19.117, 2.04204, 0, 0, 0.852641, 0.522496, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242040, 181020, 530, 1, 1, 9647.63, -7156.85, 35.7605, -1.69297, 0, 0, -0.748956, 0.66262, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242041, 181016, 530, 1, 1, 9746.57, -7174.86, 14.3237, -3.01942, 0, 0, -0.998135, 0.0610484, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242042, 181016, 530, 1, 1, 9642.19, -7165.24, 14.3229, 1.90241, 0, 0, 0.814116, 0.580702, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242043, 181022, 530, 1, 1, 9477.57, -7303.16, 14.3695, 1.0472, 0, 0, 0.500001, 0.866025, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242044, 181018, 530, 1, 1, 9555.7, -7291.21, 18.4422, 1.64061, 0, 0, 0.731354, 0.681998, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242045, 181019, 530, 1, 1, 9488.38, -7312.96, 16.711, 2.70526, 0, 0, 0.976296, 0.21644, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242046, 181016, 530, 1, 1, 9520.53, -7415.2, 14.3146, -1.93731, 0, 0, -0.824125, 0.566409, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242047, 181019, 530, 1, 1, 9485.89, -7307.27, 16.7097, -1.91986, 0, 0, -0.819151, 0.573577, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242048, 181016, 530, 1, 1, 9520.94, -7261.12, 14.3634, 1.48353, 0, 0, 0.67559, 0.737277, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242049, 181018, 530, 1, 1, 9577.85, -7444.63, 20.2819, 0.925024, 0, 0, 0.446198, 0.894934, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242050, 181016, 530, 1, 1, 9583.69, -7425.88, 13.5103, -1.81514, 0, 0, -0.78801, 0.615662, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242051, 181016, 530, 1, 1, 9583.84, -7455.04, 13.5067, -2.19912, 0, 0, -0.891008, 0.453988, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242052, 181016, 530, 1, 1, 9583.66, -7444.98, 13.5061, -1.64061, 0, 0, -0.731354, 0.681998, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242053, 181018, 530, 1, 1, 9576.13, -7425.43, 20.0839, -0.820305, 0, 0, -0.398749, 0.91706, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242054, 181019, 530, 1, 1, 9587.12, -7206.62, 17.4113, 2.33874, 0, 0, 0.920505, 0.390732, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242055, 181019, 530, 1, 1, 9524.03, -7219.3, 17.2962, -2.16421, 0, 0, -0.882948, 0.469471, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242056, 181027, 530, 1, 1, 9546.19, -7133.55, 16.3426, 1.11701, 0, 0, 0.529919, 0.848048, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242057, 181016, 530, 1, 1, 9556.41, -7178.68, 14.2535, 0.261799, 0, 0, 0.130526, 0.991445, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242058, 181019, 530, 1, 1, 9526.42, -7219.32, 17.2962, 3.00197, 0, 0, 0.997564, 0.0697546, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242059, 181018, 530, 1, 1, 9487.18, -7335.85, 18.7497, 0.017453, 0, 0, 0.00872639, 0.999962, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242060, 181019, 530, 1, 1, 9484.29, -7307.54, 16.7098, -0.994838, 0, 0, -0.477159, 0.878817, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242061, 181018, 530, 1, 1, 9546.85, -7291.17, 18.4692, 1.53589, 0, 0, 0.694658, 0.71934, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242062, 181016, 530, 1, 1, 9518.1, -7290.62, 14.3855, -2.6529, 0, 0, -0.970296, 0.241922, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242063, 181019, 530, 1, 1, 9488.99, -7311.45, 16.7107, -1.15192, 0, 0, -0.54464, 0.83867, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242064, 181018, 530, 1, 1, 9486.54, -7355.19, 18.5544, -0.296706, 0, 0, -0.147809, 0.989016, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242065, 181018, 530, 1, 1, 9542.48, -7245.92, 19.6978, -2.47837, 0, 0, -0.945519, 0.325567, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242066, 181027, 530, 1, 1, 9561.6, -7129.25, 16.3311, -0.244346, 0, 0, -0.121869, 0.992546, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242067, 181025, 530, 1, 1, 9518.93, -7076.87, 35.1824, -1.51844, 0, 0, -0.688356, 0.725373, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242068, 181018, 530, 1, 1, 9626.57, -7252.65, 18.881, -1.72788, 0, 0, -0.760407, 0.649446, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242069, 181016, 530, 1, 1, 9614.28, -7254.57, 16.4908, 0.575959, 0, 0, 0.284016, 0.95882, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242070, 181016, 530, 1, 1, 9679.71, -7394.5, 11.605, -1.88496, 0, 0, -0.809018, 0.587783, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242071, 181018, 530, 1, 1, 9800.51, -7459.87, 21.5852, -1.55334, 0, 0, -0.700908, 0.713252, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242072, 181018, 530, 1, 1, 9628.7, -7397.23, 19.8947, -1.58825, 0, 0, -0.713251, 0.700909, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242073, 181016, 530, 1, 1, 9665.25, -7413.47, 13.611, 0.05236, 0, 0, 0.026177, 0.999657, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242074, 181018, 530, 1, 1, 9950.98, -7081.83, 51.5927, -0.20944, 0, 0, -0.104529, 0.994522, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242075, 181018, 530, 1, 1, 9867.82, -7250.42, 34.2824, -2.37365, 0, 0, -0.927184, 0.374606, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242076, 181055, 530, 1, 1, 9946.34, -7241.46, 43.9058, 2.9147, 0, 0, 0.993572, 0.113203, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242077, 181016, 530, 1, 1, 9734.25, -7330.14, 24.7273, -1.43117, 0, 0, -0.656059, 0.75471, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242078, 181016, 530, 1, 1, 9770.45, -7313.02, 24.7307, -0.20944, 0, 0, -0.104529, 0.994522, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242079, 181027, 530, 1, 1, 9870.33, -7184.64, 31.8705, 2.04204, 0, 0, 0.852641, 0.522496, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242080, 181055, 530, 1, 1, 9955.16, -7098.38, 59.8619, -2.28638, 0, 0, -0.909961, 0.414694, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242081, 181027, 530, 1, 1, 9848.27, -7239.6, 27.2089, 1.22173, 0, 0, 0.573576, 0.819152, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242082, 181017, 530, 1, 1, 9752.51, -7336.51, 34.976, 1.91986, 0, 0, 0.819151, 0.573577, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242083, 181016, 530, 1, 1, 9862.43, -7450.91, 13.6452, -0.139626, 0, 0, -0.0697563, 0.997564, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242084, 181022, 530, 1, 1, 9806.77, -7407.16, 13.6263, 0.610865, 0, 0, 0.300706, 0.953717, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242085, 181025, 530, 1, 1, 9838.11, -7454.22, 23.0067, 1.55334, 0, 0, 0.700908, 0.713252, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242086, 181018, 530, 1, 1, 9820.21, -7445.31, 18.3621, 0.663225, 0, 0, 0.325568, 0.945519, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242087, 181025, 530, 1, 1, 9863.33, -7454.57, 22.9459, 1.81514, 0, 0, 0.78801, 0.615662, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242088, 181016, 530, 1, 1, 9812.97, -7428.58, 13.6163, 1.71042, 0, 0, 0.754709, 0.65606, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242089, 181018, 530, 1, 1, 9888.21, -7440.49, 18.4332, 2.07694, 0, 0, 0.861629, 0.507539, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242090, 181018, 530, 1, 1, 9633.49, -7144.69, 18.9398, 0.558505, 0, 0, 0.275637, 0.961262, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242091, 181016, 530, 1, 1, 9678.81, -7129.61, 14.323, -2.87979, 0, 0, -0.991445, 0.130528, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242092, 181018, 530, 1, 1, 9663.48, -7144.87, 19.024, 2.60054, 0, 0, 0.96363, 0.267239, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242093, 181016, 530, 1, 1, 9655.05, -7106.38, 14.323, 2.89725, 0, 0, 0.992546, 0.121868, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242094, 181016, 530, 1, 1, 9687.74, -7206.66, 14.3105, 1.69297, 0, 0, 0.748956, 0.66262, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242095, 181016, 530, 1, 1, 9628.29, -7254.45, 16.4952, -1.25664, 0, 0, -0.587786, 0.809016, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242096, 181022, 530, 1, 1, 9689.57, -7286.36, 14.2748, 2.3911, 0, 0, 0.930417, 0.366502, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242097, 181016, 530, 1, 1, 9644.85, -7399.78, 15.699, 1.29154, 0, 0, 0.601814, 0.798637, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242098, 181017, 530, 1, 1, 9638.37, -7397.28, 22.6856, -1.50098, 0, 0, -0.681997, 0.731355, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242099, 181016, 530, 1, 1, 9775.09, -7288.95, 24.7364, -2.84489, 0, 0, -0.989016, 0.147808, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242100, 181016, 530, 1, 1, 9746.09, -7307.13, 24.7326, 2.63545, 0, 0, 0.968148, 0.250379, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242101, 181016, 530, 1, 1, 9760.96, -7298.79, 24.7314, -1.79769, 0, 0, -0.782608, 0.622514, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242102, 181027, 530, 1, 1, 9881.25, -7191.33, 31.8442, -0.837758, 0, 0, -0.406737, 0.913545, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242103, 181018, 530, 1, 1, 9825.28, -7214.29, 34.3908, -2.07694, 0, 0, -0.861629, 0.507539, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242104, 181027, 530, 1, 1, 9844.72, -7253.45, 27.2703, -2.33874, 0, 0, -0.920505, 0.390732, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242105, 181022, 530, 1, 1, 9866.91, -7124.32, 30.8774, -2.86234, 0, 0, -0.990268, 0.139173, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242106, 181016, 530, 1, 1, 9729.43, -7314.13, 24.7305, 2.56563, 0, 0, 0.958819, 0.284017, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242107, 181027, 530, 1, 1, 9871.15, -7211.52, 31.9882, -1.6057, 0, 0, -0.719339, 0.694659, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242108, 181018, 530, 1, 1, 9858.42, -7340.05, 33.5396, 1.74533, 0, 0, 0.766045, 0.642787, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242109, 181016, 530, 1, 1, 9667.49, -7205.58, 14.3157, -1.58825, 0, 0, -0.713251, 0.700909, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242110, 181019, 530, 1, 1, 9652.46, -7131.68, 16.7733, -0.925024, 0, 0, -0.446198, 0.894934, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242111, 181017, 530, 1, 1, 9757.14, -7186.15, 23.5062, 2.89725, 0, 0, 0.992546, 0.121868, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242112, 181019, 530, 1, 1, 9644.52, -7140.05, 16.7733, -1.29154, 0, 0, -0.601814, 0.798637, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242113, 181020, 530, 1, 1, 9627.51, -7135.06, 35.4145, 2.94961, 0, 0, 0.995396, 0.095844, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242114, 181016, 530, 1, 1, 9517.86, -7309.91, 14.4553, 0.890118, 0, 0, 0.430511, 0.902585, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242115, 181018, 530, 1, 1, 9536.9, -7291.12, 18.4959, 1.5708, 0, 0, 0.707108, 0.707106, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242116, 181019, 530, 1, 1, 9488.36, -7308.64, 16.7091, -2.21657, 0, 0, -0.894935, 0.446197, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242117, 181016, 530, 1, 1, 9543.13, -7261.28, 14.3626, -0.279253, 0, 0, -0.139173, 0.990268, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242118, 181018, 530, 1, 1, 9556.17, -7309.81, 18.6268, -1.67552, 0, 0, -0.743146, 0.669129, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242119, 181022, 530, 1, 1, 9486.74, -7367.53, 14.3599, 0.191986, 0, 0, 0.0958456, 0.995396, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242120, 181016, 530, 1, 1, 9529.36, -7241.44, 16.4056, 3.10669, 0, 0, 0.999848, 0.0174505, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242121, 181016, 530, 1, 1, 9535.34, -7241.6, 16.3983, -2.9147, 0, 0, -0.993572, 0.113203, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242122, 181016, 530, 1, 1, 9579.72, -7178.49, 14.2327, 1.50098, 0, 0, 0.681997, 0.731355, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242123, 181019, 530, 1, 1, 9516.95, -7219.28, 17.2695, 2.79253, 0, 0, 0.984808, 0.173647, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242124, 181025, 530, 1, 1, 9552.87, -7076.55, 35.0939, -1.62316, 0, 0, -0.725376, 0.688353, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242125, 181016, 530, 1, 1, 9571.57, -7081.52, 16.5436, -2.18166, 0, 0, -0.88701, 0.461749, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242126, 181027, 530, 1, 1, 9558.12, -7144.92, 16.3431, -2.93215, 0, 0, -0.994522, 0.10453, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242127, 181019, 530, 1, 1, 9489.04, -7309.97, 16.7103, 1.3439, 0, 0, 0.622513, 0.782609, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242128, 181022, 530, 1, 1, 9538, -7348.09, 14.3366, 2.25148, 0, 0, 0.902586, 0.430509, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242129, 181016, 530, 1, 1, 9495.4, -7337.35, 14.3701, -1.41372, 0, 0, -0.649449, 0.760405, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242130, 181018, 530, 1, 1, 9536.85, -7309.67, 18.8888, -1.58825, 0, 0, -0.713251, 0.700909, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242131, 181022, 530, 1, 1, 9491.39, -7265.12, 14.326, -1.43117, 0, 0, -0.656059, 0.75471, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242132, 181016, 530, 1, 1, 9542.46, -7251.2, 16.4025, -0.10472, 0, 0, -0.0523361, 0.99863, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242133, 181016, 530, 1, 1, 9586.68, -7358.11, 13.6983, 2.89725, 0, 0, 0.992546, 0.121868, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242134, 181016, 530, 1, 1, 9495.33, -7353.62, 14.3637, -1.309, 0, 0, -0.608763, 0.793352, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242135, 181019, 530, 1, 1, 9487.18, -7307.67, 16.7095, 0.10472, 0, 0, 0.0523361, 0.99863, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242136, 181018, 530, 1, 1, 9578.05, -7454.91, 20.2977, -0.820305, 0, 0, -0.398749, 0.91706, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242137, 181019, 530, 1, 1, 9578.92, -7208.43, 17.411, -2.84489, 0, 0, -0.989016, 0.147808, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242138, 181018, 530, 1, 1, 9575.29, -7071.05, 21.8133, -1.55334, 0, 0, -0.700908, 0.713252, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242139, 181027, 530, 1, 1, 9548.76, -7142.45, 16.3752, 2.49582, 0, 0, 0.948324, 0.317305, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242140, 181019, 530, 1, 1, 9514.54, -7219.23, 17.2782, -1.76278, 0, 0, -0.771624, 0.636079, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242141, 181022, 530, 1, 1, 9688.68, -7243.62, 14.2134, -2.47837, 0, 0, -0.945519, 0.325567, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242142, 181018, 530, 1, 1, 9776.34, -7459.71, 21.5367, -1.58825, 0, 0, -0.713251, 0.700909, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242143, 181018, 530, 1, 1, 9648.49, -7397.35, 19.7111, -1.55334, 0, 0, -0.700908, 0.713252, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242144, 181016, 530, 1, 1, 9699.61, -7414.83, 13.6989, 1.44862, 0, 0, 0.662619, 0.748957, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242145, 181018, 530, 1, 1, 9842.31, -7339.95, 33.4202, 1.36136, 0, 0, 0.629322, 0.777145, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242146, 181027, 530, 1, 1, 9857.7, -7186.15, 31.8288, -0.506145, 0, 0, -0.25038, 0.968148, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242147, 181055, 530, 1, 1, 10007.3, -7030.9, 57.9729, -2.21657, 0, 0, -0.894935, 0.446197, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242148, 181017, 530, 1, 1, 9790.95, -7316.39, 35.2356, 2.23402, 0, 0, 0.898794, 0.438372, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242149, 181022, 530, 1, 1, 9828.29, -7261.11, 26.1458, -1.97222, 0, 0, -0.833885, 0.551938, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242150, 181055, 530, 1, 1, 9992.58, -7205.03, 44.0625, 2.18166, 0, 0, 0.88701, 0.461749, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242151, 181016, 530, 1, 1, 9784.87, -7302.95, 24.7277, 0.471239, 0, 0, 0.233445, 0.97237, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242152, 181017, 530, 1, 1, 9743.4, -7339.75, 34.9457, 1.90241, 0, 0, 0.814116, 0.580702, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242153, 181027, 530, 1, 1, 9838.82, -7231.6, 27.254, 2.44346, 0, 0, 0.939692, 0.342021, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242154, 181016, 530, 1, 1, 9642.69, -7106.29, 14.323, -0.994838, 0, 0, -0.477159, 0.878817, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242155, 181019, 530, 1, 1, 9652.59, -7140.02, 16.7733, -1.65806, 0, 0, -0.737276, 0.675591, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242156, 181020, 530, 1, 1, 9648.78, -7114.69, 35.3508, 1.5708, 0, 0, 0.707108, 0.707106, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242157, 181018, 530, 1, 1, 9640.13, -7120.77, 19.2479, -1.22173, 0, 0, -0.573576, 0.819152, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242158, 181018, 530, 1, 1, 9546.78, -7309.74, 18.7086, -1.58825, 0, 0, -0.713251, 0.700909, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242159, 181018, 530, 1, 1, 9522.36, -7245.14, 20.0325, -0.628319, 0, 0, -0.309017, 0.951056, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242160, 181025, 530, 1, 1, 9455.93, -7278.58, 27.5555, 0, 0, 0, 0, 1, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242161, 181016, 530, 1, 1, 9521.83, -7251.04, 16.4025, 1.309, 0, 0, 0.608763, 0.793352, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242162, 181022, 530, 1, 1, 9490.13, -7324.17, 14.3657, 0.331613, 0, 0, 0.165048, 0.986286, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242163, 181016, 530, 1, 1, 9520.46, -7378.73, 14.3025, 1.46608, 0, 0, 0.669132, 0.743144, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242164, 181027, 530, 1, 1, 9552.82, -7127.35, 16.3786, 2.02458, 0, 0, 0.848048, 0.52992, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242165, 181016, 530, 1, 1, 9589.41, -7081.65, 16.5494, -1.09956, 0, 0, -0.5225, 0.852639, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242166, 181018, 530, 1, 1, 9560.38, -7195.12, 19.307, 1.5708, 0, 0, 0.707108, 0.707106, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242167, 181019, 530, 1, 1, 9615.7, -7235.05, 16.3284, -0.855212, 0, 0, -0.414694, 0.909961, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242168, 181018, 530, 1, 1, 9616.16, -7252.59, 18.9092, -1.6057, 0, 0, -0.719339, 0.694659, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242169, 181016, 530, 1, 1, 9604.38, -7358.5, 13.7288, -0.2618, 0, 0, -0.130526, 0.991445, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242170, 181022, 530, 1, 1, 9913.19, -7182.16, 31.0098, -1.95477, 0, 0, -0.829038, 0.559192, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242171, 181017, 530, 1, 1, 9799.12, -7310.61, 35.2336, 2.19912, 0, 0, 0.891008, 0.453988, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242172, 181055, 530, 1, 1, 9951.85, -7233.11, 43.9028, 2.19912, 0, 0, 0.891008, 0.453988, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242173, 181027, 530, 1, 1, 9830.14, -7251.79, 27.2324, -2.40855, 0, 0, -0.93358, 0.35837, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242174, 181027, 530, 1, 1, 9890.71, -7214.22, 31.8661, -2.14675, 0, 0, -0.878816, 0.477161, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242175, 181017, 530, 1, 1, 9724.5, -7346.25, 34.9555, 1.91986, 0, 0, 0.819151, 0.573577, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242176, 181018, 530, 1, 1, 9971.99, -7098.17, 51.6368, 1.97222, 0, 0, 0.833885, 0.551938, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242177, 181027, 530, 1, 1, 9850.07, -7193.47, 31.8566, 1.90241, 0, 0, 0.814116, 0.580702, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242178, 181016, 530, 1, 1, 9752.18, -7323.44, 24.7289, -0.575959, 0, 0, -0.284016, 0.95882, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242179, 181018, 530, 1, 1, 9663.4, -7126.58, 19.1759, -2.74017, 0, 0, -0.979925, 0.199366, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242180, 181018, 530, 1, 1, 9657.05, -7120.85, 19.2307, -1.90241, 0, 0, -0.814116, 0.580702, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242181, 181025, 530, 1, 1, 9677.21, -7221.69, 27.4299, 1.55334, 0, 0, 0.700908, 0.713252, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242182, 181016, 530, 1, 1, 9742.11, -7191.63, 14.3237, -2.58309, 0, 0, -0.961262, 0.275636, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242183, 181016, 530, 1, 1, 9678.8, -7142.3, 14.323, -0.680679, 0, 0, -0.333807, 0.942641, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242184, 181017, 530, 1, 1, 9631.14, -7135.57, 23.118, -0.017453, 0, 0, -0.00872639, 0.999962, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242185, 181017, 530, 1, 1, 9648.53, -7119.09, 23.2984, -1.55334, 0, 0, -0.700908, 0.713252, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242186, 181018, 530, 1, 1, 9576.51, -7195.21, 19.3224, 1.58825, 0, 0, 0.713251, 0.700909, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242187, 181027, 530, 1, 1, 9564.47, -7138.31, 16.3821, 1.309, 0, 0, 0.608763, 0.793352, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242188, 181019, 530, 1, 1, 9535.97, -7219.35, 17.2962, 1.22173, 0, 0, 0.573576, 0.819152, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242189, 181018, 530, 1, 1, 9585.79, -7071.11, 21.8504, -1.64061, 0, 0, -0.731354, 0.681998, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242190, 181017, 530, 1, 1, 9485.03, -7132.41, 24.4308, 0, 0, 0, 0, 1, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242191, 181017, 530, 1, 1, 9648.39, -7152.3, 23.2634, 1.5708, 0, 0, 0.707108, 0.707106, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242192, 181017, 530, 1, 1, 9665.87, -7135.83, 23.1602, 3.10669, 0, 0, 0.999848, 0.0174505, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242193, 181016, 530, 1, 1, 9618.2, -7129.27, 14.3234, -1.91986, 0, 0, -0.819151, 0.573577, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242194, 181019, 530, 1, 1, 9644.57, -7131.67, 16.7733, -2.46091, 0, 0, -0.942641, 0.333809, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242195, 181016, 530, 1, 1, 9618.23, -7141.75, 14.323, 1.41372, 0, 0, 0.649449, 0.760405, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242196, 181019, 530, 1, 1, 9533.52, -7219.31, 17.2962, -3.05433, 0, 0, -0.999048, 0.0436174, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242197, 181018, 530, 1, 1, 9639.58, -7150.56, 19.0847, 1.18682, 0, 0, 0.559191, 0.829039, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242198, 181016, 530, 1, 1, 9654.51, -7165.12, 14.3229, 1.55334, 0, 0, 0.700908, 0.713252, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242199, 181018, 530, 1, 1, 9633.68, -7126.53, 19.3544, -0.436333, 0, 0, -0.21644, 0.976296, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242200, 181015, 1, 1, 1, 1654.72, -4435.6, 17.9091, 1.52914, 0, 0, 0.692227, 0.72168, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242201, 181015, 1, 1, 1, 1652.15, -4435.95, 17.9234, 1.537, 0, 0, 0.695058, 0.718954, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242202, 181015, 1, 1, 1, 1651.96, -4440.45, 18.6064, 1.42704, 0, 0, 0.654499, 0.756063, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242203, 181015, 1, 1, 1, 1653.69, -4440.65, 18.706, 1.44275, 0, 0, 0.660418, 0.750898, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242204, 181015, 1, 1, 1, 1652.65, -4440.59, 19.7822, 1.51343, 0, 0, 0.686537, 0.727095, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242205, 181015, 1, 1, 1, -1224.99, 68.7997, 129.731, 3.12651, 0, 0, 0.999972, 0.0075413, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242206, 181015, 1, 1, 1, -1225.05, 67.387, 129.572, 3.09509, 0, 0, 0.99973, 0.0232493, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242207, 181015, 1, 1, 1, -1220.7, 67.2529, 129.803, 3.1108, 0, 0, 0.999882, 0.0153957, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242208, 181015, 1, 1, 1, -1220.65, 69.0092, 129.919, 3.11865, 0, 0, 0.999934, 0.0114711, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242209, 181015, 1, 1, 1, -1220.65, 68.0704, 130.765, 3.04404, 0, 0, 0.998811, 0.048757, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242210, 181015, 0, 1, 1, 1629.6, 241.209, 63.8517, 6.18204, 0, 0, 0.050551, -0.998721, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242211, 181015, 0, 1, 1, 1629.51, 239.58, 63.8517, 6.25273, 0, 0, 0.0152271, -0.999884, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242212, 181015, 0, 1, 1, 1626.85, 238.099, 63.7065, 0.0048821, 0, 0, 0.00244105, 0.999997, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242213, 181015, 0, 1, 1, 1626.85, 238.099, 64.9495, 0.0048821, 0, 0, 0.00244105, 0.999997, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242214, 181015, 0, 1, 1, 1626.89, 241.666, 63.7092, 6.23702, 0, 0, 0.0230806, -0.999734, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242215, 181015, 530, 1, 1, 9611.24, -7184.37, 14.2838, 1.80031, 0, 0, 0.783423, 0.621489, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242216, 181015, 530, 1, 1, 9612.93, -7183.9, 14.286, 1.85529, 0, 0, 0.80021, 0.59972, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242217, 181015, 530, 1, 1, 9613.61, -7186.21, 14.286, 1.85529, 0, 0, 0.80021, 0.59972, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242218, 181015, 530, 1, 1, 9611.78, -7186.75, 14.2812, 1.85529, 0, 0, 0.80021, 0.59972, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242219, 181015, 530, 1, 1, 9612.49, -7186.57, 15.4229, 1.94954, 0, 0, 0.827573, 0.561358, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242220, 181015, 1, 1, 1, 9869.38, 2494.04, 1315.88, 6.18259, 0, 0, 0.0502764, -0.998735, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242221, 181015, 1, 1, 1, 9869.41, 2492.37, 1315.88, 6.14725, 0, 0, 0.0679152, -0.997691, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242222, 181015, 1, 1, 1, 9866.71, 2494.31, 1315.88, 6.18259, 0, 0, 0.0502764, -0.998735, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242223, 181015, 1, 1, 1, 9866.46, 2492.93, 1315.88, 6.28076, 0, 0, 0.00121275, -0.999999, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242224, 181015, 1, 1, 1, 9866.45, 2493.64, 1317.06, 6.28076, 0, 0, 0.00121275, -0.999999, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242225, 181015, 0, 1, 1, -8868.51, 636.281, 95.7874, 0.833655, 0, 0, 0.404862, 0.914378, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242226, 181015, 0, 1, 1, -8869.83, 637.476, 95.7874, 0.833655, 0, 0, 0.404862, 0.914378, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242227, 181015, 0, 1, 1, -8870.01, 634.537, 95.7874, 1.6544, 0, 0, 0.736039, 0.676939, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242228, 181015, 0, 1, 1, -8871.96, 634.394, 95.7874, 1.63869, 0, 0, 0.730699, 0.6827, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242229, 181015, 0, 1, 1, -8871.07, 634.479, 96.6378, 1.63083, 0, 0, 0.72801, 0.685566, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242230, 181015, 0, 1, 1, -8401.51, 1242.39, 5.23092, 5.8378, 0, 0, 0.220857, -0.975306, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242231, 181015, 0, 1, 1, -8401.88, 1243.98, 5.23059, 6.18337, 0, 0, 0.0498869, -0.998755, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242232, 181015, 0, 1, 1, -8402.78, 1248.95, 5.23059, 6.12446, 0, 0, 0.0792793, -0.996852, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242233, 181015, 0, 1, 1, -8402.78, 1248.95, 6.47447, 5.86921, 0, 0, 0.205513, -0.978654, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242234, 181015, 0, 1, 1, -4919.62, -983.484, 501.455, 2.25553, 0, 0, 0.903456, 0.42868, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242235, 181015, 0, 1, 1, -4918.56, -982.579, 501.455, 2.29087, 0, 0, 0.91089, 0.41265, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242236, 181015, 0, 1, 1, -4916.08, -985.152, 501.446, 2.83672, 0, 0, 0.988404, 0.151847, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242237, 181015, 0, 1, 1, -4917.25, -986.488, 501.445, 1.66648, 0, 0, 0.740114, 0.672481, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242238, 181015, 0, 1, 1, -4916.9, -985.882, 502.689, 1.06172, 0, 0, 0.506275, 0.862372, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242239, 181015, 530, 1, 1, -4005.6, -11844.9, 0.186664, 4.78858, 0, 0, 0.679663, -0.733525, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242240, 181015, 530, 1, 1, -4003.86, -11844.8, 0.202929, 4.80428, 0, 0, 0.673884, -0.738837, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242241, 181015, 530, 1, 1, -4004.18, -11840.8, 0.209176, 4.7925, 0, 0, 0.678224, -0.734856, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242242, 181015, 530, 1, 1, -4006.18, -11840.7, 0.192529, 5.27945, 0, 0, 0.481064, -0.876686, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242243, 181015, 530, 1, 1, -4005.05, -11840.7, 1.09752, 4.62757, 0, 0, 0.73645, -0.676492, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242244, 201940, 1, 1, 1, 1653.63, -4435.42, 17.8551, 1.66265, 0, 0, 0.738825, 0.673897, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242245, 201940, 1, 1, 1, -1224.99, 67.983, 129.641, 3.0731, 0, 0, 0.999414, 0.0342396, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242246, 201940, 0, 1, 1, 1628.43, 240.185, 64.4967, 6.23309, 0, 0, 0.0250451, -0.999686, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242247, 201940, 530, 1, 1, 9612.14, -7184.16, 14.2855, 1.78068, 0, 0, 0.777286, 0.629148, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242248, 201940, 1, 1, 1, 9869.81, 2493.38, 1315.88, 6.06479, 0, 0, 0.108981, -0.994044, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242249, 201940, 0, 1, 1, -8868.98, 636.704, 95.7874, 0.833655, 0, 0, 0.404862, 0.914378, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242250, 201940, 0, 1, 1, -4919.13, -983.066, 501.456, 2.23589, 0, 0, 0.899203, 0.437531, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242251, 201940, 530, 1, 1, -4004.67, -11844.9, 0.194667, 4.81606, 0, 0, 0.66952, -0.742794, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242252, 201289, 33, 1, 1, -222.652, 2207.23, 79.7614, 3.34831, 0, 0, 0.994663, -0.103175, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242253, 201289, 33, 1, 1, -222.311, 2211.65, 79.7616, 2.93597, 0, 0, 0.99472, 0.10263, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242254, 201289, 33, 1, 1, -220.849, 2216.83, 79.7609, 2.90848, 0, 0, 0.993215, 0.116293, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242255, 201289, 33, 1, 1, -205.261, 2177.29, 79.7651, 0.756489, 0, 0, 0.36929, 0.929314, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242256, 200332, 33, 1, 1, -228.634, 2196.77, 79.7618, 6.06264, 0, 0, 0.110049, -0.993926, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242257, 200332, 33, 1, 1, -229.234, 2192.63, 79.7622, 6.13725, 0, 0, 0.0729029, -0.997339, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242258, 200332, 33, 1, 1, -228.925, 2195.46, 82.4863, 6.02886, 0, 0, 0.12682, -0.991926, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242259, 200300, 33, 1, 1, -229.234, 2192.63, 79.7622, 6.13725, 0, 0, 0.0729029, -0.997339, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242260, 200300, 33, 1, 1, -228.634, 2196.77, 79.7618, 6.06264, 0, 0, 0.110049, -0.993926, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242261, 200300, 33, 1, 1, -228.925, 2195.46, 82.4863, 6.02886, 0, 0, 0.12682, -0.991926, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242262, 200336, 33, 1, 1, -195.872, 2205.43, 79.7639, 1.19474, 0, 0, 0.56247, 0.826818, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242263, 200336, 33, 1, 1, -217.118, 2219.3, 79.7625, 2.30215, 0, 0, 0.913203, 0.407506, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242264, 200333, 33, 1, 1, -193.981, 2199.37, 79.7493, 3.65696, 0, 0, 0.966983, -0.254841, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242265, 200334, 33, 1, 1, -205.174, 2177.62, 81.039, 3.76692, 0, 0, 0.951518, -0.307594, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242266, 200335, 33, 1, 1, -196.882, 2195.72, 79.765, 1.72096, 0, 0, 0.758156, 0.652074, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242267, 200337, 33, 1, 1, -220.423, 2216.37, 81.0388, 2.59275, 0, 0, 0.962582, 0.27099, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242268, 200337, 33, 1, 1, -213.83, 2218.7, 79.7631, 5.03141, 0, 0, 0.585817, -0.810444, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242269, 200337, 33, 1, 1, -217.341, 2220.39, 80.8288, 2.23539, 0, 0, 0.899094, 0.437756, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242270, 200337, 33, 1, 1, -216.527, 2219.35, 80.7348, 2.23539, 0, 0, 0.899094, 0.437756, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242271, 200337, 33, 1, 1, -215.719, 2218.32, 80.7345, 2.23539, 0, 0, 0.899094, 0.437756, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242272, 200337, 33, 1, 1, -218.174, 2219.65, 80.7954, 2.38305, 0, 0, 0.928935, 0.370244, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242273, 200337, 33, 1, 1, -217.446, 2218.96, 80.7347, 2.38305, 0, 0, 0.928935, 0.370244, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242274, 200337, 33, 1, 1, -216.943, 2218.31, 80.7347, 2.35556, 0, 0, 0.923758, 0.382976, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242275, 200337, 33, 1, 1, -216.325, 2217.69, 80.7346, 2.35556, 0, 0, 0.923758, 0.382976, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242276, 200337, 33, 1, 1, -218.195, 2219.56, 81.9112, 2.35556, 0, 0, 0.923758, 0.382976, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242277, 200338, 33, 1, 1, -198.645, 2203.81, 79.7959, 4.6882, 0, 0, 0.715607, -0.698503, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242278, 200338, 33, 1, 1, -196.699, 2203.76, 80.7359, 0.933992, 0, 0, 0.450206, 0.892925, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242279, 200338, 33, 1, 1, -195.022, 2206.03, 80.7362, 0.933992, 0, 0, 0.450206, 0.892925, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242280, 200338, 33, 1, 1, -196.073, 2206.38, 80.7368, 1.10678, 0, 0, 0.525574, 0.850748, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242281, 200338, 33, 1, 1, -195.499, 2206.3, 81.6454, 1.26386, 0, 0, 0.590703, 0.806889, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242282, 200338, 33, 1, 1, -196.832, 2193.36, 79.764, 5.88593, 0, 0, 0.197324, -0.980338, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242283, 200338, 33, 1, 1, -197.179, 2192.53, 79.7641, 5.90163, 0, 0, 0.189623, -0.981857, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242284, 200338, 33, 1, 1, -198.496, 2193.06, 79.7644, 5.90163, 0, 0, 0.189623, -0.981857, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242285, 202105, 33, 1, 1, -227.017, 2172.73, 79.7664, 3.8541, 0, 0, 0.93721, -0.348766, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (242286, 201752, 0, 1, 1, -9031.13, 353.063, 92.9444, -2.9845, 0, 0, -0.996917, 0.0784656, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242287, 201752, 0, 1, 1, -9032.31, 356.844, 93.1288, -1.11701, 0, 0, -0.529919, 0.848048, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242288, 201752, 0, 1, 1, -9030.08, 356.375, 92.9861, -1.11701, 0, 0, -0.529919, 0.848048, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242289, 201752, 0, 1, 1, -9027.49, 353.521, 92.9057, -1.11701, 0, 0, -0.529919, 0.848048, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242290, 201752, 0, 1, 1, -9031.5, 355.071, 92.9915, -0.663223, 0, 0, -0.325567, 0.945519, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242291, 201752, 0, 1, 1, -9030.07, 356.182, 94.2354, -0.488691, 0, 0, -0.241921, 0.970296, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242292, 201778, 0, 1, 1, -9031.98, 355.418, 94.3387, 0.942477, 0, 0, 0.45399, 0.891007, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242293, 201778, 0, 1, 1, -9030.32, 353.55, 94.1902, 2.26892, 0, 0, 0.906306, 0.422622, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242294, 202169, 0, 1, 1, -8401.05, 1245.19, 5.23024, 0, 0, 0, 0, 1, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242295, 202169, 0, 1, 1, -8400.73, 1248.06, 6.45781, -0.663223, 0, 0, -0.325567, 0.945519, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242296, 202169, 0, 1, 1, -8400.67, 1248.02, 5.23024, 0, 0, 0, 0, 1, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242297, 202169, 0, 1, 1, -8400.76, 1243.05, 5.23024, 0.872664, 0, 0, 0.422618, 0.906308, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242298, 201716, 1, 1, 1, 6764.82, -4905.13, 774.264, 0, 0, 0, 0, 1, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242299, 201906, 33, 1, 1, -199.137, 2165.32, 80.6689, 2.04204, 0, 0, 0.852641, 0.522496, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242300, 201906, 33, 1, 1, -200.911, 2162.44, 79.7639, 2.04204, 0, 0, 0.852641, 0.522496, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242301, 201906, 33, 1, 1, -199.852, 2164.86, 80.6729, 3.08918, 0, 0, 0.999657, 0.0262033, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242302, 201906, 33, 1, 1, -201.056, 2165.41, 80.6763, 0.680677, 0, 0, 0.333806, 0.942642, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242303, 201906, 33, 1, 1, -200.339, 2165.8, 80.671, -0.645772, 0, 0, -0.317305, 0.948324, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242304, 201906, 33, 1, 1, -201.795, 2162.82, 79.7638, 2.04204, 0, 0, 0.852641, 0.522496, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242305, 201906, 33, 1, 1, -199.467, 2166.15, 80.6654, 0.174532, 0, 0, 0.0871553, 0.996195, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242306, 201906, 33, 1, 1, -200.524, 2164.54, 80.6773, 0.174532, 0, 0, 0.0871553, 0.996195, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242307, 201906, 33, 1, 1, -201.818, 2165.14, 80.6793, 1.37881, 0, 0, 0.636078, 0.771625, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242308, 201716, 0, 1, 1, -402.274, 163.143, 75.6627, 3.65071, 0, 0, 0.967775, -0.251818, 60, 100, 1, 0);
INSERT INTO gameobject VALUES (242309, 201716, 1, 1, 1, -3418.81, -4212.7, 10.3292, 0.932394, 0, 0, 0.449492, 0.893284, 60, 100, 1, 0);
INSERT INTO gameobject VALUES (242310, 201716, 0, 1, 1, 121.643, -2401.57, 123.532, 1.69738, 0, 0, 0.750415, 0.660967, 60, 100, 1, 0);
INSERT INTO gameobject VALUES (242311, 201716, 1, 1, 1, 4851.07, 137.164, 52.3573, 3.32611, 0, 0, 0.995747, -0.0921278, 60, 100, 1, 0);
INSERT INTO gameobject VALUES (242312, 201716, 1, 1, 1, 6767.76, -4880.77, 776.832, 0.473977, 0, 0, 0.234776, 0.972049, 60, 100, 1, 0);
INSERT INTO gameobject VALUES (242313, 201716, 530, 1, 1, -1800.57, 4849.58, 3.67941, 0.732729, 0, 0, 0.358224, 0.933636, 60, 100, 1, 0);
INSERT INTO gameobject VALUES (242314, 201716, 1, 1, 1, 1269.73, -4095.83, 27.2461, 0.383236, 0, 0, 0.190448, 0.981697, 60, 100, 1, 0);
INSERT INTO gameobject VALUES (242315, 201716, 0, 1, 1, -9462.46, 525.975, 55.3952, 4.44641, 0, 0, 0.794624, -0.607102, 60, 100, 1, 0);
INSERT INTO gameobject VALUES (242316, 201716, 0, 1, 1, -51.7072, 1147.06, 66.2442, 6.0002, 0, 0, 0.141021, -0.990007, 60, 100, 1, 0);
INSERT INTO gameobject VALUES (242317, 201716, 571, 1, 1, 5610.19, 67.2452, 149.648, 1.10907, 0, 0, 0.526548, 0.850145, 60, 100, 1, 0);
INSERT INTO gameobject VALUES (242318, 201716, 571, 1, 1, 5586.44, 36.157, 148.304, 2.49451, 0, 0, 0.948115, 0.317926, 60, 100, 1, 0);
INSERT INTO gameobject VALUES (242319, 201716, 571, 1, 1, 5525.21, 35.5649, 148.918, 0.00558376, 0, 0, 0.00279188, 0.999996, 60, 100, 1, 0);
INSERT INTO gameobject VALUES (242320, 201752, 1, 1, 1, 1397.13, -4491.81, 31.4504, 3.15883, 0, 0, 0.999963, -0.00861853, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242321, 201752, 1, 1, 1, 1395.8, -4490.65, 31.4609, 2.97661, 0, 0, 0.996599, 0.0823978, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242322, 201752, 1, 1, 1, 1397.18, -4489, 31.3971, 4.9943, 0, 0, 0.600753, -0.799435, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242323, 201752, 1, 1, 1, 1396.45, -4486.47, 31.3666, 4.9943, 0, 0, 0.600753, -0.799435, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242324, 201752, 1, 1, 1, 1395.43, -4488.87, 31.4347, 4.49165, 0, 0, 0.780689, -0.62492, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242325, 201778, 1, 1, 1, 1395.74, -4489.53, 32.6781, 5.15452, 0, 0, 0.534852, -0.844946, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242326, 201752, 1, 1, 1, 1396.36, -4484.71, 31.3406, 5.23934, 0, 0, 0.498548, -0.866862, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242327, 201778, 1, 1, 1, 1396.53, -4485.84, 32.6102, 3.27035, 0, 0, 0.997928, -0.0643342, 180, 100, 1, 0);
INSERT INTO gameobject VALUES (242328, 201752, 1, 1, 1, 1396.45, -4491.19, 32.5861, 2.95541, 0, 0, 0.99567, 0.0929569, 180, 100, 1, 0);
DELETE FROM game_event_gameobject WHERE eventEntry=8;
REPLACE INTO game_event_gameobject VALUES(8, 241100),(8, 241101),(8, 241102),(8, 241103),(8, 241104),(8, 241105),(8, 241106),(8, 241107),(8, 241108),(8, 241109),
(8, 241110),(8, 241111),(8, 241112),(8, 241113),(8, 241114),(8, 241115),(8, 241116),(8, 241117),(8, 241118),(8, 241119),(8, 241120),
(8, 241121),(8, 241122),(8, 241123),(8, 241124),(8, 241125),(8, 241126),(8, 241127),(8, 241128),(8, 241129),(8, 241130),(8, 241131),
(8, 241132),(8, 241133),(8, 241134),(8, 241135),(8, 241136),(8, 241137),(8, 241138),(8, 241139),(8, 241140),(8, 241141),(8, 241142),
(8, 241143),(8, 241144),(8, 241145),(8, 241146),(8, 241147),(8, 241148),(8, 241149),(8, 241150),(8, 241151),(8, 241152),(8, 241153),
(8, 241154),(8, 241155),(8, 241156),(8, 241157),(8, 241158),(8, 241159),(8, 241160),(8, 241161),(8, 241162),(8, 241163),(8, 241164),
(8, 241165),(8, 241166),(8, 241167),(8, 241168),(8, 241169),(8, 241170),(8, 241171),(8, 241172),(8, 241173),(8, 241174),(8, 241175),
(8, 241176),(8, 241177),(8, 241178),(8, 241179),(8, 241180),(8, 241181),(8, 241182),(8, 241183),(8, 241184),(8, 241185),(8, 241186),
(8, 241187),(8, 241188),(8, 241189),(8, 241190),(8, 241191),(8, 241192),(8, 241193),(8, 241194),(8, 241195),(8, 241196),(8, 241197),
(8, 241198),(8, 241199),(8, 241200),(8, 241201),(8, 241202),(8, 241203),(8, 241204),(8, 241205),(8, 241206),(8, 241207),(8, 241208),
(8, 241209),(8, 241210),(8, 241211),(8, 241212),(8, 241213),(8, 241214),(8, 241215),(8, 241216),(8, 241217),(8, 241218),(8, 241219),
(8, 241220),(8, 241221),(8, 241222),(8, 241223),(8, 241224),(8, 241225),(8, 241226),(8, 241227),(8, 241228),(8, 241229),(8, 241230),
(8, 241231),(8, 241232),(8, 241233),(8, 241234),(8, 241235),(8, 241236),(8, 241237),(8, 241238),(8, 241239),(8, 241240),(8, 241241),
(8, 241242),(8, 241243),(8, 241244),(8, 241245),(8, 241246),(8, 241247),(8, 241248),(8, 241249),(8, 241250),(8, 241251),(8, 241252),
(8, 241253),(8, 241254),(8, 241255),(8, 241256),(8, 241257),(8, 241258),(8, 241259),(8, 241260),(8, 241261),(8, 241262),(8, 241263),
(8, 241264),(8, 241265),(8, 241266),(8, 241267),(8, 241268),(8, 241269),(8, 241270),(8, 241271),(8, 241272),(8, 241273),(8, 241274),
(8, 241275),(8, 241276),(8, 241277),(8, 241278),(8, 241279),(8, 241280),(8, 241281),(8, 241282),(8, 241283),(8, 241284),(8, 241285),
(8, 241286),(8, 241287),(8, 241288),(8, 241289),(8, 241290),(8, 241291),(8, 241292),(8, 241293),(8, 241294),(8, 241295),(8, 241296),
(8, 241297),(8, 241298),(8, 241299),(8, 241300),(8, 241301),(8, 241302),(8, 241303),(8, 241304),(8, 241305),(8, 241306),(8, 241307),
(8, 241308),(8, 241309),(8, 241310),(8, 241311),(8, 241312),(8, 241313),(8, 241314),(8, 241315),(8, 241316),(8, 241317),(8, 241318),
(8, 241319),(8, 241320),(8, 241321),(8, 241322),(8, 241323),(8, 241324),(8, 241325),(8, 241326),(8, 241327),(8, 241328),(8, 241329),
(8, 241330),(8, 241331),(8, 241332),(8, 241333),(8, 241334),(8, 241335),(8, 241336),(8, 241337),(8, 241338),(8, 241339),(8, 241340),
(8, 241341),(8, 241342),(8, 241343),(8, 241344),(8, 241345),(8, 241346),(8, 241347),(8, 241348),(8, 241349),(8, 241350),(8, 241351),
(8, 241352),(8, 241353),(8, 241354),(8, 241355),(8, 241356),(8, 241357),(8, 241358),(8, 241359),(8, 241360),(8, 241361),(8, 241362),
(8, 241363),(8, 241364),(8, 241365),(8, 241366),(8, 241367),(8, 241368),(8, 241369),(8, 241370),(8, 241371),(8, 241372),(8, 241373),
(8, 241374),(8, 241375),(8, 241376),(8, 241377),(8, 241378),(8, 241379),(8, 241380),(8, 241381),(8, 241382),(8, 241383),(8, 241384),
(8, 241385),(8, 241386),(8, 241387),(8, 241388),(8, 241389),(8, 241390),(8, 241391),(8, 241392),(8, 241393),(8, 241394),(8, 241395),
(8, 241396),(8, 241397),(8, 241398),(8, 241399),(8, 241400),(8, 241401),(8, 241402),(8, 241403),(8, 241404),(8, 241405),(8, 241406),
(8, 241407),(8, 241408),(8, 241409),(8, 241410),(8, 241411),(8, 241412),(8, 241413),(8, 241414),(8, 241415),(8, 241416),(8, 241417),
(8, 241418),(8, 241419),(8, 241420),(8, 241421),(8, 241422),(8, 241423),(8, 241424),(8, 241425),(8, 241426),(8, 241427),(8, 241428),
(8, 241429),(8, 241430),(8, 241431),(8, 241432),(8, 241433),(8, 241434),(8, 241435),(8, 241436),(8, 241437),(8, 241438),(8, 241439),
(8, 241440),(8, 241441),(8, 241442),(8, 241443),(8, 241444),(8, 241445),(8, 241446),(8, 241447),(8, 241448),(8, 241449),(8, 241450),
(8, 241451),(8, 241452),(8, 241453),(8, 241454),(8, 241455),(8, 241456),(8, 241457),(8, 241458),(8, 241459),(8, 241460),(8, 241461),
(8, 241462),(8, 241463),(8, 241464),(8, 241465),(8, 241466),(8, 241467),(8, 241468),(8, 241469),(8, 241470),(8, 241471),(8, 241472),
(8, 241473),(8, 241474),(8, 241475),(8, 241476),(8, 241477),(8, 241478),(8, 241479),(8, 241480),(8, 241481),(8, 241482),(8, 241483),
(8, 241484),(8, 241485),(8, 241486),(8, 241487),(8, 241488),(8, 241489),(8, 241490),(8, 241491),(8, 241492),(8, 241493),(8, 241494),
(8, 241495),(8, 241496),(8, 241497),(8, 241498),(8, 241499),(8, 241500),(8, 241501),(8, 241502),(8, 241503),(8, 241504),(8, 241505),
(8, 241506),(8, 241507),(8, 241508),(8, 241509),(8, 241510),(8, 241511),(8, 241512),(8, 241513),(8, 241514),(8, 241515),(8, 241516),
(8, 241517),(8, 241518),(8, 241519),(8, 241520),(8, 241521),(8, 241522),(8, 241523),(8, 241524),(8, 241525),(8, 241526),(8, 241527),
(8, 241528),(8, 241529),(8, 241530),(8, 241531),(8, 241532),(8, 241533),(8, 241534),(8, 241535),(8, 241536),(8, 241537),(8, 241538),
(8, 241539),(8, 241540),(8, 241541),(8, 241542),(8, 241543),(8, 241544),(8, 241545),(8, 241546),(8, 241547),(8, 241548),(8, 241549),
(8, 241550),(8, 241551),(8, 241552),(8, 241553),(8, 241554),(8, 241555),(8, 241556),(8, 241557),(8, 241558),(8, 241559),(8, 241560),
(8, 241561),(8, 241562),(8, 241563),(8, 241564),(8, 241565),(8, 241566),(8, 241567),(8, 241568),(8, 241569),(8, 241570),(8, 241571),
(8, 241572),(8, 241573),(8, 241574),(8, 241575),(8, 241576),(8, 241577),(8, 241578),(8, 241579),(8, 241580),(8, 241581),(8, 241582),
(8, 241583),(8, 241584),(8, 241585),(8, 241586),(8, 241587),(8, 241588),(8, 241589),(8, 241590),(8, 241591),(8, 241592),(8, 241593),
(8, 241594),(8, 241595),(8, 241596),(8, 241597),(8, 241598),(8, 241599),(8, 241600),(8, 241601),(8, 241602),(8, 241603),(8, 241604),
(8, 241605),(8, 241606),(8, 241607),(8, 241608),(8, 241609),(8, 241610),(8, 241611),(8, 241612),(8, 241613),(8, 241614),(8, 241615),
(8, 241616),(8, 241617),(8, 241618),(8, 241619),(8, 241620),(8, 241621),(8, 241622),(8, 241623),(8, 241624),(8, 241625),(8, 241626),
(8, 241627),(8, 241628),(8, 241629),(8, 241630),(8, 241631),(8, 241632),(8, 241633),(8, 241634),(8, 241635),(8, 241636),(8, 241637),
(8, 241638),(8, 241639),(8, 241640),(8, 241641),(8, 241642),(8, 241643),(8, 241644),(8, 241645),(8, 241646),(8, 241647),(8, 241648),
(8, 241649),(8, 241650),(8, 241651),(8, 241652),(8, 241653),(8, 241654),(8, 241655),(8, 241656),(8, 241657),(8, 241658),(8, 241659),
(8, 241660),(8, 241661),(8, 241662),(8, 241663),(8, 241664),(8, 241665),(8, 241666),(8, 241667),(8, 241668),(8, 241669),(8, 241670),
(8, 241671),(8, 241672),(8, 241673),(8, 241674),(8, 241675),(8, 241676),(8, 241677),(8, 241678),(8, 241679),(8, 241680),(8, 241681),
(8, 241682),(8, 241683),(8, 241684),(8, 241685),(8, 241686),(8, 241687),(8, 241688),(8, 241689),(8, 241690),(8, 241691),(8, 241692),
(8, 241693),(8, 241694),(8, 241695),(8, 241696),(8, 241697),(8, 241698),(8, 241699),(8, 241700),(8, 241701),(8, 241702),(8, 241703),
(8, 241704),(8, 241705),(8, 241706),(8, 241707),(8, 241708),(8, 241709),(8, 241710),(8, 241711),(8, 241712),(8, 241713),(8, 241714),
(8, 241715),(8, 241716),(8, 241717),(8, 241718),(8, 241719),(8, 241720),(8, 241721),(8, 241722),(8, 241723),(8, 241724),(8, 241725),
(8, 241726),(8, 241727),(8, 241728),(8, 241729),(8, 241730),(8, 241731),(8, 241732),(8, 241733),(8, 241734),(8, 241735),(8, 241736),
(8, 241737),(8, 241738),(8, 241739),(8, 241740),(8, 241741),(8, 241742),(8, 241743),(8, 241744),(8, 241745),(8, 241746),(8, 241747),
(8, 241748),(8, 241749),(8, 241750),(8, 241751),(8, 241752),(8, 241753),(8, 241754),(8, 241755),(8, 241756),(8, 241757),(8, 241758),
(8, 241759),(8, 241760),(8, 241761),(8, 241762),(8, 241763),(8, 241764),(8, 241765),(8, 241766),(8, 241767),(8, 241768),(8, 241769),
(8, 241770),(8, 241771),(8, 241772),(8, 241773),(8, 241774),(8, 241775),(8, 241776),(8, 241777),(8, 241778),(8, 241779),(8, 241780),
(8, 241781),(8, 241782),(8, 241783),(8, 241784),(8, 241785),(8, 241786),(8, 241787),(8, 241788),(8, 241789),(8, 241790),(8, 241791),
(8, 241792),(8, 241793),(8, 241794),(8, 241795),(8, 241796),(8, 241797),(8, 241798),(8, 241799),(8, 241800),(8, 241801),(8, 241802),
(8, 241803),(8, 241804),(8, 241805),(8, 241806),(8, 241807),(8, 241808),(8, 241809),(8, 241810),(8, 241811),(8, 241812),(8, 241813),
(8, 241814),(8, 241815),(8, 241816),(8, 241817),(8, 241818),(8, 241819),(8, 241820),(8, 241821),(8, 241822),(8, 241823),(8, 241824),
(8, 241825),(8, 241826),(8, 241827),(8, 241828),(8, 241829),(8, 241830),(8, 241831),(8, 241832),(8, 241833),(8, 241834),(8, 241835),
(8, 241836),(8, 241837),(8, 241838),(8, 241839),(8, 241840),(8, 241841),(8, 241842),(8, 241843),(8, 241844),(8, 241845),(8, 241846),
(8, 241847),(8, 241848),(8, 241849),(8, 241850),(8, 241851),(8, 241852),(8, 241853),(8, 241854),(8, 241855),(8, 241856),(8, 241857),
(8, 241858),(8, 241859),(8, 241860),(8, 241861),(8, 241862),(8, 241863),(8, 241864),(8, 241865),(8, 241866),(8, 241867),(8, 241868),
(8, 241869),(8, 241870),(8, 241871),(8, 241872),(8, 241873),(8, 241874),(8, 241875),(8, 241876),(8, 241877),(8, 241878),(8, 241879),
(8, 241880),(8, 241881),(8, 241882),(8, 241883),(8, 241884),(8, 241885),(8, 241886),(8, 241887),(8, 241888),(8, 241889),(8, 241890),
(8, 241891),(8, 241892),(8, 241893),(8, 241894),(8, 241895),(8, 241896),(8, 241897),(8, 241898),(8, 241899),(8, 241900),(8, 241901),
(8, 241902),(8, 241903),(8, 241904),(8, 241905),(8, 241906),(8, 241907),(8, 241908),(8, 241909),(8, 241910),(8, 241911),(8, 241912),
(8, 241913),(8, 241914),(8, 241915),(8, 241916),(8, 241917),(8, 241918),(8, 241919),(8, 241920),(8, 241921),(8, 241922),(8, 241923),
(8, 241924),(8, 241925),(8, 241926),(8, 241927),(8, 241928),(8, 241929),(8, 241930),(8, 241931),(8, 241932),(8, 241933),(8, 241934),
(8, 241935),(8, 241936),(8, 241937),(8, 241938),(8, 241939),(8, 241940),(8, 241941),(8, 241942),(8, 241943),(8, 241944),(8, 241945),
(8, 241946),(8, 241947),(8, 241948),(8, 241949),(8, 241950),(8, 241951),(8, 241952),(8, 241953),(8, 241954),(8, 241955),(8, 241956),
(8, 241957),(8, 241958),(8, 241959),(8, 241960),(8, 241961),(8, 241962),(8, 241963),(8, 241964),(8, 241965),(8, 241966),(8, 241967),
(8, 241968),(8, 241969),(8, 241970),(8, 241971),(8, 241972),(8, 241973),(8, 241974),(8, 241975),(8, 241976),(8, 241977),(8, 241978),
(8, 241979),(8, 241980),(8, 241981),(8, 241982),(8, 241983),(8, 241984),(8, 241985),(8, 241986),(8, 241987),(8, 241988),(8, 241989),
(8, 241990),(8, 241991),(8, 241992),(8, 241993),(8, 241994),(8, 241995),(8, 241996),(8, 241997),(8, 241998),(8, 241999),(8, 242000),
(8, 242001),(8, 242002),(8, 242003),(8, 242004),(8, 242005),(8, 242006),(8, 242007),(8, 242008),(8, 242009),(8, 242010),(8, 242011),
(8, 242012),(8, 242013),(8, 242014),(8, 242015),(8, 242016),(8, 242017),(8, 242018),(8, 242019),(8, 242020),(8, 242021),(8, 242022),
(8, 242023),(8, 242024),(8, 242025),(8, 242026),(8, 242027),(8, 242028),(8, 242029),(8, 242030),(8, 242031),(8, 242032),(8, 242033),
(8, 242034),(8, 242035),(8, 242036),(8, 242037),(8, 242038),(8, 242039),(8, 242040),(8, 242041),(8, 242042),(8, 242043),(8, 242044),
(8, 242045),(8, 242046),(8, 242047),(8, 242048),(8, 242049),(8, 242050),(8, 242051),(8, 242052),(8, 242053),(8, 242054),(8, 242055),
(8, 242056),(8, 242057),(8, 242058),(8, 242059),(8, 242060),(8, 242061),(8, 242062),(8, 242063),(8, 242064),(8, 242065),(8, 242066),
(8, 242067),(8, 242068),(8, 242069),(8, 242070),(8, 242071),(8, 242072),(8, 242073),(8, 242074),(8, 242075),(8, 242076),(8, 242077),
(8, 242078),(8, 242079),(8, 242080),(8, 242081),(8, 242082),(8, 242083),(8, 242084),(8, 242085),(8, 242086),(8, 242087),(8, 242088),
(8, 242089),(8, 242090),(8, 242091),(8, 242092),(8, 242093),(8, 242094),(8, 242095),(8, 242096),(8, 242097),(8, 242098),(8, 242099),
(8, 242100),(8, 242101),(8, 242102),(8, 242103),(8, 242104),(8, 242105),(8, 242106),(8, 242107),(8, 242108),(8, 242109),(8, 242110),
(8, 242111),(8, 242112),(8, 242113),(8, 242114),(8, 242115),(8, 242116),(8, 242117),(8, 242118),(8, 242119),(8, 242120),(8, 242121),
(8, 242122),(8, 242123),(8, 242124),(8, 242125),(8, 242126),(8, 242127),(8, 242128),(8, 242129),(8, 242130),(8, 242131),(8, 242132),
(8, 242133),(8, 242134),(8, 242135),(8, 242136),(8, 242137),(8, 242138),(8, 242139),(8, 242140),(8, 242141),(8, 242142),(8, 242143),
(8, 242144),(8, 242145),(8, 242146),(8, 242147),(8, 242148),(8, 242149),(8, 242150),(8, 242151),(8, 242152),(8, 242153),(8, 242154),
(8, 242155),(8, 242156),(8, 242157),(8, 242158),(8, 242159),(8, 242160),(8, 242161),(8, 242162),(8, 242163),(8, 242164),(8, 242165),
(8, 242166),(8, 242167),(8, 242168),(8, 242169),(8, 242170),(8, 242171),(8, 242172),(8, 242173),(8, 242174),(8, 242175),(8, 242176),
(8, 242177),(8, 242178),(8, 242179),(8, 242180),(8, 242181),(8, 242182),(8, 242183),(8, 242184),(8, 242185),(8, 242186),(8, 242187),
(8, 242188),(8, 242189),(8, 242190),(8, 242191),(8, 242192),(8, 242193),(8, 242194),(8, 242195),(8, 242196),(8, 242197),(8, 242198),
(8, 242199),(8, 242200),(8, 242201),(8, 242202),(8, 242203),(8, 242204),(8, 242205),(8, 242206),(8, 242207),(8, 242208),(8, 242209),
(8, 242210),(8, 242211),(8, 242212),(8, 242213),(8, 242214),(8, 242215),(8, 242216),(8, 242217),(8, 242218),(8, 242219),(8, 242220),
(8, 242221),(8, 242222),(8, 242223),(8, 242224),(8, 242225),(8, 242226),(8, 242227),(8, 242228),(8, 242229),(8, 242230),(8, 242231),
(8, 242232),(8, 242233),(8, 242234),(8, 242235),(8, 242236),(8, 242237),(8, 242238),(8, 242239),(8, 242240),(8, 242241),(8, 242242),
(8, 242243),(8, 242244),(8, 242245),(8, 242246),(8, 242247),(8, 242248),(8, 242249),(8, 242250),(8, 242251),(8, 242252),(8, 242253),
(8, 242254),(8, 242255),(8, 242256),(8, 242257),(8, 242258),(8, 242259),(8, 242260),(8, 242261),(8, 242262),(8, 242263),(8, 242264),
(8, 242265),(8, 242266),(8, 242267),(8, 242268),(8, 242269),(8, 242270),(8, 242271),(8, 242272),(8, 242273),(8, 242274),(8, 242275),
(8, 242276),(8, 242277),(8, 242278),(8, 242279),(8, 242280),(8, 242281),(8, 242282),(8, 242283),(8, 242284),(8, 242285),(8, 242286),
(8, 242287),(8, 242288),(8, 242289),(8, 242290),(8, 242291),(8, 242292),(8, 242293),(8, 242294),(8, 242295),(8, 242296),(8, 242297),
(8, 242298),(8, 242299),(8, 242300),(8, 242301),(8, 242302),(8, 242303),(8, 242304),(8, 242305),(8, 242306),(8, 242307),(8, 242308),
(8, 242309),(8, 242310),(8, 242311),(8, 242312),(8, 242313),(8, 242314),(8, 242315),(8, 242316),(8, 242317),(8, 242318),(8, 242319),
(8, 242320),(8, 242321),(8, 242322),(8, 242323),(8, 242324),(8, 242325),(8, 242326),(8, 242327),(8, 242328);