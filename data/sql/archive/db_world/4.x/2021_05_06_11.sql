-- DB update 2021_05_06_10 -> 2021_05_06_11
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_06_10';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_06_10 2021_05_06_11 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1619958638373648000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619958638373648000');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15402;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 15402);
INSERT INTO `smart_scripts` VALUES
(15402, 0, 0, 0, 20, 0, 100, 0, 8487, 0, 0, 0, 0, 80, 1540200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Mirveda - On Quest \'Corrupted Soil\' Finished - Run Script'),
(15402, 0, 1, 2, 19, 0, 100, 0, 8488, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Mirveda - On Quest \'Unexpected Results\' Taken - Store Targetlist'),
(15402, 0, 2, 0, 61, 0, 100, 0, 8488, 0, 0, 0, 0, 80, 1540201, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Mirveda - On Quest \'Unexpected Results\' Taken - Run Script'),
(15402, 0, 3, 0, 0, 0, 100, 0, 900, 900, 3000, 4000, 0, 11, 20811, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Mirveda - In Combat - Cast \'Fireball\''),
(15402, 0, 4, 0, 6, 1, 100, 0, 0, 0, 0, 0, 0, 6, 8488, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Mirveda - On Just Died - Fail Quest \'Unexpected Results\' (Phase 1)'),
(15402, 0, 5, 6, 7, 1, 100, 0, 0, 0, 0, 0, 0, 15, 8488, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Mirveda - On Evade - Quest Credit \'Unexpected Results\' (Phase 1)'),
(15402, 0, 6, 0, 61, 1, 100, 0, 0, 0, 0, 0, 0, 80, 1540202, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Mirveda - On Evade - Run Script (Phase 1)'),
(15402, 0, 7, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 18, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Mirveda - On Respawn - Set Flags Immune To NPC\'s');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (1540200, 1540201, 1540202));
INSERT INTO `smart_scripts` VALUES
(1540200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Mirveda - Actionlist - Set Npc Flag '),
(1540200, 9, 1, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Mirveda - Actionlist - Say Line 0'),
(1540200, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Mirveda - Actionlist - Set Npc Flags Questgiver');

INSERT INTO `smart_scripts` VALUES
(1540201, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Mirveda - Actionlist - Set Npc Flag '),
(1540201, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 2, 232, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Mirveda - Actionlist - Set Faction 232'),
(1540201, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 19, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Mirveda - Actionlist - Remove Flags Immune To NPC\'s'),
(1540201, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Mirveda - Actionlist - Set Event Phase 1'),
(1540201, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 12, 15958, 7, 180000, 0, 0, 0, 8, 0, 0, 0, 0, 8750.1, -7129.7, 35.2976, 3.8041, 'Apprentice Mirveda - Actionlist - Summon Creature \'Gharsul the Remorseless\''),
(1540201, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 12, 15656, 7, 180000, 0, 0, 0, 8, 0, 0, 0, 0, 8753.61, -7133.15, 35, 3.8576, 'Apprentice Mirveda - Actionlist - Summon Creature \'Angershade\''),
(1540201, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 12, 15656, 7, 180000, 0, 0, 0, 8, 0, 0, 0, 0, 8747.14, -7125.71, 35.848, 3.8576, 'Apprentice Mirveda - Actionlist - Summon Creature \'Angershade\'');

INSERT INTO `smart_scripts` VALUES
(1540202, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Mirveda - Actionlist - Set Npc Flags Questgiver'),
(1540202, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 2, 1604, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Mirveda - Actionlist - Set Faction 1604'),
(1540202, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 18, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Mirveda - Actionlist - Set Flags Immune To NPC\'s'),
(1540202, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Mirveda - Actionlist - Set Event Phase 0');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
