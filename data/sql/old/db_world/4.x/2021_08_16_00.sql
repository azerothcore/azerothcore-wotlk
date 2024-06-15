-- DB update 2021_08_13_01 -> 2021_08_16_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_13_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_13_01 2021_08_16_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1628543691784458000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628543691784458000');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 42325) AND (`SourceId` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 4351) AND (`ConditionValue3` = 0);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 42325) AND (`SourceId` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 4352) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 42325, 0, 1, 31, 1, 3, 4351, 0, 0, 0, 0, '', 'Casting a spell only on a Bloodfen Raptor '),
(17, 0, 42325, 0, 2, 31, 1, 3, 4352, 0, 0, 0, 0, '', 'Casting a spell only on a Bloodfen Screecher');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_16_00' WHERE sql_rev = '1628543691784458000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
