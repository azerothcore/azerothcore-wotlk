-- DB update 2019_06_06_01 -> 2019_06_08_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_06_06_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_06_06_01 2019_06_08_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1559220494373180355'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1559220494373180355');

-- fix Ice Totem
UPDATE `creature_template` SET `spell1` = 0 WHERE `entry` = 12141;
DELETE FROM `creature_template_addon` WHERE `entry` = 12141;
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (12141,0,0,0,0,0,'18978');

-- Mogor should be uninterruptible
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854271 WHERE `entry` = 18069;

-- Base script
DELETE FROM `smart_scripts` WHERE `entryorguid` = 18069 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(18069,0,0,0,0,0,100,0,1000,1000,10000,10000,0,11,16033,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Mogor - In Combat - Cast ''Chain Lightning'''),
(18069,0,1,0,0,0,100,0,4000,4000,11000,13000,0,11,39529,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Mogor - In Combat - Cast ''Flame Shock'''),
(18069,0,2,0,2,1,100,1,0,60,0,0,0,11,15982,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - Between 0-60% Health - Cast ''Healing Wave'' - Phase 1 (No Repeat)'),
(18069,0,3,0,2,2,100,0,0,50,15000,15000,0,11,15982,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - Between 0-60% Health - Cast ''Healing Wave'' - Phase 2'),
(18069,0,4,0,0,0,100,0,20000,20000,20000,20000,0,11,18975,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - In Combat - Cast ''Summon Ice Totem'''),
(18069,0,5,0,2,0,100,1,0,30,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Mogor - Between 0-30% Health - Say Line 0 (No Repeat)'),
(18069,0,6,0,6,0,100,1,0,0,0,0,0,26,9977,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Mogor - On Just Died - Call Group Event Happens (No Repeat)'),
(18069,0,7,0,38,0,100,0,12,12,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Data Set 12 12 - Say Line 1'),
(18069,0,8,0,38,0,100,0,13,13,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Data Set 13 13 - Say Line 2'),
(18069,0,9,0,38,0,100,0,14,14,0,0,0,1,6,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Data Set 14 14 - Say Line 6'),
(18069,0,10,11,38,0,100,0,1,1,0,0,0,53,0,18069,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Data Set 1 1 - Start Waypoint'),
(18069,0,11,0,61,0,100,0,0,0,0,0,0,1,3,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Mogor - On Data Set 1 1 - Say Line 3'),
(18069,0,12,0,40,0,100,0,4,18069,0,0,0,80,1806900,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Waypoint 4 Reached - Run Script'),
(18069,0,13,0,6,0,100,1,0,0,0,0,0,26,9977,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Mogor - On Just Died - Quest Credit ''The Ring of Blood: The Final Challenge'' (No Repeat)'),
(18069,0,14,0,2,1,100,0,0,0.1,0,0,0,80,1806901,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Health Percentage 0.1 - Run Script'),
(18069,0,15,0,7,0,100,0,0,0,0,0,0,80,1806902,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Evade - Run Script');

-- Start fight
DELETE FROM `smart_scripts` WHERE `entryorguid` = 1806900 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(1806900,9,0,0,0,0,100,0,0,0,0,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Script - Say Line 4'),
(1806900,9,1,0,0,0,100,0,5000,5000,0,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Script - Set Faction 14'),
(1806900,9,2,0,0,0,100,0,0,0,0,0,0,101,0,0,0,0,0,0,8,0,0,0,0,-714.823,7931.65,58.8672,4.3693,'Mogor - On Script - Set Home Position'),
(1806900,9,3,0,0,0,100,0,0,0,0,0,0,42,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Script - Set Invincibility HP Level To 1'),
(1806900,9,4,0,0,0,100,0,9,9,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Script - Set Reactstate Aggressive'),
(1806900,9,5,0,0,0,100,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Script - Set Phase 1'),
(1806900,9,6,0,0,0,100,0,0,0,0,0,0,49,0,0,0,0,0,0,21,50,0,0,0,0,0,0,0,'Mogor - On Script - Attack Nearest Player Within 50 Yards');

-- Resurrect
DELETE FROM `smart_scripts` WHERE `entryorguid` = 1806901 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(1806901,9,0,0,0,0,100,0,0,0,0,0,0,41,0,0,0,0,0,0,11,12141,50,0,0,0,0,0,0,'Mogor - On Script - Force Despawn ''Ice Totem'''),
(1806901,9,1,0,0,0,100,0,0,0,0,0,0,90,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Script - Set ''UNIT_STAND_STATE_DEAD'''),
(1806901,9,2,0,0,0,100,0,0,0,0,0,0,27,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Script - Stop Combat'),
(1806901,9,3,0,0,0,100,0,0,0,0,0,0,28,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Script - Remove All Auras'),
(1806901,9,4,0,0,0,100,0,0,0,0,0,0,18,33686272,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Script - Set Unit Flags'),
(1806901,9,5,0,0,0,100,0,0,0,0,0,0,42,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Script - Set Invincibility HP Level To 0'),
(1806901,9,6,0,0,0,100,0,10000,10000,0,0,0,11,32343,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Script - Cast Spell ''Revive Self'''),
(1806901,9,7,0,0,0,100,0,2500,2500,0,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Script - Say Line 5'),
(1806901,9,8,0,0,0,100,0,0,0,0,0,0,19,33686272,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Script - Remove Unit Flags'),
(1806901,9,9,0,0,0,100,0,0,0,0,0,0,91,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Script - Remove ''UNIT_STAND_STATE_DEAD'''),
(1806901,9,10,0,0,0,100,0,0,0,0,0,0,49,0,0,0,0,0,0,21,50,0,0,0,0,0,0,0,'Mogor - On Script - Attack Nearest Player Within 50 Yards'),
(1806901,9,11,0,0,0,100,0,0,0,0,0,0,11,28747,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Script - Cast ''Frenzy'''),
(1806901,9,12,0,0,0,100,0,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Script - Set Phase 2');

-- Evade / Reset
DELETE FROM `smart_scripts` WHERE `entryorguid` = 1806902 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(1806902,9,0,0,0,0,100,0,0,0,0,0,0,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Script - Set Faction 35'),
(1806902,9,1,0,0,0,100,0,0,0,0,0,0,22,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Script - Set Phase 0'),
(1806902,9,2,0,0,0,100,0,0,0,0,0,0,41,0,0,0,0,0,0,11,12141,50,0,0,0,0,0,0,'Mogor - On Script - Force Despawn ''Ice Totem'''),
(1806902,9,3,0,0,0,100,0,0,0,0,0,0,78,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mogor - On Script - Script Reset');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
