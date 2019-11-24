-- DB update 2019_11_20_00 -> 2019_11_24_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_11_20_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_11_20_00 2019_11_24_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1572032036915466688'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1572032036915466688');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 24 AND `SourceEntry` IN (48539,48544,48545);
INSERT INTO `conditions`(`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(24, 0, 48539, 0, 0, 1, 1, 70405, 0, 0, 1, 0, 0, '', 'Revitalize (Rank 1) - cannot proc if target has Mutated abomination aura ICC - 10 or 25'),
(24, 0, 48544, 0, 0, 1, 1, 70405, 0, 0, 1, 0, 0, '', 'Revitalize (Rank 2) - cannot proc if target has Mutated abomination aura ICC - 10 or 25'),
(24, 0, 48545, 0, 0, 1, 1, 70405, 0, 0, 1, 0, 0, '', 'Revitalize (Rank 3) - cannot proc if target has Mutated abomination aura ICC - 10 or 25');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
