-- DB update 2022_01_20_00 -> 2022_01_21_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_20_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_20_00 2022_01_21_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1640710429099175800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640710429099175800');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 19) AND (`SourceGroup` = 0) AND (`SourceEntry` = 3375);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 3375, 0, 0, 2, 0, 7667, 1, 0, 1, 0, 0, '', 'Display quest \'Replacement Vial\' if player lost item (Not in inventory)'),
(19, 0, 3375, 0, 0, 2, 0, 7667, 1, 1, 1, 0, 0, '', 'Display quest \'Replacement Vial\' if player lost item (Not in bank)'),
(19, 0, 3375, 0, 0, 47, 0, 2200, 74, 0, 0, 0, 0, '', 'Quest \'Back to Uldaman\' is Complete/Rewarded.');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_21_00' WHERE sql_rev = '1640710429099175800';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
