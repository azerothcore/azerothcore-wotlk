-- DB update 2017_08_22_01 -> 2017_08_25_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_08_22_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_08_22_01 2017_08_25_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1503630648814585000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1503630648814585000');

-- fix arrows and spawn script, must be started after talk
UPDATE `smart_scripts` SET  `id` = '6' WHERE `entryorguid` = '1746100' AND `source_type` = '9' AND `id` = '4' AND `link` = '0';
UPDATE `smart_scripts` SET  `id` = '4' WHERE `entryorguid` = '1746100' AND `source_type` = '9' AND `id` = '3' AND `link` = '0'; 
UPDATE `smart_scripts` SET  `id` = '5',`source_type` = '9',`entryorguid` = '1746100' WHERE `entryorguid` = '17461' AND `source_type` = '0' AND `id` = '2' AND `link` = '0'; 
UPDATE `smart_scripts` SET  `id` = '3',`source_type` = '9',`entryorguid` = '1746100' WHERE `entryorguid` = '17461' AND `source_type` = '0' AND `id` = '1' AND `link` = '0'; 


-- fix infinite spawn bug
UPDATE `smart_scripts` SET `event_param3` = '0' , `event_param4` = '0' WHERE `entryorguid` = '1746100' AND `source_type` = '9' AND `id` = '5' AND `link` = '0';

-- fix timings
UPDATE `smart_scripts` SET `event_param1` = '4000' , `event_param2` = '4000' WHERE `entryorguid` = '1746100' AND `source_type` = '9' AND `id` = '2' AND `link` = '0'; 
UPDATE `smart_scripts` SET `event_param1` = '0' , `event_param2` = '0' WHERE `entryorguid` = '1746100' AND `source_type` = '9' AND `id` = '3' AND `link` = '0';

-- added voice to blood guard 
UPDATE `creature_text` SET `sound` = '10156' WHERE `entry` = '17461' AND `groupid` = '0' AND `id` = '0'; 
UPDATE `creature_text` SET `sound` = '10157' WHERE `entry` = '17461' AND `groupid` = '1' AND `id` = '0'; 
UPDATE `creature_text` SET `sound` = '10158' WHERE `entry` = '17461' AND `groupid` = '2' AND `id` = '0'; 
UPDATE `creature_text` SET `sound` = '10159' WHERE `entry` = '17461' AND `groupid` = '3' AND `id` = '0'; 
--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
