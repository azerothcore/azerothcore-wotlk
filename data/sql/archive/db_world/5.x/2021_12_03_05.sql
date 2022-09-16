-- DB update 2021_12_03_04 -> 2021_12_03_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_03_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_03_04 2021_12_03_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638107879444151149'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638107879444151149');

-- The Duke of Cynders
UPDATE `creature_template` SET `unit_flags`=320, `AIName`="SmartAI" WHERE `entry`=15206;
DELETE FROM `smart_scripts` WHERE `entryorguid`=15206 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15206,0,0,0,54,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Duke of Cynders - Just Summoned - Say 0"),
(15206,0,1,0,1,0,100,1,5000,5000,0,0,19,256,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Duke of Cynders - OOC - Remove unit_flag (No Repeat)"),
(15206,0,2,0,0,0,100,0,3000,6000,6000,9000,11,25028,0,0,0,0,0,5,0,0,0,0,0,0,0,"The Duke of Cynders - In Combat - Cast Fire Blast"),
(15206,0,3,0,0,0,100,0,8000,14000,12000,17000,11,18399,0,0,0,0,0,5,0,0,0,0,0,0,0,"The Duke of Cynders - In Combat - Cast Flamestrike"),
(15206,0,4,0,0,0,100,0,6000,10000,8000,12000,11,22424,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Duke of Cynders - In Combat - Cast Blast Wave");

DELETE FROM `creature_text` WHERE `CreatureID`=15206 AND `ID`>0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(15206,0,1,"You will pay the ultimate price for this insolence, little vermin.  Your soul is mine!",12,0,100,0,0,0,10801,0,"The Duke of Cynders"),
(15206,0,2,"This act of defiance will not go unpunished.  You, and your world, will die!",12,0,100,0,0,0,10802,0,"The Duke of Cynders"),
(15206,0,3,"Imposter!  It is a dishonor without equal to be summoned by a whelp such as you!  DIE!",12,0,100,0,0,0,10804,0,"The Duke of Cynders");

-- The Duke of Fathoms
UPDATE `creature_template` SET `unit_flags`=320, `AIName`="SmartAI" WHERE `entry`=15207;
DELETE FROM `smart_scripts` WHERE `entryorguid`=15207 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15207,0,0,0,54,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Duke of Fathoms - Just Summoned - Say 0"),
(15207,0,1,0,1,0,100,1,5000,5000,0,0,19,256,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Duke of Fathoms - OOC - Remove unit_flag (No Repeat)"),
(15207,0,2,0,4,0,100,0,0,0,0,0,11,3417,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Duke of Fathoms - On Aggro - Cast Thrash"),
(15207,0,3,0,0,0,100,0,8000,12000,8000,12000,11,16790,0,0,0,0,0,2,0,0,0,0,0,0,0,"The Duke of Fathoms - In Combat - Cast Knockdown"),
(15207,0,4,0,0,0,100,0,3000,6000,10000,15000,11,18670,0,0,0,0,0,2,0,0,0,0,0,0,0,"The Duke of Fathoms - In Combat - Cast Knock Away");

DELETE FROM `creature_text` WHERE `CreatureID`=15207 AND `ID`>0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(15207,0,1,"You will pay the ultimate price for this insolence, little vermin.  Your soul is mine!",12,0,100,0,0,0,10801,0,"The Duke of Fathoms"),
(15207,0,2,"This act of defiance will not go unpunished.  You, and your world, will die!",12,0,100,0,0,0,10802,0,"The Duke of Fathoms"),
(15207,0,3,"Imposter!  It is a dishonor without equal to be summoned by a whelp such as you!  DIE!",12,0,100,0,0,0,10804,0,"The Duke of Fathoms");

-- The Duke of Shards
UPDATE `creature_template` SET `unit_flags`=320, `AIName`="SmartAI" WHERE `entry`=15208;
DELETE FROM `smart_scripts` WHERE `entryorguid`=15208 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15208,0,0,0,54,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Duke of Shards - Just Summoned - Say 0"),
(15208,0,1,0,1,0,100,1,5000,5000,0,0,19,256,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Duke of Shards - OOC - Remove unit_flag (No Repeat)"),
(15208,0,2,0,0,0,100,0,4000,6000,4000,6000,11,13446,0,0,0,0,0,2,0,0,0,0,0,0,0,"The Duke of Shards - In Combat - Cast Strike"),
(15208,0,3,0,0,0,100,0,8000,12000,13000,17000,11,8078,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Duke of Shards - In Combat - Cast Thunderclap"),
(15208,0,4,0,0,0,100,0,6000,10000,10000,15000,11,6524,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Duke of Shards - In Combat - Cast Ground Tremor");

DELETE FROM `creature_text` WHERE `CreatureID`=15208 AND `ID`>0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(15208,0,1,"You will pay the ultimate price for this insolence, little vermin.  Your soul is mine!",12,0,100,0,0,0,10801,0,"The Duke of Shards"),
(15208,0,2,"This act of defiance will not go unpunished.  You, and your world, will die!",12,0,100,0,0,0,10802,0,"The Duke of Shards"),
(15208,0,3,"Imposter!  It is a dishonor without equal to be summoned by a whelp such as you!  DIE!",12,0,100,0,0,0,10804,0,"The Duke of Shards");

-- The Duke of Zephyrs
UPDATE `creature_template` SET `unit_flags`=320, `AIName`="SmartAI" WHERE `entry`=15220;
DELETE FROM `smart_scripts` WHERE `entryorguid`=15220 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15220,0,0,0,54,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Duke of Zephyrs - Just Summoned - Say 0"),
(15220,0,1,0,1,0,100,1,5000,5000,0,0,19,256,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Duke of Zephyrs - OOC - Remove unit_flag (No Repeat)"),
(15220,0,2,0,0,0,100,0,5000,8000,14000,18000,11,25034,0,0,0,0,0,2,0,0,0,0,0,0,0,"The Duke of Zephyrs - In Combat - Cast Forked Lightning"),
(15220,0,3,0,0,0,100,0,10000,12000,18000,22000,11,44417,0,0,0,0,0,5,0,0,0,0,0,0,0,"The Duke of Zephyrs - In Combat - Cast Lightning Cloud"),
(15220,0,4,0,0,0,100,0,5000,15000,10000,15000,11,12882,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Duke of Zephyrs - In Combat - Cast Wing Flap"),
(15220,0,5,0,0,0,100,0,8000,20000,8000,20000,11,15535,0,0,0,0,0,5,0,0,0,0,0,0,0,"The Duke of Zephyrs - In Combat - Cast Enveloping Winds");

DELETE FROM `creature_text` WHERE `CreatureID`=15220 AND `ID`>0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(15220,0,1,"You will pay the ultimate price for this insolence, little vermin.  Your soul is mine!",12,0,100,0,0,0,10801,0,"The Duke of Zephyrs"),
(15220,0,2,"This act of defiance will not go unpunished.  You, and your world, will die!",12,0,100,0,0,0,10802,0,"The Duke of Zephyrs"),
(15220,0,3,"Imposter!  It is a dishonor without equal to be summoned by a whelp such as you!  DIE!",12,0,100,0,0,0,10804,0,"The Duke of Zephyrs");

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_03_05' WHERE sql_rev = '1638107879444151149';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
