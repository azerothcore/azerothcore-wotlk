-- DB update 2019_03_19_00 -> 2019_03_19_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_03_19_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_03_19_00 2019_03_19_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1552864578895131621'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1552864578895131621');

DELETE FROM `creature_template_addon` WHERE `entry` = 24747;
DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 24747 AND `MovementType` = 0);
INSERT INTO `creature_addon` (`guid`,`bytes1`) SELECT `guid`, 1 as `bytes1` FROM `creature` WHERE `id` = 24747 AND `MovementType` = 0;

UPDATE `creature` SET `spawndist` = 5, `MovementType` = 1 WHERE `id` = 24746;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
