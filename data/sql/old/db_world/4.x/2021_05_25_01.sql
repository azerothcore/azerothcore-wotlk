-- DB update 2021_05_25_00 -> 2021_05_25_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_25_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_25_00 2021_05_25_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1621246170226501700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621246170226501700');

-- These cages shouldn't really despawn
UPDATE `gameobject` SET `spawntimesecs` = 0 WHERE (`id` = 186287);

-- Prevent players from using keys while there's no prisoner inside
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18628700) AND (`source_type` = 9) AND (`id` IN (2,3,4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(18628700, 9, 2, 0, 0, 0, 100, 0, 300000, 300000, 0, 0, 0, 32, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackhoof Cage - Script - Reset Go'),
(18628700, 9, 3, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 104, 48, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackhoof Cage - Script - Set Flag'),
(18628700, 9, 4, 0, 0, 0, 100, 0, 64500, 64500, 0, 0, 0, 104, 32, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackhoof Cage - Script - Set Flag');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
