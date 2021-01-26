-- DB update 2021_01_09_01 -> 2021_01_09_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_01_09_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_01_09_01 2021_01_09_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1606850752274331900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606850752274331900');

DELETE FROM `gossip_menu_option` WHERE  `MenuID`=10120 AND `OptionID`=1;
UPDATE `conditions` SET `ElseGroup`=1, `ConditionTypeOrReference`=47, `ConditionValue2`=10 WHERE `SourceGroup`=10120 AND `ConditionValue1`=13373;
UPDATE `conditions` SET `SourceEntry`=0, `ElseGroup`=2, `ConditionTypeOrReference`=47, `ConditionValue2`=10 WHERE `SourceGroup`=10120 AND `ConditionValue1`=13374;
UPDATE `conditions` SET `SourceEntry`=0, `ElseGroup`=3, `ConditionTypeOrReference`=47, `ConditionValue2`=10 WHERE `SourceGroup`=10120 AND `ConditionValue1`=13376;
UPDATE `conditions` SET `ElseGroup`=4, `ConditionTypeOrReference`=47, `ConditionValue2`=10 WHERE `SourceGroup`=10120 AND `ConditionValue1`=13406;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
