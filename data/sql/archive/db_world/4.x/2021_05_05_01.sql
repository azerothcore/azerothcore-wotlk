-- DB update 2021_05_05_00 -> 2021_05_05_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_05_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_05_00 2021_05_05_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1620070589328456500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620070589328456500');

-- Spawn -> combat
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=4969;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4969 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(4969, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 38, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Old Town Thug - On spawn - Set in combat with zone');

-- Stop combat
DELETE FROM `smart_scripts` WHERE `entryorguid`=4961 AND `source_type`=0 AND `id`=4;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(4961, 0, 4, 0, 2, 0, 100, 0, 0, 15, 0, 0, 0, 2, 84, 0, 0, 0, 0, 0, 11, 4969, 50, 1, 0, 0, 0, 0, 0, 'Dashel Stonefist - Between 0-15% Health - Set minions friendly');

-- Better text handling but dialogues from Old Town Thug are still not fixed here
UPDATE `creature_text` SET `CreatureID`=4969, `ID`=1 WHERE  `CreatureID`=38867 AND `GroupID`=0 AND `ID`=0;
UPDATE `creature_text` SET `GroupID`=1, `ID`=0 WHERE  `CreatureID`=4969 AND `GroupID`=0 AND `ID`=1;

-- Despawn both Old Town Thug if they're alive
DELETE FROM `smart_scripts` WHERE `entryorguid`=4961 AND `source_type`=0 AND `id`=5;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(4961, 0, 5, 0, 2, 0, 100, 0, 0, 15, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 11, 4969, 50, 1, 0, 0, 0, 0, 0, 'Dashel Stonefist - Between 0-15% Health - Despawn minions in 10s');


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
