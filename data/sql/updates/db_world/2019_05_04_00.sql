-- DB update 2019_05_03_00 -> 2019_05_04_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_05_03_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_05_03_00 2019_05_04_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1556033308686302400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1556033308686302400');

DELETE FROM `creature_equip_template` WHERE `CreatureID`=17701 AND `ID`=1;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES (17701, 1, 14882, 0, 0, 0);

-- Creating a new SmartAI script for [Creature] ENTRY 17333 (name: Wrathscale Screamer)

-- Table creature_template
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17333;

-- Table smart_scripts
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17333);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17333, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 8000, 8000, 11, 31295, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wrathscale Screamer - In Combat - Cast \'31295\'');


-- Creating a new SmartAI script for [Creature] ENTRY 17331 (name: Wrathscale Shorestalker)

-- Table creature_template
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17331;

-- Table smart_scripts
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17331);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17331, 0, 0, 0, 0, 0, 100, 0, 2500, 2500, 7400, 7400, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wrathscale Shorestalker - In Combat - Cast \'11976\'');


-- Creating a new SmartAI script for [Creature] ENTRY 17349 (name: Blue Flutterer)

-- Table creature_template
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17349;

-- Table smart_scripts
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17349);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17349, 0, 0, 0, 0, 0, 100, 0, 1500, 1500, 10500, 10500, 11, 36332, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blue Flutterer - In Combat - Cast \'36332\'');

-- Creating a new SmartAI script for [Creature] ENTRY 17327 (name: Blacksilt Tidecaller)

-- Table creature_template
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17327;

-- Table smart_scripts
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17327);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17327, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 15000, 15000, 11, 12550, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blacksilt Tidecaller - In Combat - Cast \'12550\''),
(17327, 0, 1, 0, 0, 0, 100, 0, 5300, 5300, 19600, 19600, 11, 12160, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blacksilt Tidecaller - In Combat - Cast \'12160\'');


-- Creating a new SmartAI script for [Creature] ENTRY 17343 (name: Thistle Lasher)

-- Table creature_template
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17343;

-- Table smart_scripts
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17343);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17343, 0, 0, 0, 0, 0, 100, 0, 1800, 1800, 20600, 20600, 11, 31286, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Thistle Lasher - In Combat - Cast \'31286\'');

-- Thistle Lasher: Link "Dropped Weapon" to "Lash" (otherwise it is not cast on the player)
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 31286 AND `spell_effect` = 6608;
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES (31286,6608,1,'Lash: Cast ''Dropped Weapon'' (6608) on hit on the same target');

-- Creating a new SmartAI script for [Creature] ENTRY 17352 (name: Corrupted Treant)

-- Table creature_template
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17352;

-- Table smart_scripts
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17352);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17352, 0, 0, 0, 0, 0, 100, 0, 3250, 3250, 10270, 10270, 11, 5810, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Treant - In Combat - Cast \'5810\'');


-- Creating a new SmartAI script for [Creature] ENTRY 17527 (name: Enraged Ravager)

-- Table creature_template
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17527;

-- Table smart_scripts
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17527);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17527, 0, 0, 0, 0, 0, 100, 0, 5000, 5000, 25000, 25000, 11, 3242, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Enraged Ravager - In Combat - Cast \'3242\''),
(17527, 0, 1, 0, 2, 0, 100, 0, 0, 30, 0, 0, 11, 15716, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Enraged Ravager - Between 0-30% Health - Cast \'15716\'');


-- Creating a new SmartAI script for [Creature] ENTRY 17346 (name: Mutated Tangler)

-- Table creature_template
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17346;

-- Table smart_scripts
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17346);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17346, 0, 0, 0, 0, 0, 100, 0, 2500, 2500, 11720, 11720, 11, 31287, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mutated Tangler - In Combat - Cast \'31287\'');

-- Creating a new SmartAI script for [Creature] ENTRY 17353 (name: Corrupted Stomper)

-- Table creature_template
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17353;

-- Table smart_scripts
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17353);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17353, 0, 0, 0, 0, 0, 100, 0, 2500, 2500, 8900, 8900, 11, 31277, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Stomper - In Combat - Cast \'31277\'');


-- Creating a new SmartAI script for [Creature] ENTRY 17358 (name: Fouled Water Spirit)

-- Table creature_template
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17358;

-- Table smart_scripts
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17358);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17358, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 121000, 121000, 11, 31280, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fouled Water Spirit - In Combat - Cast \'31280\''),
(17358, 0, 1, 0, 0, 0, 100, 0, 3100, 3100, 9600, 9600, 11, 31281, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fouled Water Spirit - In Combat - Cast \'31281\'');


-- Creating a new SmartAI script for [Creature] ENTRY 17522 (name: Myst Spinner)

-- Table creature_template
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17522;

-- Table smart_scripts
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17522);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17522, 0, 0, 0, 0, 0, 100, 0, 4500, 4500, 12800, 12800, 11, 745, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Myst Spinner - In Combat - Cast \'745\'');


-- Creating a new SmartAI script for [Creature] ENTRY 17523 (name: Myst Leecher)

-- Table creature_template
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17523;

-- Table smart_scripts
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17523);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17523, 0, 0, 0, 0, 0, 100, 0, 1500, 1500, 33000, 33000, 11, 31288, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Myst Leecher - In Combat - Cast \'31288\'');


-- Creating a new SmartAI script for [Creature] ENTRY 17608 (name: Sunhawk Pyromancer)

-- Table creature_template
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17608;

-- Table smart_scripts
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17608);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17608, 0, 0, 0, 26, 0, 100, 1, 0, 10, 0, 1, 11, 31734, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Pyromancer - In Combat LOS 10 yards - Cast \'31734\' (No Repeat)'),
(17608, 0, 1, 0, 0, 0, 100, 0, 1500, 1500, 25700, 25700, 11, 11962, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Pyromancer - In Combat - Cast \'11962\''),
(17608, 0, 2, 0, 0, 0, 100, 0, 5200, 5200, 9900, 9900, 11, 9053, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Pyromancer - In Combat - Cast \'9053\'');


-- Creating a new SmartAI script for [Creature] ENTRY 17607 (name: Sunhawk Defender)

-- Table creature_template
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17607;

-- Table smart_scripts
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17607);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17607, 0, 0, 0, 26, 0, 100, 1, 0, 10, 0, 1, 11, 31734, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Pyromancer - In Combat LOS 10 yards - Cast \'31734\' (No Repeat)'),
(17607, 0, 1, 0, 0, 0, 100, 0, 3200, 3200, 15400, 15400, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Defender - In Combat - Cast \'15284\''),
(17607, 0, 2, 0, 0, 0, 100, 0, 8600, 8600, 34200, 34200, 11, 31737, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Defender - In Combat - Cast \'31737\'');


-- Creating a new SmartAI script for [Creature] ENTRY 17610 (name: Sunhawk Agent)

-- Table creature_template
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17610;

-- Table smart_scripts
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17610);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17610, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 5916, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Agent - On Reset - Cast \'5916\''),
(17610, 0, 1, 0, 0, 0, 100, 0, 2500, 2500, 8900, 8900, 11, 14873, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Agent - In Combat - Cast \'14873\''),
(17610, 0, 2, 0, 0, 0, 100, 0, 12850, 12850, 35700, 35700, 11, 7159, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Agent - In Combat - Cast \'7159\''),
(17610, 0, 3, 0, 0, 0, 100, 0, 15000, 15000, 87000, 87000, 11, 15691, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Agent - In Combat - Cast \'15691\'');


-- Creating a new SmartAI script for [Creature] ENTRY 17609 (name: Sunhawk Saboteur)

-- Table creature_template
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17609;

-- Table smart_scripts
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17609);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17609, 0, 0, 0, 26, 0, 100, 1, 0, 10, 0, 1, 11, 31734, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Pyromancer - In Combat LOS 10 yards - Cast \'31734\' (No Repeat)'),
(17609, 0, 1, 0, 0, 0, 100, 0, 1000, 1000, 6200, 6200, 11, 6660, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Saboteur - In Combat - Cast \'6660\''),
(17609, 0, 2, 0, 0, 0, 100, 0, 11750, 11750, 32400, 32400, 11, 14443, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Saboteur - In Combat - Cast \'14443\''),
(17609, 0, 3, 0, 9, 0, 100, 0, 4, 30, 1, 1, 79, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Saboteur - Within 4-30 Range - Set Ranged Movement'),
(17609, 0, 4, 0, 9, 0, 100, 0, 0, 4, 1, 1, 79, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Saboteur - Within 0-4 Range - Set Ranged Movement');


-- Creating a new SmartAI script for [Creature] ENTRY 17713 (name: Bloodcursed Naga)

-- Table creature_template
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17713;

-- Table smart_scripts
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17713);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17713, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 12544, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bloodcursed Naga - On Reset - Cast \'12544\''),
(17713, 0, 1, 0, 0, 0, 100, 0, 2500, 2500, 6700, 6700, 11, 20792, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodcursed Naga - In Combat - Cast \'20792\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
