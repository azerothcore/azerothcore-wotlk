-- DB update 2022_04_07_04 -> 2022_04_07_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_07_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_07_04 2022_04_07_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1649126786433718200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1649126786433718200');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14081;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 14081 AND `source_type` = 0 AND `id` IN (0, 1);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14081, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 11, 22391, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demon Portal - On Respawn - Cast \'Serverside - Demon Portal\''),
(14081, 0, 1, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demon Portal - On Evade - Despawn Instant');

DELETE FROM `creature_text` WHERE `CreatureID` = 14101;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(14101, 0, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 1191, 0, 'Enraged Felguard - Frenzy (30% health)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14101;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 14101 AND `source_type` = 0 AND `id` IN (0, 1, 2, 3, 4, 5, 6);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14101, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 11, 22393, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enraged Felguard - On Respawn - Cast \'Enraged Felguard Spawn\''),
(14101, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 25, 45, 1, 0, 0, 0, 0, 0, 0, 'Enraged Felguard - On Respawn - Start Attacking'),
(14101, 0, 2, 0, 9, 0, 100, 0, 0, 5, 5000, 8000, 0, 11, 15580, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Enraged Felguard - Within 0-5 Range - Cast \'Strike\''),
(14101, 0, 3, 0, 0, 0, 100, 0, 7000, 11000, 12000, 15000, 0, 11, 15548, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enraged Felguard - In Combat - Cast \'Thunderclap\''),
(14101, 0, 4, 0, 0, 0, 100, 0, 9000, 13000, 13000, 17000, 0, 11, 16046, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enraged Felguard - In Combat - Cast \'Blast Wave\''),
(14101, 0, 5, 6, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enraged Felguard - Between 30-0% Health - Cast \'Frenzy\' (No Repeat)'),
(14101, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Enraged Felguard - Between 30-0% Health - Say Line 0 (No Repeat)');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 12459 AND `source_type` = 0 AND `id` IN (0, 1, 2, 3, 4);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12459, 0, 0, 0, 0, 0, 85, 2, 5000, 5000, 5000, 7000, 0, 11, 19717, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Warlock - In Combat - Cast \'Rain of Fire\' (Normal Dungeon)'),
(12459, 0, 1, 0, 0, 0, 85, 2, 6000, 6000, 3000, 7000, 0, 11, 22336, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Warlock - In Combat - Cast \'Shadow Bolt\' (Normal Dungeon)'),
(12459, 0, 2, 0, 0, 0, 80, 2, 10000, 15000, 14000, 18000, 0, 11, 22372, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Warlock - In Combat - Cast \'Demon Portal\' (Normal Dungeon)'),
(12459, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 14081, 10, 0, 0, 0, 0, 0, 0, 'Blackwing Warlock - On Just Died - Despawn Instant'),
(12459, 0, 4, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 9, 14081, 0, 10, 1, 0, 0, 0, 0, 'Blackwing Warlock - On Evade - Despawn Instant');

UPDATE `creature` SET `spawntimesecs` = 30 WHERE `id1` = 13996 AND `unit_flags` = 64; -- this way we avoid overriding the spawntime for Vael technicians.

-- Each pack of technicians with its proper warlock.
DELETE FROM `linked_respawn` WHERE `guid` IN (84192, 84194, 84190, 84186, 84188, 84182, 84184, 84185, 84187, 84189, 84191, 84193, 84183, 84195, 84196, 84135, 84134, 84136, 84137, 84139, 84138, 84144, 84148, 84146,  84202, 84142, 84203, 84141, 84143, 84145, 84147, 84140, 84149, 84151, 84150, 84169, 84170, 84167, 84171, 84162, 84166, 84173, 84176, 84178, 84179,  84157, 84152, 84153, 84158, 84156, 84155, 84161, 84160, 84159, 84154, 84174, 84175, 84177, 84172, 84165, 84168, 84180, 84181, 84163, 84164);
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(84192,84541,0),
(84194,84541,0),
(84190,84541,0),
(84186,84542,0),
(84188,84542,0),
(84182,84546,0),
(84184,84546,0),
(84185,84546,0),
(84187,84546,0),
(84189,84546,0),
(84191,84553,0),
(84193,84553,0),
(84183,84553,0),
(84195,84553,0),
(84196,84553,0),
(84135,84560,0),
(84134,84560,0),
(84136,84560,0),
(84137,84560,0),
(84139,84560,0),
(84138,84561,0),
(84144,84561,0),
(84148,84561,0),
(84146,84561,0),
(84202,84561,0),
(84142,84598,0),
(84203,84598,0),
(84141,84598,0),
(84143,84598,0),
(84145,84598,0),
(84147,84598,0),
(84140,84598,0),
(84149,84598,0),
(84151,84599,0),
(84150,84599,0),
(84169,84653,0),
(84170,84653,0),
(84167,84653,0),
(84171,84653,0),
(84162,84653,0),
(84166,84652,0),
(84173,84652,0),
(84176,84652,0),
(84178,84652,0),
(84179,84652,0),
(84157,85757,0),
(84152,85757,0),
(84153,85757,0),
(84158,85757,0),
(84156,85757,0),
(84155,85775,0),
(84161,85775,0),
(84160,85775,0),
(84159,85775,0),
(84154,85775,0),
(84174,85581,0),
(84175,85581,0),
(84177,85581,0),
(84172,85581,0),
(84165,85581,0),
(84168,85601,0),
(84180,85601,0),
(84181,85601,0),
(84163,85601,0),
(84164,85601,0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_07_05' WHERE sql_rev = '1649126786433718200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
