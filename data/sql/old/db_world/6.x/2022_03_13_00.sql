-- DB update 2022_03_12_03 -> 2022_03_13_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_12_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_12_03 2022_03_13_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1647042448722452100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647042448722452100');

UPDATE `creature_template` SET `unit_flags` = `unit_flags`|256|512|33554432, `AIName` = 'SmartAI', `flags_extra` = `flags_extra`|2|64 WHERE `entry` IN (14307, 14309, 14310, 14311, 14312);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (14307, 14309, 14310, 14311, 14312) AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14307, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 11, 22653, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Black Drakonid Spawner - On Respawn - Cast \'Serverside - Drakonid Spawner\''),
(14307, 0, 1, 0, 1, 0, 100, 1, 1000, 60000, 60000, 60000, 0, 11, 22680, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Black Drakonid Spawner - Out of Combat - Cast \'Spawn Chromatic Drakonid\' (No Repeat)'),
(14309, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 11, 22653, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Black Drakonid Spawner - On Respawn - Cast \'Serverside - Drakonid Spawner\''),
(14309, 0, 1, 0, 1, 0, 100, 1, 1000, 60000, 60000, 60000, 0, 11, 22680, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Black Drakonid Spawner - Out of Combat - Cast \'Spawn Chromatic Drakonid\' (No Repeat)'),
(14310, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 11, 22653, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Black Drakonid Spawner - On Respawn - Cast \'Serverside - Drakonid Spawner\''),
(14310, 0, 1, 0, 1, 0, 100, 1, 1000, 60000, 60000, 60000, 0, 11, 22680, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Black Drakonid Spawner - Out of Combat - Cast \'Spawn Chromatic Drakonid\' (No Repeat)'),
(14311, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 11, 22653, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Black Drakonid Spawner - On Respawn - Cast \'Serverside - Drakonid Spawner\''),
(14311, 0, 1, 0, 1, 0, 100, 1, 1000, 60000, 60000, 60000, 0, 11, 22680, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Black Drakonid Spawner - Out of Combat - Cast \'Spawn Chromatic Drakonid\' (No Repeat)'),
(14312, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 11, 22653, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Black Drakonid Spawner - On Respawn - Cast \'Serverside - Drakonid Spawner\''),
(14312, 0, 1, 0, 1, 0, 100, 1, 1000, 60000, 60000, 60000, 0, 11, 22680, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Black Drakonid Spawner - Out of Combat - Cast \'Spawn Chromatic Drakonid\' (No Repeat)');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_spawn_drakonid';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(22659, 'spell_spawn_drakonid');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_13_00' WHERE sql_rev = '1647042448722452100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
