-- DB update 2021_10_26_03 -> 2021_10_26_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_26_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_26_03 2021_10_26_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1635047186151663471'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635047186151663471');

-- Quest 8304 Dearest Natalia

-- Rutgar Glyphshaper
UPDATE `creature_template` SET `gossip_menu_id`=6533, `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=15170;
DELETE FROM `smart_scripts` WHERE `entryorguid`=15170 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_chance`,`event_param1`,`event_param2`,`action_type`,`action_param1`,`target_type`,`comment`) VALUES
(15170,0,0,1,62,100,6545,0,33,15222,7, 'Rutgar Glyphshaper - On Gossip Option Select - Killmonster credit Rutgar Questioned'),
(15170,0,1,0,61,100,0,0,72,0,7, 'Rutgar Glyphshaper - On Gossip Option Select - Close Gossip');

-- Gossip option fix
UPDATE `gossip_menu_option` SET `ActionMenuID`=6551 WHERE `MenuID`=6533;

-- Condition for source Gossip menu option condition type Quest taken
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=6533 AND `SourceEntry`=0 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 6533, 0, 0, 0, 9, 0, 8304, 0, 0, 0, 0, 0, '', 'Show gossip menu 6533 option id 0 if quest Dearest Natalia has been taken.');

-- Frankal Stonebridge
UPDATE `creature_template` SET `gossip_menu_id`=6534, `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=15171;
DELETE FROM `smart_scripts` WHERE `entryorguid`=15171 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_chance`,`event_param1`,`event_param2`,`action_type`,`action_param1`,`target_type`,`comment`) VALUES
(15171,0,0,1,62,100,6552,0,33,15221,7, 'Frankal Stonebridge - On Gossip Option Select - Killmonster credit Frankal Questioned'),
(15171,0,1,0,61,100,0,0,72,0,7, 'Frankal Stonebridge - On Gossip Option Select - Close Gossip');

-- Gossip option fix
UPDATE `gossip_menu_option` SET `OptionText`='Hello, Frankal. I''ve heard that you might have some information as to the whereabouts of Mistress Natalia Mar''alith.', `OptionBroadcastTextID`=10727, `ActionMenuID`=6558 WHERE `MenuID`=6534;

-- Condition for source Gossip menu option condition type Quest taken
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=6534 AND `SourceEntry`=0 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 6534, 0, 0, 0, 9, 0, 8304, 0, 0, 0, 0, 0, '', 'Show gossip menu 6534 option id 0 if quest Dearest Natalia has been taken.');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_26_04' WHERE sql_rev = '1635047186151663471';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
