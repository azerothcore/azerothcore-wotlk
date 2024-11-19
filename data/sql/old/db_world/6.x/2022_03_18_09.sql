-- DB update 2022_03_18_08 -> 2022_03_18_09
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_18_08';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_18_08 2022_03_18_09 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1647134885721287500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647134885721287500');

UPDATE `conditions` SET `ConditionTypeOrReference` = 8 WHERE `SourceEntry` = 1645 AND `ConditionValue1` = 2997;
UPDATE `conditions` SET `ConditionTypeOrReference` = 8 WHERE `SourceEntry` = 1645 AND `ConditionValue1` = 2999;
UPDATE `conditions` SET `ConditionTypeOrReference` = 8 WHERE `SourceEntry` = 1645 AND `ConditionValue1` = 3000;
UPDATE `conditions` SET `ElseGroup` = 1 WHERE `SourceEntry` = 1645 AND `ConditionValue1` = 2997;
UPDATE `conditions` SET `ElseGroup` = 2 WHERE `SourceEntry` = 1645 AND `ConditionValue1` = 2999;
UPDATE `conditions` SET `ElseGroup` = 3 WHERE `SourceEntry` = 1645 AND `ConditionValue1` = 3000;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_18_09' WHERE sql_rev = '1647134885721287500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
