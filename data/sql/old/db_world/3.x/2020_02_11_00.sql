-- DB update 2020_02_10_00 -> 2020_02_11_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_02_10_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_02_10_00 2020_02_11_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1579458178491145006'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1579458178491145006');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 11897 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(11897,0,0,0,0,0,100,0,2000,4000,8000,11000,0,11,18663,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Duskwing - In Combat - Cast ''Shadow Shock'''),
(11897,0,1,0,0,0,100,0,6000,9000,14000,17000,0,11,8281,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Duskwing - In Combat - Cast ''Sonic Burst''');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
