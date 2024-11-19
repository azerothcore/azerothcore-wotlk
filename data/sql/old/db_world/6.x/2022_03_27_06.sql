-- DB update 2022_03_27_05 -> 2022_03_27_06
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_27_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_27_05 2022_03_27_06 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1647097838805578400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647097838805578400');

DELETE FROM `smart_scripts` WHERE  `entryorguid` IN (23751, 23752, 23753);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23751, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 15, 182817, 30, 0, 0, 0, 0, 0, 0, 'North Tent - On Spellhit - Despawn Flames'),
(23751, 0, 0, 1, 8, 0, 100, 0, 42356, 0, 0, 0, 0, 33, 23751, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'North Tent - On Spellhit - Kill Credit'),
(23751, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 50, 182817, 60, 0, 0, 0, 0, 20, 186310, 40, 0, 0, 0, 0, 5, 0, 'North Tent - On Spellhit - Summon GameObject'),
(23752, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 15, 182817, 30, 0, 0, 0, 0, 0, 0, 'Northeast Tent - On Spellhit - Despawn Flames'),
(23752, 0, 0, 1, 8, 0, 100, 0, 42356, 0, 0, 0, 0, 33, 23752, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Northeast Tent - On Spellhit - Kill Credit'),
(23752, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 50, 182817, 60, 0, 0, 0, 0, 20, 186310, 40, 0, 0, 0, 0, 5, 0, 'Northeast Tent - On Spellhit - Summon GameObject'),
(23753, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 15, 182817, 30, 0, 0, 0, 0, 0, 0, 'East Tent - On Spellhit - Despawn Flames'),
(23753, 0, 0, 1, 8, 0, 100, 0, 42356, 0, 0, 0, 0, 33, 23753, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'East Tent - On Spellhit - Kill Credit'),
(23753, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 50, 182817, 60, 0, 0, 0, 0, 20, 186310, 40, 0, 0, 0, 0, 5, 0, 'East Tent - On Spellhit - Summon GameObject');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_27_06' WHERE sql_rev = '1647097838805578400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
