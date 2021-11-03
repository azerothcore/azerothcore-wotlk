-- DB update 2019_07_02_01 -> 2019_07_05_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_07_02_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_07_02_01 2019_07_05_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1562240494889723700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1562240494889723700');

DELETE FROM `creature` WHERE `guid` IN(204949,204950,204951,204952,204953,204954,204955,204956,204957,204958);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES 
(204949, 17066, 0, 0, 0, 1, 1, 0, 0, 2288.63, 422.085, 40.196, -0.5061, 300, 0, 0, 42, 0, 0, 0, 0, 0, '', 0),
(204950, 17066, 530, 0, 0, 1, 1, 0, 0, 7670.44, -6836.25, 86.0302, -0.506, 300, 0, 0, 42, 0, 0, 0, 0, 0, '', 0),
(204951, 17066, 530, 0, 0, 1, 1, 0, 0, 9379.9, -6791.63, 21.243, -0.5061, 300, 0, 0, 42, 0, 0, 0, 0, 0, '', 0),
(204952, 17066, 1, 0, 0, 1, 1, 0, 0, 146.607, -4735.15, 20.925, -0.5061, 300, 0, 0, 42, 0, 0, 0, 0, 0, '', 0),
(204953, 17066, 530, 0, 0, 1, 1, 0, 0, 2046.23, 6579.71, 141.576, 5.77704, 300, 0, 0, 42, 0, 0, 0, 0, 0, '', 0),
(204954, 17066, 530, 0, 0, 1, 1, 0, 0, -4204.67, -12321.1, 8.04382, 5.77704, 300, 0, 0, 42, 0, 0, 0, 0, 0, '', 0),
(204955, 17066, 1, 0, 0, 1, 1, 0, 0, -4399.5, 2171.79, 18.1664, 5.77704, 300, 0, 0, 42, 0, 0, 0, 0, 0, '', 0),
(204956, 17066, 0, 0, 0, 1, 1, 0, 0, 1002.28, -1432.47, 70.4004, 5.77704, 300, 0, 0, 42, 0, 0, 0, 0, 0, '', 0),
(204957, 17066, 0, 0, 0, 1, 1, 0, 0, -8261.67, -2638.05, 139.06, 5.77704, 300, 0, 0, 42, 0, 0, 0, 0, 0, '', 0),
(204958, 17066, 530, 0, 0, 1, 1, 0, 0, 2285.15, 6157.91, 141.664, 5.77704, 300, 0, 0, 42, 0, 0, 0, 0, 0, '', 0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
