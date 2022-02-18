-- DB update 2022_02_15_01 -> 2022_02_15_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_15_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_15_01 2022_02_15_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1644605173333655100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1644605173333655100');

UPDATE `creature_template` SET `AIName` = "SmartAI" WHERE `entry` = 18985;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 18985 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18985, 0, 0, 1, 62, 0, 100, 0, 7859, 0, 0, 0, 11, 33137, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Seer Skaltesh - On Gossip Option Select - Cast Create Elemental Sapta'),
(18985, 0, 1, 0, 61, 0, 100, 0, 7859, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Seer Skaltesh - On Gossip Option Select - Close Gossip');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_15_02' WHERE sql_rev = '1644605173333655100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
