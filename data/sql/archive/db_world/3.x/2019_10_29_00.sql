-- DB update 2019_10_27_00 -> 2019_10_29_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_10_27_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_10_27_00 2019_10_29_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1571293310924626365'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1571293310924626365');

-- Astor Hadren: Use "root" instead of pause waypoint movement
DELETE FROM `smart_scripts` WHERE `entryorguid` = 6497 AND `source_type` = 0 AND `id` BETWEEN 5 AND 7;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(6497,0,5,6,64,0,100,0,0,0,0,0,0,103,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Astor Hadren - On Gossip Hello - Set Root On'),
(6497,0,6,0,61,0,100,0,0,0,0,0,0,67,1,15000,15000,0,0,0,1,0,0,0,0,0,0,0,0,'Astor Hadren - Linked - Create Timed Event ID 1'),
(6497,0,7,0,59,0,100,0,1,0,0,0,0,103,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Astor Hadren - On Timed Event ID 1 - Set Root Off');

-- Nurse Judith: Pause waypoint on "Gossip Hello" not necessary, as this NPC does not have gossip options
DELETE FROM `smart_scripts` WHERE `entryorguid` = 19455 AND `source_type` = 0 AND `id` = 1;

-- Consortium Nether Runner: Pause waypoint on "Gossip Hello" not necessary, as this NPC does not have gossip options
DELETE FROM `smart_scripts` WHERE `entryorguid` = 19667 AND `source_type` = 0 AND `id` = 1;

-- Experimental Pilot: Pause waypoint on "Gossip Hello" not necessary, as this NPC does not have gossip options
DELETE FROM `smart_scripts` WHERE `entryorguid` = 19776 AND `source_type` = 0 AND `id` = 1;

-- Grom'tor: Use "root" instead of pause waypoint movement; cleanup comments
DELETE FROM `smart_scripts` WHERE `entryorguid` = 21291 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(21291,0,0,0,11,0,100,0,0,0,0,0,0,53,0,21291,1,0,0,0,1,0,0,0,0,0,0,0,0,'Grom''tor, Son of Oronok - On Respawn - Start Waypoint Movement'),
(21291,0,1,0,1,0,100,0,10000,30000,240000,240000,0,80,2129100,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Grom''tor, Son of Oronok - OOC - Call Action List'),
(21291,0,2,3,64,0,100,0,0,0,0,0,0,103,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Grom''tor, Son of Oronok - On Gossip Hello - Set Root On'),
(21291,0,3,0,61,0,100,0,0,0,0,0,0,67,1,20000,20000,0,0,0,1,0,0,0,0,0,0,0,0,'Grom''tor, Son of Oronok - Linked - Create Timed Event ID 1'),
(21291,0,4,0,59,0,100,0,1,0,0,0,0,103,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Grom''tor, Son of Oronok - On Timed Event ID 1 - Set Root Off');

-- Mordenai: Use "root" instead of pause waypoint movement
DELETE FROM `smart_scripts` WHERE `entryorguid` = 22113 AND `source_type` = 0 AND `id` IN (1,9,10);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(22113,0,1,9,64,0,100,0,0,0,0,0,0,103,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mordenai - On Gossip Hello - Set Root On'),
(22113,0,9,0,61,0,100,0,0,0,0,0,0,67,1,180000,180000,0,0,0,1,0,0,0,0,0,0,0,0,'Mordenai - Linked - Create Timed Event ID 1'),
(22113,0,10,0,59,0,100,0,1,0,0,0,0,103,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mordenai - On Timed Event ID 1 - Set Root Off');

-- Armorer Orkuruk: Set gossip flag in order to be able to run SAI on "Gossip Hello"; use "root" instead of pause waypoint movement
UPDATE `creature_template` SET `npcflag` = `npcflag` | 1 WHERE `entry` = 25274;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 25274 AND `source_type` = 0 AND `id` IN (1,6,7);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(25274,0,1,6,64,0,100,0,0,0,0,0,0,103,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Armorer Orkuruk - On Gossip Hello - Set Root On'),
(25274,0,6,0,61,0,100,0,0,0,0,0,0,67,1,180000,180000,0,0,0,1,0,0,0,0,0,0,0,0,'Armorer Orkuruk - Linked - Create Timed Event ID 1'),
(25274,0,7,0,59,0,100,0,1,0,0,0,0,103,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Armorer Orkuruk - On Timed Event ID 1 - Set Root Off');

-- Librarian Hamilton: Pause waypoint on "Gossip Hello" not necessary, as this NPC mostly stands in one place (and it was not working anyway, as the gossip flag is missing)
DELETE FROM `smart_scripts` WHERE `entryorguid` = 27141 AND `source_type` = 0 AND `id` = 1;

-- Initiate Greer: Pause waypoint on "Gossip Hello" not necessary, as this NPC does not have gossip options
DELETE FROM `smart_scripts` WHERE `entryorguid` = 27299 AND `source_type` = 0 AND `id` = 1;

-- Apprentice Trotter: Pause waypoint on "Gossip Hello" not necessary, as this NPC does not have gossip options
DELETE FROM `smart_scripts` WHERE `entryorguid` = 27301 AND `source_type` = 0 AND `id` = 1;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
