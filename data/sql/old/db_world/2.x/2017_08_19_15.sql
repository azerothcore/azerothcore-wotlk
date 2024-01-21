-- DB update 2017_08_19_14 -> 2017_08_19_15
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_08_19_14';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_08_19_14 2017_08_19_15 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1495464409315344160'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1495464409315344160');

-- The Troll Cave requires 14 kills, not 10.
UPDATE `quest_template` SET `RequiredNpcOrGoCount1` = 14 where `ID` = 182;

-- Make The Grizzled Den more tolerable.
DELETE FROM `creature` WHERE `guid` IN (3137,3255,3261,3262,3548,3551,3554,3558,3583,3239,3243,3246,3257,3258,3552,3565,3566,3567,3570,3573,3574,3578);

-- The Perfect Stout does not require Rejold's New Brew, it's the otherway around.
UPDATE `quest_template_addon` SET `NextQuestID` = 0, `PrevQuestID` = 315 WHERE `ID` = 415;

-- All Tunnel Rats should be able to drop ears, not just 1 out of 6 types.
DELETE FROM `creature_loot_template` WHERE `entry` in (1172,1174,1175,1176,1177) and `item` = 3110;
INSERT INTO `creature_loot_template` VALUES
(1172, 3110,-38,1,0,1,1),
(1174, 3110,-80,1,0,1,1),
(1175, 3110,-80,1,0,1,1),
(1176, 3110,-38,1,0,1,1),
(1177, 3110,-80,1,0,1,1);

-- Red Silk Bandanas needs The Defias Brotherhood (6), not Red Leather Bandanas.
UPDATE `quest_template_addon` SET `PrevQuestID` = 155 WHERE `ID` = 214;

-- Letter to Stormpike follows Encrypted Letter
UPDATE `quest_template_addon` SET `PrevQuestID` = 511 WHERE `ID` = 514;

-- Kurzen Jungle Fighter also drops Jungle Remedy
DELETE FROM `creature_loot_template` WHERE `entry` = 937 AND `item` = 2633;
INSERT INTO `creature_loot_template` VALUES (937,2633,-33,1,0,1,1);

-- Inspecting the ruins requires either They Call Him Smilling Jim or James Hyal
UPDATE `quest_template_addon` SET `NextQuestID` = 11123 WHERE `ID` = 1282;
UPDATE `quest_template_addon` SET `NextQuestID` = 11123 WHERE `ID` = 1302;
UPDATE `quest_template_addon` SET `PrevQuestID` =     0 WHERE `ID` = 11123;

-- Raising the drop rate on Forked Mudrock Tongues
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -40 WHERE `entry` = 4397 AND `item` = 5883;

-- Trouble in Winterspring! is a breadcrumb quest, not prequest.
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE `ID` = 5082;

-- Raising the drop rate of Thick Yeti Fur
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -71 WHERE `entry` = 7457 AND `item` = 12366;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -41 WHERE `entry` = 7458 AND `item` = 12366;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -43 WHERE `entry` = 7459 AND `item` = 12366;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -45 WHERE `entry` = 7460 AND `item` = 12366;

-- Flesh Eating Worm adjustment
UPDATE `creature_template` SET `mindmg` = 16, `maxdmg` = 25, `scale`=0.4 WHERE `entry` = 2462;

-- Rotting Worm adjustment
UPDATE `creature_template` SET `mindmg` = 41, `maxdmg` = 66, `scale`=0.4 WHERE `entry` = 10925;

-- Fool's stout follows Report Back to Fizzlebub
UPDATE `quest_template_addon` SET `PrevQuestID` = 1122 WHERE `ID` = 1127;

-- Fixing Half-Buried Bottle loot table, it's not a raptor.
DELETE FROM `gameobject_loot_template` WHERE `entry` = 2032;
INSERT INTO `gameobject_loot_template` VALUES
(2032,1477,2.5,1,0,1,1),
(2032,1711,4.2,1,0,1,1),
(2032,2289,2.7,1,0,1,1),
(2032,2290,4.4,1,0,1,1),
(2032,3608,0.02,1,0,1,1),
(2032,4098,25,1,1,1,1),
(2032,4100,25,1,1,1,1),
(2032,4101,25,1,1,1,1),
(2032,4102,25,1,1,1,1),
(2032,4298,0.02,1,0,1,1),
(2032,4299,0.02,1,0,1,1),
(2032,4350,0.02,1,0,1,1),
(2032,4351,0.02,1,0,1,1),
(2032,4352,0.02,1,0,1,1),
(2032,4412,0.02,1,0,1,1),
(2032,4414,0.02,1,0,1,1),
(2032,4416,0.02,1,0,1,1),
(2032,4417,0.02,1,0,1,1),
(2032,5543,0.02,1,0,1,1),
(2032,5774,0.02,1,0,1,1),
(2032,6045,0.02,1,0,1,1),
(2032,6454,0.02,1,0,1,1),
(2032,7085,0.02,1,0,1,1),
(2032,7090,0.02,1,0,1,1),
(2032,7360,0.02,1,0,1,1),
(2032,7363,0.02,1,0,1,1),
(2032,7364,0.02,1,0,1,1),
(2032,7449,0.02,1,0,1,1),
(2032,7450,0.02,1,0,1,1),
(2032,7975,0.1,1,0,1,1),
(2032,7992,0.0508056,1,0,1,1),
(2032,8029,0.0508056,1,0,1,1),
(2032,8385,0.0508056,1,0,1,1),
(2032,8386,0.0580636,1,0,1,1),
(2032,8387,0.0725795,1,0,1,1),
(2032,9293,0.0435477,1,0,1,1),
(2032,10300,0.1,1,0,1,1),
(2032,10301,0.1,1,0,1,1),
(2032,10302,0.0653215,1,0,1,1),
(2032,10312,0.0290318,1,0,1,1),
(2032,10424,0.02,1,0,1,1),
(2032,10601,0.02,1,0,1,1),
(2032,10603,0.0362897,1,0,1,1),
(2032,10604,0.0653215,1,0,1,1),
(2032,10606,0.1,1,0,1,1),
(2032,11098,0.02,1,0,1,1),
(2032,11164,0.02,1,0,1,1),
(2032,11165,0.02,1,0,1,1),
(2032,11167,0.02,1,0,1,1),
(2032,11202,0.0290318,1,0,1,1),
(2032,11204,0.1,1,0,1,1);

-- Atal'ai Artifacts (and 1 mithril deposit) are underground
UPDATE `gameobject` SET `position_z`=-15.29  WHERE `guid`=30371;
UPDATE `gameobject` SET `position_z`= 14.5   WHERE `guid`=30374;
UPDATE `gameobject` SET `position_z`= 31.63  WHERE `guid`=30380;
UPDATE `gameobject` SET `position_z`=-16.75  WHERE `guid`=30381;
UPDATE `gameobject` SET `position_z`= 19.57  WHERE `guid`=30383;
UPDATE `gameobject` SET `position_z`= 10.58  WHERE `guid`=30541;
UPDATE `gameobject` SET `position_z`=-19     WHERE `guid`=30542;
UPDATE `gameobject` SET `position_z`=-16.9   WHERE `guid`=30543;
UPDATE `gameobject` SET `position_z`= 20.2   WHERE `guid`=30546;
UPDATE `gameobject` SET `position_z`=-2.2    WHERE `guid`=30547;
UPDATE `gameobject` SET `position_z`= 10.5   WHERE `guid`=30550;
UPDATE `gameobject` SET `position_z`=-11.9   WHERE `guid`=30551;
UPDATE `gameobject` SET `position_z`= 10.91  WHERE `guid`=30554;
UPDATE `gameobject` SET `position_z`=-3.56   WHERE `guid`=30556;
UPDATE `gameobject` SET `position_z`= 18.70  WHERE `guid`=30558;
UPDATE `gameobject` SET `position_z`= 19.1   WHERE `guid`=30559;
UPDATE `gameobject` SET `position_z`= 18.66  WHERE `guid`=30561;
UPDATE `gameobject` SET `position_z`=-19     WHERE `guid`=30643;
UPDATE `gameobject` SET `position_z`=-6      WHERE `guid`=30646;
UPDATE `gameobject` SET `position_z`=-10.4   WHERE `guid`=30375;
UPDATE `gameobject` SET `position_z`=-8.5    WHERE `guid`=30378;
UPDATE `gameobject` SET `position_z`= 19     WHERE `guid`=31029;

-- Atal'ai Artifact twin spawn
DELETE FROM `gameobject` WHERE `guid`=30593;
DELETE FROM `gameobject` WHERE `guid`=30594;
DELETE FROM `gameobject` WHERE `guid`=30587;

-- Blue Pearls do not drop from giant clams outside of the Vile Reef in STV.
DELETE FROM `gameobject_loot_template` WHERE `entry` IN ( 2954, 2959) and `item` = 4611;
-- Blue Pearls do not drop from Small Barnacle Clam or Thick Shell Clam items.
DELETE FROM      `spell_loot_template` WHERE `entry` IN (58168,58172) and `item` = 4611;

-- Black Dragonflight Molt is a guaranteed drop from Hoard of the Black Dragonflight
UPDATE `item_loot_template` SET `ChanceOrQuestChance` = 100 WHERE `entry` = 10569 AND `item` = 10575;


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
