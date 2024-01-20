-- DB update 2021_12_31_03 -> 2021_12_31_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_31_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_31_03 2021_12_31_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1640037227067484700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640037227067484700');

-- Turning quest 'Onu is Meditating' to auto-complete.
UPDATE `quest_template` SET `Flags` = `Flags`| 65536 WHERE (`ID` = 961);

-- Adding conditions to quest: 'Onu is Meditating'
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 19) AND (`SourceGroup` = 0) AND (`SourceEntry` = 961) AND (`ConditionTypeOrReference` = 47) AND (`ConditionValue1` = 944) AND (`ConditionValue2` = 10);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 961, 0, 0, 47, 0, 944, 10, 0, 0, 0, 0, '', 'When quest \'The Master\'s Glaive\' state In-progress show \'Onu is Meditating\'');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_31_04' WHERE sql_rev = '1640037227067484700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
