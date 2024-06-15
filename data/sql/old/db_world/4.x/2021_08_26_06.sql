-- DB update 2021_08_26_05 -> 2021_08_26_06
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_26_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_26_05 2021_08_26_06 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629721384880200437'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629721384880200437');

-- Add new spawn and add roaming around
UPDATE `creature_template` SET `MovementType` = 1 WHERE (`entry` = 2783);
DELETE FROM `creature` WHERE (`id` = 2783) AND `guid` IN(14652, 146520);

INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(14652, 2783, 0, 0, 0, 1, 1, 4031, 0, -1644.56, -1933.05, 68.1722, 0.174533, 400, 5, 0, 1676, 0, 1, 0, 0, 0, '', 0),
(146520, 2783, 0, 0, 0, 1, 1, 4031, 0, -1677.72, -1928.70, 80.62, 0.174533, 400, 5, 0, 1676, 0, 1, 0, 0, 0, '', 0);

-- Add the new spawns to the same spawn pool so she can only be spawned once at a time
DELETE FROM `pool_template` WHERE `entry` = 370;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`)  VALUES (370, 1, "Marez Cowl Spawns");

DELETE FROM `pool_creature` WHERE `guid` IN (14652, 146520);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES 
(14652, 370, 0, "Marez Cowl Spawn 1"),
(146520, 370, 0, "Marez Cowl Spawn 2");

-- Change the spell for one more suited for her and added script so che can roam and channle it in a loop
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2783) AND (`source_type` = 0) AND (`id` IN (0, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2783, 0, 0, 0, 1, 0, 100, 0, 15000, 15000, 20000, 25000, 0, 11, 43897, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marez Cowl - Out of Combat - Cast \'Shadow Channeling\''),
(2783, 0, 2, 0, 1, 0, 100, 0, 5000, 10000, 10000, 15000, 0, 92, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marez Cowl - Out of Combat - Interrupt Spell');


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_26_06' WHERE sql_rev = '1629721384880200437';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
