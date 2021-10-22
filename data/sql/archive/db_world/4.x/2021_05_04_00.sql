-- DB update 2021_05_03_03 -> 2021_05_04_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_03_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_03_03 2021_05_04_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1618177302172059302'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1618177302172059302');

DELETE FROM `gameobject` WHERE `id`=2046 AND `guid`=8871;
DELETE FROM `pool_gameobject` WHERE `guid` IN (8871);


DELETE FROM `gameobject` WHERE (`id` = 1623) AND (`guid` IN (4214));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(4214, 1623, 0, 0, 0, 1, 1, -581.555237, -2028.706299, 69.566879, 4.984, 0, 0, 0, 0, 60, 100, 1, '', 0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
