-- DB update 2021_10_19_00 -> 2021_10_19_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_19_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_19_00 2021_10_19_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1634222360045886500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634222360045886500');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 36024;

DELETE FROM `smart_scripts` WHERE `entryorguid`=36024 AND `source_type`=0 AND `id`=0 AND `link`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(36024, 0, 0, 0, 22, 0, 100, 0, 101, 0, 0, 0, 0, 11, 48249, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'The Black Brewmaiden - Received Emote 101 - Cast \'Brewfest Brew Toss\'');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_19_01' WHERE sql_rev = '1634222360045886500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
