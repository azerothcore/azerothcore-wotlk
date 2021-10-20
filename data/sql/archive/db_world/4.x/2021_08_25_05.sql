-- DB update 2021_08_25_04 -> 2021_08_25_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_25_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_25_04 2021_08_25_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629392049665962208'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629392049665962208');

-- Added 3 more spawn points to Duggan Wildhammer. Changed the spawn time from 20h to 12h
DELETE FROM `creature` WHERE (`id` = 10817) AND (`guid` IN (86605, 866050, 866051, 866052));

INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(86605, 10817, 0, 0, 0, 1, 1, 0, 1, 1980.55, -3706.26, 124.345, 5.30, 72000, 15, 0, 3398, 0, 1, 0, 0, 0, '', 0), -- Top of Darrowshire, original
(866050, 10817, 0, 0, 0, 1, 1, 0, 1, 2123.51, -2943.19, 100.95, 0, 72000, 15, 0, 3398, 0, 1, 0, 0, 0, '', 0), -- Top left darrowshire
(866051, 10817, 0, 0, 0, 1, 1, 0, 1, 1740.96, -2796.50, 64.34, 0, 72000, 15, 0, 3398, 0, 1, 0, 0, 0, '', 0), -- Near the left river
(866052, 10817, 0, 0, 0, 1, 1, 0, 1, 1691.04, -3569.03, 123.40, 0, 72000, 15, 0, 3398, 0, 1, 0, 0, 0, '', 0); -- Left of darrowshire

-- Add the new spawns to the same spawn pool so he can only be spawned once at a time
DELETE FROM `pool_template` WHERE `entry` = 369;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`)  VALUES (369, 1, "Duggan Wildhammer Spawns");

DELETE FROM `pool_creature` WHERE `guid` IN (86605, 866050, 866051, 866052);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES 
(86605, 369, 0, "Duggan Wildhammer Spawn 1"),
(866050, 369, 0, "Duggan Wildhammer Spawn 2"),
(866051, 369, 0, "Duggan Wildhammer Spawn 3"),
(866052, 369, 0, "Duggan Wildhammer Spawn 4");

-- Add movement to Duggan Wildhammer
UPDATE `creature_template` SET `speed_walk` = 1 WHERE (`entry` = 10817);

-- Added the lines in a timed loop
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 10817) AND (`source_type` = 0) AND (`id` IN (3, 4, 5, 6, 7, 8, 9, 10, 11, 12));

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10817, 0, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 9, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Duggan Wildhammer - In Combat - Say Line 9'),
(10817, 0, 4, 0, 1, 0, 100, 0, 3000, 3000, 180000, 180000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Duggan Wildhammer - Out of Combat - Say Line 0'),
(10817, 0, 5, 0, 1, 0, 100, 0, 15000, 15000, 180000, 180000, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Duggan Wildhammer - Out of Combat - Say Line 1'),
(10817, 0, 6, 0, 1, 0, 100, 0, 25000, 25000, 80000, 80000, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Duggan Wildhammer - Out of Combat - Say Line 2'),
(10817, 0, 7, 0, 1, 0, 100, 0, 40000, 40000, 180000, 180000, 0, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Duggan Wildhammer - Out of Combat - Say Line 3'),
(10817, 0, 8, 0, 1, 0, 100, 0, 50000, 50000, 180000, 180000, 0, 1, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Duggan Wildhammer - Out of Combat - Say Line 4'),
(10817, 0, 9, 0, 1, 0, 100, 0, 70000, 70000, 120000, 120000, 0, 1, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Duggan Wildhammer - Out of Combat - Say Line 5'),
(10817, 0, 10, 0, 1, 0, 100, 0, 90000, 90000, 180000, 180000, 0, 1, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Duggan Wildhammer - Out of Combat - Say Line 6'),
(10817, 0, 11, 0, 1, 0, 100, 0, 100000, 100000, 120000, 120000, 0, 1, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Duggan Wildhammer - Out of Combat - Say Line 7'),
(10817, 0, 12, 0, 1, 0, 100, 0, 120000, 120000, 120000, 120000, 0, 1, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Duggan Wildhammer - Out of Combat - Say Line 8');


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_25_05' WHERE sql_rev = '1629392049665962208';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
