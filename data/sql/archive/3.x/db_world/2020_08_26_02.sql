-- DB update 2020_08_26_01 -> 2020_08_26_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_08_26_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_08_26_01 2020_08_26_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1596557480665706400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1596557480665706400');
/*
 * Zone: Silithus
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11721;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11721);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11721, 0, 0, 0, 0, 0, 100, 0, 2700, 3200, 32700, 33200, 11, 744, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Ashi Worker - In Combat - Cast \'744\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11724;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11724);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11724, 0, 0, 0, 0, 0, 100, 0, 2600, 3300, 9600, 12400, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Ashi Swarmer - In Combat - Cast \'3391\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11698;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11698);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11698, 0, 0, 0, 0, 0, 100, 0, 2400, 3900, 12400, 13900, 11, 13496, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Ashi Stinger - In Combat - Cast \'13496\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 12199;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 12199);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12199, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 24313, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shade of Ambermoon - On Aggro - Cast \'24313\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11731;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11731);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11731, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 29506, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Regal Burrower - Between 30-60% Health - Cast \'29506\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11726;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11726);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11726, 0, 0, 0, 0, 0, 100, 0, 2700, 3600, 11700, 14300, 11, 14120, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Zora Tunneler - In Combat - Cast \'14120\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11725;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11725);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11725, 0, 0, 0, 0, 0, 100, 0, 2700, 3800, 9600, 12800, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Zora Waywatcher - In Combat - Cast \'3391\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
