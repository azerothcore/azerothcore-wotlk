-- DB update 2020_12_31_00 -> 2020_12_31_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_31_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_31_00 2020_12_31_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1601269592461165174'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601269592461165174');

/* Horde */
DELETE FROM `creature_queststarter` WHERE (`quest` = 11431) AND (`id` IN (24657));
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(24657, 11431);

DELETE FROM `creature_questender` WHERE (`quest` = 11431) AND (`id` IN (24657));
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(24657, 11431);

/* Alliance */
DELETE FROM `creature_queststarter` WHERE (`quest` = 11117) AND (`id` IN (23486));
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(23486, 11117);

DELETE FROM `creature_questender` WHERE (`quest` = 11117) AND (`id` IN (23486));
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(23486, 11117);

/* fix for Wolpertinger Net */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23487;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 23487) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23487, 0, 0, 1, 8, 0, 100, 0, 41621, 0, 0, 0, 0, 11, 32906, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Wild Wolpertinger - On Spellhit \'Wolpertinger Net\' - Add Item \'Stunned Wolpertinger\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
