-- DB update 2020_08_28_02 -> 2020_08_29_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_08_28_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_08_28_02 2020_08_29_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1596557058623118600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1596557058623118600');
/*
 * Zone: Azeroth (Update for missed / skipped creatures)
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10896;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10896);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10896, 0, 0, 0, 0, 0, 100, 0, 2500, 3000, 18000, 18500, 11, 11977, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Arnak Grimtotem - In Combat - Cast \'11977\''),
(10896, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 10966, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Arnak Grimtotem - Between 30-60% Health - Cast \'10966\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10758;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10758);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10758, 0, 0, 0, 0, 0, 100, 0, 2000, 4000, 12000, 16000, 11, 34802, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grimtotem Bandit - In Combat - Cast \'34802\''),
(10758, 0, 1, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 6713, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grimtotem Bandit - Between 20-40% Health - Cast \'6713\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10760;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10760);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10760, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 11436, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grimtotem Geomancer - On Aggro - Cast \'11436\''),
(10760, 0, 1, 0, 0, 0, 100, 0, 2100, 3200, 8600, 9100, 11, 8400, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grimtotem Geomancer - In Combat - Cast \'8400\''),
(10760, 0, 2, 0, 2, 0, 100, 1, 20, 60, 0, 0, 11, 2121, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grimtotem Geomancer - Between 20-60% Health - Cast \'2121\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10759;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10759);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10759, 0, 0, 0, 0, 0, 100, 0, 2100, 3900, 9600, 12300, 11, 8046, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grimtotem Stomper - In Combat - Cast \'8046\''),
(10759, 0, 1, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 5605, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grimtotem Stomper - Between 20-40% Health - Cast \'5605\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10756;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10756);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10756, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 17276, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scalding Elemental - Between 20-80% Health - Cast \'17276\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10757;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10757);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10757, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 11983, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Boiling Elemental - Between 30-60% Health - Cast \'11983\' (No Repeat)');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
