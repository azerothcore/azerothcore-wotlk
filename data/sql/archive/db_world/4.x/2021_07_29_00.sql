-- DB update 2021_07_28_01 -> 2021_07_29_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_28_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_28_01 2021_07_29_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626635521387129200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626635521387129200');

-- Changed the event_type from CAST to UPDATE_IC so they only can cast shoot while on combat.
-- Changed the action_param2 from 66 to 64. 66 does nothing, and 64 will take into account LOS, being stunned so they cant cast it
UPDATE `smart_scripts` SET `event_type` = 0, `action_param2` = 64, `action_param3` = 1 WHERE (`entryorguid` = 7856) AND (`source_type` = 0) AND (`id` = 0);
-- Changed the Fleeing skill to have 7-action invoker instead of Self as the rest of fleeing actions in the database.
UPDATE `smart_scripts` SET  `target_type` = 7 WHERE (`entryorguid` = 7856) AND (`source_type` = 0) AND (`id` = 1);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_29_00' WHERE sql_rev = '1626635521387129200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
