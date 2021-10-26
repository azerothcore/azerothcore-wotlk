-- DB update 2021_04_25_12 -> 2021_04_25_13
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_04_25_12';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_04_25_12 2021_04_25_13 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1618958664622288300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1618958664622288300');

DELETE FROM `creature` WHERE `id`=27198 AND `guid`=113636; 
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(113636, 27198, 571, 0, 0, 1, 1, 0, 0, 3240.79, -724.326, 174.892, 4.15388, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0);
DELETE FROM `creature_template_addon` WHERE `entry` IN (27198);
INSERT INTO `creature_template_addon` (`entry`, `mount`, `path_id`, `bytes1`, `bytes2`, `auras`) VALUES
(27198,0,0,1,0,"");

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
