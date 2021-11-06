-- DB update 2021_05_07_02 -> 2021_05_07_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_07_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_07_02 2021_05_07_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1619259290727738768'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619259290727738768');

SET @INCENDIA_AGAVE_ENTRY := 175928;

DELETE FROM `gameobject` WHERE (`id` = @INCENDIA_AGAVE_ENTRY) AND (`guid` IN (6024, 6025, 6026, 6027));

INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(6024, @INCENDIA_AGAVE_ENTRY, 1, 0, 0, 1, 1, -5028.19, -2001.47, -53.28, 5.32135, 0, 0, -0.462591, 0.886572, 180, 100, 1, '', 0),
(6025, @INCENDIA_AGAVE_ENTRY, 1, 0, 0, 1, 1, -4989.31, -1968.82, -53.3953, 0.884641, 0, 0, -0.428038, -0.903761, 180, 100, 1, '', 0),
(6026, @INCENDIA_AGAVE_ENTRY, 1, 0, 0, 1, 1, -5030.59, -2045.05, -51.5, 1.67477, 0, 0, -0.742894, -0.669409, 180, 100, 1, '', 0),
(6027, @INCENDIA_AGAVE_ENTRY, 1, 0, 0, 1, 1, -4951.07, -2020.25, -53.2042, 1.41147, 0, 0, -0.648594, -0.761135, 180, 100, 1, '', 0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
