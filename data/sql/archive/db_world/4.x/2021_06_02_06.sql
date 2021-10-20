-- DB update 2021_06_02_05 -> 2021_06_02_06
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_02_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_02_05 2021_06_02_06 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1622046680993341100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622046680993341100');

-- Have Lunaclaw set data to the Moonkin Stone when it is summoned + add movement to Darkshore spawn
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 12138) AND (`source_type` = 0) AND (`id` IN (2,3, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12138, 0, 2, 0, 60, 0, 100, 1, 1, 2, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 13, 177525, 0, 60, 0, 0, 0, 0, 0, 'Lunaclaw - On Update - Set Data'),
(12138, 0, 3, 4, 11, 0, 100, 0, 2, 0, 148, 0, 0, 46, 50, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lunaclaw - On Respawn (Darkshore) - Move Forward'),
(12138, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 15, 0, 0, 0, 0, 0, 0, 0, 'Lunaclaw - On Respawn (Darkshore) - Attack Start');

-- Add purple glow to the stone when Lunaclaw is spawned
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 177525;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 177525) AND (`source_type` = 1) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(177525, 1, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 50, 177644, 60, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Moonkin Stone - On Data Set - Summon \'Moonkin Stone Aura\'');

-- Update Lunaclaw spawn position in Darkshore
UPDATE `event_scripts` SET `x` = 6359.26, `y` = 143.38, `z` = 23.61, `o` = 4.124 WHERE  `id`= 5991 AND `delay` = 0 AND `command` = 10;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_02_06' WHERE sql_rev = '1622046680993341100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
