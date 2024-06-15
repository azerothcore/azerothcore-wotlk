-- DB update 2020_08_27_01 -> 2020_08_28_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_08_27_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_08_27_01 2020_08_28_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1596557661388670700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1596557661388670700');
/*
 * Zone: Eversong Woods
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15967;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 15967);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15967, 0, 0, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 7994, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ether Fiend - Between 20-40% Health - Cast \'7994\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15949;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 15949);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15949, 0, 0, 0, 0, 0, 100, 0, 2500, 3000, 9500, 10000, 11, 6818, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Thaelis the Hungerer - In Combat - Cast \'6818\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15655;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 15655);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15655, 0, 0, 0, 2, 0, 100, 1, 5, 15, 0, 0, 11, 13496, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rotlimb Cannibal - Between 5-15% Health - Cast \'13496\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15635;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 15635);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15635, 0, 0, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 12160, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Eversong Tender - Between 10-30% Health - Cast \'12160\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15649;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 15649);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15649, 0, 0, 0, 2, 0, 100, 1, 5, 15, 0, 0, 11, 29117, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Feral Dragonhawk Hatchling - Between 5-15% Health - Cast \'29117\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15651;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 15651);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15651, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 22863, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Springpaw Stalker - On Aggro - Cast \'22863\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15668;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 15668);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15668, 0, 0, 0, 2, 0, 100, 1, 5, 15, 0, 0, 11, 26661, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grimscale Murloc - Between 5-15% Health - Cast \'26661\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15652;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 15652);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15652, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 22863, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Elder Springpaw - On Aggro - Cast \'22863\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 16353;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 16353);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16353, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 8281, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mistbat - Between 20-80% Health - Cast \'8281\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 16347;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 16347);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16347, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 32918, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Starving Ghostclaw - On Aggro - Cast \'32918\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
