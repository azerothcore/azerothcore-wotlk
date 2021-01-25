-- DB update 2020_10_31_00 -> 2020_10_31_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_10_31_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_10_31_00 2020_10_31_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1601396210900255400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601396210900255400');
/*
 * Zone: Defender of Timbermaw
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15720;
UPDATE `creature_template` SET `unit_class` = 8 WHERE `entry` = 15720;

DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 15720);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15720, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, 25357, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Timbermaw Ancestor - On Respawn - Cast \'25357\''),
(15720, 0, 1, 0, 0, 0, 100, 0, 2100, 2700, 8600, 9300, 11, 20295, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Timbermaw Ancestor - In Combat - Cast \'20295\''),
(15720, 0, 2, 0, 12, 0, 100, 1, 5, 50, 0, 0, 11, 25357, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 'Timbermaw Ancestor - Target Between 5-50% Health - Cast \'25357\' (No Repeat)');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
