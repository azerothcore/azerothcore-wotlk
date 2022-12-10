-- DB update 2021_10_08_03 -> 2021_10_08_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_08_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_08_03 2021_10_08_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1632847156889213161'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632847156889213161');

-- Adds 8 Giant Webwood Spider spawns
DELETE FROM `creature` WHERE `id` = 2001 AND `guid` IN (209189, 209190, 209191, 209192, 209193, 209194, 209195, 209196);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(209189, 2001, 1, 0, 0, 1, 1, 6808, 0, 10920, 1434, 1303.6, 2.8, 300, 5, 0, 198, 0, 1, 0, 0, 0, '', 0),
(209190, 2001, 1, 0, 0, 1, 1, 6808, 0, 10885, 1393, 1317, 1.5, 300, 5, 0, 198, 0, 1, 0, 0, 0, '', 0),
(209191, 2001, 1, 0, 0, 1, 1, 6808, 0, 10937, 1401, 1313.7, 0.1, 300, 5, 0, 198, 0, 1, 0, 0, 0, '', 0),
(209192, 2001, 1, 0, 0, 1, 1, 6808, 0, 10847, 1462, 1307.2, 5.6, 300, 5, 0, 198, 0, 1, 0, 0, 0, '', 0),
(209193, 2001, 1, 0, 0, 1, 1, 6808, 0, 10797, 1734, 1314.6, 5.9, 300, 5, 0, 198, 0, 1, 0, 0, 0, '', 0),
(209194, 2001, 1, 0, 0, 1, 1, 6808, 0, 10970, 1824, 1330.3, 3.8, 300, 5, 0, 198, 0, 1, 0, 0, 0, '', 0),
(209195, 2001, 1, 0, 0, 1, 1, 6808, 0, 10834, 1824, 1341.3, 1.3, 300, 5, 0, 198, 0, 1, 0, 0, 0, '', 0),
(209196, 2001, 1, 0, 0, 1, 1, 6808, 0, 10972, 1386, 1321.6, 2.6, 300, 5, 0, 198, 0, 1, 0, 0, 0, '', 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_08_04' WHERE sql_rev = '1632847156889213161';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
