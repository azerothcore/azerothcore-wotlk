-- DB update 2020_11_12_05 -> 2020_11_13_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_12_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_12_05 2020_11_13_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1603644190044708500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1603644190044708500');
/*
 * Zone: Alterac Mountains
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2320;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2320);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2320, 0, 0, 0, 0, 0, 100, 0, 2500, 3000, 6500, 7000, 11, 18797, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nagaz - In Combat - Cast \'18797\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14223;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 14223);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14223, 0, 0, 0, 2, 0, 100, 1, 10, 40, 0, 0, 11, 26064, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cranky Benj - Between 10-40% Health - Cast \'26064\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2351;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2351);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2351, 0, 0, 0, 0, 0, 100, 0, 2200, 2600, 7400, 8100, 11, 31279, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gray Bear - In Combat - Cast \'31279\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2779;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2779);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2779, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 43107, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Prince Nazjak - On Aggro - Cast \'43107\' (No Repeat)'),
(2779, 0, 1, 0, 0, 0, 100, 0, 3800, 5400, 10900, 13100, 11, 17687, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Prince Nazjak - In Combat - Cast \'17687\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2578;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2578);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2578, 0, 0, 0, 0, 0, 100, 0, 2300, 3000, 8400, 9100, 11, 51772, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Young Mesa Buzzard - In Combat - Cast \'51772\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
