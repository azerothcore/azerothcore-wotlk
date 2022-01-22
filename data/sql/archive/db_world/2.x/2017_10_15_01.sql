-- DB update 2017_10_15_00 -> 2017_10_15_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_10_15_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_10_15_00 2017_10_15_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1504704582101308200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1504704582101308200');

-- Editing the SmartAI script of [Creature] ENTRY 11663 (name: Flamewaker Healer)

-- Table creature_template
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11663;

-- Table smart_scripts
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11663);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11663, 0, 0, 0, 0, 0, 100, 2, 9000, 9000, 9000, 9000, 11, 20603, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Flamewaker Healer - In Combat - Cast \'Shadow Shock\' (Normal Dungeon)'),
(11663, 0, 1, 0, 0, 0, 100, 2, 2000, 2000, 2000, 2000, 11, 22677, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Flamewaker Healer - In Combat - Cast \'Shadow Bolt\' (Normal Dungeon)'),
(11663, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Flamewaker Healer - On Aggro - Call For Help');


-- Editing the SmartAI script of [Creature] ENTRY 11664 (name: Flamewaker Elite)

-- Table creature_template
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11664;

-- Table smart_scripts
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 11664);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11664, 0, 0, 0, 0, 0, 85, 2, 1000, 1000, 8000, 8000, 11, 36711, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Flamewaker Elite - In Combat - Cast \'Fireball\' (Normal Dungeon)'),
(11664, 0, 1, 0, 0, 0, 100, 2, 12000, 12000, 12000, 12000, 11, 20229, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Flamewaker Elite - In Combat - Cast \'Blast Wave\' (Normal Dungeon)'),
(11664, 0, 2, 0, 0, 0, 80, 2, 5000, 5000, 15000, 15000, 11, 20623, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Flamewaker Elite - In Combat - Cast \'Fire Blast\' (Normal Dungeon)'),
(11664, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Flamewaker Elite - On Aggro - Call For Help');

-- Core Hound scriptname
UPDATE `creature_template` SET `scriptname` = 'npc_magmadar_core_hound' WHERE `entry` = 11671;

-- Core Hound texts
DELETE FROM `creature_text` WHERE entry = 11671;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `textrange`) VALUES 
(11671, 0, 0, "%s collapses and begins to smolder.", 16, 0, 100, 0, 2000, 0),
(11671, 1, 0, "%s reignites from the heat of another Core Hound!", 16, 0, 100, 0, 2000, 0);--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
