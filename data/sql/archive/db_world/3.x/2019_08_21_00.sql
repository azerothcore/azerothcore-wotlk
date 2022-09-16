-- DB update 2019_08_15_00 -> 2019_08_21_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_08_15_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_08_15_00 2019_08_21_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1564814353928512372'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1564814353928512372');

UPDATE `creature_addon` SET `bytes1` = 0 WHERE `guid` IN (127770,127771,127773,127774);

DELETE FROM `smart_scripts` WHERE `entryorguid` = 16168 AND `source_type` = 0 AND `id` IN (4,5,6);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(16168,0,4,0,1,0,100,0,1000,1000,0,0,0,90,9,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stoneskin Gargoyle - On Update OOC - Set Unit Field Bytes 1 ''UNIT_STAND_STATE_SUBMERGED'' (Controlled via conditions - only when not roaming)'),
(16168,0,5,0,1,0,100,0,1000,1000,0,0,0,91,9,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stoneskin Gargoyle - On Update OOC - Remove Unit Field Bytes 1 ''UNIT_STAND_STATE_SUBMERGED'' (Controlled via conditions - only when roaming)'),
(16168,0,6,0,4,0,100,0,0,0,0,0,0,91,9,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stoneskin Gargoyle - On Aggro - Remove Unit Field Bytes 1 ''UNIT_STAND_STATE_SUBMERGED''');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 16168;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(22,5,16168,0,0,21,1,16,0,0,1,0,0,'','Stoneskin Gargoyle Not Roaming - Enable Script to set ''UNIT_STAND_STATE_SUBMERGED'''),
(22,6,16168,0,0,21,1,16,0,0,0,0,0,'','Stoneskin Gargoyle Roaming - Enable Script to remove ''UNIT_STAND_STATE_SUBMERGED''');

DELETE FROM `waypoint_data` WHERE `id` = 1277750;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
(1277750,1,2872.72,-3489.73,297.62,0,0,0,0,100,0),
(1277750,2,2855.09,-3489.83,297.883,0,0,0,0,100,0),
(1277750,3,2836.62,-3489.82,297.864,0,0,0,0,100,0),
(1277750,4,2824.2,-3490.14,291.881,0,0,0,0,100,0),
(1277750,5,2809.43,-3490.46,285.972,0,0,0,0,100,0),
(1277750,6,2793.53,-3489.82,280.41,0,0,0,0,100,0),
(1277750,7,2777.57,-3489.79,274.032,0,0,0,0,100,0),
(1277750,8,2761.81,-3489.97,268.243,0,0,0,0,100,0),
(1277750,9,2749.38,-3489.91,262.153,0,0,0,0,100,0),
(1277750,10,2728.6,-3490.62,262.131,0,0,0,0,100,0),
(1277750,11,2749.38,-3489.91,262.153,0,0,0,0,100,0),
(1277750,12,2761.81,-3489.97,268.243,0,0,0,0,100,0),
(1277750,13,2777.57,-3489.79,274.032,0,0,0,0,100,0),
(1277750,14,2793.53,-3489.82,280.41,0,0,0,0,100,0),
(1277750,15,2809.43,-3490.46,285.972,0,0,0,0,100,0),
(1277750,16,2824.2,-3490.14,291.881,0,0,0,0,100,0),
(1277750,17,2836.62,-3489.82,297.864,0,0,0,0,100,0),
(1277750,18,2854.79,-3489.83,297.886,0,0,0,0,100,0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
