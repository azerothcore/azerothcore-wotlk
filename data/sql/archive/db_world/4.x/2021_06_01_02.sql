-- DB update 2021_06_01_01 -> 2021_06_01_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_01_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_01_01 2021_06_01_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1621933074448445073'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621933074448445073');

-- Lord Baurles K. Wishock
SET @ENTRY := 1439;

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = @ENTRY;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = @ENTRY);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 1, 20, 0, 100, 0, 336, 0, 0, 0, 0, 5, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Baurles K. Wishock - On Quest \'A Noble Brew\' Finished - Play Emote 7'),
(@ENTRY, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 67, 1, 2000, 2000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Baurles K. Wishock - On Quest \'A Noble Brew\' Finished - Create Timed Event'),
(@ENTRY, 0, 2, 3, 59, 0, 100, 0, 1, 0, 0, 0, 0, 1, 0, 3000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Baurles K. Wishock - On Timed Event 1 Triggered - Say Line 0'),
(@ENTRY, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 17, 64, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Baurles K. Wishock - On Timed Event 1 Triggered - Set Emote State 64'),
(@ENTRY, 0, 4, 5, 52, 0, 100, 0, 0, @ENTRY, 0, 0, 0, 1, 1, 8000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Baurles K. Wishock - On Text 0 Over - Say Line 1'),
(@ENTRY, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 67, 2, 5000, 5000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Baurles K. Wishock - On Text 0 Over - Create Timed Event'),
(@ENTRY, 0, 6, 0, 59, 0, 100, 0, 2, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Baurles K. Wishock - On Timed Event 2 Triggered - Kill Self'),
(@ENTRY, 0, 7, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Baurles K. Wishock - On Respawn - Set Emote State 0');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_01_02' WHERE sql_rev = '1621933074448445073';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
