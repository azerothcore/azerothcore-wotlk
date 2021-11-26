-- DB update 2021_08_06_08 -> 2021_08_06_09
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_06_08';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_06_08 2021_08_06_09 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1627813955000857700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627813955000857700');

-- Corrupted Songflower despawn after the quest is completed
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 164886;
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (164886, 171939, 171942, 174594, 174595, 174596, 174597, 174598, 174712, 174713)) AND (`source_type` = 1) AND (`id` = 2);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(164886, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Songflower - On Quest Finished - Despawn Instant'),
(171939, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Songflower - On Quest Finished - Despawn Instant'),
(171942, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Songflower - On Quest Finished - Despawn Instant'),
(174594, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Songflower - On Quest Finished - Despawn Instant'),
(174595, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Songflower - On Quest Finished - Despawn Instant'),
(174596, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Songflower - On Quest Finished - Despawn Instant'),
(174597, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Songflower - On Quest Finished - Despawn Instant'),
(174598, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Songflower - On Quest Finished - Despawn Instant'),
(174712, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Songflower - On Quest Finished - Despawn Instant'),
(174713, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Songflower - On Quest Finished - Despawn Instant');

-- Cleansed Songflower despawn after the quest is completed
UPDATE `gameobject_template` SET `Data5` = 1, `AIName` = 'SmartGameObjectAI' WHERE (`entry` = 164882);

-- Corrupted Night Dragon despawn after the quest is completed
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 164885;
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN ( 164885, 173324, 174608, 174684) AND (`source_type` = 1) AND (`id` IN (0, 1, 2)));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(164885, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 0, 50, 164881, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject'),
(164885, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Night Dragon - On Quest \'Corrupted Night Dragon\' Finished - Set Lootstate Deactivated'),
(164885, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Night Dragon - On Quest Finished - Despawn Instant'),

(173324, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 0, 50, 173325, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject'),
(173324, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Night Dragon - On Quest \'Corrupted Night Dragon\' Finished - Set Lootstate Deactivated'),
(173324, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Night Dragon - On Quest Finished - Despawn Instant'),

(174608, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 0, 50, 174609, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject'),
(174608, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Night Dragon - On Quest \'Corrupted Night Dragon\' Finished - Set Lootstate Deactivated'),
(174608, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Night Dragon - On Quest Finished - Despawn Instant'),

(174684, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 0, 50, 174685, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject'),
(174684, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Night Dragon - On Quest \'Corrupted Night Dragon\' Finished - Set Lootstate Deactivated'),
(174684, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Night Dragon - On Quest Finished - Despawn Instant');

-- Cleansed Night Dragon despawn after the quest is completed
UPDATE `gameobject_template` SET `Data3` = 1 , `Data5` = 1, `AIName` = 'SmartGameObjectAI' WHERE (`entry` IN (164881, 173325, 174609, 174685));
-- Spawns of cleansed items must be deleted to be fixed
DELETE FROM `gameobject` WHERE (`id` IN (164881, 173325, 174609, 174685)); 

-- Corrupted Whipper Root
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (164888, 173284, 174605, 174606, 174607, 174686) AND (`source_type` = 1) AND (`id` IN (0, 1, 2)));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES

(164888, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 0, 50, 164883, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject'),
(164888, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Whipper Root - On Quest \'Corrupted Night Dragon\' Finished - Set Lootstate Deactivated'),
(164888, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Whipper Root - On Quest Finished - Despawn Instant'),

(173284, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 0, 50, 174622, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject'),
(173284, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Whipper Root - On Quest \'Corrupted Night Dragon\' Finished - Set Lootstate Deactivated'),
(173284, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Whipper Root - On Quest Finished - Despawn Instant'),

(174605, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 0, 50, 174623, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject'),
(174605, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Whipper Root - On Quest \'Corrupted Night Dragon\' Finished - Set Lootstate Deactivated'),
(174605, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Whipper Root - On Quest Finished - Despawn Instant'),

(174606, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 0, 50, 174624, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject'),
(174606, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Whipper Root - On Quest \'Corrupted Night Dragon\' Finished - Set Lootstate Deactivated'),
(174606, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Whipper Root - On Quest Finished - Despawn Instant'),

(174607, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 0, 50, 174625, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject'),
(174607, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Whipper Root - On Quest \'Corrupted Night Dragon\' Finished - Set Lootstate Deactivated'),
(174607, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Whipper Root - On Quest Finished - Despawn Instant'),

(174686, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 0, 50, 174687, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject'),
(174686, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Whipper Root - On Quest \'Corrupted Night Dragon\' Finished - Set Lootstate Deactivated'),
(174686, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Whipper Root - On Quest Finished - Despawn Instant');

-- Cleansed Whipper Root
UPDATE `gameobject_template` SET `Data3` = 1 , `Data5` = 1, `AIName` = 'SmartGameObjectAI' WHERE (`entry` IN (164883, 174622, 174623, 174624, 174625, 174687));
-- Spawns of cleansed items must be deleted to be fixed
DELETE FROM `gameobject` WHERE (`id` IN (164883, 174622, 174623, 174624, 174625, 174687)); 

-- Corrupted windblossom
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` IN (164887, 173327, 174599, 174600, 174601, 174602, 174603, 174604, 174708, 174709);
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (164887, 173327, 174599, 174600, 174601, 174602, 174603, 174604, 174708, 174709)) AND (`source_type` = 1);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES

(164887, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 0, 50, 164884, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject'),
(164887, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Windblossom - On Quest \'Corrupted Windblossom\' Finished - Set Lootstate Deactivated'),
(164887, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Windblossom - On Quest Finished - Despawn Instant'),

(173327, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 0, 50, 173326, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject'),
(173327, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Windblossom - On Quest \'Corrupted Windblossom\' Finished - Set Lootstate Deactivated'),
(173327, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Windblossom - On Quest Finished - Despawn Instant'),

(174599, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 0, 50, 174616, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject'),
(174599, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Windblossom - On Quest \'Corrupted Windblossom\' Finished - Set Lootstate Deactivated'),
(174599, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Windblossom - On Quest Finished - Despawn Instant'),

(174600, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 0, 50, 174617, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject'),
(174600, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Windblossom - On Quest \'Corrupted Windblossom\' Finished - Set Lootstate Deactivated'),
(174600, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Windblossom - On Quest Finished - Despawn Instant'),

(174601, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 0, 50, 174618, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject'),
(174601, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Windblossom - On Quest \'Corrupted Windblossom\' Finished - Set Lootstate Deactivated'),
(174601, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Windblossom - On Quest Finished - Despawn Instant'),

(174602, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 0, 50, 174619, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject'),
(174602, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Windblossom - On Quest \'Corrupted Windblossom\' Finished - Set Lootstate Deactivated'),
(174602, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Windblossom - On Quest Finished - Despawn Instant'),

(174603, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 0, 50, 174620, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject'),
(174603, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Windblossom - On Quest \'Corrupted Windblossom\' Finished - Set Lootstate Deactivated'),
(174603, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Windblossom - On Quest Finished - Despawn Instant'),

(174604, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 0, 50, 174621, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject'),
(174604, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Windblossom - On Quest \'Corrupted Windblossom\' Finished - Set Lootstate Deactivated'),
(174604, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Windblossom - On Quest Finished - Despawn Instant'),

(174708, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 0, 50, 174710, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject'),
(174708, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Windblossom - On Quest \'Corrupted Windblossom\' Finished - Set Lootstate Deactivated'),
(174708, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Windblossom - On Quest Finished - Despawn Instant'),

(174709, 1, 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 0, 50, 174711, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Summon Gameobject'),
(174709, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Windblossom - On Quest \'Corrupted Windblossom\' Finished - Set Lootstate Deactivated'),
(174709, 1, 2, 0, 20, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Windblossom - On Quest Finished - Despawn Instant');

-- Cleansed windblossom
UPDATE `gameobject_template` SET `Data3` = 1, `Data5` = 1, `AIName` = 'SmartGameObjectAI' WHERE (`entry` IN (164884, 173326, 174616, 174617, 174618, 174619, 174620, 174621, 174710, 174711));
-- Spawns of cleansed items must be deleted to be fixed
DELETE FROM `gameobject` WHERE (`id` IN (164884, 173326, 174616, 174617, 174618, 174619, 174620, 174621, 174710, 174711)); 


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_06_09' WHERE sql_rev = '1627813955000857700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
