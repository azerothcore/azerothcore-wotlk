-- DB update 2020_01_09_00 -> 2020_01_11_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_01_09_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_01_09_00 2020_01_11_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1577618082185968188'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1577618082185968188');

-- Loramus Thalipedes: Add SAI and gossip menus as replacement for the CreatureScript "npc_loramus_thalipedes"
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 7783;

DELETE FROM `gossip_menu` WHERE `MenuID` IN (1212,1213,1214,1215,1216,1217);
INSERT INTO `gossip_menu` (`MenuID`,`TextID`) VALUES
(1212,1812),
(1213,1813),
(1214,1814),
(1215,1815),
(1216,1816),
(1217,1817);

DELETE FROM `smart_scripts` WHERE `entryorguid` = 7783 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(7783,0,0,1,62,0,100,0,1212,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Loramus Thalipedes - On Gossip Selected - Close Gossip'),
(7783,0,1,0,61,0,100,0,0,0,0,0,0,15,2744,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Loramus Thalipedes - Linked - Complete Quest ''The Demon Hunter'''),
(7783,0,2,3,62,0,100,0,1217,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Loramus Thalipedes - On Gossip Selected - Close Gossip'),
(7783,0,3,0,61,0,100,0,0,0,0,0,0,15,3141,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Loramus Thalipedes - Linked - Complete Quest ''Loramus'''),
(7783,0,4,0,19,0,100,0,3602,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Loramus Thalipedes - On Quest ''Azsharite'' Accepted - Say Line 0');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 11487 AND `SourceEntry` IN (0,1);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
(15,11487,0,0,0,9,0,2744,0,0,0,0,0,'','Only show gossip option if quest ''The Demon Hunter'' has been accepted.'),
(15,11487,1,0,0,9,0,3141,0,0,0,0,0,'','Only show gossip option if quest ''Loramus'' has been accepted.');

-- Felhound Tracker Kit: Ensure that it always contains "Fel Orb" and "Fel Tracker Owner's Manual", no other items
DELETE FROM `item_loot_template` WHERE `Entry` = 10834;
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
VALUES
(10834,10831,0,100,0,1,0,1,1,NULL),
(10834,10832,0,100,0,1,0,1,1,NULL);

-- Azsharite Formation: Ensure that only formations which have a humanoid form can contain a "Crystallized Note"
DELETE FROM `gameobject_loot_template` WHERE `Entry` = 9676 AND `Item` IN (10839,10840);

-- Felhound Tracker: Disable combat with players / NPCs
UPDATE `creature_template` SET `AIName` = 'SmartAI', `unit_flags` = `unit_flags` | 256 | 512 WHERE `entry` = 8668;

-- Felhound Tracker SAI
DELETE FROM `smart_scripts` WHERE `entryorguid` = 8668 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (866800,866801) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(8668,0,0,0,11,0,100,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Felhound Tracker - On Respawn - Set Phase 1'),
(8668,0,1,0,22,1,100,0,75,500,500,0,0,80,866800,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Felhound Tracker - On Receive Emote ''ROAR'' (Phase 1) - Call Action List'),
(8668,0,2,3,1,2,100,0,5000,5000,5000,5000,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Felhound Tracker - OOC (Phase 2) - Set Phase 1'),
(8668,0,3,0,61,0,100,0,1,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Felhound Tracker - Linked - Say Line 1'),
(8668,0,4,5,38,2,100,0,1,1,500,500,0,29,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Felhound Tracker - On Data Set 1 1 (Phase 2) - Stop Following'),
(8668,0,5,12,61,0,100,0,0,0,0,0,0,69,1,0,0,1,0,0,12,1,0,0,0,0,0,0,0,'Felhound Tracker - Linked - Move To Pos 1 (Stored Target ID 1)'),
(8668,0,6,7,38,2,100,0,1,2,500,500,0,29,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Felhound Tracker - On Data Set 1 2 (Phase 2) - Stop Following'),
(8668,0,7,12,61,0,100,0,0,0,0,0,0,69,1,0,0,1,0,0,12,2,0,0,0,0,0,0,0,'Felhound Tracker - Linked - Move To Pos 1 (Stored Target ID 2)'),
(8668,0,8,9,38,2,100,0,1,3,500,500,0,29,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Felhound Tracker - On Data Set 1 3 (Phase 2) - Stop Following'),
(8668,0,9,12,61,0,100,0,0,0,0,0,0,69,1,0,0,1,0,0,12,3,0,0,0,0,0,0,0,'Felhound Tracker - Linked - Move To Pos 1 (Stored Target ID 3)'),
(8668,0,10,11,38,2,100,0,1,4,500,500,0,29,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Felhound Tracker - On Data Set 1 4 (Phase 2) - Stop Following'),
(8668,0,11,12,61,0,100,0,0,0,0,0,0,69,1,0,0,1,0,0,12,4,0,0,0,0,0,0,0,'Felhound Tracker - Linked - Move To Pos 1 (Stored Target ID 4)'),
(8668,0,12,13,61,0,100,0,0,0,0,0,0,22,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Felhound Tracker - Linked - Set Phase 3'),
(8668,0,13,0,61,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Felhound Tracker - Linked - Say Line 0'),
(8668,0,14,0,34,0,100,0,0,1,0,0,0,80,866801,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Felhound Tracker - On WP 1 Reached - Call Action List'),

(866800,9,0,0,0,0,100,0,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Felhound Tracker - On Script - Set Phase 2'),
(866800,9,1,0,0,0,100,0,0,0,0,0,0,64,1,0,0,0,0,0,20,152620,90,0,0,0,0,0,0,'Felhound Tracker - On Script - Store Target ID 1 (Azsharite Formation)'),
(866800,9,2,0,0,0,100,0,0,0,0,0,0,64,2,0,0,0,0,0,20,152621,90,0,0,0,0,0,0,'Felhound Tracker - On Script - Store Target ID 2 (Azsharite Formation)'),
(866800,9,3,0,0,0,100,0,0,0,0,0,0,64,3,0,0,0,0,0,20,152622,90,0,0,0,0,0,0,'Felhound Tracker - On Script - Store Target ID 3 (Azsharite Formation)'),
(866800,9,4,0,0,0,100,0,0,0,0,0,0,64,4,0,0,0,0,0,20,152631,90,0,0,0,0,0,0,'Felhound Tracker - On Script - Store Target ID 4 (Azsharite Formation)'),
(866800,9,5,0,0,0,100,0,0,0,0,0,0,45,1,1,0,0,0,0,12,1,0,0,0,0,0,0,0,'Felhound Tracker - On Script - Set Data 1 1 (Stored Target ID 1)'),
(866800,9,6,0,0,0,100,0,0,0,0,0,0,45,1,1,0,0,0,0,12,2,0,0,0,0,0,0,0,'Felhound Tracker - On Script - Set Data 1 1 (Stored Target ID 2)'),
(866800,9,7,0,0,0,100,0,0,0,0,0,0,45,1,1,0,0,0,0,12,3,0,0,0,0,0,0,0,'Felhound Tracker - On Script - Set Data 1 1 (Stored Target ID 3)'),
(866800,9,8,0,0,0,100,0,0,0,0,0,0,45,1,1,0,0,0,0,12,4,0,0,0,0,0,0,0,'Felhound Tracker - On Script - Set Data 1 1 (Stored Target ID 4)'),

(866801,9,0,0,0,0,100,0,3000,3000,0,0,0,29,1,90,0,0,0,0,23,0,0,0,0,0,0,0,0,'Felhound Tracker - On Script - Follow Summoner'),
(866801,9,1,0,0,0,100,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Felhound Tracker - On Script - Set Phase 1');

-- Azsharite Formation SAI
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` IN (152620,152621,152622,152631);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (152620,152621,152622,152631) AND `source_type` = 1;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 15262000 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(152620,1,0,0,11,0,100,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Azsharite Formation - On Respawn - Set Phase 1'),
(152620,1,1,0,38,1,100,0,1,1,0,0,0,45,1,1,0,0,0,0,11,8668,90,1,0,0,0,0,0,'Azsharite Formation - On Data Set 1 1 (Phase 1) - Set Data 1 1 (Felhound Tracker)'),
(152620,1,2,0,70,0,100,0,3,0,0,0,0,80,15262000,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Azsharite Formation - On Gameobject State Changed - Call Action List'),

(152621,1,0,0,11,0,100,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Azsharite Formation - On Respawn - Set Phase 1'),
(152621,1,1,0,38,1,100,0,1,1,0,0,0,45,1,2,0,0,0,0,11,8668,90,1,0,0,0,0,0,'Azsharite Formation - On Data Set 1 1 (Phase 1) - Set Data 1 2 (Felhound Tracker)'),
(152621,1,2,0,70,0,100,0,3,0,0,0,0,80,15262000,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Azsharite Formation - On Gameobject State Changed - Call Action List'),

(152622,1,0,0,11,0,100,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Azsharite Formation - On Respawn - Set Phase 1'),
(152622,1,1,0,38,1,100,0,1,1,0,0,0,45,1,3,0,0,0,0,11,8668,90,1,0,0,0,0,0,'Azsharite Formation - On Data Set 1 1 (Phase 1) - Set Data 1 3 (Felhound Tracker)'),
(152622,1,2,0,70,0,100,0,3,0,0,0,0,80,15262000,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Azsharite Formation - On Gameobject State Changed - Call Action List'),

(152631,1,0,0,11,0,100,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Azsharite Formation - On Respawn - Set Phase 1'),
(152631,1,1,0,38,1,100,0,1,1,0,0,0,45,1,4,0,0,0,0,11,8668,90,1,0,0,0,0,0,'Azsharite Formation - On Data Set 1 1 (Phase 1) - Set Data 1 4 (Felhound Tracker)'),
(152631,1,2,0,70,0,100,0,3,0,0,0,0,80,15262000,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Azsharite Formation - On Gameobject State Changed - Call Action List'),

(15262000,9,0,0,0,0,100,0,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Azsharite Formation - On Script - Set Phase 2'),
(15262000,9,1,0,0,0,100,0,180000,180000,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Azsharite Formation - On Script - Set Phase 1');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
