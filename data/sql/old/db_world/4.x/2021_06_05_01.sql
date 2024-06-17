-- DB update 2021_06_05_00 -> 2021_06_05_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_05_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_05_00 2021_06_05_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1622465489637988400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622465489637988400');

DELETE FROM `gossip_menu` WHERE `MenuID` = 7183 AND `TextID` = 8462;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (7183, 8462);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 7183) AND (`SourceEntry` IN (8462,8619)) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 16) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 512) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 7183, 8619, 0, 0, 16, 0, 512, 0, 0, 0, 0, 0, '', 'Advisor Sorrelon - Show Blood Elf gossip text'),
(14, 7183, 8462, 0, 0, 16, 0, 512, 0, 0, 1, 0, 0, '', 'Advisor Sorrelon - Show generic Horde gossip text');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_05_01' WHERE sql_rev = '1622465489637988400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
