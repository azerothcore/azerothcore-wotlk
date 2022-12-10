-- DB update 2021_11_07_02 -> 2021_11_07_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_07_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_07_02 2021_11_07_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1636144391799645100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636144391799645100');

UPDATE `creature_template` SET `AiName`='' WHERE `entry`=23090;
UPDATE `creature_template_addon` SET `auras`='18950 32199' WHERE `entry`=23090;
DELETE FROM `smart_scripts` WHERE `entryorguid`=23090;

UPDATE `creature_template_addon` SET `auras`='20540' WHERE `entry`=12856;
DELETE FROM `smart_scripts` WHERE `entryorguid`=12856 AND `id`=3;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_07_03' WHERE sql_rev = '1636144391799645100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
