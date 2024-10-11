-- DB update 2021_12_07_02 -> 2021_12_07_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_07_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_07_02 2021_12_07_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638437762578877300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638437762578877300');

-- Water seekers cast a poison spell that didn't exist on the SmartAI.
-- Missing Flee for assist event
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3260;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 3260);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3260, 0, 0, 0, 0, 0, 100, 0, 2000, 6000, 15000, 17000, 0, 11, 12748, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bristleback Water Seeker - In Combat - Cast \'Frost Nova\''),
(3260, 0, 1, 0, 0, 0, 100, 0, 0, 2000, 11000, 13000, 0, 11, 744, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bristleback Water Seeker - In Combat - Cast \'Poison\''),
(3260, 0, 2, 0, 2, 0, 100, 0, 1, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bristleback Water Seeker - Between 1-15% Health - Flee For Assist');

-- Timers adjusted according to footage aswell, to mimic their random spellcasting instead of spamming fireballs,
-- since they hit very hard and make this quest excessively harder.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3263;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 3263);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3263, 0, 0, 0, 0, 0, 100, 0, 0, 7000, 4000, 5000, 0, 11, 20793, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bristleback Geomancer - In Combat - Cast \'Fireball\''),
(3263, 0, 1, 0, 0, 0, 100, 0, 2000, 12000, 30000, 35000, 0, 11, 4979, 64, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bristleback Geomancer - In Combat - Cast \'Quick Flame Ward\''),
(3263, 0, 2, 0, 0, 0, 100, 0, 1500, 10000, 18000, 25000, 0, 11, 20794, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bristleback Geomancer - In Combat - Cast \'Flamestrike\''),
(3263, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bristleback Geomancer - Between 0-15% Health - Flee For Assist (No Repeat)');

-- Thornweavers cast Thorns in-combat and not out of combat.
-- Adjusted their timers for a more accurate classic experience
-- Missing flee for assist event at 0-10% health percentage
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3261;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 3261);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3261, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 20000, 24000, 0, 11, 782, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bristleback Thornweaver - In Combat - Cast \'Thorns\''),
(3261, 0, 1, 0, 0, 0, 80, 0, 1000, 6000, 12000, 16000, 0, 11, 12747, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bristleback Thornweaver - In Combat - Cast \'Entangling Roots\''),
(3261, 0, 2, 0, 2, 0, 100, 0, 0, 10, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bristleback Thornweaver - Between 0-10% Health - Flee For Assist');

-- Hunter's timers re-checked for accuracy
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3258;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 3258);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3258, 0, 0, 0, 0, 0, 100, 0, 1000, 5000, 3000, 4000, 0, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bristleback Hunter - In Combat - Cast \'Shoot\''),
(3258, 0, 1, 0, 0, 0, 100, 0, 1000, 5000, 6000, 8000, 0, 11, 8806, 32, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Bristleback Hunter - In Combat - Cast \'Poisoned Shot\''),
(3258, 0, 2, 0, 2, 0, 100, 1, 1, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bristleback Hunter - Between 1-15% Health - Flee For Assist (No Repeat)');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_07_03' WHERE sql_rev = '1638437762578877300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
