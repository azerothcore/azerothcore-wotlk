-- DB update 2020_06_21_00 -> 2020_06_23_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_06_21_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_06_21_00 2020_06_23_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1589121527805378200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1589121527805378200');
/*
 * Zone: Winterspring
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7434;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7434);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7434, 0, 0, 0, 0, 0, 100, 0, 1500, 2500, 16500, 18500, 11, 36590, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Frostsaber Pride Watcher - In Combat - Cast \'36590\''),
(7434, 0, 1, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 15716, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frostsaber Pride Watcher - Between 5-30% Health - Cast \'15716\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7433;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7433);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7433, 0, 0, 0, 0, 0, 100, 0, 1000, 2000, 16000, 18000, 11, 13443, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Frostsaber Huntress - In Combat - Cast \'13443\''),
(7433, 0, 1, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 15716, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frostsaber Huntress - Between 5-30% Health - Cast \'15716\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7432;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7432);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7432, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, 30991, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frostsaber Stalker - On Respawn - Cast \'30991\''),
(7432, 0, 1, 0, 1, 0, 100, 0, 1200, 1400, 0, 0, 11, 30991, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frostsaber Stalker - Out of Combat - Cast \'30991\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7431;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7431);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7431, 0, 0, 0, 0, 0, 100, 0, 1500, 2000, 10000, 11000, 11, 24331, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Frostsaber - In Combat - Cast \'24331\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7430;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7430);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7430, 0, 0, 0, 0, 0, 100, 0, 1500, 2000, 10000, 11000, 11, 24331, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Frostsaber Cub - In Combat - Cast \'24331\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10738;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10738);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10738, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, 17205, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Chief Winterfall - On Respawn - Cast \'17205\''),
(10738, 0, 1, 0, 0, 0, 100, 0, 1200, 1400, 8600, 8900, 11, 15793, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'High Chief Winterfall - In Combat - Cast \'15793\''),
(10738, 0, 2, 0, 0, 0, 100, 0, 6500, 7000, 14200, 16800, 11, 12548, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'High Chief Winterfall - In Combat - Cast \'12548\''),
(10738, 0, 3, 0, 0, 0, 100, 0, 9400, 9900, 24300, 24900, 11, 8364, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'High Chief Winterfall - In Combat - Cast \'8364\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7439;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7439);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7439, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, 17205, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Winterfall Shaman - On Respawn - Cast \'17205\''),
(7439, 0, 1, 0, 0, 0, 100, 0, 1000, 1500, 7500, 8000, 11, 9532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Winterfall Shaman - In Combat - Cast \'9532\''),
(7439, 0, 2, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 13585, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Winterfall Shaman - Between 30-60% Health - Cast \'13585\' (No Repeat)'),
(7439, 0, 3, 0, 2, 0, 100, 1, 10, 20, 0, 0, 11, 11431, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Winterfall Shaman - Between 10-20% Health - Cast \'11431\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7438;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7438);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7438, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, 17205, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Winterfall Ursa - On Respawn - Cast \'17205\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7459;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7459);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7459, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 6268, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ice Thistle Matriarch - On Aggro - Cast \'6268\''),
(7459, 0, 1, 0, 0, 0, 100, 0, 2700, 3400, 11900, 16000, 11, 15878, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ice Thistle Matriarch - In Combat - Cast \'15878\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7460;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7460);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7460, 0, 0, 0, 0, 0, 100, 0, 2100, 2700, 8400, 9300, 11, 3131, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ice Thistle Patriarch - In Combat - Cast \'3131\''),
(7460, 0, 1, 0, 0, 0, 100, 0, 11750, 14600, 21200, 24300, 11, 15878, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ice Thistle Patriarch - In Combat - Cast \'15878\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7449;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7449);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7449, 0, 0, 0, 0, 0, 100, 0, 4700, 5200, 17700, 19200, 11, 28547, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Chillwind Ravager - In Combat - Cast \'28547\''),
(7449, 0, 1, 0, 2, 0, 100, 1, 5, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chillwind Ravager - Between 5-30% Health - Cast \'8599\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7462;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7462);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7462, 0, 0, 0, 0, 0, 100, 0, 1400, 1900, 16500, 17400, 11, 13738, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hederine Manastalker - In Combat - Cast \'13738\''),
(7462, 0, 1, 0, 0, 0, 100, 0, 2400, 2600, 6200, 6400, 11, 15980, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hederine Manastalker - In Combat - Cast \'15980\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7461;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7461);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7461, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 37668, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hederine Initiate - On Aggro - Cast \'37668\''),
(7461, 0, 1, 0, 0, 0, 100, 0, 2600, 2900, 7200, 7400, 11, 12739, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hederine Initiate - In Combat - Cast \'12739\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7463;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7463);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7463, 0, 0, 0, 0, 0, 100, 0, 3700, 4200, 9600, 13900, 11, 17547, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hederine Slayer - In Combat - Cast \'17547\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7429;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7429);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7429, 0, 0, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 9616, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frostmaul Preserver - Between 30-60% Health - Cast \'9616\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7428;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7428);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7428, 0, 0, 0, 0, 0, 100, 0, 2700, 3400, 8500, 9900, 11, 18368, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Frostmaul Giant - In Combat - Cast \'18368\''),
(7428, 0, 1, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 18670, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Frostmaul Giant - Between 20-40% Health - Cast \'18670\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7454;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7454);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7454, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 5915, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Berserk Owlbeast - On Aggro - Cast \'5915\''),
(7454, 0, 1, 0, 0, 0, 100, 0, 4800, 5000, 25800, 26000, 11, 34971, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Berserk Owlbeast - In Combat - Cast \'34971\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7452;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7452);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7452, 0, 0, 0, 2, 0, 100, 0, 5, 30, 0, 0, 11, 15716, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crazed Owlbeast - Between 5-30% Health - Cast \'15716\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10807;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10807);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10807, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 16552, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Brumeran - On Aggro - Cast \'16552\''),
(10807, 0, 1, 0, 0, 0, 100, 0, 2100, 2900, 8700, 9600, 11, 15797, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Brumeran - In Combat - Cast \'15797\''),
(10807, 0, 2, 0, 2, 0, 100, 0, 5, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Brumeran - Between 5-30% Health - Cast \'8599\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7456;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7456);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7456, 0, 0, 0, 0, 0, 100, 0, 3450, 4250, 12700, 13900, 11, 3589, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Winterspring Screecher - In Combat - Cast \'3589\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7437;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7437);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7437, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, 12544, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cobalt Mageweaver - On Respawn - Cast \'12544\''),
(7437, 0, 1, 0, 0, 0, 100, 0, 1700, 2300, 5600, 6100, 11, 15043, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cobalt Mageweaver - In Combat - Cast \'15043\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7436;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7436);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7436, 0, 0, 0, 0, 0, 100, 0, 1700, 1900, 16700, 16900, 11, 11977, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cobalt Scalebane - In Combat - Cast \'11977\''),
(7436, 0, 1, 0, 2, 0, 100, 1, 40, 70, 0, 0, 11, 15655, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cobalt Scalebane - Between 40-70% Health - Cast \'15655\' (No Repeat)'),
(7436, 0, 2, 0, 2, 0, 100, 1, 10, 20, 0, 0, 11, 6713, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cobalt Scalebane - Between 10-20% Health - Cast \'6713\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10659;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10659);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10659, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 15089, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cobalt Whelp - On Aggro - Cast \'15089\''),
(10659, 0, 1, 0, 0, 0, 100, 0, 2100, 2700, 17200, 17800, 11, 13443, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cobalt Whelp - In Combat - Cast \'13443\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10660;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10660);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10660, 0, 0, 0, 0, 0, 100, 0, 1700, 2300, 5800, 6900, 11, 9672, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cobalt Broodling - In Combat - Cast \'9672\''),
(10660, 0, 1, 0, 2, 0, 100, 1, 20, 60, 0, 0, 11, 29881, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cobalt Broodling - Between 20-60% Health - Cast \'29881\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10661;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10661);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10661, 0, 0, 0, 0, 0, 100, 0, 2400, 3500, 8600, 9700, 11, 16340, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Spell Eater - In Combat - Cast \'16340\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7435;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7435);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7435, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 9080, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cobalt Wyrmkin - On Aggro - Cast \'9080\''),
(7435, 0, 1, 0, 0, 0, 100, 0, 2450, 2650, 7600, 8700, 11, 15580, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cobalt Wyrmkin - In Combat - Cast \'15580\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7455;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7455);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7455, 0, 0, 0, 0, 0, 100, 0, 2300, 3400, 8600, 9500, 11, 16576, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Winterspring Owl - In Combat - Cast \'16576\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7448;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7448);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7448, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 15850, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Chillwind Chimaera - On Aggro - Cast \'15850\''),
(7448, 0, 1, 0, 0, 0, 100, 0, 2300, 2800, 8700, 8900, 11, 15797, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Chillwind Chimaera - In Combat - Cast \'15797\''),
(7448, 0, 2, 0, 2, 0, 100, 0, 15, 30, 0, 0, 11, 20005, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Chillwind Chimaera - Between 15-30% Health - Cast \'20005\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7447;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7447);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7447, 0, 0, 0, 0, 0, 100, 0, 1400, 1600, 11400, 11600, 11, 16552, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fledgling Chillwind - In Combat - Cast \'16552\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7450;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7450);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7450, 0, 0, 0, 0, 0, 100, 0, 2400, 2600, 17500, 17700, 11, 13738, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ragged Owlbeast - In Combat - Cast \'13738\''),
(7450, 0, 1, 0, 0, 0, 100, 1, 6500, 6600, 0, 0, 11, 15848, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ragged Owlbeast - In Combat - Cast \'15848\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7457;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7457);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7457, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 3604, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rogue Ice Thistle - On Aggro - Cast \'3604\''),
(7457, 0, 1, 0, 2, 0, 100, 1, 20, 60, 0, 0, 11, 15878, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rogue Ice Thistle - Between 20-60% Health - Cast \'15878\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7440;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7440);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7440, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, 17205, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Winterfall Den Watcher - On Respawn - Cast \'17205\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7442;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7442);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7442, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, 17205, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Winterfall Pathfinder - On Respawn - Cast \'17205\''),
(7442, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 16498, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Winterfall Pathfinder - On Aggro - Cast \'16498\''),
(7442, 0, 2, 0, 0, 0, 100, 0, 1000, 1100, 4500, 4600, 11, 6660, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Winterfall Pathfinder - In Combat - Cast \'6660\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7441;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7441);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7441, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, 17205, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Winterfall Totemic - On Respawn - Cast \'17205\''),
(7441, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 15786, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Winterfall Totemic - On Aggro - Cast \'15786\''),
(7441, 0, 2, 0, 0, 0, 100, 0, 2500, 3000, 7500, 8000, 11, 15787, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Winterfall Totemic - In Combat - Cast \'15787\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10916;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10916);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10916, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, 17205, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Winterfall Runner - On Respawn - Cast \'17205\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
