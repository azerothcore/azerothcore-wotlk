-- DB update 2020_01_28_00 -> 2020_01_30_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_01_28_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_01_28_00 2020_01_30_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1579041492812648634'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1579041492812648634');

-- Ironhide Devilsaur: Use SAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6499;

-- Tyrant Devilsaur: Delete duplicate
DELETE FROM `creature` WHERE `guid` = 23744;
DELETE FROM `creature_addon` WHERE `guid` = 23744;

-- All Devilsaurs: Set large in order to increase their visibility distance
UPDATE `creature_addon` SET `isLarge` = 1 WHERE `guid` IN (23741,23743,23745,24437);

-- All Devilsaurs: Set active in order to enable them walking around on their own
DELETE FROM `smart_scripts` WHERE `entryorguid` = 6499 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (6498,6500) AND `source_type` = 0 AND `id` = 1;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 6584 AND `source_type` = 0 AND `id` = 3;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(6498,0,1,0,11,0,100,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Devilsaur - On Respawn - Set Active On'),
(6499,0,0,0,11,0,100,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ironhide Devilsaur - On Respawn - Set Active On'),
(6500,0,1,0,11,0,100,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Tyrant Devilsaur - On Respawn - Set Active On'),
(6584,0,3,0,11,0,100,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'King Mosh - On Respawn - Set Active On');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
