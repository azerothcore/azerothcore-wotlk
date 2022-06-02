-- DB update 2019_12_24_00 -> 2019_12_25_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_12_24_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_12_24_00 2019_12_25_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1576450864355101200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1576450864355101200');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 17083 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(17083,0,0,0,0,0,100,0,1500,3000,10000,15000,0,11,30478,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Fel Orc Convert - In Combat - Cast Hemorrhage'),
(17083,0,1,2,4,0,100,0,0,0,0,0,0,64,1,0,0,0,0,0,11,16807,50,0,0,0,0,0,0,'Fel Orc Convert - On Aggro - Store Target'),
(17083,0,2,0,61,0,100,0,0,0,0,0,0,45,1,1,0,0,0,0,12,1,0,0,0,0,0,0,0,'Fel Orc Convert - Linked - Set Data'),
(17083,0,3,0,6,0,100,0,0,0,0,0,0,45,1,2,0,0,0,0,12,1,0,0,0,0,0,0,0,'Fel Orc Convert - On Death - Set Data');

DELETE FROM `spell_script_names` WHERE `spell_id` = 30505;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`)
VALUES
(30505, 'spell_tsh_shadow_bolt');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
