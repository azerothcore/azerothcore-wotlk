-- DB update 2020_02_15_00 -> 2020_02_17_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_02_15_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_02_15_00 2020_02_17_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1579770074985495361'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1579770074985495361');

-- Spark Nilminer: Fix wrong gossip options by removing the obsolete gossip menu options for Ragged John
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 2061 AND `OptionID` = 1;
DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (2714,2715,2716,2717,2718,2719,2720,2721,2722,2723,2725);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 2061 AND `SourceEntry` = 1;

-- J.D. Collie: Gossip options and conditions
DELETE FROM `gossip_menu` WHERE `MenuID` = 2184 AND `TextID` = 2833;
DELETE FROM `gossip_menu` WHERE `MenuID` IN (2200,2202,2203,2204);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`)
VALUES
(2184,2833),
(2200,2834),
(2202,2836),
(2203,2837),
(2204,2838);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup` = 2184;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
(14,2184,2833,0,0,8,0,4321,0,0,0,0,0,'','Show gossip text 2833 if quest ''Making Sense of It'' is rewarded'),
(15,2184,0,0,0,8,0,4321,0,0,0,0,0,'','Show gossip option 0 if quest ''Making Sense of It'' is rewarded'),
(15,2184,1,0,0,8,0,4321,0,0,0,0,0,'','Show gossip option 1 if quest ''Making Sense of It'' is rewarded'),
(15,2184,2,0,0,8,0,4321,0,0,0,0,0,'','Show gossip option 2 if quest ''Making Sense of It'' is rewarded'),
(15,2184,3,0,0,2,0,11482,1,1,1,0,0,'','Show gossip option 3 if player does not have item ''Crystal Pylon User''s Manual'''),
(15,2184,3,0,0,8,0,4321,0,0,0,0,0,'','Show gossip option 3 if quest ''Making Sense of It'' is rewarded');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 9117 AND `source_type` = 0 AND `id` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(9117,0,1,0,62,0,100,0,2184,3,0,0,0,11,15211,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'J.D. Collie - On Gossip Option 3 Selected - Cast ''Create Pylon User''s Manual''');

-- Karna Remtravel: Add Gossip Option
DELETE FROM `gossip_menu` WHERE `MenuID` = 2082;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`)
VALUES
(2082,2735);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 2081;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
(15,2081,0,0,0,9,0,4244,0,0,0,0,0,'','Show gossip option if quest ''Chasing A-Me 01 (Part 2)'' is taken');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
