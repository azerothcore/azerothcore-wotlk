-- DB update 2021_05_31_03 -> 2021_06_01_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_31_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_31_03 2021_06_01_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1616252380101739000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1616252380101739000');
/*
 * Zone: Zangamarsh
 * Update by Knindza | <www.azerothcore.org>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20293;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20293);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20293, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 3248, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bogstrok Clacker - On Aggro - Cast \'3248\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20710;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20710);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20710, 0, 0, 0, 2, 0, 100, 1, 5, 10, 0, 0, 11, 1604, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bogstrok Hatchling - Between 5-10% Health - Cast \'1604\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20442;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20442);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20442, 0, 0, 0, 2, 0, 100, 1, 10, 30, 0, 0, 11, 35491, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Captain Bo\'kar - Between 10-30% Health - Cast \'35491\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18340;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18340);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18340, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 33962, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Steam Pump Overseer - On Aggro - Cast \'33962\' (No Repeat)'),
(18340, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 5164, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Steam Pump Overseer - Between 20-80% Health - Cast \'5164\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18214;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18214);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18214, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fenclaw Thrasher - Between 20-80% Health - Cast \'3391\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18212;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18212);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18212, 0, 0, 0, 2, 0, 100, 1, 5, 10, 0, 0, 11, 3019, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mudfin Frenzy - Between 5-10% Health - Cast \'3019\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18046;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18046);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18046, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 35472, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rajah Haghazed - On Aggro - Cast \'35472\' (No Repeat)'),
(18046, 0, 1, 0, 0, 0, 100, 0, 2500, 5000, 10000, 15000, 11, 35473, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rajah Haghazed - In Combat - Cast \'35473\''),
(18046, 0, 2, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 16856, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rajah Haghazed - Between 20-80% Health - Cast \'16856\' (No Repeat)'),
(18046, 0, 3, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 15062, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rajah Haghazed - Between 5-30% Health - Cast \'15062\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20090;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20090);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20090, 0, 0, 0, 2, 0, 100, 1, 5, 15, 0, 0, 11, 11831, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodscale Sentry - Between 5-15% Health - Cast \'11831\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20079;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20079);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20079, 0, 0, 0, 2, 0, 100, 1, 5, 20, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkcrest Sentry - Between 5-20% Health - Flee For Assist (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18122;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18122);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18122, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 41363, 0, 0, 0, 0, 0, 19, 18122, 5, 0, 0, 0, 0, 0, 'Dreghood Drudge - On Aggro - Cast \'41363\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20291;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20291);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20291, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 6870, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lagoon Walker - Between 20-80% Health - Cast \'6870\' (No Repeat)'),
(20291, 0, 1, 0, 2, 0, 100, 1, 10, 40, 0, 0, 11, 7948, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lagoon Walker - Between 10-40% Health - Cast \'7948\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20290;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20290);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20290, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 35319, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lagoon Eel - On Aggro - Cast \'35319\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18201;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18201);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18201, 0, 0, 0, 2, 0, 100, 1, 5, 15, 0, 0, 11, 35336, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tamed Sporebat - Between 5-15% Health - Cast \'35336\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19734;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 19734);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19734, 0, 0, 0, 0, 0, 100, 1, 2000, 5000, 0, 0, 12, 20479, 3, 10000, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fungal Giant - In Combat - Summon Creature \'Unstable Shroom\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20479;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20479);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20479, 0, 0, 1, 0, 0, 100, 1, 2000, 4000, 0, 0, 11, 35252, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Unstable Shroom - In Combat - Cast \'35252\' (No Repeat)'),
(20479, 0, 1, 0, 61, 0, 100, 1, 0, 0, 0, 0, 11, 35362, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Unstable Shroom - In Combat - Cast \'35362\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18423;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18423);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18423, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 32323, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cho\'war the Pillager - On Aggro - Cast \'32323\' (No Repeat)'),
(18423, 0, 1, 0, 0, 0, 100, 1, 1500, 2000, 0, 0, 11, 31403, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cho\'war the Pillager - In Combat - Cast \'31403\' (No Repeat)'),
(18423, 0, 2, 0, 0, 0, 100, 0, 2500, 5000, 10000, 15000, 11, 17963, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cho\'war the Pillager - In Combat - Cast \'17963\''),
(18423, 0, 3, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 15708, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cho\'war the Pillager - Between 20-80% Health - Cast \'15708\' (No Repeat)');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_01_00' WHERE sql_rev = '1616252380101739000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
