-- DB update 2021_10_06_01 -> 2021_10_07_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_06_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_06_01 2021_10_07_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1622026442432794800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622026442432794800');

-- Remove incorrect gossip text 
UPDATE `gossip_menu_option` SET `ActionMenuID`= 0 WHERE `MenuID`= 5502 AND `OptionID`= 0;

-- Add conditions to be met for gossip option to be available
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 5502) AND (`SourceEntry` = 0) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` IN (2,8)) AND (`ConditionTarget` = 0) AND (`ConditionValue1` IN (1046,5462)) AND (`ConditionValue2` IN (0,1)) AND (`ConditionValue3` IN (0,1));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 5502, 0, 0, 0, 2, 0, 5462, 1, 1, 1, 0, 0, '', 'Only show gossip option if player doesn\'t have item Dartol\'s Rod of Transformation'),
(15, 5502, 0, 0, 0, 8, 0, 1046, 0, 0, 0, 0, 0, '', 'Only show gossip option if player has completed quest 1046');

-- Add SAI for Raene Wolfrunner for the actual item creation
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 3691) AND (`source_type` = 0) AND (`id` IN (6, 7));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3691, 0, 6, 7, 62, 0, 100, 0, 5502, 0, 0, 0, 0, 11, 22227, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Raene Wolfrunner - On Gossip Option Select - Cast \'Create Dartol\'s Rod\''),
(3691, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Raene Wolfrunner - On Gossip Option Select - Close Gossip');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_07_00' WHERE sql_rev = '1622026442432794800';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
