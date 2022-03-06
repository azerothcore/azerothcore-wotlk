-- DB update 2022_03_02_03 -> 2022_03_02_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_02_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_02_03 2022_03_02_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1645770819774593100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1645770819774593100');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 1 AND `SourceGroup` IN (7461, 7463, 8716, 8717, 12396) AND `SourceEntry` IN (21104, 21105);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(1, 8716, 21104, 0, 0, 9, 0, 8620, 0, 0, 0, 0, 0, '', 'Draconic for Dummies Chapter II will drop only when a player have The Only Prescription (8620) in their quest log'),
(1, 8717, 21104, 0, 0, 9, 0, 8620, 0, 0, 0, 0, 0, '', 'Draconic for Dummies Chapter II will drop only when a player have The Only Prescription (8620) in their quest log'),
(1, 12396, 21104, 0, 0, 9, 0, 8620, 0, 0, 0, 0, 0, '', 'Draconic for Dummies Chapter II will drop only when a player have The Only Prescription (8620) in their quest log'),
(1, 7463, 21105, 0, 0, 9, 0, 8620, 0, 0, 0, 0, 0, '', 'Draconic for Dummies Chapter III will drop only when a player have The Only Prescription (8620) in their quest log'),
(1, 7461, 21105, 0, 0, 9, 0, 8620, 0, 0, 0, 0, 0, '', 'Draconic for Dummies Chapter III will drop only when a player have The Only Prescription (8620) in their quest log');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_02_04' WHERE sql_rev = '1645770819774593100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
