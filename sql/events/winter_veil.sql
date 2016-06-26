
REPLACE INTO game_event VALUES(2, "2015-12-16 01:00:00", "2020-12-31 06:00:00", 525600, 25920, 141, "Winter Veil", 0);
REPLACE INTO game_event VALUES(52, "2015-12-25 06:00:00", "2020-12-31 06:00:00", 525600, 11700, 0, "Winter Veil: Gifts", 0);

-- Winter Wondervolt machine trap script
DELETE FROM spell_script_names WHERE spell_id IN(26275);
INSERT INTO spell_script_names VALUES(26275, "spell_winter_wondervolt_trap");

-- Winter Veil Disguise Kit
UPDATE quest_template SET RewardMailTemplateId=0, RewardMailDelay=0 WHERE Id IN(7042, 6963, 7043, 6983);
UPDATE quest_template SET RewardMailTemplateId=108, RewardMailDelay=86400 WHERE Id IN(6984);
UPDATE quest_template SET RewardMailTemplateId=117, RewardMailDelay=86400 WHERE Id IN(7045);

-- Crashin' Trashin'
UPDATE creature_template SET modelid1=11686, modelid2=0, modelid3=0, modelid4=0 WHERE entry=27674;
REPLACE INTO creature_template_addon VALUES(27664, 0, 0, 0, 1, 0, "49384");
REPLACE INTO creature_template_addon VALUES(40281, 0, 0, 0, 1, 0, "75110");
UPDATE creature_template SET spell1=49297 WHERE entry IN(27664, 40281);
DELETE FROM spell_script_names WHERE spell_id IN(49297, 49325);
INSERT INTO spell_script_names VALUES(49297, "spell_winter_veil_racer_rocket_slam");
INSERT INTO spell_script_names VALUES(49325, "spell_winter_veil_racer_slam_hit");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(49325);
INSERT INTO conditions VALUES(13, 1, 49325, 0, 0, 31, 0, 3, 27664, 0, 0, 0, 0, '', 'Crashin Trashin');
INSERT INTO conditions VALUES(13, 1, 49325, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Crashin Trashin');
INSERT INTO conditions VALUES(13, 1, 49325, 0, 1, 31, 0, 3, 40281, 0, 0, 0, 0, '', 'Crashin Trashin');
INSERT INTO conditions VALUES(13, 1, 49325, 0, 1, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Crashin Trashin');

-- Red Rider Air Rifle
DELETE FROM spell_script_names WHERE spell_id IN(67533, 65576);
INSERT INTO spell_script_names VALUES(67533, "spell_winter_veil_shoot_air_rifle");
INSERT INTO spell_script_names VALUES(65576, "spell_winter_veil_shoot_air_rifle");

-- Templates
UPDATE creature_template SET faction=1154 WHERE entry IN(5661); -- undercity
UPDATE creature_template SET faction=2132 WHERE entry IN(26044); -- warsong offensive
UPDATE creature_template SET faction=11 WHERE entry IN(739, 927, 1444, 12336, 5484, 5489, 1351, 1182); -- stranglethorn, stormwind, nijel's point
UPDATE creature_template SET faction=150 WHERE entry IN(8140); -- theramore

-- Gaily Wrapped Present (21310)
UPDATE item_loot_template SET ChanceOrQuestChance=25, groupid=1 WHERE entry=21310;

-- Winter Veil Gift
DELETE FROM game_event_gameobject WHERE eventEntry=52 AND guid IN(151771, 151772);
INSERT INTO game_event_gameobject VALUES (52, 151771),(52, 151772);
DELETE FROM gameobject_queststarter WHERE id=187236;
INSERT INTO gameobject_queststarter VALUES (187236, 13966);
DELETE FROM gameobject_questender WHERE id=187236;
INSERT INTO gameobject_questender VALUES (187236, 13966);
DELETE FROM gameobject WHERE id=187236 AND guid IN(151771, 151772);
INSERT INTO gameobject VALUES (151771, 187236, 0, 1, 1, -4915.6, -979.443, 501.449, 2.42955, 0, 0, 0.93729, 0.34855, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (151772, 187236, 1, 1, 1, 1628.6, -4413.76, 16.0398, 6.25408, 0, 0, 0.0145513, -0.999894, 300, 0, 1, 0);



-- ---------------------------------
-- Achievements
-- ---------------------------------
-- A Frosty Shake (1690)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(6261);
DELETE FROM disables WHERE sourceType=4 AND entry IN(6261);
INSERT INTO achievement_criteria_data VALUES(6261, 5, 21848, 0, "");
INSERT INTO achievement_criteria_data VALUES(6261, 6, 4395, 0, "");
INSERT INTO achievement_criteria_data VALUES(6261, 7, 21848, 0, "");
INSERT INTO achievement_criteria_data VALUES(6261, 16, 141, 0, "");

-- BB King (4437)
UPDATE creature_template SET unit_flags = unit_flags&~(0x2|0x80|0x100|0x200) WHERE entry IN(29611, 2784, 7937, 7999, 17468);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12663, 12664, 12665, 12666, 12667);
DELETE FROM disables WHERE sourceType=4 AND entry IN(2663, 12664, 12665, 12666, 12667);
INSERT INTO achievement_criteria_data VALUES(12663, 1, 29611, 0, "");
INSERT INTO achievement_criteria_data VALUES(12664, 1, 2784, 0, "");
INSERT INTO achievement_criteria_data VALUES(12665, 1, 7937, 0, "");
INSERT INTO achievement_criteria_data VALUES(12666, 1, 7999, 0, "");
INSERT INTO achievement_criteria_data VALUES(12667, 1, 17468, 0, "");

-- BB King (4436)
UPDATE creature_template SET unit_flags = unit_flags&~(0x2|0x80|0x100|0x200) WHERE entry IN(3057, 10181, 16802, 4949, 10540);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12662, 12661, 12660, 12658, 12659);
DELETE FROM disables WHERE sourceType=4 AND entry IN(12662, 12661, 12660, 12658, 12659);
INSERT INTO achievement_criteria_data VALUES(12662, 1, 3057, 0, "");
INSERT INTO achievement_criteria_data VALUES(12661, 1, 10181, 0, "");
INSERT INTO achievement_criteria_data VALUES(12660, 1, 16802, 0, "");
INSERT INTO achievement_criteria_data VALUES(12658, 1, 4949, 0, "");
INSERT INTO achievement_criteria_data VALUES(12659, 1, 10540, 0, "");

-- Bros. Before Ho Ho Ho's (1686)
UPDATE creature_template SET unit_flags = unit_flags&~(0x2|0x80|0x100|0x200) WHERE entry IN(739, 1182, 927, 8140, 1444, 5489, 12336, 1351, 5484);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(6228, 6229, 6230, 6231, 6232, 6233, 6234, 6235, 6236);
DELETE FROM disables WHERE sourceType=4 AND entry IN(6228, 6229, 6230, 6231, 6232, 6233, 6234, 6235, 6236);
INSERT INTO achievement_criteria_data VALUES(6228, 1, 739, 0, "");
INSERT INTO achievement_criteria_data VALUES(6236, 1, 1182, 0, "");
INSERT INTO achievement_criteria_data VALUES(6229, 1, 927, 0, "");
INSERT INTO achievement_criteria_data VALUES(6231, 1, 8140, 0, "");
INSERT INTO achievement_criteria_data VALUES(6230, 1, 1444, 0, "");
INSERT INTO achievement_criteria_data VALUES(6232, 1, 5489, 0, "");
INSERT INTO achievement_criteria_data VALUES(6233, 1, 12336, 0, "");
INSERT INTO achievement_criteria_data VALUES(6234, 1, 1351, 0, "");
INSERT INTO achievement_criteria_data VALUES(6235, 1, 5484, 0, "");

-- Bros. Before Ho Ho Ho's (1685)
UPDATE creature_template SET unit_flags = unit_flags|0x8|0x100 WHERE entry=31261;
UPDATE creature_template SET unit_flags = unit_flags&~(0x2|0x80|0x100|0x200) WHERE entry IN(5661, 26044, 31261);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(6225, 6226, 6662);
DELETE FROM disables WHERE sourceType=4 AND entry IN(6225, 6226, 6662);
INSERT INTO achievement_criteria_data VALUES(6225, 1, 5661, 0, "");
INSERT INTO achievement_criteria_data VALUES(6226, 1, 26044, 0, "");
INSERT INTO achievement_criteria_data VALUES(6662, 1, 31261, 0, "");

-- Crashin' & Thrashin' (1295)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(4090);
DELETE FROM disables WHERE sourceType=4 AND entry IN(4090);
INSERT INTO achievement_criteria_data VALUES(4090, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(4090, 16, 141, 0, "");

-- Let It Snow (1687)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(6237, 6238, 6239, 6240, 6241, 6242, 6243, 6244, 6245, 6246);
DELETE FROM disables WHERE sourceType=4 AND entry IN(6237, 6238, 6239, 6240, 6241, 6242, 6243, 6244, 6245, 6246);
INSERT INTO achievement_criteria_data VALUES(6237, 2, 6, 2, "");
INSERT INTO achievement_criteria_data VALUES(6238, 2, 1, 1, "");
INSERT INTO achievement_criteria_data VALUES(6239, 2, 7, 6, "");
INSERT INTO achievement_criteria_data VALUES(6240, 2, 11, 4, "");
INSERT INTO achievement_criteria_data VALUES(6241, 2, 4, 5, "");
INSERT INTO achievement_criteria_data VALUES(6242, 2, 3, 8, "");
INSERT INTO achievement_criteria_data VALUES(6243, 2, 8, 7, "");
INSERT INTO achievement_criteria_data VALUES(6244, 2, 2, 3, "");
INSERT INTO achievement_criteria_data VALUES(6245, 2, 9, 10, "");
INSERT INTO achievement_criteria_data VALUES(6246, 2, 5, 11, "");

-- Scrooge (1255)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10441);
DELETE FROM disables WHERE sourceType=4 AND entry IN(10441);
INSERT INTO achievement_criteria_data VALUES(10441, 1, 2784, 0, "");
INSERT INTO achievement_criteria_data VALUES(10441, 16, 141, 0, "");

-- Scrooge (259)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(5272);
DELETE FROM disables WHERE sourceType=4 AND entry IN(5272);
INSERT INTO achievement_criteria_data VALUES(5272, 1, 3057, 0, "");
INSERT INTO achievement_criteria_data VALUES(5272, 16, 141, 0, "");

-- The Winter Veil Gourmet (1688)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(6247, 6248, 6249);
DELETE FROM disables WHERE sourceType=4 AND entry IN(6247, 6248, 6249);
INSERT INTO achievement_criteria_data VALUES(6247, 16, 141, 0, "");
INSERT INTO achievement_criteria_data VALUES(6248, 16, 141, 0, "");
INSERT INTO achievement_criteria_data VALUES(6249, 16, 141, 0, "");

-- 'Tis the Season (277)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(4230);
DELETE FROM disables WHERE sourceType=4 AND entry IN(4230);
INSERT INTO achievement_criteria_data VALUES(4230, 5, 55000, 0, "");
INSERT INTO achievement_criteria_data VALUES(4230, 16, 141, 0, "");

-- With a Little Helper from My Friends (252)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(3826, 3827, 3828, 3829);
DELETE FROM disables WHERE sourceType=4 AND entry IN(3826, 3827, 3828, 3829);
INSERT INTO achievement_criteria_data VALUES(3826, 5, 26157, 0, "");
INSERT INTO achievement_criteria_data VALUES(3827, 5, 26272, 0, "");
INSERT INTO achievement_criteria_data VALUES(3828, 5, 26273, 0, "");
INSERT INTO achievement_criteria_data VALUES(3829, 5, 26274, 0, "");

-- Fa-la-la-la-Ogri'la (1282)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(3936, 3937, 3938);
DELETE FROM disables WHERE sourceType=4 AND entry IN(3936, 3937, 3938);
INSERT INTO achievement_criteria_data VALUES(3936, 5, 44827, 0, "");
INSERT INTO achievement_criteria_data VALUES(3937, 5, 44825, 0, "");
INSERT INTO achievement_criteria_data VALUES(3938, 5, 44824, 0, "");
