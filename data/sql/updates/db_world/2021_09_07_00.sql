-- DB update 2021_09_06_02 -> 2021_09_07_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_06_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_06_02 2021_09_07_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626260907562417400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626260907562417400');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 7983) AND (`SourceEntry` = 9039) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 9) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 9663) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 7434) AND (`SourceEntry` = 9039) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 9) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 9663) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 7434, 9039, 0, 0, 9, 0, 9663, 0, 0, 0, 0, 0, '', 'Show gossip text 9039 if player has quest 9663');

UPDATE `gossip_menu` SET `MenuID` = 7434 WHERE `MenuID` = 7983 AND `TextID` = 9039;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_07_00' WHERE sql_rev = '1626260907562417400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
