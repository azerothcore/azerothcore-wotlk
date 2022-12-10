-- DB update 2021_12_18_03 -> 2021_12_19_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_18_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_18_03 2021_12_19_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1639776045356880700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639776045356880700');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=181045 AND `SourceGroup` IN (1, 5);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(22, 1, 181045, 1, 0, 29, 1, 16044, 30, 0, 0, 0, 0, '', 'Brazier of Beckoning only run SAI if Mor Grayhoof Trigger is near'),
(22, 5, 181045, 1, 0, 29, 1, 16048, 30, 0, 0, 0, 0, '', 'Brazier of Beckoning only run SAI if Lord Vathalak Trigger is near');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`=181051 AND `SourceGroup` IN (1, 5);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(22, 1, 181051, 1, 0, 29, 1, 16044, 30, 0, 0, 0, 0, '', 'Brazier of Invocation only run SAI if Mor Grayhoof Trigger is near'),
(22, 5, 181051, 1, 0, 29, 1, 16048, 30, 0, 0, 0, 0, '', 'Brazier of Invocation only run SAI if Lord Vathalak Trigger is near');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_19_00' WHERE sql_rev = '1639776045356880700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
