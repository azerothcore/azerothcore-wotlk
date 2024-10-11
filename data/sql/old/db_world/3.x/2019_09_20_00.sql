-- DB update 2019_09_17_00 -> 2019_09_20_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_09_17_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_09_17_00 2019_09_20_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1567680571242071924'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1567680571242071924');

-- Sarathstra SAI
DELETE FROM `smart_scripts` WHERE `entryorguid` = 26858 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(26858,0,0,1,38,0,100,0,1,1,0,0,0,101,0,0,0,0,0,0,8,0,0,0,0,4374.88,943.2,88.7,2.26207,'Sarathstra - On Data Set - Set Home Position'),
(26858,0,1,0,61,0,100,0,0,0,0,0,0,69,0,0,0,0,0,0,8,0,0,0,0,4374.88,943.2,88.7,0,'Sarathstra - Linked - Move To Pos'),
(26858,0,2,0,34,0,100,0,8,0,0,0,0,49,0,0,0,0,0,0,21,100,0,0,0,0,0,0,0,'Sarathstra - Movement Inform - Attack Start'),
(26858,0,3,4,4,0,100,0,0,0,0,0,0,60,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sarathstra - On Aggro - Set Fly Off'),
(26858,0,4,0,61,0,100,0,0,0,0,0,0,207,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sarathstra - Linked - Set Hover Off'),
(26858,0,5,6,25,0,100,0,0,0,0,0,0,60,1,150,1,0,0,0,1,0,0,0,0,0,0,0,0,'Sarathstra - On Reset - Set Fly On'),
(26858,0,6,0,61,0,100,0,0,0,0,0,0,207,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sarathstra - Linked - Set Hover On');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
