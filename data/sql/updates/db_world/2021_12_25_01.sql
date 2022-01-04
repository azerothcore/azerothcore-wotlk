-- DB update 2021_12_25_00 -> 2021_12_25_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_25_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_25_00 2021_12_25_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638655418843943400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638655418843943400');

/* LK Path of Frost Effect
*/

UPDATE `creature_addon` SET `auras`= 53274 WHERE `guid` = 130896;

/* Lich King text + voice during phase 3 of DK questline
*/

DELETE FROM `creature_text` WHERE (`CreatureID` = 29110) AND (`GroupID` = 0);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(29110, 0, 0, 'Bow before your king!', 14, 0, 100, 0, 0, 14796, 29511, 0, 'Lich King - Ebon Hold - Phase 3 Voice Lines'),
(29110, 0, 1, 'Come to me, Crusaders. I will remake you!', 14, 0, 100, 0, 0, 14799, 29514, 0, 'Lich King - Ebon Hold - Phase 3 Voice Lines'),
(29110, 0, 3, 'Cower before my terrible creations!', 14, 0, 100, 0, 0, 14800, 29515, 0, 'Lich King - Ebon Hold - Phase 3 Voice Lines'),
(29110, 0, 4, 'Feast, my children! Feast upon the flesh of the living!', 14, 0, 100, 0, 0, 14801, 29516, 0, 'Lich King - Ebon Hold - Phase 3 Voice Lines'),
(29110, 0, 5, 'Lay down your arms and surrender your souls!', 14, 0, 100, 0, 0, 14802, 29517, 0, 'Lich King - Ebon Hold - Phase 3 Voice Lines'),
(29110, 0, 6, 'Leave no survivors!', 14, 0, 100, 0, 0, 14793, 29508, 0, 'Lich King - Ebon Hold - Phase 3 Voice Lines'),
(29110, 0, 7, 'Soon you will belong to the Scourge.', 14, 0, 100, 0, 0, 14794, 29509, 0, 'Lich King - Ebon Hold - Phase 3 Voice Lines'),
(29110, 0, 8, 'The Light has abandoned you!', 14, 0, 100, 0, 0, 14797, 29512, 0, 'Lich King - Ebon Hold - Phase 3 Voice Lines'),
(29110, 0, 9, 'There is no Light. Only darkness!', 14, 0, 100, 0, 0, 14798, 29513, 0, 'Lich King - Ebon Hold - Phase 3 Voice Lines'),
(29110, 0, 10, 'Where is your Light now, Crusaders?', 14, 0, 100, 0, 0, 14795, 29510, 0, 'Lich King - Ebon Hold - Phase 3 Voice Lines'),
(29110, 0, 11, 'This is the end!', 14, 0, 100, 0, 0, 14789, 29503, 0, 'Lich King - Ebon Hold - Phase 3 Voice Lines'),
(29110, 0, 12, 'Suffer, insects!', 14, 0, 100, 0, 0, 14787, 29467, 0, 'Lich King - Ebon Hold - Phase 3 Voice Lines'),
(29110, 0, 13, 'Ravage the living, minions!', 14, 0, 100, 0, 0, 14788, 29502, 0, 'Lich King - Ebon Hold - Phase 3 Voice Lines'),
(29110, 0, 14, 'The sacking of the Scarlet Enclave will be a lesson for history!', 14, 0, 100, 0, 0, 14790, 29504, 0, 'Lich King - Ebon Hold - Phase 3 Voice Lines'),
(29110, 0, 15, 'There is nowhere to run...', 14, 0, 100, 0, 0, 14791, 29505, 0, 'Lich King - Ebon Hold - Phase 3 Voice Lines'),
(29110, 0, 16, 'Let the destruction of this place serve as a lesson to all those who would dare oppose the Scourge!', 14, 0, 100, 0, 0, 14792, 29506, 0, 'Lich King - Ebon Hold - Phase 3 Voice Lines');

/* SAI - Cycle through each voice line every minute
*/

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29110;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 29110) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29110, 0, 0, 0, 1, 0, 100, 0, 40000, 50000, 60000, 60000, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lich King - Ebon Hold - Phase 3 Voice Lines');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_25_01' WHERE sql_rev = '1638655418843943400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
