-- DB update 2021_10_24_06 -> 2021_10_25_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_24_06';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_24_06 2021_10_25_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1635063079296632300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635063079296632300');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=19 AND `SourceEntry` IN (12139,11219);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19,0,12139,0,0,8,0,11361,0,0,0,0,0,'','"Let the Fires Come" available if "Fire Training" rewarded'),
(19,0,12139,0,1,8,0,11449,0,0,0,0,0,'','"Let the Fires Come" available if "Fire Training" rewarded'),
(19,0,12139,0,2,8,0,11450,0,0,0,0,0,'','"Let the Fires Come" available if "Fire Training" rewarded'),
(19,0,11219,0,0,8,0,11361,0,0,0,0,0,'','"Stop the Fires" available if "Fire Training" rewarded'),
(19,0,11219,0,1,8,0,11449,0,0,0,0,0,'','"Stop the Fires" available if "Fire Training" rewarded'),
(19,0,11219,0,2,8,0,11450,0,0,0,0,0,'','"Stop the Fires" available if "Fire Training" rewarded');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_25_00' WHERE sql_rev = '1635063079296632300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
