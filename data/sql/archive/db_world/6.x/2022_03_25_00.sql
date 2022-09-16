-- DB update 2022_03_23_03 -> 2022_03_25_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_23_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_23_03 2022_03_25_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1643290179356130100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643290179356130100');

-- npc kneel
DELETE FROM `creature_addon` WHERE (`guid` IN (102453, 102454, 102455, 102457, 102458, 102459, 102462, 102463, 102464, 102466));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(102453, 0, 0, 8, 257, 0, 0, NULL),
(102454, 0, 0, 8, 257, 0, 0, NULL),
(102455, 0, 0, 8, 257, 0, 0, NULL),
(102457, 0, 0, 8, 257, 0, 0, NULL),
(102458, 0, 0, 8, 257, 0, 0, NULL),
(102459, 0, 0, 8, 257, 0, 0, NULL),
(102462, 0, 0, 8, 257, 0, 0, NULL),
(102463, 0, 0, 8, 257, 0, 0, NULL),
(102464, 0, 0, 8, 257, 0, 0, NULL),
(102466, 0, 0, 8, 257, 0, 0, NULL);

-- npc Wounded Skirmisher
DELETE FROM `creature` WHERE (`guid` IN (102453, 102454, 102455, 102456, 102457, 102458, 102459, 102460, 102461, 102462, 102463, 102464, 102466, 102467, 102469));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(102453, 27463, 0, 0, 571, 0, 0, 1, 1, 1, 4229.39, -2981.89, 283.151, 1.61792, 300, 0, 0, 9940, 0, 0, 0, 0, 0, '', 0),
(102454, 27463, 0, 0, 571, 0, 0, 1, 1, 1, 4134.07, -2897.23, 279.272, 5.12241, 300, 0, 0, 9940, 0, 0, 0, 0, 0, '', 0),
(102455, 27463, 0, 0, 571, 0, 0, 1, 1, 1, 4123.8, -2835.11, 284.196, 0.610865, 300, 0, 0, 9940, 0, 0, 0, 0, 0, '', 0),
(102456, 27463, 0, 0, 571, 0, 0, 1, 1, 1, 4000.98, -2847.93, 273.325, 6.03884, 300, 0, 0, 9940, 0, 0, 0, 0, 0, '', 0),
(102457, 27463, 0, 0, 571, 0, 0, 1, 1, 1, 4185.56, -2961.08, 283.319, 0.903392, 300, 0, 0, 9940, 0, 0, 0, 0, 0, '', 0),
(102458, 27463, 0, 0, 571, 0, 0, 1, 1, 1, 4017.75, -2835.31, 279.277, 1.47867, 300, 0, 0, 9940, 0, 0, 0, 0, 0, '', 0),
(102459, 27463, 0, 0, 571, 0, 0, 1, 1, 1, 4073.33, -2906.89, 278.332, 6.10865, 300, 0, 0, 9940, 0, 0, 0, 0, 0, '', 0),
(102460, 27463, 0, 0, 571, 0, 0, 1, 1, 1, 4085.95, -2846.31, 286.589, 2.94961, 300, 0, 0, 9940, 0, 0, 0, 0, 0, '', 0),
(102461, 27463, 0, 0, 571, 0, 0, 1, 1, 1, 4071.18, -2886.01, 281.6, 5.8294, 300, 0, 0, 9940, 0, 0, 0, 0, 0, '', 0),
(102462, 27463, 0, 0, 571, 0, 0, 1, 1, 1, 4074.98, -2940.5, 276.138, 4.22481, 300, 0, 0, 9940, 0, 0, 0, 0, 0, '', 0),
(102463, 27463, 0, 0, 571, 0, 0, 1, 1, 1, 4139.99, -3020.99, 285.459, 5.82814, 300, 0, 0, 9940, 0, 0, 0, 0, 0, '', 0),
(102464, 27463, 0, 0, 571, 0, 0, 1, 1, 1, 4166.57, -2964.73, 283.2, 2.63745, 300, 0, 0, 9940, 0, 0, 0, 0, 0, '', 0),
(102466, 27463, 0, 0, 571, 0, 0, 1, 1, 1, 4204.05, -3048.94, 280.839, 4.65053, 300, 0, 0, 9940, 0, 0, 0, 0, 0, '', 0),
(102467, 27463, 0, 0, 571, 0, 0, 1, 1, 1, 4057.32, -2822.2, 288.962, 3.4383, 300, 0, 0, 9940, 0, 0, 0, 0, 0, '', 0),
(102469, 27463, 0, 0, 571, 0, 0, 1, 1, 1, 4183.3, -2934.44, 283.114, 5.63741, 300, 0, 0, 9940, 0, 0, 0, 0, 0, '', 0);

-- npc Skirmisher Corpse
DELETE FROM `creature` WHERE `guid`=91749;
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(91749, 27457, 0, 0, 571, 0, 0, 1, 1, 1, 4137.9, -3008.35, 285.667, 5.54491, 300, 0, 0, 4399, 0, 0, 0, 0, 0, '', 0);

DELETE FROM `waypoint_data` WHERE `id`=274630;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(274630, 1, 4153.06, -2928.47, 282.58, 0, 0, 1, 0, 100, 0),
(274630, 2, 4184.53, -2909.76, 280.17, 0, 0, 1, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `id`=274631;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(274631, 1, 4138.41, -2950.63, 282.92, 0, 0, 1, 0, 100, 0),
(274631, 2, 4153.06, -2928.47, 282.58, 0, 0, 1, 0, 100, 0),
(274631, 3, 4184.53, -2909.76, 280.17, 0, 0, 1, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `id`=274632;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(274632, 1, 4184.53, -2909.76, 280.17, 0, 0, 1, 0, 100, 0);

/* implementing both conditions */

DELETE FROM `spell_script_names` WHERE `spell_id`=48812 AND `ScriptName`='spell_renew_skirmisher';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(48812, 'spell_renew_skirmisher');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceGroup`=0 AND `SourceEntry`=48812;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(17,0,48812,0,0,31,1,3,27463,0,0,0,0,"","Heals a wounded skirmisher at Blue Sky Logging Ground.");

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_25_00' WHERE sql_rev = '1643290179356130100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
