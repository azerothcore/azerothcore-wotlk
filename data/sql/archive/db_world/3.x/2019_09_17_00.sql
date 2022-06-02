-- DB update 2019_09_16_00 -> 2019_09_17_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_09_16_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_09_16_00 2019_09_17_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1567608091409034200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1567608091409034200');

-- Prevent casting "Twisting Blade" on self ("Xink's Shredder") or on the player
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceEntry` = 47938;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
(17,0,47938,0,0,33,1,0,0,0,1,0,0,'','Spell ''Twisting Blade'' - Invalid Target - Self'),
(17,0,47938,0,0,31,1,4,0,0,1,0,0,'','Spell ''Twisting Blade'' - Invalid Target - Player');

-- Disable random movement for "Zivlix's Destruction Machine"
UPDATE `creature` SET `spawndist` = 0, `MovementType` = 0 WHERE `guid` = 100815;

-- Xink's Shredder SAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27061;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 27061 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(27061,0,0,0,54,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Xink''s Shredder - On Just Summoned - Say Line 0'),
(27061,0,1,2,28,0,100,0,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Xink''s Shredder - On Passenger Removed - Say Line 1'),
(27061,0,2,0,61,0,100,0,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Xink''s Shredder - Linked - Force Despawn');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
