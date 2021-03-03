-- DB update 2020_10_25_00 -> 2020_10_26_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_10_25_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_10_25_00 2020_10_26_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1601314356612298800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601314356612298800');
/*
 * Zone: Eastern Plaguelands
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17878;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17878);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17878, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7978, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scourge Siege Engineer - On Aggro - Cast \'7978\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15162;
UPDATE `creature_template` SET `unit_class`= 2 WHERE `entry`= 15162;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 15162);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15162, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 20294, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Inquisitor - On Aggro - Cast \'20294\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8606;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 8606);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8606, 0, 0, 0, 2, 0, 100, 1, 40, 80, 0, 0, 11, 11442, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Living Decay - Between 40-80% Health - Cast \'11442\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11290;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11290);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11290, 0, 0, 0, 0, 0, 100, 0, 2300, 3400, 9800, 12600, 11, 3234, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mossflayer Zombie - In Combat - Cast \'3234\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8596;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 8596);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8596, 0, 0, 0, 0, 0, 100, 0, 2700, 3400, 11200, 13700, 11, 31279, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Plaguehound Runt - In Combat - Cast \'31279\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 12387;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 12387);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12387, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 13901, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Large Vile Slime - On Aggro - Cast \'13901\''),
(12387, 0, 1, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 16843, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Large Vile Slime - Between 30-60% Health - Cast \'16843\' (No Repeat)'),
(12387, 0, 2, 0, 2, 0, 100, 1, 10, 20, 0, 0, 11, 11975, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Large Vile Slime - Between 10-20% Health - Cast \'11975\' (No Repeat)');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
