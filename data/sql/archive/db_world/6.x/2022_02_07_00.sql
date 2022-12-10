-- DB update 2022_02_06_00 -> 2022_02_07_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_06_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_06_00 2022_02_07_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1643486369280661300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643486369280661300');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (-84605, -84616, -84606, -84603, -84615, -84614) AND `source_type` = 0 AND `id` IN (2, 3, 4, 5, 6);
DELETE FROM `smart_scripts` WHERE `entryorguid` = 3626 AND `source_type` = 2 AND `id` IN (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3626, 2, 0, 6, 46, 0, 100, 0, 3626, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 84605, 13996, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Set Data 1 1'),
(3626, 2, 1, 7, 46, 0, 100, 0, 3626, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 84616, 13996, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Set Data 1 1'),
(3626, 2, 2, 8, 46, 0, 100, 0, 3626, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 84606, 13996, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Set Data 1 1'),
(3626, 2, 3, 9, 46, 0, 100, 0, 3626, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 84603, 13996, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Set Data 1 1'),
(3626, 2, 4, 10, 46, 0, 100, 0, 3626, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 84615, 13996, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Set Data 1 1'),
(3626, 2, 5, 11, 46, 0, 100, 0, 3626, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 84614, 13996, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Set Data 1 1'),
(3626, 2, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 19, 0x00000100|0x00000200, 0, 0, 0, 0, 0, 10, 84605, 13996, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Remove Flags Immune To Players & Immune To NPC\'s'),
(3626, 2, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 19, 0x00000100|0x00000200, 0, 0, 0, 0, 0, 10, 84616, 13996, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Remove Flags Immune To Players & Immune To NPC\'s'),
(3626, 2, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 19, 0x00000100|0x00000200, 0, 0, 0, 0, 0, 10, 84606, 13996, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Remove Flags Immune To Players & Immune To NPC\'s'),
(3626, 2, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 19, 0x00000100|0x00000200, 0, 0, 0, 0, 0, 10, 84603, 13996, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Remove Flags Immune To Players & Immune To NPC\'s'),
(3626, 2, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 19, 0x00000100|0x00000200, 0, 0, 0, 0, 0, 10, 84615, 13996, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Remove Flags Immune To Players & Immune To NPC\'s'),
(3626, 2, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 19, 0x00000100|0x00000200, 0, 0, 0, 0, 0, 10, 84614, 13996, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Remove Flags Immune To Players & Immune To NPC\'s'),
(-84605, 0, 2, 5, 4, 0, 100, 2, 0, 0, 0, 0, 0, 54, 300000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - On Aggro - Pause waypoint'),
(-84605, 0, 3, 0, 0, 0, 75, 2, 2000, 2000, 2000, 6000, 0, 11, 22334, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - In Combat - Cast \'Bomb\''),
(-84605, 0, 4, 0, 0, 0, 85, 2, 2000, 2000, 8000, 8000, 0, 11, 22335, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - In Combat - Cast \'Bottle of Poison\''),
(-84605, 0, 5, 0, 61, 0, 100, 2, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - On Aggro - Start Attack'),
(-84605, 0, 6, 0, 7, 0, 100, 2, 0, 0, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - On Evade - Resume waypoint'),
(-84616, 0, 2, 5, 4, 0, 100, 2, 0, 0, 0, 0, 0, 54, 300000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - On Aggro - Pause waypoint'),
(-84616, 0, 3, 0, 0, 0, 75, 2, 2000, 2000, 2000, 6000, 0, 11, 22334, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - In Combat - Cast \'Bomb\''),
(-84616, 0, 4, 0, 0, 0, 85, 2, 2000, 2000, 8000, 8000, 0, 11, 22335, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - In Combat - Cast \'Bottle of Poison\''),
(-84616, 0, 5, 0, 61, 0, 100, 2, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - On Aggro - Start Attack'),
(-84616, 0, 6, 0, 7, 0, 100, 2, 0, 0, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - On Evade - Resume waypoint'),
(-84606, 0, 2, 5, 4, 0, 100, 2, 0, 0, 0, 0, 0, 54, 300000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - On Aggro - Pause waypoint'),
(-84606, 0, 3, 0, 0, 0, 75, 2, 2000, 2000, 2000, 6000, 0, 11, 22334, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - In Combat - Cast \'Bomb\''),
(-84606, 0, 4, 0, 0, 0, 85, 2, 2000, 2000, 8000, 8000, 0, 11, 22335, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - In Combat - Cast \'Bottle of Poison\''),
(-84606, 0, 5, 0, 61, 0, 100, 2, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - On Aggro - Start Attack'),
(-84606, 0, 6, 0, 7, 0, 100, 2, 0, 0, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - On Evade - Resume waypoint'),
(-84603, 0, 2, 5, 4, 0, 100, 2, 0, 0, 0, 0, 0, 54, 300000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - On Aggro - Pause waypoint'),
(-84603, 0, 3, 0, 0, 0, 75, 2, 2000, 2000, 2000, 6000, 0, 11, 22334, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - In Combat - Cast \'Bomb\''),
(-84603, 0, 4, 0, 0, 0, 85, 2, 2000, 2000, 8000, 8000, 0, 11, 22335, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - In Combat - Cast \'Bottle of Poison\''),
(-84603, 0, 5, 0, 61, 0, 100, 2, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - On Aggro - Start Attack'),
(-84603, 0, 6, 0, 7, 0, 100, 2, 0, 0, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - On Evade - Resume waypoint'),
(-84615, 0, 2, 5, 4, 0, 100, 2, 0, 0, 0, 0, 0, 54, 300000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - On Aggro - Pause waypoint'),
(-84615, 0, 3, 0, 0, 0, 75, 2, 2000, 2000, 2000, 6000, 0, 11, 22334, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - In Combat - Cast \'Bomb\''),
(-84615, 0, 4, 0, 0, 0, 85, 2, 2000, 2000, 8000, 8000, 0, 11, 22335, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - In Combat - Cast \'Bottle of Poison\''),
(-84615, 0, 5, 0, 61, 0, 100, 2, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - On Aggro - Start Attack'),
(-84615, 0, 6, 0, 7, 0, 100, 2, 0, 0, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - On Evade - Resume waypoint'),
(-84614, 0, 2, 5, 4, 0, 100, 2, 0, 0, 0, 0, 0, 54, 300000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - On Aggro - Pause waypoint'),
(-84614, 0, 3, 0, 0, 0, 75, 2, 2000, 2000, 2000, 6000, 0, 11, 22334, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - In Combat - Cast \'Bomb\''),
(-84614, 0, 4, 0, 0, 0, 85, 2, 2000, 2000, 8000, 8000, 0, 11, 22335, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - In Combat - Cast \'Bottle of Poison\''),
(-84614, 0, 5, 0, 61, 0, 100, 2, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - On Aggro - Start Attack'),
(-84614, 0, 6, 0, 7, 0, 100, 2, 0, 0, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Technician - On Evade - Resume waypoint');

UPDATE `creature` SET `unit_flags` = `unit_flags`|0x00000040 WHERE `guid` IN (84605, 84616, 84606, 84603, 84615, 84614);
UPDATE `creature_template` SET `unit_flags` = `unit_flags`|0x00000040 WHERE `entry` = 13996;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_07_00' WHERE sql_rev = '1643486369280661300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
