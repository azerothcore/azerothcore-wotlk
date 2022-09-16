-- DB update 2021_08_24_01 -> 2021_08_24_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_24_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_24_01 2021_08_24_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629295484385297983'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629295484385297983');

DELETE FROM `gameobject` WHERE (`id` = 179828) AND (`guid` IN (6974, 6976, 6991, 6995, 7003, 7005, 7006, 7009));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(6974, 179828, 0, 0, 0, 1, 1, -6508.78, -1365.26, 212.859, 0.645772, 0, 0, 0.317305, 0.948324, 150, 100, 1, '', 0),
(6976, 179828, 0, 0, 0, 1, 1, -6570.39, -1332.69, 212.095, -0.907571, 0, 0, 0.438371, -0.898794, 150, 100, 1, '', 0),
(6991, 179828, 0, 0, 0, 1, 1, -6518.08, -1341.7, 210.242, 2.84489, 0, 0, 0.989016, 0.147809, 150, 100, 1, '', 0),
(6995, 179828, 0, 0, 0, 1, 1, -6576.94, -1319.12, 210.249, -0.244346, 0, 0, 0.121869, -0.992546, 150, 100, 1, '', 0),
(7003, 179828, 0, 0, 0, 1, 1, -6572.96, -1327.58, 212.095, -2.72271, 0, 0, 0.978148, -0.207912, 150, 100, 1, '', 0),
(7005, 179828, 0, 0, 0, 1, 1, -6562.07, -1344.44, 212.619, 1.25664, 0, 0, 0.587785, 0.809017, 150, 100, 1, '', 0),
(7006, 179828, 0, 0, 0, 1, 1, -6558.36, -1347.93, 210.26, -2.93215, 0, 0, 0.994522, -0.104529, 150, 100, 1, '', 0),
(7009, 179828, 0, 0, 0, 1, 1, -6551.49, -1318.46, 210.419, 0.698132, 0, 0, 0.34202, 0.939693, 150, 100, 1, '', 0);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_24_02' WHERE sql_rev = '1629295484385297983';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
