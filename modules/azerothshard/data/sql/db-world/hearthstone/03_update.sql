-- update quests with rep
UPDATE `quest_template` SET `Flags` = 4226, `RewardFactionID1` = 948, `RewardFactionValueId1` = 0, RewardFactionValueIdOverride1 = 10 WHERE ID BETWEEN 100000 AND 100080;

-- mark of azeroth

UPDATE item_template SET NAME = "Mark of Azeroth", stackable = 2147483647, description = "Il bottino di ogni avventuriero!", maxcount = 0, spellid_1 = 0, spellcharges_1 = 0, flags = 0 WHERE entry = 37711;

SELECT * FROM quest_template WHERE title = "A Donation of Runecloth" OR title = "Uccidi Illidan";
-- quest rewards
UPDATE `quest_template` SET RewardItemId1 = 37711, RewardItemCount1 = 2 WHERE ID BETWEEN 100000 AND 100080;

-- hearthstone trasmog sack
UPDATE item_template SET NAME = "Garga's Magic Box", description = "Non sono così egocentrico da chiamare un NPC come me." WHERE entry = 32558;

DELETE FROM creature_questender WHERE id = 100001;
INSERT INTO creature_questender (id, quest) VALUES 
(100001, 100000),
(100001, 100001),
(100001, 100002),
(100001, 100003),
(100001, 100004),
(100001, 100005),
(100001, 100006),
(100001, 100007),
(100001, 100008),
(100001, 100009),
(100001, 100010),
(100001, 100011),
(100001, 100012),
(100001, 100013),
(100001, 100014),
(100001, 100015),
(100001, 100016),
(100001, 100017),
(100001, 100018),
(100001, 100019),
(100001, 100020),
(100001, 100021),
(100001, 100022),
(100001, 100023),
(100001, 100024),
(100001, 100025),
(100001, 100026),
(100001, 100027),
(100001, 100028),
(100001, 100029),
(100001, 100030),
(100001, 100031),
(100001, 100032),
(100001, 100033),
(100001, 100034),
(100001, 100035),
(100001, 100036),
(100001, 100037),
(100001, 100038),
(100001, 100039),
(100001, 100040),
(100001, 100041),
(100001, 100042),
(100001, 100043),
(100001, 100044),
(100001, 100045),
(100001, 100046),
(100001, 100047),
(100001, 100048),
(100001, 100049),
(100001, 100050),
(100001, 100051),
(100001, 100052),
(100001, 100053),
(100001, 100054),
(100001, 100055),
(100001, 100056),
(100001, 100057),
(100001, 100058),
(100001, 100059),
(100001, 100060),
(100001, 100061),
(100001, 100062),
(100001, 100063),
(100001, 100064),
(100001, 100065),
(100001, 100066),
(100001, 100067),
(100001, 100068),
(100001, 100069),
(100001, 100070),
(100001, 100071),
(100001, 100072),
(100001, 100073),
(100001, 100074),
(100001, 100075),
(100001, 100076),
(100001, 100077),
(100001, 100078),
(100001, 100079),
(100001, 100080);

DELETE FROM `creature_template` WHERE (entry = 100001);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES
(100001, 0, 0, 0, 0, 0, 10215, 0, 0, 0, 'Manaben', 'Han\'al Apprentice', NULL, 0, 80, 80, 0, 2007, 3, 1.1, 1.5, 1.2, 1, 0, 0, 0, 8, 33536, 2048, 0, 0, 0, 0, 0, 0, 7, 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 0, 10, 10, 1, 0, 0, 1, 0, 2, '', 12341);

UPDATE creature_template SET gossip_menu_id = 60000 WHERE entry = 100001;


DELETE FROM gossip_menu WHERE entry = 60000;
INSERT INTO gossip_menu (entry, text_id) VALUES (60000, 100010);

DELETE FROM npc_text WHERE ID = 100010;
INSERT INTO npc_text (ID, text0_0, text0_1, lang0, Prob0, em0_0) VALUES 
(100010, "Il Maestro è una persona molto stimata e famosa... aiutalo, e sarà generoso con te, $n!", 0, 0,100, 0);

-- UPDATE quest_template SET method = 0, TYPE = 0, flags = 4098, rewardfactionid1 = 69, rewardfactionvalueid1 = 6, RewardFactionValueIdOverride1 = 0, unknown0 = 1 WHERE id = 100000;
UPDATE quest_template SET method = 0, TYPE = 0, flags = 4098, rewardfactionid1 = 948, rewardfactionvalueid1 = 1, RewardFactionValueIdOverride1 = 0, unknown0 = 1 WHERE ID BETWEEN 100000 AND 100080;

DELETE FROM item_template WHERE entry >= 100017 AND subclass IN (0, 5, 7,8,9,10); 