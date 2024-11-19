-- DB update 2022_03_23_02 -> 2022_03_23_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_23_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_23_02 2022_03_23_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1647530609689243500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647530609689243500');

DELETE FROM `creature` WHERE `guid` = 84205 AND `id1` = 14459;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`,`equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(84205,14459,469,0,0,1,1,0,-7644.53,-1081.53,408.574,5.2709,10,0,0,42,0,0,0,0,0,'',0);

DELETE FROM `creature_text` WHERE `CreatureID` = 14459;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration` ,`Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(14459, 0, 0, '%s flee as the controlling power of the orb is drained.', 16, 0, 100, 0, 0, 0, 9592, 3, '');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_23_03' WHERE sql_rev = '1647530609689243500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
