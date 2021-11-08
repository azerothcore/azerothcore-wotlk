-- DB update 2020_12_10_04 -> 2020_12_10_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_10_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_10_04 2020_12_10_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1606619446977707200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606619446977707200');

-- Add cosmetic event to Iron Mender, cast Fuse Metal out of combat

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 34198;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 34198) AND (`source_type` = 0) AND (`id` IN (6, 7));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(34198, 0, 6, 0, 1, 0, 100, 0, 4000, 4000, 20000, 20000, 0, 11, 64897, 1, 1, 0, 0, 0, 11, 34190, 5, 0, 0, 0, 0, 0, 0, 'Cosmetic - Cast Fuse Metal (10)'),
(34198, 0, 7, 0, 1, 0, 100, 0, 4000, 4000, 20000, 20000, 0, 11, 64968, 1, 1, 0, 0, 0, 11, 34190, 5, 0, 0, 0, 0, 0, 0, 'Cosmetic - Cast Fuse Metal (25)');


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
