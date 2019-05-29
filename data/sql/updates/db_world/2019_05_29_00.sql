-- DB update 2019_05_27_00 -> 2019_05_29_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_05_27_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_05_27_00 2019_05_29_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1558651761752003200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1558651761752003200');

-- Olga's gossip menu needs to be corrected in smart_scripts to register user selection
UPDATE `smart_scripts` SET `event_param1` = 9014 WHERE `entryorguid` = 24639 AND `source_type` = 0 AND `id` = 0;

-- Jack had the wrong gossip_menu_id in his creature_template entry (previous 9025)
UPDATE `creature_template` SET `gossip_menu_id` = 9013 WHERE `entry` = 24788;

-- Update condition to reflect the changed gossip menu id
UPDATE `conditions` SET `SourceGroup` = 9013 WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 9025 AND `ConditionTypeOrReference` = 9 AND `ConditionValue1` = 11466;

-- Jack needs the corresponding correction to smart_scripts so the debt item can be placed in character's inventory
UPDATE `smart_scripts` SET `event_param1` = 9013 WHERE `entryorguid` = 24788 AND `source_type` = 0 AND `id` = 3;

-- Olga was not walking all the way back to her starting position, so an extra waypoint was needed
DELETE FROM `waypoints` WHERE `entry` = 246390 AND `pointid` = 3;
INSERT INTO `waypoints`(`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES
(246390, 3, -91.8194, -3532.71, 7.7126, 'Olga, the Scalawag Wench');

-- Once Olga got back to her starting position, she refused to turn back around, so an extra smart_script entry is needed to re-orient her
-- event_type=SMART_EVENT_WAYPOINT_REACHED, action_type=SMART_ACTION_SET_ORIENTATION
DELETE FROM `smart_scripts` WHERE `entryorguid` = 24639 AND `source_type` = 0 AND `id` = 3 AND `link` = 0;
INSERT INTO `smart_scripts`(`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24639, 0, 3, 0, 40, 0, 100, 0, 3, 246390, 0, 0, 0, 66, 5, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 'Olga, the Scalawag Wench - Set to initial orientation');

-- Stop Jack dancing
DELETE FROM `smart_scripts` WHERE `entryorguid` = 2463901 AND `source_type` = 9 AND `id` = 5;
INSERT INTO `smart_scripts`(`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2463901, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 17, 26, 0, 0, 0, 0, 0, 19, 24788, 0, 0, 0, 0, 0, 0, 0, 'Olga, the Scalawag Wench - On Script - Set Emote State 26');

-- Ensure that Jack is dancing when spawned the first time and on respawn
DELETE FROM `smart_scripts` WHERE `entryorguid` = 24788 AND `source_type` = 0 AND `id` = 0;
INSERT INTO `smart_scripts`(`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24788, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 17, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, ' Jack Adams - On Reset - Set Emote State 10');

-- Ensure that Olga returns to her starting position even if the player doesn't get the debt from Jack
DELETE FROM `smart_scripts` WHERE `entryorguid` = 24788 AND `source_type` = 0 AND `id` = 6; -- ID 6 is not needed anymore
UPDATE `smart_scripts` SET `link` = 0 WHERE `entryorguid` = 24788 AND `id` = 5;             -- Remove the link to ID 6
DELETE FROM `smart_scripts` WHERE `entryorguid` = 2478800 AND `source_type` = 9 AND `id` = 9;
INSERT INTO `smart_scripts`(`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2478800, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 3, 3, 0, 0, 0, 0, 19, 24639, 0, 0, 0, 0, 0, 0, 0, 'Jack Adams - On Script - Set Data 3 3');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
