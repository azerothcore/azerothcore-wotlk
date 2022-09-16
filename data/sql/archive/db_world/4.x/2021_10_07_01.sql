-- DB update 2021_10_07_00 -> 2021_10_07_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_07_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_07_00 2021_10_07_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1624399628559846000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624399628559846000');

-- adding 85% chance to despawn to new dungeon rares

-- Panzor the Invincible
SET @ENTRY := 8923;
DELETE FROM `smart_scripts` WHERE `entryOrGuid` = @ENTRY AND `source_type` = 0;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`= @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 37, 0, 85, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI initialize - Self: Despawn in 0.5 s');

-- Tsu'zee
SET @ENTRY := 11467;
DELETE FROM `smart_scripts` WHERE `entryOrGuid` = @ENTRY AND `source_type` = 0;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`= @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 37, 0, 85, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI initialize - Self: Despawn in 0.5 s'),
(@ENTRY, 0, 1, 0, 0, 0, 100, 2, 3000, 5000, 5000, 7000, 11, 15581, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Every 5 - 7 seconds (3 - 5s initially) - Self: Cast spell Sinister Strike (15581) on Victim'),
(@ENTRY, 0, 2, 0, 0, 0, 100, 2, 6000, 8000, 9000, 12000, 11, 12540, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Every 9 - 12 seconds (6 - 8s initially) - Self: Cast spell Gouge (12540) on Random hostile'),
(@ENTRY, 0, 3, 0, 0, 0, 100, 2, 7000, 11000, 16000, 21000, 11, 21060, 1, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 'Every 16 - 21 seconds (7 - 11s initially) - Self: Cast spell Blind (21060) on Random hostile (not top) (flags: interrupt previous)');

-- Dark Iron Ambassador
SET @ENTRY := 6228;
DELETE FROM `smart_scripts` WHERE `entryOrGuid` = @ENTRY AND `source_type` = 0;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`= @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 37, 0, 85, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI initialize - Self: Despawn in 0.5 s'),
(@ENTRY, 0, 1, 0, 1, 0, 100, 2, 1000, 1000, 1800000, 1800000, 11, 12544, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Every 1800 seconds (1s initially) - Self: Cast spell Frost Armor (12544) on Self (flags: aura not present)'),
(@ENTRY, 0, 2, 0, 0, 0, 100, 2, 1100, 2000, 2400, 3800, 11, 9053, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Every 2.4 - 3.8 seconds (1.1 - 2s initially) - Self: Cast spell Fireball (9053) on Victim (flags: combat move)'),
(@ENTRY, 0, 3, 0, 0, 0, 100, 2, 1000, 1000, 60000, 65000, 11, 184, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Every 60 - 65 seconds (1 - 1s initially) - Self: Cast spell Fire Shield II (184) on Self'),
(@ENTRY, 0, 4, 0, 0, 0, 100, 3, 2000, 2000, 0, 0, 11, 10870, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Time = 2 seconds - Self: Cast spell Summon Burning Servant (10870) on Self (flags: triggered)'),
(@ENTRY, 0, 5, 0, 0, 0, 100, 3, 3000, 3000, 0, 0, 11, 10870, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Time = 3 seconds - Self: Cast spell Summon Burning Servant (10870) on Self (flags: triggered)'),
(@ENTRY, 0, 6, 0, 8, 0, 100, 0, 9798, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On spell Radiation (9798) hit - Self: Talk 0 to invoker');

DELETE FROM `pool_creature` WHERE guid IN (45763, 300742);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES 
(45763, 9718, 85, 'Ghok Bashguud add'),
(300742, 9718, 15, 'Ghok Bashguud');

DELETE FROM `pool_template` WHERE entry = 9718;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (9718, 1, 'Ghok Bashguud - LBRS');

-- Script Zekkis, add him 2 abilities
SET @ENTRY := 5400;
DELETE FROM `smart_scripts` WHERE `entryOrGuid` = @ENTRY AND `source_type` = 0;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`= @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 0, 0, 100, 0, 0, 5000, 60000, 60000, 11, 8282, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Every 60 - 60 seconds (0 - 5s initially) - Self: Cast spell Curse of Blood (8282) on Victim'),
(@ENTRY, 0, 1, 0, 0, 0, 100, 0, 5000, 10000, 120000, 120000, 11, 7102, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Every 120 - 120 seconds (5 - 10s initially) - Self: Cast spell Contagion of Rot (7102) on Victim');

 -- Burning Servant
SET @ENTRY := 7738;
DELETE FROM `smart_scripts` WHERE `entryOrGuid` = @ENTRY AND `source_type` = 0;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`= @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 0, 0, 100, 2, 2000, 2000, 20000, 30000, 11, 10869, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Every 20 - 30 seconds (2 - 2s initially) - Self: Cast spell Summon Embers (10869) on Self');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_07_01' WHERE sql_rev = '1624399628559846000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
