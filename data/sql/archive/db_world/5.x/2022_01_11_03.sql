-- DB update 2022_01_11_02 -> 2022_01_11_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_11_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_11_02 2022_01_11_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1641824664894549700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641824664894549700');

SET @FIRESWORN = 12099;
SET @CORE_HOUND = 11671;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 29 AND `SourceEntry` = @FIRESWORN;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(29, 0, @CORE_HOUND, 0, 0, 13, 0, 2, 1, 3, 1, 0, 0, '', 'Core Hound only spawn if boss state 1 (Magmadar) is not DONE.'),
(29, 0, @FIRESWORN, 0, 0, 13, 0, 2, 3, 3, 1, 0, 0, '', 'Firesworn only spawn if boss state 3 (Garr) is not DONE.');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_11_03' WHERE sql_rev = '1641824664894549700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
