-- DB update 2020_06_12_00 -> 2020_06_12_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_06_12_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_06_12_00 2020_06_12_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1588339146103973500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588339146103973500');

/*
 * Zone: Sholazar Basin
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* FLAGS */
UPDATE `creature_template` SET `unit_flags` = `unit_flags`|4 WHERE `entry` IN (29125, 29126, 29127);

/* DROPCHANCE */
UPDATE `creature_loot_template` SET `Chance` = 30 WHERE `Item` = 39265;
UPDATE `creature_loot_template` SET `Chance` = 30 WHERE `Item` = 39266;


/* SMARTSCRIPTS */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (29126, 29125, 29127);

DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 29126);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29126, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 15000, 15000, 11, 53229, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crystal of the Violent Storm - In Combat - Cast \'53229\'');

DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 29125);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29125, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 5000, 5000, 11, 53218, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crystal of the Frozen Grip - In Combat - Cast \'53218\'');

DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 29127);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29127, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 10000, 10000, 11, 53235, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crystal of Unstable Energy - In Combat - Cast \'53235\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
