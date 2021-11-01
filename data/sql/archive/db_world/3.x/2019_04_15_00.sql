-- DB update 2019_04_14_00 -> 2019_04_15_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_04_14_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_04_14_00 2019_04_15_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1555024514010587300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1555024514010587300');

SET @ENTRY := 21291;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`= @ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 54, 20000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grom''tor, Son of Oronok - When player opened dialog - Give Pause path for 20000 ms'),
(@ENTRY, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 53, 0, 21291, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grom''tor, Son of Oronok - On respawn - Start path, walk, repeat, Passive'),
(@ENTRY, 0, 2, 0, 1, 0, 100, 0, 10000, 30000, 240000, 240000, 80, 2129100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grom''tor, Son of Oronok - When out of combat and timer at the beginning - Start timed action list id #2129100');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
