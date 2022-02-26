-- DB update 2022_01_03_17 -> 2022_01_03_18
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_03_17';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_03_17 2022_01_03_18 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1640704117328778600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640704117328778600');

-- The 'Serpent Statue' is supposed to be despawned but currently not supported by the core.
-- Will have to wait until Dynamic spawn is implemented.
-- Lord Kragaru improvement SmartAI.
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 12369);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12369, 0, 0, 0, 9, 0, 100, 0, 0, 5, 8000, 10000, 0, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Kragaru - Within 0-5 Range - Cast \'Cleave\''),
(12369, 0, 1, 0, 13, 0, 100, 0, 10000, 15000, 0, 0, 0, 11, 12555, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Kragaru - On Victim Casting \'null\' - Cast \'Pummel\''),
(12369, 0, 2, 0, 11, 0, 100, 1, 0, 0, 0, 0, 0, 11, 8609, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Kragaru - On Respawn - Cast \'Cyclone Visual Spawn (DND)\' (No Repeat)');

-- SmartAI for Serpent Statue
DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 177673);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(177673, 1, 0, 0, 70, 0, 100, 0, 2, 0, 0, 0, 0, 50, 177705, 4, 0, 0, 0, 0, 8, 0, 0, 0, 0, 252.547, 2963.69, 1.64267, 5.58505, 'Serpent Statue - On Gameobject State Changed - Summon Gameobject \'Naga Beam\'');

-- SmartAI for Naga beam spawning the NPC
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 177705;
DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 177705);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(177705, 1, 0, 1, 60, 0, 100, 0, 3500, 3500, 0, 0, 0, 12, 12369, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 0, 252.513, 2963.7, 1.64204, 0.90757, 'Naga Beam - On Update - Summon Creature \'Lord Kragaru\'');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_03_18' WHERE sql_rev = '1640704117328778600';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
