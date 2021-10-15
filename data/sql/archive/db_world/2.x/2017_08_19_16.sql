-- DB update 2017_08_19_15 -> 2017_08_19_16
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_08_19_15';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_08_19_15 2017_08_19_16 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1495729610203623150'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1495729610203623150');

-- Bael'Gar's Fiery Essence requires Bael'Gar's Corpse, borrowed from TrinityCore/sql/old/3.3.5a/world/61_2016_10_17/2016_08_23_00_world.sql
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN(17) AND `SourceEntry`=13982;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17,0,13982,0,0,29,0,9016,10,1,0,0,0,'',"Spell 'Bael'Gar's Fiery Essence' requires Bael'Gar's corpse");

-- Crimson Crysal Shard is a guaranteed drop
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 100 WHERE `entry` = 19188 AND `item` = 29476;

-- Kurenai
UPDATE `quest_template` SET `RewardFactionValue1`    = 7     WHERE `ID` IN (9924,9954, 9917, 10476, 9923, 11502, 10477, 9871, 9873, 9878, 9874, 9921, 9936, 9940, 10116, 10115, 9835, 9833, 9905, 9834,9839,9830, 9902);
UPDATE `quest_template` SET `RewardFactionOverride1` = 70000 WHERE `ID` IN (9955,9933,9956,9879,9922,9938);
UPDATE `quest_template` SET `RewardFactionValue1`    = 8     WHERE `ID` IN (9918);

-- Mag'har
UPDATE `quest_template` SET `RewardFactionValue1`    = 7      WHERE `ID` IN (9867, 9442,10102,10085, 9447, 9891, 9916, 11503, 9441, 9906, 10478, 9872, 9865, 10479, 9910, 10082, 9888, 10175, 9863, 9935, 9939, 9945, 10101);
UPDATE `quest_template` SET `RewardFactionOverride1` = 70000  WHERE `ID` IN (9410, 9907, 10167, 9946, 9948, 10045, 9934, 9868, 9937, 10168);
UPDATE `quest_template` SET `RewardFactionValue1`    = 8      WHERE `ID` IN (9889);
UPDATE `quest_template` SET `RewardFactionOverride1` = 200000 WHERE `ID` IN (10212);

-- Sporeggar
UPDATE `quest_template` SET `RewardFactionOverride1` =  75000 WHERE `ID` in (9739, 9743, 9742, 9744, 9919, 9806, 9808, 9807, 9809,9726, 9727, 9714, 9715);
UPDATE `quest_template` SET `RewardFactionOverride1` = 105000 WHERE `ID` in (9719, 9717, 9729);

-- Diaphanous wing droprate
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -40 WHERE `item` = 24372 AND `entry` IN (18132, 18133, 20197, 20198, 18283);

-- Greater and Young Sporebat also drop eyes.
DELETE FROM `creature_loot_template` WHERE `entry` IN (20387, 18129) AND `item` = 24426;
INSERT INTO `creature_loot_template` VALUES
(18129, 24426,-20,1,0,1,1),
(20387, 24426,-20,1,0,1,1);


-- Added vengeful draenei, from Trinity
DELETE FROM `creature` WHERE `id` = 21636;
INSERT INTO `creature` (`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(21636,530,1,1,0,0,-2981.75,4378.62,-49.227, 6.20934,600,0,0,5914,0,0,0,0,0),
(21636,530,1,1,0,0,-2962.8, 4378.18,-49.227, 3.08974,600,0,0,5914,0,0,0,0,0),
(21636,530,1,1,0,0,-2961.98,4363.85,-49.227, 1.88651,600,0,0,5914,0,0,0,0,0),
(21636,530,1,1,0,0,-2980.05,4363.27,-49.227, 1.61633,600,0,0,5914,0,0,0,0,0),
(21636,530,1,1,0,0,-3049.06,4495.87,-42.944, 6.09074,600,0,0,5914,0,0,0,0,0),
(21636,530,1,1,0,1,-2974.29,4441.98,-47.2117,1.43117,600,0,0,5914,0,0,0,0,0),
(21636,530,1,1,0,1,-3013.52,4510.81,-42.8637,5.0091, 600,0,0,5914,0,0,0,0,0),
(21636,530,1,1,0,1,-2898.17,4497.22,-42.8615,2.9147, 600,0,0,5914,0,0,0,0,0);


-- Escaping the Tomb was missing it's goal
UPDATE `quest_template` SET `AreaDescription` = 'Escort Akuno' WHERE `ID` = 10887;


-- Redone Slain Sha'tar Vindicator
DELETE FROM `creature` WHERE id = 21859;
INSERT INTO `creature` (`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(21859,530,1,1,0,1,-3736,   5333.73,-12.50,2.1171,150,0,0,6986,0,0,0,0,0),
(21859,530,1,1,0,1,-3750.4, 5301.33,-17.10,3.6650,150,0,0,6986,0,0,0,0,0),
(21859,530,1,1,0,1,-3649.6, 5322.93,-18.15,5.3430,150,0,0,6986,0,0,0,0,0),
(21859,530,1,1,0,1,-3779.2, 5225.73,-22.75,2.7725,150,0,0,6986,0,0,0,0,0),
(21859,530,1,1,0,1,-3714.4, 5214.93,-21.00,4.2144,150,0,0,6986,0,0,0,0,0),
(21859,530,1,1,0,1,-3750.4, 5171.73,-22.15,2.0036,150,0,0,6986,0,0,0,0,0),
(21859,530,1,1,0,1,-3764.8, 5128.53,-22.30,3.0938,150,0,0,6986,0,0,0,0,0),
(21859,530,1,1,0,1,-3750.4, 5085.33,-18.40,0.6098,150,0,0,6986,0,0,0,0,0);

-- Redone Slain Auchenai Warrior
DELETE FROM `creature` WHERE `id` = 21846;
INSERT INTO `creature` (`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(21846,530,1,1,0,1,-3714.4, 5290.53,-18.75,3.3858,150,0,0,6986,0,0,0,0,0),
(21846,530,1,1,0,1,-3714.4, 5225.73,-22.60,4.8247,150,0,0,6986,0,0,0,0,0),
(21846,530,1,1,0,1,-3692.8, 5344.53,-13.85,4.8579,150,0,0,6986,0,0,0,0,0),
(21846,530,1,1,0,1,-3642.4, 5290.53,-21.35,1.1159,150,0,0,6986,0,0,0,0,0),
(21846,530,1,1,0,1,-3750.4, 5268.93,-15.30,0.4874,150,0,0,6986,0,0,0,0,0),
(21846,530,1,1,0,1,-3772,   5214.93,-22.70,2.7571,150,0,0,6986,0,0,0,0,0),
(21846,530,1,1,0,1,-3736,   5160.93,-22.25,2.7343,150,0,0,6986,0,0,0,0,0),
(21846,530,1,1,0,1,-3764.8, 5106.93,-19.80,0.6078,150,0,0,6986,0,0,0,0,0);

-- Drop chance howling wind
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 15 WHERE `item` = 24504 AND `entry` IN (17158,17159,17160);


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
