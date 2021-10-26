-- DB update 2021_07_05_00 -> 2021_07_05_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_05_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_05_00 2021_07_05_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1624689676324157623'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624689676324157623');

-- Removes Civilian flag from Nazzivus Summoners
UPDATE `creature_template` SET `flags_extra` = `flags_extra`&~(2) WHERE `entry` = 17524;

-- Set MovementType to 1 for spawn 86538 to match all other Nazzivus Summoners
DELETE FROM `creature` WHERE `id` = 17524 AND `guid` = 86538;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(86538, 17524, 530, 0, 0, 1, 1, 0, 1, -2481.5, -11259.1, 31.07, 5.3, 534, 5, 0, 273, 0, 1, 0, 0, 0, '', 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_05_01' WHERE sql_rev = '1624689676324157623';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
