-- DB update 2021_01_03_01 -> 2021_01_04_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_01_03_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_01_03_01 2021_01_04_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1608949912835926000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1608949912835926000');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (19257, 19258);

-- Arcanist Torseldori
DELETE FROM `smart_scripts` WHERE `entryorguid` = 19257 AND `source_type`= 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)VALUES 
(19257, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Arcanist Torseldori - On aggro - say text'),
(19257, 0, 1, 0, 0, 0, 100, 0, 1000, 1000, 3000, 4000, 0, 11, 15530, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Arcanist Torseldori - IC - Cast spell Frostbolt'),
(19257, 0, 2, 0, 0, 0, 100, 0, 4000, 10000, 10000, 14000, 0, 11, 12674, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Arcanist Torseldori - IC - Cast spell Frost Nova'),
(19257, 0, 3, 0, 0, 0, 100, 0, 10000, 15000, 13000, 24000, 0, 11, 33634, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Arcanist Torseldori - IC - Cast spell Frost Blizzard');

-- Bloodmage
DELETE FROM `smart_scripts` WHERE `entryorguid` = 19258 AND `source_type`= 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(19258, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 3000, 4000, 0, 11, 15530, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodmage - IC - Cast spell Frostbolt'),
(19258, 0, 1, 0, 0, 0, 100, 0, 4000, 10000, 10000, 14000, 0, 11, 12674, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodmage - IC - Cast spell Frost Nova'),
(19258, 0, 2, 0, 0, 0, 100, 0, 10000, 15000, 13000, 24000, 0, 11, 33634, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodmage - IC - Cast spell Frost Blizzard');


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
