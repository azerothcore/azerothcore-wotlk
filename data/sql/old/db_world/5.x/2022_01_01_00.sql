-- DB update 2021_12_31_08 -> 2022_01_01_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_31_08';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_31_08 2022_01_01_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1640860713284766500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640860713284766500');

-- Spawn conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 29 AND `SourceEntry` = 12101;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(29, 0, 12101, 0, 0, 13, 0, 2, 3, 3, 1, 0, 0, '', 'Lava Surger only spawn if boss state 3 (Garr) is not DONE.');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_01_00' WHERE sql_rev = '1640860713284766500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
