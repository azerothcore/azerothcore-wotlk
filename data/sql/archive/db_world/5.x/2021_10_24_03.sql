-- DB update 2021_10_24_02 -> 2021_10_24_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_24_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_24_02 2021_10_24_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1634747614685560600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634747614685560600');

-- *** Quest "The Hunt is on" ***
-- Gossip is in place options just need to be enabled and conditions added
UPDATE `gossip_menu_option` SET `OptionType`=1,`OptionNpcFlag`=1 WHERE `MenuID` IN (9217,9218,9219) AND `OptionType`=0;
-- Condition for source Gossip menu option condition type Aura
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup` IN (9217,9218,9219) AND `SourceEntry`=0 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 9217, 0, 0, 0, 1, 0, 46078, 0, 0, 0, 0, 0, '', 'Show gossip menu 9217 option id 0 if target has aura Righteous Vision.'),
(15, 9218, 0, 0, 0, 1, 0, 46078, 0, 0, 0, 0, 0, '', 'Show gossip menu 9218 option id 0 if target has aura Righteous Vision.'),
(15, 9219, 0, 0, 0, 1, 0, 46078, 0, 0, 0, 0, 0, '', 'Show gossip menu 9219 option id 0 if target has aura Righteous Vision.');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_24_03' WHERE sql_rev = '1634747614685560600';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
