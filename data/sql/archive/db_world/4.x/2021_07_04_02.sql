-- DB update 2021_07_04_01 -> 2021_07_04_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_04_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_04_01 2021_07_04_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1624282955303279000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624282955303279000');

SET @STATUE_QUEEN_AZSHARA = 181964;
SET @ENTRY_ATOPH_THE_BLOODCURSED = 17715;

-- Gameobject Statue of Queen Azshara executes a event_script whose ID is 11027
-- This event is used to summon Atoph The Bloodcursed.
UPDATE `event_scripts` SET `datalong2`='60000', `x`='-1896.13', `y`='-12861.1', `z`='87.1412', `o`='3.5412' WHERE  `id`=11027;

UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = @STATUE_QUEEN_AZSHARA;
DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = @STATUE_QUEEN_AZSHARA);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@STATUE_QUEEN_AZSHARA, 1, 1, 3, 70, 0, 100, 0, 1, 0, 0, 0, 0, 105, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Statue of Queen Azshara - On Gameobject State Changed - Add Gameobject Flags Not Selectable'),
(@STATUE_QUEEN_AZSHARA, 1, 3, 4, 61, 0, 100, 0, 1, 0, 0, 0, 0, 50, 181965, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -1943.62, -12878.9, 88.3187, 3.8366, 'Statue of Queen Azshara - On Gameobject State Changed - Summon Gameobject \'Statue Fire\''),
(@STATUE_QUEEN_AZSHARA, 1, 4, 5, 61, 0, 100, 0, 1, 0, 0, 0, 0, 50, 181965, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -1945.27, -12881.7, 91.1005, 3.73761, 'Statue of Queen Azshara - On Gameobject State Changed - Summon Gameobject \'Statue Fire\''),
(@STATUE_QUEEN_AZSHARA, 1, 5, 6, 61, 0, 100, 0, 1, 0, 0, 0, 0, 50, 181965, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -1944.73, -12887.7, 88.1748, 2.81869, 'Statue of Queen Azshara - On Gameobject State Changed - Summon Gameobject \'Statue Fire\''),
(@STATUE_QUEEN_AZSHARA, 1, 6, 7, 61, 0, 100, 0, 1, 0, 0, 0, 0, 50, 181965, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -1951.88, -12881.8, 88.8753, 0.304646, 'Statue of Queen Azshara - On Gameobject State Changed - Summon Gameobject \'Statue Fire\''),
(@STATUE_QUEEN_AZSHARA, 1, 7, 0, 61, 0, 100, 0, 1, 0, 0, 0, 0, 50, 181965, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -1944.95, -12882.5, 99.2512, 4.0282, 'Statue of Queen Azshara - On Gameobject State Changed - Summon Gameobject \'Statue Fire\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = @ENTRY_ATOPH_THE_BLOODCURSED;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = @ENTRY_ATOPH_THE_BLOODCURSED);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY_ATOPH_THE_BLOODCURSED, 0, 0, 1, 63, 0, 100, 0, 0, 0, 0, 0, 0, 46, 30, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Atoph the Bloodcursed - On Just Created - Move Forward 30 Yards'),
(@ENTRY_ATOPH_THE_BLOODCURSED, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 4000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Atoph the Bloodcursed - On Just Created - Say Line 0'),
(@ENTRY_ATOPH_THE_BLOODCURSED, 0, 2, 3, 6, 0, 100, 0, 0, 0, 0, 0, 0, 106, 16, 0, 0, 0, 0, 0, 13, @STATUE_QUEEN_AZSHARA, 0, 200, 0, 0, 0, 0, 0, 'Atoph the Bloodcursed - On Just Died - Remove Gameobject Flags Not Selectable'),
(@ENTRY_ATOPH_THE_BLOODCURSED, 0, 3, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Atoph the Bloodcursed - On Just Died - Despawn In 30000 ms'),
(@ENTRY_ATOPH_THE_BLOODCURSED, 0, 4, 5, 1, 0, 100, 0, 60000, 60000, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Atoph the Bloodcursed - Out of Combat - Despawn Instant'),
(@ENTRY_ATOPH_THE_BLOODCURSED, 0, 5, 6, 61, 0, 100, 0, 60000, 60000, 0, 0, 0, 106, 16, 0, 0, 0, 0, 0, 13, @STATUE_QUEEN_AZSHARA, 0, 500, 0, 0, 0, 0, 0, 'Atoph the Bloodcursed - Out of Combat - Remove Gameobject Flags Not Selectable'),
(@ENTRY_ATOPH_THE_BLOODCURSED, 0, 6, 0, 61, 0, 100, 0, 60000, 60000, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 13, 181965, 0, 200, 0, 0, 0, 0, 0, 'Atoph the Bloodcursed - Out of Combat - Despawn Instant'),
(@ENTRY_ATOPH_THE_BLOODCURSED, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 13, 181965, 0, 500, 0, 0, 0, 0, 0, 'Atoph the Bloodcursed - On Just Died - Despawn Instant');

DELETE FROM `creature_text` WHERE `CreatureID` = @ENTRY_ATOPH_THE_BLOODCURSED;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(@ENTRY_ATOPH_THE_BLOODCURSED, 0, 0, 'Who dares defile the statue of our beloved?', 14, 0, 100, 0, 0, 0, 14366, 0, 'Atoph the Bloodcursed');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_04_02' WHERE sql_rev = '1624282955303279000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
