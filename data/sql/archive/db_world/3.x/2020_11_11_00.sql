-- DB update 2020_11_10_02 -> 2020_11_11_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_10_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_10_02 2020_11_11_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1603643078632991300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1603643078632991300');
/*
 * Zone: Blasted Lands
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7670;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7670);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7670, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 7164, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Servant of Allistarj - On Aggro - Cast \'7164\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7669;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7669);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7669, 0, 0, 0, 0, 0, 100, 0, 3600, 4200, 9800, 12700, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Servant of Grol - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6011;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 6011);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6011, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 22120, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Felguard Sentry - On Aggro - Cast \'22120\' (No Repeat)'),
(6011, 0, 1, 0, 0, 0, 100, 0, 2700, 4100, 9800, 12900, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Felguard Sentry - In Combat - Cast \'15496\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7668;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7668);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7668, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 7165, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Servant of Razelikh - On Aggro - Cast \'7165\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5977;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5977);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5977, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 11960, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dreadmaul Mauler - On Aggro - Cast \'11960\' (No Repeat)'),
(5977, 0, 1, 0, 0, 0, 100, 0, 2700, 4300, 9800, 12400, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dreadmaul Mauler - In Combat - Cast \'3391\''),
(5977, 0, 2, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dreadmaul Mauler - Between 5-30% Health - Cast \'8599\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7671;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7671);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7671, 0, 0, 0, 0, 0, 100, 0, 3600, 4200, 9800, 12700, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Servant of Sevine - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5984;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5984);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5984, 0, 0, 0, 0, 0, 100, 0, 2700, 4300, 32700, 34300, 11, 7367, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Starving Snickerfang - In Combat - Cast \'7367\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5974;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5974);
UPDATE `creature_template` SET `unit_class`= 2 WHERE `entry`= 5974;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5974, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 11960, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dreadmaul Ogre - On Aggro - Cast \'11960\' (No Repeat)'),
(5974, 0, 1, 0, 0, 0, 100, 0, 2700, 3200, 8700, 11200, 11, 20793, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dreadmaul Ogre - In Combat - Cast \'20793\''),
(5974, 0, 2, 0, 2, 0, 100, 1, 10, 40, 0, 0, 11, 6742, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dreadmaul Ogre - Between 10-40% Health - Cast \'6742\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 751;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 751);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(751, 0, 0, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Marsh Flesheater - Between 5-30% Health - Cast \'8599\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5976;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 5976);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5976, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 11960, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dreadmaul Brute - On Aggro - Cast \'11960\' (No Repeat)'),
(5976, 0, 1, 0, 0, 0, 100, 0, 2700, 4300, 9800, 12400, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dreadmaul Brute - In Combat - Cast \'3391\''),
(5976, 0, 2, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dreadmaul Brute - Between 5-30% Health - Cast \'8599\' (No Repeat)');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
