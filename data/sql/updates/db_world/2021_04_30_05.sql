-- DB update 2021_04_30_04 -> 2021_04_30_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_04_30_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_04_30_04 2021_04_30_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1619821428598508300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619821428598508300');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 16287;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 16287) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16287, 0, 0, 1, 62, 0, 100, 0, 7178, 0, 0, 0, 0, 56, 30632, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ambassador Sunsorrow - On Gossip Option 0 Selected - Add Item \'Lament of the Highborne\' 1 Time'),
(16287, 0, 1, 0, 61, 0, 100, 0, 7178, 0, 0, 0, 0, 98, 7178, 10378, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ambassador Sunsorrow - On Gossip Option 0 Selected - Send Gossip'),
(16287, 0, 2, 0, 64, 0, 100, 0, 0, 0, 0, 0, 0, 98, 7178, 8458, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ambassador Sunsorrow - On Gossip Hello - Send Gossip');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
