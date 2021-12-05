-- DB update 2021_12_05_03 -> 2021_12_05_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_05_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_05_03 2021_12_05_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638110187508927447'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638110187508927447');

-- Prince Skaldrenox
UPDATE `creature_template` SET `unit_flags`=320, `AIName`="SmartAI" WHERE `entry`=15203;
DELETE FROM `smart_scripts` WHERE `entryorguid`=15203 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15203,0,0,0,54,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Prince Skaldrenox - Just Summoned - Say 0"),
(15203,0,1,0,1,0,100,1,10000,10000,0,0,19,256,0,0,0,0,0,1,0,0,0,0,0,0,0,"Prince Skaldrenox - OOC - Remove unit_flag (No Repeat)"),
(15203,0,2,0,0,0,100,0,4000,6000,20000,30000,11,25050,0,0,0,0,0,4,0,0,0,0,0,0,0,"Prince Skaldrenox - In Combat - Cast Mark of Flames"),
(15203,0,3,0,0,0,100,0,8000,10000,15000,24000,11,25049,0,0,0,0,0,1,0,0,0,0,0,0,0,"Prince Skaldrenox - In Combat - Cast Blastwave"),
(15203,0,4,0,0,0,100,0,7000,8000,7000,8000,11,15284,0,0,0,0,0,2,0,0,0,0,0,0,0,"Prince Skaldrenox - In Combat - Cast Cleave");

DELETE FROM `creature_text` WHERE `CreatureID`=15203 AND `ID`>0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(15203,0,1,"You dare!  Outrageous!  I curse you, $c.  I curse you with... death!",14,0,100,0,0,0,10806,0,"Prince Skaldrenox"),
(15203,0,2,"What?  Such a small, frail thing beckons me?  I shall add your bones to my throne, $r!!",14,0,100,0,0,0,10807,0,"Prince Skaldrenox"),
(15203,0,3,"Killing you and your cohorts, $c, will amuse me.  I shall make it quick.",14,0,100,0,0,0,10810,0,"Prince Skaldrenox");

-- High Marshal Whirlaxis
UPDATE `creature_template` SET `unit_flags`=320, `AIName`="SmartAI" WHERE `entry`=15204;
DELETE FROM `smart_scripts` WHERE `entryorguid`=15204 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15204,0,0,0,54,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"High Marshal Whirlaxis - Just Summoned - Say 0"),
(15204,0,1,0,1,0,100,1,10000,10000,0,0,19,256,0,0,0,0,0,1,0,0,0,0,0,0,0,"High Marshal Whirlaxis - OOC - Remove unit_flag (No Repeat)"),
(15204,0,2,0,0,0,100,0,0,0,5000,5000,11,25020,32,0,0,0,0,1,0,0,0,0,0,0,0,"High Marshal Whirlaxis - In Combat - Cast Lightning Shield"),
(15204,0,3,0,0,0,100,0,9000,11000,21000,26000,11,23103,0,0,0,0,0,5,0,0,0,0,0,0,0,"High Marshal Whirlaxis - In Combat - Cast Enveloping Winds"),
(15204,0,4,0,0,0,100,0,17000,20000,17000,20000,11,25060,0,0,0,0,0,1,0,0,0,0,0,0,0,"High Marshal Whirlaxis - In Combat - Cast Updraft");

DELETE FROM `creature_text` WHERE `CreatureID`=15204 AND `ID`>0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(15204,0,1,"You dare!  Outrageous!  I curse you, $c.  I curse you with... death!",14,0,100,0,0,0,10806,0,"High Marshal Whirlaxis"),
(15204,0,2,"What?  Such a small, frail thing beckons me?  I shall add your bones to my throne, $r!!",14,0,100,0,0,0,10807,0,"High Marshal Whirlaxis"),
(15204,0,3,"Killing you and your cohorts, $c, will amuse me.  I shall make it quick.",14,0,100,0,0,0,10810,0,"High Marshal Whirlaxis");

-- Baron Kazum
UPDATE `creature_template` SET `unit_flags`=320, `AIName`="SmartAI" WHERE `entry`=15205;
DELETE FROM `smart_scripts` WHERE `entryorguid`=15205 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15205,0,0,0,54,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Baron Kazum - Just Summoned - Say 0"),
(15205,0,1,0,1,0,100,1,10000,10000,0,0,19,256,0,0,0,0,0,1,0,0,0,0,0,0,0,"Baron Kazum - OOC - Remove unit_flag (No Repeat)"),
(15205,0,3,0,0,0,100,0,3000,6000,13000,16000,11,25056,0,0,0,0,0,1,0,0,0,0,0,0,0,"Baron Kazum - In Combat - Cast Stomp"),
(15205,0,4,0,0,0,100,0,7000,10000,15000,28000,11,19129,0,0,0,0,0,1,0,0,0,0,0,0,0,"Baron Kazum - In Combat - Cast Massive Tremor"),
(15205,0,5,0,0,0,100,0,12000,15000,15000,18000,11,17547,0,0,0,0,0,2,0,0,0,0,0,0,0,"Baron Kazum - In Combat - Cast Mortal Strike");

DELETE FROM `creature_text` WHERE `CreatureID`=15205 AND `ID`>0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(15205,0,1,"You dare!  Outrageous!  I curse you, $c.  I curse you with... death!",14,0,100,0,0,0,10806,0,"Baron Kazum"),
(15205,0,2,"What?  Such a small, frail thing beckons me?  I shall add your bones to my throne, $r!!",14,0,100,0,0,0,10807,0,"Baron Kazum"),
(15205,0,3,"Killing you and your cohorts, $c, will amuse me.  I shall make it quick.",14,0,100,0,0,0,10810,0,"Baron Kazum");

-- Lord Skwol
UPDATE `creature_template` SET `unit_flags`=320, `AIName`="SmartAI" WHERE `entry`=15305;
DELETE FROM `smart_scripts` WHERE `entryorguid`=15305 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15305,0,0,0,54,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Lord Skwol - Just Summoned - Say 0"),
(15305,0,1,0,1,0,100,1,10000,10000,0,0,19,256,0,0,0,0,0,1,0,0,0,0,0,0,0,"Lord Skwol - OOC - Remove unit_flag (No Repeat)"),
(15305,0,2,0,4,0,100,0,0,0,0,0,11,3417,0,0,0,0,0,1,0,0,0,0,0,0,0,"Lord Skwol - On Aggro - Cast Thrash"),
(15305,0,3,0,0,0,100,0,10000,12000,18000,20000,11,25053,0,0,0,0,0,2,0,0,0,0,0,0,0,"Lord Skwol - In Combat - Cast Venom Spit"),
(15305,0,4,0,0,0,100,0,2000,3000,5000,8000,11,25051,0,0,0,0,0,2,0,0,0,0,0,0,0,"Lord Skwol - In Combat - Cast Sunder Armor");

DELETE FROM `creature_text` WHERE `CreatureID`=15305 AND `ID`>0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(15305,0,1,"You dare!  Outrageous!  I curse you, $c.  I curse you with... death!",14,0,100,0,0,0,10806,0,"Lord Skwol"),
(15305,0,2,"What?  Such a small, frail thing beckons me?  I shall add your bones to my throne, $r!!",14,0,100,0,0,0,10807,0,"Lord Skwol"),
(15305,0,3,"Killing you and your cohorts, $c, will amuse me.  I shall make it quick.",14,0,100,0,0,0,10810,0,"Lord Skwol");

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_05_04' WHERE sql_rev = '1638110187508927447';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
