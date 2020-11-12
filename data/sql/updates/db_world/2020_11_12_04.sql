-- DB update 2020_11_12_03 -> 2020_11_12_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_12_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_12_03 2020_11_12_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1603643976297010600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1603643976297010600');
/*
 * Zone: Dun Morogh
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1131;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1131);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1131, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 3149, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Winter Wolf - Between 20-80% Health - Cast \'3149\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1199;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1199);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1199, 0, 0, 0, 2, 0, 100, 0, 1, 5, 0, 0, 11, 13496, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Juvenile Snow Leopard - Between 1-5% Health - Cast \'13496\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6124;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6124);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6124, 0, 0, 0, 0, 0, 100, 0, 3700, 5200, 10100, 12300, 11, 58461, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Captain Beld - In Combat - Cast \'58461\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1128;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1128);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1128, 0, 0, 0, 2, 0, 100, 0, 1, 5, 0, 0, 11, 13496, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Young Black Bear - Between 1-5% Health - Cast \'13496\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1201;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1201);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1201, 0, 0, 0, 2, 0, 100, 0, 1, 5, 0, 0, 11, 13496, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Snow Leopard - Between 1-5% Health - Cast \'13496\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
