-- DB update 2021_12_02_02 -> 2021_12_02_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_02_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_02_02 2021_12_02_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638105320614262889'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638105320614262889');

-- Crimson Templar
UPDATE `creature_template` SET `unit_flags`=320, `AIName`="SmartAI" WHERE `entry`=15209;
DELETE FROM `smart_scripts` WHERE `entryorguid`=15209 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15209,0,0,0,54,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crimson Templar - Just Summoned - Say 0"),
(15209,0,1,0,1,0,100,1,5000,5000,0,0,19,256,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crimson Templar - OOC - Remove unit_flag (No Repeat)"),
(15209,0,2,0,0,0,100,0,4000,6000,7000,11000,11,11989,0,0,0,0,0,1,0,0,0,0,0,0,0,"Crimson Templar - In Combat - Cast Fireball Volley"),
(15209,0,3,0,0,0,100,0,2000,3000,11000,15000,11,16536,0,0,0,0,0,2,0,0,0,0,0,0,0,"Crimson Templar - In Combat - Cast Flame Buffet");

DELETE FROM `creature_text` WHERE `CreatureID`=15209 AND `ID`>0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(15209,0,1,"My lord will be outraged to learn of this ambush.  Let us hope your death will appease him.",12,0,100,0,0,0,10694,0,"Crimson Templar"),
(15209,0,2,"It is my duty and honor to die for the Abyssal Council!",12,0,100,0,0,0,10695,0,"Crimson Templar"),
(15209,0,3,"Your life is a fitting sacrifice for my master, $c.",12,0,100,0,0,0,10696,0,"Crimson Templar");

-- Azure Templar
UPDATE `creature_template` SET `unit_flags`=320, `AIName`="SmartAI" WHERE `entry`=15211;
DELETE FROM `smart_scripts` WHERE `entryorguid`=15211 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15211,0,0,0,54,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Azure Templar - Just Summoned - Say 0"),
(15211,0,1,0,1,0,100,1,5000,5000,0,0,19,256,0,0,0,0,0,1,0,0,0,0,0,0,0,"Azure Templar - OOC - Remove unit_flag (No Repeat)"),
(15211,0,2,0,0,0,100,0,3000,5000,8000,12000,11,12548,0,0,0,0,0,2,0,0,0,0,0,0,0,"Azure Templar - In Combat - Cast Frost Shock"),
(15211,0,3,0,0,0,100,0,7000,9000,11000,15000,11,14907,0,0,0,0,0,1,0,0,0,0,0,0,0,"Azure Templar - In Combat - Cast Frost Nova");

DELETE FROM `creature_text` WHERE `CreatureID`=15211 AND `ID`>0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(15211,0,1,"My lord will be outraged to learn of this ambush.  Let us hope your death will appease him.",12,0,100,0,0,0,10694,0,"Azure Templar"),
(15211,0,2,"It is my duty and honor to die for the Abyssal Council!",12,0,100,0,0,0,10695,0,"Azure Templar"),
(15211,0,3,"Your life is a fitting sacrifice for my master, $c.",12,0,100,0,0,0,10696,0,"Azure Templar");

-- Hoary Templar
UPDATE `creature_template` SET `unit_flags`=320, `AIName`="SmartAI" WHERE `entry`=15212;
DELETE FROM `smart_scripts` WHERE `entryorguid`=15212 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15212,0,0,0,54,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hoary Templar - Just Summoned - Say 0"),
(15212,0,1,0,1,0,100,1,5000,5000,0,0,19,256,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hoary Templar - OOC - Remove unit_flag (No Repeat)"),
(15212,0,2,0,0,0,100,0,3000,5000,7000,11000,11,2610,2,0,0,0,0,2,0,0,0,0,0,0,0,"Hoary Templar - In Combat - Cast Shock"),
(15212,0,3,0,4,0,100,0,0,0,0,0,11,25020,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hoary Templar - On Aggro - Cast Lightning Shield");

DELETE FROM `creature_text` WHERE `CreatureID`=15212 AND `ID`>0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(15212,0,1,"My lord will be outraged to learn of this ambush.  Let us hope your death will appease him.",12,0,100,0,0,0,10694,0,"Hoary Templar"),
(15212,0,2,"It is my duty and honor to die for the Abyssal Council!",12,0,100,0,0,0,10695,0,"Hoary Templar"),
(15212,0,3,"Your life is a fitting sacrifice for my master, $c.",12,0,100,0,0,0,10696,0,"Hoary Templar");

-- Earthen Templar
UPDATE `creature_template` SET `unit_flags`=320, `AIName`="SmartAI" WHERE `entry`=15307;
DELETE FROM `smart_scripts` WHERE `entryorguid`=15307 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15307,0,0,0,54,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Earthen Templar - Just Summoned - Say 0"),
(15307,0,1,0,1,0,100,1,5000,5000,0,0,19,256,0,0,0,0,0,1,0,0,0,0,0,0,0,"Earthen Templar - OOC - Remove unit_flag (No Repeat)"),
(15307,0,2,0,0,0,100,0,2000,3000,13000,15000,11,22127,2,0,0,0,0,2,0,0,0,0,0,0,0,"Earthen Templar - In Combat - Cast Entangling Roots"),
(15307,0,3,0,0,0,100,0,7000,9000,12000,16000,11,18813,0,0,0,0,0,2,0,0,0,0,0,0,0,"Earthen Templar - In Combat - Cast Knock Away");

DELETE FROM `creature_text` WHERE `CreatureID`=15307 AND `ID`>0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(15307,0,1,"My lord will be outraged to learn of this ambush.  Let us hope your death will appease him.",12,0,100,0,0,0,10694,0,"Earthen Templar"),
(15307,0,2,"It is my duty and honor to die for the Abyssal Council!",12,0,100,0,0,0,10695,0,"Earthen Templar"),
(15307,0,3,"Your life is a fitting sacrifice for my master, $c.",12,0,100,0,0,0,10696,0,"Earthen Templar");

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_02_03' WHERE sql_rev = '1638105320614262889';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
