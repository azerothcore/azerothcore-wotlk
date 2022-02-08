-- DB update 2021_10_14_08 -> 2021_10_14_09
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_14_08';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_14_08 2021_10_14_09 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633980818495484300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633980818495484300');

DELETE FROM `gossip_menu` WHERE `MenuID` = 5631 AND `TextID` = 6742;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(5631, 6742);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 5630;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 5630, 0, 0, 0, 8, 0, 4148, 0, 0, 0, 0, 0, '', 'Show gossip option if quest \'Bloodpetal Zapper\' is rewarded'),
(15, 5630, 0, 0, 0, 2, 0, 11320, 1, 1, 1, 0, 0, '', 'Show gossip option if player does not have item \'Bloodpetal Zapper\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9118;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 9118) AND (`source_type` = 0) AND (`id` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9118, 0, 0, 0, 62, 0, 100, 0, 5630, 0, 0, 0, 0, 11, 22565, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Larion - On Gossip Option 0 Selected - Cast \'Create Bloodpetal Zapper\'');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_14_09' WHERE sql_rev = '1633980818495484300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
