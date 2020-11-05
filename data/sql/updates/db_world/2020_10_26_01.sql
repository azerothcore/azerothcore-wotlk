-- DB update 2020_10_26_00 -> 2020_10_26_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_10_26_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_10_26_00 2020_10_26_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1601314686326215700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601314686326215700');
/*
 * Zone: Western Plaguelands
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11873;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11873);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11873, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 11443, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Spectral Attendant - On Aggro - Cast \'11443\''),
(11873, 0, 1, 0, 0, 0, 100, 0, 2200, 3400, 9800, 12700, 11, 13860, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Spectral Attendant - In Combat - Cast \'13860\''),
(11873, 0, 2, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 11981, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Spectral Attendant - Between 30-60% Health - Cast \'11981\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10580;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10580);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10580, 0, 0, 0, 0, 0, 100, 0, 2400, 3700, 8600, 9800, 11, 8714, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fetid Zombie - In Combat - Cast \'8714\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4472;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4472);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4472, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 11443, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Haunting Vision - On Aggro - Cast \'11443\''),
(4472, 0, 1, 0, 0, 0, 100, 0, 2200, 3400, 9800, 12700, 11, 13860, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Haunting Vision - In Combat - Cast \'13860\''),
(4472, 0, 2, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 11981, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Haunting Vision - Between 30-60% Health - Cast \'11981\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1813;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1813);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1813, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 32065, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Decaying Horror - On Aggro - Cast \'32065\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1824;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1824);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1824, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 3436, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Plague Lurker - Between 20-80% Health - Cast \'3436\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11613;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11613);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11613, 0, 0, 0, 0, 0, 100, 0, 2700, 3900, 9700, 12400, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Huntsman Radley - In Combat - Cast \'11976\''),
(11613, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 14443, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Huntsman Radley - Between 20-80% Health - Cast \'14443\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11614;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11614);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11614, 0, 0, 0, 0, 0, 100, 0, 2100, 3200, 17100, 18200, 11, 13692, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodshot - In Combat - Cast \'13692\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1836;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1836);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1836, 0, 0, 0, 0, 0, 100, 0, 2500, 3000, 9500, 10000, 11, 16856, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Cavalier - In Combat - Cast \'16856\''),
(1836, 0, 1, 0, 2, 0, 100, 1, 40, 80, 0, 0, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Cavalier - Between 40-80% Health - Cast \'15284\' (No Repeat)'),
(1836, 0, 2, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 6253, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Cavalier - Between 10-30% Health - Cast \'6253\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10608;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10608);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10608, 0, 0, 0, 1, 0, 100, 0, 0, 0, 0, 0, 11, 13864, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Priest - Out of Combat - Cast \'13864\''),
(10608, 0, 1, 0, 0, 0, 100, 0, 2300, 5200, 8600, 9300, 11, 15498, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Priest - In Combat - Cast \'15498\''),
(10608, 0, 2, 0, 2, 0, 100, 1, 60, 90, 0, 0, 11, 8362, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Priest - Between 60-90% Health - Cast \'8362\' (No Repeat)'),
(10608, 0, 3, 0, 2, 0, 100, 1, 5, 25, 0, 0, 11, 12039, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Priest - Between 5-25% Health - Cast \'12039\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11611;
UPDATE `creature_addon` SET `auras`= 13008 WHERE `guid`=45432;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11611);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11611, 0, 0, 0, 0, 0, 100, 0, 2300, 3100, 8900, 9600, 11, 13953, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cavalier Durgen - In Combat - Cast \'13953\''),
(11611, 0, 1, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 13005, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cavalier Durgen - Between 10-30% Health - Cast \'13005\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1884;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1884);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1884, 0, 0, 0, 0, 0, 100, 0, 2500, 3000, 17500, 18000, 11, 11977, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Lumberjack - In Combat - Cast \'11977\''),
(1884, 0, 1, 0, 2, 0, 100, 1, 25, 40, 0, 0, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Lumberjack - Between 25-40% Health - Cast \'15496\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1785;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1785);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1785, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 17650, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Terror - On Aggro - Cast \'17650\''),
(1785, 0, 1, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 12542, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Terror - Between 5-30% Health - Cast \'12542\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10605;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10605);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10605, 0, 0, 0, 1, 0, 100, 0, 0, 0, 0, 0, 11, 17175, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Medic - Out of Combat - Cast \'17175\''),
(10605, 0, 1, 0, 2, 0, 100, 1, 5, 95, 0, 0, 11, 11640, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Medic - Between 5-95% Health - Cast \'11640\' (No Repeat)'),
(10605, 0, 2, 0, 2, 0, 100, 1, 5, 20, 0, 0, 11, 17137, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Medic - Between 5-20% Health - Cast \'17137\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10801;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10801);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10801, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 15716, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jabbering Ghoul - On Aggro - Cast \'15716\''),
(10801, 0, 1, 0, 0, 0, 100, 0, 2500, 3000, 22500, 23000, 11, 12097, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jabbering Ghoul - In Combat - Cast \'12097\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1822;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 1822);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1822, 0, 0, 0, 0, 0, 100, 1, 2700, 4500, 0, 0, 11, 3583, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Venom Mist Lurker - In Combat - Cast \'3583\' (No Repeat)');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
