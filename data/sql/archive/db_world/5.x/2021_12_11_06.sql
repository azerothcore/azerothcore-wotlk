-- DB update 2021_12_11_05 -> 2021_12_11_06
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_11_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_11_05 2021_12_11_06 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638753088438372219'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638753088438372219');

-- Fix Sangrias Stillblade for quest 9678 "The First Trial"
UPDATE `creature_template` SET `npcflag`=2, `unit_flags`=32768, `BaseAttackTime`=4000, `RangeAttackTime`=4000 WHERE `entry`=17716;

DELETE FROM `smart_scripts` WHERE `entryorguid`=17716 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(17716,0,0,1,60,0,100,1,2000,2000,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sangrias Stillblade - On Update - Say text 0 (No Repeat)'),
(17716,0,1,0,61,0,100,0,0,0,0,0,0,53,1,17716,0,9678,0,2,1,0,0,0,0,0,0,0,0,'Sangrias Stillblade - On Update - Load path (No Repeat)'),
(17716,0,2,0,9,0,100,1,8,25,0,0,0,11,22120,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Sangrias Stillblade - Within 8-25 Range - Cast ''Charge'' (No Repeat)'),
(17716,0,3,0,6,0,100,1,0,0,0,0,0,15,9678,0,0,0,0,0,16,0,0,0,0,0,0,0,0,'Sangrias Stillblade - On Death - Complete quest for player party'),
(17716,0,4,0,7,0,100,1,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sangrias Stillblade - On Evade - despawn (No Repeat)');

DELETE FROM `waypoints` WHERE `entry`=17716;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`point_comment`) VALUES
(17716,1,8051.857,-7543.9897,149.69759,0,0, 'Sangrias Stillblade'),
(17716,2,8094.734,-7541.6343,151.74496,0,0, 'Sangrias Stillblade');

DELETE FROM `creature_text` WHERE `CreatureID`=17716;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(17716,0,0, 'Defend yourself, youngling! We''ll see if there''s a Blood Knight in you, yet.',14,0,100,0,0,0,14365,0, 'Sangrias Stillblade say on attack');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_11_06' WHERE sql_rev = '1638753088438372219';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
