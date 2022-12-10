-- DB update 2021_11_09_07 -> 2021_11_10_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_09_07';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_09_07 2021_11_10_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1636491400432791100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636491400432791100');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 1) AND (`SourceGroup` IN (2764, 2765, 4063)) AND (`SourceEntry` = 21525);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(1, 2764, 21525, 0, 0, 12, 0, 2, 0, 0, 0, 0, 0, '', 'Green Winter Hat only drops when event 2 is active'),
(1, 2765, 21525, 0, 0, 12, 0, 2, 0, 0, 0, 0, 0, '', 'Green Winter Hat only drops when event 2 is active'),
(1, 4063, 21525, 0, 0, 12, 0, 2, 0, 0, 0, 0, 0, '', 'Green Winter Hat only drops when event 2 is active');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_10_00' WHERE sql_rev = '1636491400432791100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
