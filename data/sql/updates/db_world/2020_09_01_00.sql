-- DB update 2020_08_31_00 -> 2020_09_01_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_08_31_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_08_31_00 2020_09_01_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1596728845705471100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1596728845705471100');
/*
 * Raid: Ulduar
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPTS */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 33772;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 33772);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(33772, 0, 0, 0, 0, 0, 100, 0, 500, 500, 30000, 30000, 11, 49576, 0, 0, 0, 0, 0, 17, 15, 90, 0, 0, 0, 0, 0, 'Faceless Horror - In Combat - Cast \'49576\''),
(33772, 0, 1, 0, 0, 0, 100, 0, 3000, 8000, 7000, 12000, 11, 63722, 0, 0, 0, 0, 0, 17, 12, 65, 0, 0, 0, 0, 0, 'Faceless Horror - In Combat - Cast \'63722\''),
(33772, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 63703, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Faceless Horror - On Aggro - Cast \'63703\''),
(33772, 0, 3, 0, 7, 0, 100, 0, 0, 0, 0, 0, 28, 63703, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Faceless Horror - On Evade - Remove Aura \'63703\''),
(33772, 0, 4, 5, 2, 0, 100, 1, 10, 30, 0, 0, 11, 63710, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Faceless Horror - Between 10-30% Health - Cast \'63710\' (No Repeat)'),
(33772, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 12, 33806, 1, 300000, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Faceless Horror - Between 10-30% Health - Summon Creature \'Void Beast\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 33806;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 33806);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(33806, 0, 0, 1, 6, 0, 100, 0, 0, 0, 0, 0, 28, 63710, 0, 0, 0, 0, 0, 19, 33772, 100, 0, 0, 0, 0, 0, 'Void Beast - On Just Died - Remove Aura \'63710\''),
(33806, 0, 1, 0, 7, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Void Beast - On Evade - Despawn In 10000 ms'),
(33806, 0, 2, 0, 0, 0, 100, 0, 10000, 15000, 20000, 40000, 11, 63723, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Void Beast - In Combat - Cast \'63723\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
