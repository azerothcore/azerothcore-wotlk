-- DB update 2021_06_04_00 -> 2021_06_04_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_04_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_04_00 2021_06_04_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1622406071663809300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622406071663809300');

SET @PORT0 = 177243;
SET @PORT1 = 177365;
SET @PORT2 = 177366;
SET @PORT3 = 177367;
SET @PORT4 = 177368;
SET @PORT5 = 177369;
SET @PORT6 = 177397;
SET @PORT7 = 177398;
SET @PORT8 = 177399;
SET @PORT9 = 177400;

-- Set autodespawn after two minutes after activating if the guardian isn't killed
UPDATE `gameobject_template` SET `Data3` = 120000, `Data5` = 1 WHERE `entry` IN (@PORT0,@PORT1,@PORT2,@PORT3,@PORT4,@PORT5,@PORT6,@PORT7,@PORT8,@PORT9);

-- Convert and improve Demon Portal C++ script to SAI
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI', `ScriptName` = '' WHERE `entry` IN (@PORT0,@PORT1,@PORT2,@PORT3,@PORT4,@PORT5,@PORT6,@PORT7,@PORT8,@PORT9);

DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (@PORT0,@PORT1,@PORT2,@PORT3,@PORT4,@PORT5,@PORT6,@PORT7,@PORT8,@PORT9)) AND (`source_type` = 1) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@PORT0, 1, 0, 1, 70, 0, 100, 1, 2, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demon Portal - On Use - Store Targetlist'),
(@PORT0, 1, 1, 2, 61, 0, 100, 0, 5581, 0, 0, 0, 0, 12, 11937, 3, 120000, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demon Portal - On Use - Summon Creature \'Demon Portal Guardian\''),
(@PORT0, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 9, 11937, 0, 20, 1, 0, 0, 0, 0, 'Demon Portal - On Use - Send Targetlist to \'Demon Portal Guardian\''),
(@PORT1, 1, 0, 1, 70, 0, 100, 1, 2, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demon Portal - On Use - Store Targetlist'),
(@PORT1, 1, 1, 2, 61, 0, 100, 0, 5581, 0, 0, 0, 0, 12, 11937, 3, 120000, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demon Portal - On Use - Summon Creature \'Demon Portal Guardian\''),
(@PORT1, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 9, 11937, 0, 20, 1, 0, 0, 0, 0, 'Demon Portal - On Use - Send Targetlist to \'Demon Portal Guardian\''),
(@PORT2, 1, 0, 1, 70, 0, 100, 1, 2, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demon Portal - On Use - Store Targetlist'),
(@PORT2, 1, 1, 2, 61, 0, 100, 0, 5581, 0, 0, 0, 0, 12, 11937, 3, 120000, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demon Portal - On Use - Summon Creature \'Demon Portal Guardian\''),
(@PORT2, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 9, 11937, 0, 20, 1, 0, 0, 0, 0, 'Demon Portal - On Use - Send Targetlist to \'Demon Portal Guardian\''),
(@PORT3, 1, 0, 1, 70, 0, 100, 1, 2, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demon Portal - On Use - Store Targetlist'),
(@PORT3, 1, 1, 2, 61, 0, 100, 0, 5581, 0, 0, 0, 0, 12, 11937, 3, 120000, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demon Portal - On Use - Summon Creature \'Demon Portal Guardian\''),
(@PORT3, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 9, 11937, 0, 20, 1, 0, 0, 0, 0, 'Demon Portal - On Use - Send Targetlist to \'Demon Portal Guardian\''),
(@PORT4, 1, 0, 1, 70, 0, 100, 1, 2, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demon Portal - On Use - Store Targetlist'),
(@PORT4, 1, 1, 2, 61, 0, 100, 0, 5581, 0, 0, 0, 0, 12, 11937, 3, 120000, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demon Portal - On Use - Summon Creature \'Demon Portal Guardian\''),
(@PORT4, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 9, 11937, 0, 20, 1, 0, 0, 0, 0, 'Demon Portal - On Use - Send Targetlist to \'Demon Portal Guardian\''),
(@PORT5, 1, 0, 1, 70, 0, 100, 1, 2, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demon Portal - On Use - Store Targetlist'),
(@PORT5, 1, 1, 2, 61, 0, 100, 0, 5581, 0, 0, 0, 0, 12, 11937, 3, 120000, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demon Portal - On Use - Summon Creature \'Demon Portal Guardian\''),
(@PORT5, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 9, 11937, 0, 20, 1, 0, 0, 0, 0, 'Demon Portal - On Use - Send Targetlist to \'Demon Portal Guardian\''),
(@PORT6, 1, 0, 1, 70, 0, 100, 1, 2, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demon Portal - On Use - Store Targetlist'),
(@PORT6, 1, 1, 2, 61, 0, 100, 0, 5581, 0, 0, 0, 0, 12, 11937, 3, 120000, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demon Portal - On Use - Summon Creature \'Demon Portal Guardian\''),
(@PORT6, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 9, 11937, 0, 20, 1, 0, 0, 0, 0, 'Demon Portal - On Use - Send Targetlist to \'Demon Portal Guardian\''),
(@PORT7, 1, 0, 1, 70, 0, 100, 1, 2, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demon Portal - On Use - Store Targetlist'),
(@PORT7, 1, 1, 2, 61, 0, 100, 0, 5581, 0, 0, 0, 0, 12, 11937, 3, 120000, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demon Portal - On Use - Summon Creature \'Demon Portal Guardian\''),
(@PORT7, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 9, 11937, 0, 20, 1, 0, 0, 0, 0, 'Demon Portal - On Use - Send Targetlist to \'Demon Portal Guardian\''),
(@PORT8, 1, 0, 1, 70, 0, 100, 1, 2, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demon Portal - On Use - Store Targetlist'),
(@PORT8, 1, 1, 2, 61, 0, 100, 0, 5581, 0, 0, 0, 0, 12, 11937, 3, 120000, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demon Portal - On Use - Summon Creature \'Demon Portal Guardian\''),
(@PORT8, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 9, 11937, 0, 20, 1, 0, 0, 0, 0, 'Demon Portal - On Use - Send Targetlist to \'Demon Portal Guardian\''),
(@PORT9, 1, 0, 1, 70, 0, 100, 1, 2, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demon Portal - On Use - Store Targetlist'),
(@PORT9, 1, 1, 2, 61, 0, 100, 0, 5581, 0, 0, 0, 0, 12, 11937, 3, 120000, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demon Portal - On Use - Summon Creature \'Demon Portal Guardian\''),
(@PORT9, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 9, 11937, 0, 20, 1, 0, 0, 0, 0, 'Demon Portal - On Use - Send Targetlist to \'Demon Portal Guardian\'');

-- Lower Demon Portal spawn time to 5 minutes
UPDATE `gameobject` SET `spawntimesecs` = 300 WHERE `id` IN (@PORT0,@PORT1,@PORT2,@PORT3,@PORT4,@PORT5,@PORT6,@PORT7,@PORT8,@PORT9);

-- Add SAI to Demon Portal Guardian
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11937;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 11937) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11937, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 49, 1, 1, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 0, 'Demon Portal Guardian - On Just Summoned - Attack Start'),
(11937, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Demon Portal Guardian - On Death - Set GO LootState');

-- Adjust POI points positions
DELETE FROM `quest_poi_points` WHERE `QuestID` = 5581 AND `Idx2` IN (1,2,3,4);
INSERT INTO `quest_poi_points` (`QuestID`, `Idx1`, `Idx2`, `X`, `Y`, `VerifiedBuild`) VALUES
(5581, 0, 1, -1689, 1733, 0),
(5581, 0, 2, -1752, 1998, 0),
(5581, 0, 3, -1986, 1944, 0),
(5581, 0, 4, -2068, 1845, 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_04_01' WHERE sql_rev = '1622406071663809300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
