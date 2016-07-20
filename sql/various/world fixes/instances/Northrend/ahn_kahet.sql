
-- -------------------------------------
-- ELDER NADOX
-- -------------------------------------
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=30338); -- dont remove from creature

DELETE FROM spell_script_names WHERE spell_id=56159;
INSERT INTO spell_script_names VALUES(56159, "spell_ahn_kahet_swarmer_aura");

REPLACE INTO creature_template VALUES (29309, 31456, 0, 0, 0, 0, 27407, 0, 0, 0, 'Elder Nadox', '', '', 0, 75, 75, 2, 16, 0, 1.6, 1.42857, 1, 1, 339, 481, 0, 370, 7.5, 2400, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 293, 436, 53, 6, 72, 29309, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 17, 20, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 650854271, 0+0x200000, 'boss_elder_nadox', 12340);
REPLACE INTO creature_template VALUES (30172, 31446, 0, 0, 0, 0, 26831, 0, 0, 0, 'Ahn\'kahar Swarm Egg', '', '', 0, 70, 70, 2, 16, 0, 1, 1, 1, 0, 252, 357, 0, 304, 1, 2000, 0, 1, 33554434, 2048, 8, 0, 0, 0, 0, 0, 215, 320, 44, 10, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, '', 12340);
REPLACE INTO creature_template VALUES (30173, 31445, 0, 0, 0, 0, 26828, 0, 0, 0, 'Ahn\'kahar Guardian Egg', '', '', 0, 70, 70, 2, 16, 0, 1, 1, 1, 0, 252, 357, 0, 304, 1, 2000, 0, 1, 33554434, 2048, 8, 0, 0, 0, 0, 0, 215, 320, 44, 10, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, '', 12340);
REPLACE INTO creature_template VALUES (30176, 31441, 0, 0, 0, 0, 28079, 0, 0, 0, 'Ahn\'kahar Guardian', '', '', 0, 74, 74, 2, 16, 0, 1, 1.42857, 1, 1, 328, 467, 0, 354, 7.5, 2400, 0, 1, 32768, 2048, 8, 0, 0, 0, 0, 0, 287, 426, 63, 6, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 650854271, 0+0x200000, 'npc_ahnkahar_nerubian', 12340);
REPLACE INTO creature_template VALUES (30178, 31448, 0, 0, 0, 0, 28078, 0, 0, 0, 'Ahn\'kahar Swarmer', '', '', 0, 74, 74, 2, 16, 0, 0.833332, 1.42857, 1, 0, 328, 467, 0, 354, 1, 3000, 0, 1, 32768, 2048, 8, 0, 0, 0, 0, 0, 287, 426, 63, 6, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.012157, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 650854271, 0+0x200000, 'npc_ahnkahar_nerubian', 12340);
REPLACE INTO creature_template VALUES (31441, 0, 0, 0, 0, 0, 28079, 0, 0, 0, 'Ahn\'kahar Guardian (1)', '', '', 0, 81, 81, 2, 16, 0, 1, 1.42857, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 32768, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 650854271, 0+0x200000, '', 12340);
REPLACE INTO creature_template VALUES (31445, 0, 0, 0, 0, 0, 26828, 0, 0, 0, 'Ahn\'kahar Guardian Egg (1)', '', '', 0, 81, 81, 2, 16, 0, 1, 1, 1, 0, 464, 604, 0, 708, 1, 2000, 0, 1, 33554434, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 10, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (31446, 0, 0, 0, 0, 0, 26831, 0, 0, 0, 'Ahn\'kahar Swarm Egg (1)', '', '', 0, 81, 81, 2, 16, 0, 1, 1, 1, 0, 464, 604, 0, 708, 1, 2000, 0, 1, 33554434, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 10, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (31448, 0, 0, 0, 0, 0, 28078, 0, 0, 0, 'Ahn\'kahar Swarmer  (1)', '', '', 0, 80, 80, 2, 16, 0, 0.833332, 1.42857, 1, 0, 422, 586, 0, 642, 1, 3000, 0, 1, 32768, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.019841, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 650854271, 0+0x200000, '', 12340);
REPLACE INTO creature_template VALUES (31456, 0, 0, 0, 0, 0, 27407, 0, 0, 0, 'Elder Nadox (1)', '', '', 0, 82, 82, 2, 16, 0, 1.6, 1.42857, 1, 1, 463, 640, 0, 726, 13, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 360, 520, 91, 6, 72, 31456, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 32, 20, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 650854271, 1+0x200000, '', 12340);

-- TC, remove some unused scripts
DELETE FROM spell_script_names WHERE ScriptName='spell_elder_nadox_guardian' AND spell_id=56153;

-- -------------------------------------
-- PRINCE TALDARAM
-- -------------------------------------
DELETE FROM creature_addon WHERE guid=131951; -- shit aura
REPLACE INTO creature_template VALUES (29308, 31469, 0, 0, 0, 0, 27406, 0, 0, 0, 'Prince Taldaram', '', '', 0, 75, 75, 2, 16, 0, 1.6, 1.42857, 1, 1, 339, 481, 0, 370, 7.5, 2400, 0, 2, 33587264, 2048, 8, 0, 0, 0, 0, 0, 293, 436, 53, 7, 72, 29308, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4181, 6969, '', 0, 3, 1, 20, 20, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 650854271, 0+0x200000, 'boss_taldaram', 12340);
REPLACE INTO creature_template VALUES (30106, 31458, 0, 0, 0, 0, 26767, 0, 0, 0, 'Flame Sphere', '', '', 0, 80, 80, 2, 16, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 570687488, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 4, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 53, 1, 0, 0, 'npc_taldaram_flamesphere', 12340);
REPLACE INTO creature_template VALUES (31458, 0, 0, 0, 0, 0, 26767, 0, 0, 0, 'Flame Sphere (1)', '', '', 0, 80, 80, 2, 16, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 570687488, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 4, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 53, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (31469, 0, 0, 0, 0, 0, 27406, 0, 0, 0, 'Prince Taldaram (1)', '', '', 0, 82, 82, 2, 16, 0, 1.6, 1.42857, 1, 1, 463, 640, 0, 726, 13, 2200, 0, 2, 33587264, 2048, 8, 0, 0, 0, 0, 0, 360, 520, 91, 7, 72, 31469, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8362, 13938, '', 0, 3, 1, 34, 20, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 650854271, 1+0x200000, '', 12340);
REPLACE INTO creature_template VALUES (31686, 0, 0, 0, 0, 0, 26767, 0, 0, 0, 'Flame Sphere', '', '', 0, 80, 80, 2, 16, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 570687488, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 4, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 53, 1, 0, 0, 'npc_taldaram_flamesphere', 12340);
REPLACE INTO creature_template VALUES (31687, 0, 0, 0, 0, 0, 26767, 0, 0, 0, 'Flame Sphere', '', '', 0, 80, 80, 2, 16, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 570687488, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 4, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 53, 1, 0, 0, 'npc_taldaram_flamesphere', 12340);

-- TC, remove some unused scripts
DELETE FROM spell_script_names WHERE ScriptName='spell_prince_taldaram_flame_sphere_summon';
DELETE FROM spell_script_names WHERE ScriptName='spell_prince_taldaram_conjure_flame_sphere';



-- -------------------------------------
-- JEDOGA
-- -------------------------------------
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(30181, 30114));
DELETE FROM creature WHERE id IN(30181, 30114);
UPDATE creature SET MovementType=0, spawndist=0 WHERE id=29310;
DELETE FROM linked_respawn WHERE linkedGuid=131953;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(56150);
INSERT INTO conditions VALUES(13, 1, 56150, 0, 0, 31, 0, 3, 30181, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 56150, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');

REPLACE INTO creature_template VALUES (29310, 31465, 0, 0, 0, 0, 26777, 0, 0, 0, 'Jedoga Shadowseeker', '', '', 0, 75, 75, 2, 16, 0, 1, 1.71429, 1.35, 1, 339, 481, 0, 370, 7.5, 2400, 0, 2, 32832, 2048, 9, 0, 0, 0, 0, 0, 293, 436, 53, 7, 72, 29310, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4176, 6960, '', 0, 3, 1, 20, 20, 1, 0, 0, 0, 0, 0, 0, 0, 172, 1, 650854271, 0+0x200000, 'boss_jedoga_shadowseeker', 12340);
REPLACE INTO creature_template VALUES (30114, 31473, 0, 0, 0, 0, 27378, 27379, 27380, 27381, 'Twilight Initiate', '', '', 0, 74, 74, 2, 16, 0, 1, 1.14286, 1, 0, 279, 408, 0, 158, 1, 2000, 0, 8, 32768, 2048, 8, 0, 0, 0, 0, 0, 263, 391, 41, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.8, 4, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 0+0x200000, 'npc_jedoga_initiand', 12340);
REPLACE INTO creature_template VALUES (30181, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Jedoga Controller', '', '', 0, 74, 74, 2, 14, 0, 1, 1.14286, 1, 1, 328, 467, 0, 354, 7.5, 2000, 0, 1, 33554432, 2048, 8, 0, 0, 0, 0, 0, 287, 426, 63, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 4, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, '', 12340);
REPLACE INTO creature_template VALUES (31465, 0, 0, 0, 0, 0, 26777, 0, 0, 0, 'Jedoga Shadowseeker (1)', '', '', 0, 82, 82, 2, 16, 0, 1, 1.71429, 1.35, 1, 463, 640, 0, 726, 13, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 360, 520, 91, 7, 72, 31465, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8352, 13920, '', 0, 3, 1, 32, 20, 1, 0, 0, 0, 0, 0, 0, 0, 172, 1, 650854271, 1+0x200000, '', 12340);
REPLACE INTO creature_template VALUES (31473, 0, 0, 0, 0, 0, 27378, 27379, 27380, 27381, 'Twilight Initiate (1)', '', '', 0, 80, 80, 2, 16, 0, 1, 1.14286, 1, 0, 346, 499, 0, 287, 3, 2000, 0, 8, 32768, 2048, 8, 0, 0, 0, 0, 0, 315, 468, 69, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 4, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 0+0x200000, '', 12340);


-- -------------------------------------
-- HEROLD VOLAZJ
-- -------------------------------------
REPLACE INTO creature_template VALUES (29311, 31464, 0, 0, 0, 0, 27408, 0, 0, 0, 'Herald Volazj', '', '', 0, 75, 75, 2, 16, 0, 1.6, 1.42857, 1, 1, 342, 485, 0, 392, 7.5, 2400, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 295, 438, 68, 10, 72, 29311, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4177, 6961, '', 0, 3, 1, 25, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 650854271, 0+0x200000, 'boss_volazj', 12340);
REPLACE INTO creature_template VALUES (30625, 31480, 0, 0, 0, 0, 11686, 0, 0, 0, 'Twisted Visage', '', '', 0, 73, 73, 2, 16, 0, 1.6, 1, 1, 1, 316, 450, 0, 320, 7.5, 2400, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 278, 413, 58, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.402415, 1, 1, 0, 0, 0, 0, 0, 0, 0, 116, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (31464, 0, 0, 0, 0, 0, 27408, 0, 0, 0, 'Herald Volazj (1)', '', '', 0, 82, 82, 2, 16, 0, 1.6, 1.42857, 1, 1, 488, 642, 0, 782, 13, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 10, 72, 31464, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8354, 13922, '', 0, 3, 1, 32, 1, 1, 0, 43821, 0, 0, 0, 0, 0, 150, 1, 650854271, 1+0x200000, '', 12340);
REPLACE INTO creature_template VALUES (31480, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Twisted Visage', '', '', 0, 80, 80, 2, 16, 0, 1.6, 1, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.952381, 1, 1, 0, 0, 0, 0, 0, 0, 0, 116, 1, 0, 0, '', 12340);


-- -------------------------------------
-- AMANITAR
-- -------------------------------------
DELETE FROM spell_linked_spell WHERE spell_trigger=56648;
INSERT INTO spell_linked_spell VALUES(56648, -57055, 1, "Remove Mini with Potent Fungus");
UPDATE creature_template SET modelid1=26981, modelid2=0, flags_extra=130 WHERE entry IN(30391, 30435, 31461, 31462);


-- -------------------------------------
-- ACHIEVEMENTS
-- -------------------------------------
-- Ahn'kahet: The Old Kingdom (481)
DELETE FROM disables WHERE sourceType=4 AND entry IN(3578, 3579, 3580, 3581);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(3578, 3579, 3580, 3581);
INSERT INTO achievement_criteria_data VALUES(3578, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(3579, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(3580, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(3581, 12, 0, 0, "");

-- Heroic: Ahn'kahet: The Old Kingdom (492)
DELETE FROM disables WHERE sourceType=4 AND entry IN(6851, 6852, 6853, 6854);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(6851, 6852, 6853, 6854);
INSERT INTO achievement_criteria_data VALUES(6851, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(6852, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(6853, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(6854, 12, 1, 0, "");

-- Respect Your Elders (2038)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7317);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7317);
INSERT INTO achievement_criteria_data VALUES(7317, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7317, 18, 0, 0, "");

-- Volunteer Work (2056)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7359);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7359);
INSERT INTO achievement_criteria_data VALUES(7359, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7359, 18, 0, 0, "");

-- Volazj's Quick Demise (1862)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7133);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7133);
INSERT INTO achievement_criteria_data VALUES(7133, 12, 1, 0, "");

