-- DB update 2021_05_24_00 -> 2021_05_25_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_24_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_24_00 2021_05_25_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1617919703551999441'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617919703551999441');

SET @ENTRY := 10505;
DELETE FROM `creature_template_spell` WHERE (`CreatureID` = @ENTRY);
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(@ENTRY, 0, 18376, 0),
(@ENTRY, 1, 12020, 12340),
(@ENTRY, 2, 8362, 0),
(@ENTRY, 3, 17843, 0),
(@ENTRY, 4, 15586, 0),
(@ENTRY, 5, 13747, 0);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = @ENTRY;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = @ENTRY);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 0, 0, 100, 0, 7000, 15000, 60000, 60000, 0, 11, 12020, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Instructor Malicia - In Combat - Cast \'Call of the Grave\''),
(@ENTRY, 0, 1, 0, 0, 0, 100, 0, 3000, 12000, 17000, 22000, 0, 11, 18376, 32, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Instructor Malicia - In Combat - Cast \'Corruption\''),
(@ENTRY, 0, 2, 0, 14, 0, 100, 0, 5000, 40, 10000, 10000, 0, 11, 8362, 32, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Instructor Malicia - Friendly At 5000 Health - Cast \'Renew\''),
(@ENTRY, 0, 3, 0, 14, 0, 100, 0, 5000, 40, 8000, 8000, 0, 11, 17843, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Instructor Malicia - Friendly At 5000 Health - Cast \'Flash Heal\''),
(@ENTRY, 0, 4, 0, 2, 0, 100, 0, 0, 40, 18000, 25000, 0, 11, 15586, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Instructor Malicia - Between 0-40% Health - Cast \'Heal\''),
(@ENTRY, 0, 5, 0, 0, 0, 100, 0, 13000, 15000, 20000, 35000, 0, 11, 13747, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Instructor Malicia - In Combat - Cast \'Slow\''),
(@ENTRY, 0, 6, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 34, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Instructor Malicia - On Just Died - Set Instance Data 1 to 1');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
