-- DB update 2019_03_25_01 -> 2019_03_26_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_03_25_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_03_25_01 2019_03_26_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1553553710022065730'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1553553710022065730');

DELETE FROM `gameobject` WHERE `guid` IN (29727, 29728, 29729, 29730, 29731, 29732, 29733, 29734, 29735, 29736, 29737, 29738, 29739, 29740, 29741);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES 
(29727, 20919, 47, 0, 0, 1, 1, 2082.74, 1671.82, 61.2396, 3.66079, 0, 0, 0.966493, -0.256693, 300, 0, 1, '', 0),
(29728, 20919, 47, 0, 0, 1, 1, 2159.43, 1687.49, 57.5433, 3.66079, 0, 0, 0.966493, -0.256693, 300, 0, 1, '', 0),
(29729, 20919, 47, 0, 0, 1, 1, 2080.89, 1703.36, 56.6447, 0.553757, 0, 0, 0.273354, 0.961913, 300, 0, 1, '', 0),
(29730, 20919, 47, 0, 0, 1, 1, 2055.28, 1767.7, 58.4559, 2.98378, 0, 0, 0.996889, 0.0788245, 300, 0, 1, '', 0),
(29731, 20919, 47, 0, 0, 1, 1, 2196.64, 1827.96, 61.4706, 2.11277, 0, 0, 0.870583, 0.492022, 300, 0, 1, '', 0),
(29732, 20919, 47, 0, 0, 1, 1, 2030.32, 1867.61, 56.2866, 5.6777, 0, 0, 0.298139, -0.954522, 300, 0, 1, '', 0),
(29733, 20919, 47, 0, 0, 1, 1, 2091.33, 1861.73, 51.0341, 1.25355, 0, 0, 0.586536, 0.809923, 300, 0, 1, '', 0),
(29734, 20919, 47, 0, 0, 1, 1, 2200.15, 1897.64, 71.3191, 2.6492, 0, 0, 0.969846, 0.243717, 300, 0, 1, '', 0),
(29735, 20919, 47, 0, 0, 1, 1, 2075.75, 1742.04, 76.7184, 1.33994, 0, 0, 0.620962, 0.78384, 300, 0, 1, '', 0),
(29736, 20919, 47, 0, 0, 1, 1, 2126, 1661.15, 82.4824, 0.0220437, 0, 0, 0.0110216, 0.999939, 300, 0, 1, '', 0),
(29737, 20919, 47, 0, 0, 1, 1, 2207.92, 1596.91, 80.7375, 3.60582, 0, 0, 0.973182, -0.230035, 300, 0, 1, '', 0),
(29738, 20919, 47, 0, 0, 1, 1, 2156.98, 1542.26, 72.849, 2.43086, 0, 0, 0.937519, 0.347934, 300, 0, 1, '', 0),
(29739, 20919, 47, 0, 0, 1, 1, 2179.95, 1514.06, 69.0709, 0.778385, 0, 0, 0.379441, 0.925216, 300, 0, 1, '', 0),
(29740, 20919, 47, 0, 0, 1, 1, 2000.85, 1533.93, 80.3971, 4.919, 0, 0, 0.630419, -0.776255, 300, 0, 1, '', 0),
(29741, 20919, 47, 0, 0, 1, 1, 1991.49, 1608.53, 81.1601, 1.1004, 0, 0, 0.522858, 0.85242, 300, 0, 1, '', 0);

UPDATE smart_scripts SET action_param1 = 1, comment = "Snufflenose Gopher - Script - Set Deffensive" WHERE entryorguid = 478100 AND id = 4;

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceEntry` = 6918;
INSERT INTO `conditions` VALUES (17, 0, 6918, 0, 0, 29, 0, 4781, 5, 0, 1, 0, 0, '', 'Blueleaf Tubers: Only spawn one Snufflenose Gopher');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
