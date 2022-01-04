-- DB update 2022_01_03_16 -> 2022_01_03_17
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_03_16';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_03_16 2022_01_03_17 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1640651539577989000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640651539577989000');

-- Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 19) AND (`SourceGroup` = 0) AND (`SourceEntry` IN (7483, 7484, 7485)) AND (`SourceId` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 7483, 0, 1, 8, 0, 7482, 0, 0, 0, 0, 0, '', 'Libram of Rapidity - Available only if Elven Legends (Alliance) is completed'),
(19, 0, 7484, 0, 1, 8, 0, 7482, 0, 0, 0, 0, 0, '', 'Libram of Focus - Available only if Elven Legends (Alliance) is completed'),
(19, 0, 7485, 0, 1, 8, 0, 7482, 0, 0, 0, 0, 0, '', 'Libram of Protection - Available only if Elven Legends (Alliance) is completed'),
(19, 0, 7483, 0, 2, 8, 0, 7481, 0, 0, 0, 0, 0, '', 'Libram of Rapidity - Available only if Elven Legends (Horde) is completed'),
(19, 0, 7484, 0, 2, 8, 0, 7481, 0, 0, 0, 0, 0, '', 'Libram of Focus - Available only if Elven Legends (Horde) is completed'),
(19, 0, 7485, 0, 2, 8, 0, 7481, 0, 0, 0, 0, 0, '', 'Libram of Protection - Available only if Elven Legends (Horde) is completed');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_03_17' WHERE sql_rev = '1640651539577989000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
