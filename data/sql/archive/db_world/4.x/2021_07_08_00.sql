-- DB update 2021_07_07_23 -> 2021_07_08_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_07_23';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_07_23 2021_07_08_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1625686259138336600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625686259138336600');

-- Lard\'s Picnic Basket
-- Handled now with SAI
DELETE FROM `event_scripts` WHERE `id` = 8605;

-- Spawntime changed to 10 secs to prevent abuse
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI', `Data2` = 0, `Data3` = 10000 WHERE `entry` = 179910;

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 179910);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(179910, 1, 0, 1, 70, 0, 100, 0, 2, 0, 0, 0, 0, 12, 14748, 4, 30000, 1, 0, 0, 8, 1, 0, 0, 0, 421.357, -4806.02, 11.9855, 3.12414, 'Lard\'s Picnic Basket - On Gameobject State Changed - Summon Creature \'Vilebranch Kidnapper\''),
(179910, 1, 1, 2, 61, 0, 100, 0, 2, 0, 0, 0, 0, 12, 14748, 4, 30000, 1, 0, 0, 8, 0, 0, 0, 0, 399.936, -4824.07, 9.13856, 5.39307, 'Lard\'s Picnic Basket - On Gameobject State Changed - Summon Creature \'Vilebranch Kidnapper\''),
(179910, 1, 2, 0, 61, 0, 100, 0, 2, 0, 0, 0, 0, 12, 14748, 4, 30000, 1, 0, 0, 8, 0, 0, 0, 0, 378.172, -4784.85, -2.44194, 4.29351, 'Lard\'s Picnic Basket - On Gameobject State Changed - Summon Creature \'Vilebranch Kidnapper\'');

-- Vilebranch Kidnapper
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14748;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 14748);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14748, 0, 1, 0, 12, 0, 100, 1, 0, 20, 0, 0, 0, 11, 7160, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Vilebranch Kidnapper - Target Between 0-20% Health - Cast \'Execute\' (No Repeat)'),
(14748, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vilebranch Kidnapper - Between 0-15% Health - Flee For Assist (No Repeat)'),
(14748, 0, 3, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vilebranch Kidnapper - On Aggro - Say Line 0 (No Repeat)'),
(14748, 0, 0, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vilebranch Kidnapper - On Evade - Despawn Instant');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_08_00' WHERE sql_rev = '1625686259138336600';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
