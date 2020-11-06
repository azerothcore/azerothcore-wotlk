-- DB update 2020_11_06_02 -> 2020_11_06_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_06_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_06_02 2020_11_06_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1603643792422914800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1603643792422914800');
/*
 * Zone: Loch Modan
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1225;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1225);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1225, 0, 0, 0, 0, 0, 100, 0, 2200, 3600, 8400, 9700, 11, 31279, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ol\' Sooty - In Combat - Cast \'31279\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2477;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2477);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2477, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 7165, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gradok - On Aggro - Cast \'7165\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1186;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1186);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1186, 0, 0, 0, 0, 0, 100, 0, 2700, 5100, 9900, 12600, 11, 15793, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Elder Black Bear - In Combat - Cast \'15793\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1193;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1193);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1193, 0, 0, 0, 2, 0, 100, 1, 5, 10, 0, 0, 11, 3019, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Loch Frenzy - Between 5-10% Health - Cast \'3019\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1189;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1189);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1189, 0, 0, 0, 0, 0, 100, 0, 2700, 5100, 9900, 12600, 11, 15793, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Black Bear Patriarch - In Combat - Cast \'15793\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2478;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2478);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2478, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 7164, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Haren Swifthoof - On Aggro - Cast \'7164\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1693;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1693);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1693, 0, 0, 0, 0, 0, 100, 0, 2800, 4400, 9200, 9900, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Loch Crocolisk - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14266;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 14266);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14266, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 12023, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shanda the Spinner - On Aggro - Cast \'12023\' (No Repeat)'),
(14266, 0, 1, 0, 0, 0, 100, 0, 2700, 3400, 32700, 33400, 11, 13298, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shanda the Spinner - In Combat - Cast \'13298\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14268;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 14268);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14268, 0, 0, 0, 0, 0, 100, 0, 4700, 6300, 11700, 14200, 11, 4150, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lord Condar - In Combat - Cast \'4150\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1188;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1188);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1188, 0, 0, 0, 0, 0, 100, 0, 2700, 5100, 9900, 12600, 11, 15793, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grizzled Black Bear - In Combat - Cast \'15793\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1224;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1224);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1224, 0, 0, 0, 0, 0, 100, 0, 2800, 4400, 9200, 9900, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Young Threshadon - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7170;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7170);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7170, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 7165, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thragomm - On Aggro - Cast \'7165\' (No Repeat)');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
