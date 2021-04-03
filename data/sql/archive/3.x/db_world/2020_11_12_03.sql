-- DB update 2020_11_12_02 -> 2020_11_12_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_12_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_12_02 2020_11_12_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1603644044194630800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1603644044194630800');
/*
 * Zone: Wetlands
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5683;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5683);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5683, 0, 0, 0, 0, 0, 100, 0, 2700, 3400, 8900, 9600, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Comar Villard - In Combat - Cast \'3391\''),
(5683, 0, 1, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 12540, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Comar Villard - Between 5-30% Health - Cast \'12540\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1400;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1400);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1400, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 50433, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wetlands Crocolisk - On Aggro - Cast \'50433\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1020;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1020);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1020, 0, 0, 0, 0, 0, 100, 0, 2300, 3000, 8400, 9100, 11, 51772, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mottled Raptor - In Combat - Cast \'51772\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1039;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1039);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1039, 0, 0, 0, 0, 0, 100, 0, 3800, 6900, 13800, 15700, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fen Dweller - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1417;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1417);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1417, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 50433, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Young Wetlands Crocolisk - On Aggro - Cast \'50433\' (No Repeat)');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
