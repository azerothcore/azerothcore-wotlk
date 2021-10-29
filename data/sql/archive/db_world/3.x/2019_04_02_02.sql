-- DB update 2019_04_02_01 -> 2019_04_02_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_04_02_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_04_02_01 2019_04_02_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1553974864385673300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1553974864385673300');

-- Table creature_template
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (1057, 6412);

-- Table smart_scripts
DELETE FROM `smart_scripts` WHERE source_type = 0 AND entryorguid IN (1057, 6412);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1057, 0, 0, 0, 11, 0, 100, 1, 0, 0, 0, 0, 11, 8853, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Bonewarder - On Respawn - Cast 8853 (No Repeat)'),
(1057, 0, 1, 0, 4, 0, 100, 1, 1000, 1000, 0, 0, 11, 13787, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Bonewarder - On Aggro - Cast 13787 (No Repeat)'),
(1057, 0, 2, 0, 0, 0, 100, 0, 3000, 4000, 120000, 120000, 11, 6205, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Bonewarder - In Combat - Cast 6205'),
(1057, 0, 3, 0, 0, 0, 100, 0, 5000, 6000, 15000, 15000, 11, 707, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Bonewarder - In Combat - Cast 707'),
(6412, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skeleton - On Just Died - Despawn In 5000 ms');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
