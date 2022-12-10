-- DB update 2019_12_26_00 -> 2019_12_30_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_12_26_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_12_26_00 2019_12_30_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1576886642925348957'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1576886642925348957');

-- Snufflenose Gopher: Render immune to PC and NPC
UPDATE `creature_template` SET `unit_flags` = `unit_flags` | 256 | 512 WHERE `entry` = 4781;

-- Snufflenose Gopher: Ensure that the react state is always passive; remove unnecessary entries
UPDATE `smart_scripts` SET `link` = 0 WHERE `entryorguid` = 4781 AND `source_type` = 0 AND `id` = 5;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 4781 AND `source_type` = 0 AND `id` IN (6,8);
DELETE FROM `smart_scripts` WHERE `entryorguid` = 478100 AND `source_type` = 9 AND `id` = 4;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(4781,0,8,0,11,0,100,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Snufflenose Gopher - On Respawn - Set React State ''Passive''');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
