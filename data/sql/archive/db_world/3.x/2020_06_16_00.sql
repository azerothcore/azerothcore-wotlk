-- DB update 2020_06_14_00 -> 2020_06_16_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_06_14_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_06_14_00 2020_06_16_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1588339999314521100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588339999314521100');

/*
 * Zone: Outland
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* RESPAWNS */
UPDATE `creature` SET `spawntimesecs` = 600 WHERE `id` IN (18695, 18697, 18694, 18686, 18678, 18692, 18680, 18690, 18685, 18683, 18682, 18681, 18689, 18698, 17144, 18696, 18677, 20932, 18693, 18679);


/* SMARTSCRIPTS */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18694;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18694);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18694, 0, 0, 0, 0, 0, 100, 0, 2000, 3000, 13000, 14000, 11, 36414, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Collidus the Warp-Watcher - In Combat - Cast \'36414\''),
(18694, 0, 1, 0, 2, 0, 100, 0, 0, 20, 0, 0, 11, 34322, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Collidus the Warp-Watcher - Between 0-20% Health - Cast \'34322\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18692;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18692);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18692, 0, 0, 0, 0, 0, 100, 0, 2000, 3000, 7500, 9000, 11, 9573, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hemathion - In Combat - Cast \'9573\''),
(18692, 0, 1, 0, 2, 0, 100, 0, 10, 20, 0, 0, 11, 14100, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hemathion - Between 10-20% Health - Cast \'14100\''),
(18692, 0, 2, 0, 2, 0, 100, 1, 0, 20, 0, 0, 11, 38895, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hemathion - Between 0-20% Health - Cast \'38895\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18680;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18680);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18680, 0, 0, 0, 0, 0, 100, 0, 2500, 3000, 8000, 8500, 11, 35493, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Marticar - In Combat - Cast \'35493\''),
(18680, 0, 1, 0, 2, 0, 100, 1, 0, 25, 0, 0, 11, 32039, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Marticar - Between 0-25% Health - Cast \'32039\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18690;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18690);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18690, 0, 0, 0, 0, 0, 100, 0, 1500, 2000, 6000, 8500, 11, 35238, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Morcrush - In Combat - Cast \'35238\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18682;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18682);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18682, 0, 0, 0, 0, 0, 100, 0, 2500, 3000, 7500, 9000, 11, 35238, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bog Lurker - In Combat - Cast \'35238\''),
(18682, 0, 1, 0, 2, 0, 100, 1, 0, 50, 0, 0, 11, 34163, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bog Lurker - Between 0-50% Health - Cast \'34163\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18681;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18681);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18681, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 11831, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Emissary - On Aggro - Cast \'11831\''),
(18681, 0, 1, 0, 0, 0, 100, 0, 4500, 6500, 14500, 17500, 11, 36990, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Emissary - In Combat - Cast \'36990\''),
(18681, 0, 2, 0, 2, 0, 100, 1, 45, 65, 0, 0, 11, 39207, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Emissary - Between 45-65% Health - Cast \'39207\' (No Repeat)'),
(18681, 0, 3, 0, 2, 0, 100, 1, 0, 10, 0, 0, 11, 46457, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Emissary - Between 0-10% Health - Cast \'46457\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18689;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18689);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18689, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 38882, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crippler - On Aggro - Cast \'38882\''),
(18689, 0, 1, 0, 0, 0, 100, 0, 4500, 5000, 14500, 19000, 11, 39214, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crippler - In Combat - Cast \'39214\''),
(18689, 0, 2, 0, 2, 0, 100, 1, 30, 60, 0, 0, 11, 38621, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crippler - Between 30-60% Health - Cast \'38621\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17144;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 17144);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17144, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 3604, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Goretooth - On Aggro - Cast \'3604\''),
(17144, 0, 1, 0, 0, 0, 100, 0, 1900, 2200, 17400, 18300, 11, 39215, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Goretooth - In Combat - Cast \'39215\''),
(17144, 0, 2, 0, 2, 0, 100, 1, 0, 25, 0, 0, 11, 38887, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Goretooth - Between 0-25% Health - Cast \'38887\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18677;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18677);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18677, 0, 0, 0, 0, 0, 100, 0, 3000, 3200, 7500, 8400, 11, 38875, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mekthorg the Wild - In Combat - Cast \'38875\''),
(18677, 0, 1, 0, 2, 0, 100, 1, 30, 40, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mekthorg the Wild - Between 30-40% Health - Cast \'8599\' (No Repeat)'),
(18677, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 11, 37704, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mekthorg the Wild - Between 0-15% Health - Cast \'37704\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20932;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20932);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20932, 0, 0, 0, 0, 0, 100, 0, 1700, 2600, 7800, 9100, 11, 15797, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nuramoc - In Combat - Cast \'15797\''),
(20932, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 21971, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nuramoc - Between 20-80% Health - Cast \'21971\' (No Repeat)'),
(20932, 0, 2, 0, 2, 0, 100, 1, 0, 20, 0, 0, 11, 38905, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nuramoc - Between 0-20% Health - Cast \'38905\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18693;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18693);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18693, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 37844, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Speaker Mar\'grom - On Aggro - Cast \'37844\''),
(18693, 0, 1, 0, 2, 0, 100, 0, 60, 99, 60, 99, 11, 12466, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Speaker Mar\'grom - Between 60-99% Health - Cast \'12466\''),
(18693, 0, 2, 0, 2, 0, 100, 0, 19, 69, 19, 69, 11, 15497, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Speaker Mar\'grom - Between 19-69% Health - Cast \'15497\''),
(18693, 0, 3, 0, 2, 0, 100, 0, 0, 19, 0, 19, 11, 15241, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Speaker Mar\'grom - Between 0-19% Health - Cast \'15241\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18679;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18679);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18679, 0, 0, 0, 0, 0, 100, 0, 1700, 2400, 5200, 6300, 11, 9080, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Vorakem Doomspeaker - In Combat - Cast \'9080\''),
(18679, 0, 1, 0, 2, 0, 100, 1, 0, 25, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vorakem Doomspeaker - Between 0-25% Health - Cast \'8599\' (No Repeat)');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
