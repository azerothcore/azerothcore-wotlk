-- DB update 2020_06_01_00 -> 2020_06_02_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_06_01_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_06_01_00 2020_06_02_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1588332453846633800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588332453846633800');

UPDATE `quest_template` SET `RequiredNPCorGO1` = 20058 WHERE `id` = 10506;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20058);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20058, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodmaul Dire Wolf - On Respawn - Set Faction 0'),
(20058, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodmaul Dire Wolf - On Respawn - Remove Flags Immune To Players'),
(20058, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 19, 262144, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodmaul Dire Wolf - On Respawn - Remove Flags Stunned'),
(20058, 0, 3, 4, 8, 0, 100, 0, 36310, 0, 0, 0, 0, 33, 20058, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodmaul Dire Wolf - On Spellhit \'Rina`s Diminution Powder\' - Quest Credit \'null\''),
(20058, 0, 4, 5, 61, 0, 100, 0, 36310, 0, 0, 0, 0, 2, 31, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodmaul Dire Wolf - On Spellhit \'Rina`s Diminution Powder\' - Set Faction 31'),
(20058, 0, 5, 6, 61, 0, 100, 0, 36310, 0, 0, 0, 0, 41, 60000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodmaul Dire Wolf - On Spellhit \'Rina`s Diminution Powder\' - Despawn In 60000 ms'),
(20058, 0, 6, 7, 61, 0, 100, 0, 36310, 0, 0, 0, 0, 18, 262144, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodmaul Dire Wolf - On Spellhit \'Rina`s Diminution Powder\' - Set Flags Stunned'),
(20058, 0, 7, 8, 61, 0, 100, 0, 36310, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodmaul Dire Wolf - On Spellhit \'Rina`s Diminution Powder\' - Set Flags Immune To Players'),
(20058, 0, 8, 0, 61, 0, 100, 0, 36310, 0, 0, 0, 0, 27, 20058, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodmaul Dire Wolf - On Spellhit \'Rina`s Diminution Powder\' - Stop Combat');

DELETE FROM `creature` WHERE `id` = 21176;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
