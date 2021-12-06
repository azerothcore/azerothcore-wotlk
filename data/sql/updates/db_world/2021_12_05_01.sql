-- DB update 2021_12_05_00 -> 2021_12_05_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_05_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_05_00 2021_12_05_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638455217402525600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638455217402525600');

UPDATE `creature_questender` SET `id` = 13445 WHERE `quest` IN (7021,7024);

DELETE FROM `creature` WHERE `guid`=24 AND `id` = 13431;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(24, 13431, 1, 0, 0, 1, 1, 0, 0, -1234.51, 73.4529, 129.591, 2.80998, 300, 0, 0, 1003, 0, 0, 0, 0, 0, '', 0);

DELETE FROM `game_event_creature` WHERE `eventEntry` IN (2,24) AND `guid` = 24;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(2, 24);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_05_01' WHERE sql_rev = '1638455217402525600';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
