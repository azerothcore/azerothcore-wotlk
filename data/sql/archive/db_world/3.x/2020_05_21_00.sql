-- DB update 2020_05_20_00 -> 2020_05_21_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_05_20_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_05_20_00 2020_05_21_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1587676154153218400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1587676154153218400');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 6497;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6497, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 2, 68, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Astor Hadren - On Respawn - Set Faction 68'),
(6497, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 6497, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Astor Hadren - On Respawn - Start Waypoint'),
(6497, 0, 2, 0, 64, 0, 100, 0, 0, 0, 0, 0, 0, 54, 15000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Astor Hadren - On Gossip Hello - Pause Waypoint'),
(6497, 0, 3, 4, 62, 0, 100, 0, 125, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Astor Hadren - On Gossip Option 0 Selected - Close Gossip'),
(6497, 0, 4, 5, 61, 0, 100, 0, 125, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Astor Hadren - On Gossip Option 0 Selected - Set Faction 14'),
(6497, 0, 5, 6, 61, 0, 100, 0, 125, 0, 0, 0, 0, 55, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Astor Hadren - On Gossip Option 0 Selected - Stop Waypoint'),
(6497, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Astor Hadren - On Gossip Option 0 Selected - Start Attacking'),
(6497, 0, 7, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 2, 68, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Astor Hadren - On Evade - Set Faction 68');

UPDATE `conditions` SET `comment` = 'Astor Hadren - Show gossip if quest 14420 is taken' WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 126;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
