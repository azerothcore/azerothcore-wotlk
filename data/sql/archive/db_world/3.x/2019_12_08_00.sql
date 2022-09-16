-- DB update 2019_12_07_00 -> 2019_12_08_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_12_07_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_12_07_00 2019_12_08_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1574778273250296900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

DELETE FROM `smart_scripts` WHERE `entryorguid` = 29618 AND `source_type` = 0 AND `id` IN (7,8,9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(29618, 0, 7, 8, 8, 0, 100, 1, 66474, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Snowblind Follower - On Spellhit ''Throw Net'' - Say Line 0 (No Repeat)'),
(29618, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 0, 33, 34899, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Snowblind Follower - Linked - Quest Credit ''Gormok Wants His Snobolds'''),
(29618, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Snowblind Follower - Linked - Despawn in 5000 ms');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
