-- DB update 2022_02_12_01 -> 2022_02_13_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_12_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_12_01 2022_02_13_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1644063517005361300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1644063517005361300');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (179526,179528,179532,179533) AND `source_type`=1;
UPDATE `gameobject_template` SET `AiName`='' WHERE `entry` IN (179526,179528,179532,179533);

UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` IN (179527,179530,179531);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (179527,179530,179531) AND `source_type` = 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(179527,1,0,1,70,0,100,0,2,0,0,0,118,2,0,0,0,0,0,20,179526,5,0,0,0,0,0,0,'Warpwood Pod - Root - On State Changed - Set State Destroyed (Warpwood Pod)'),
(179527,1,1,2,61,0,100,0,0,0,0,0,41,1000,0,0,0,0,0,20,179526,5,0,0,0,0,0,0,'Warpwood Pod - Root - On State Changed - Despawn (Warpwood Pod)'),
(179527,1,2,0,61,0,100,0,0,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Warpwood Pod - Root - On State Changed - Delayed Despawn'),

(179530,1,0,1,70,0,100,0,2,0,0,0,118,2,0,0,0,0,0,20,179532,5,0,0,0,0,0,0,'Warpwood Pod - Spore - On State Changed - Set State Destroyed (Warpwood Pod)'),
(179530,1,1,2,61,0,100,0,0,0,0,0,41,1000,0,0,0,0,0,20,179532,5,0,0,0,0,0,0,'Warpwood Pod - Spore - On State Changed - Despawn (Warpwood Pod)'),
(179530,1,2,0,61,0,100,0,0,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Warpwood Pod - Spore - On State Changed - Delayed Despawn'),

(179531,1,0,1,70,0,100,0,2,0,0,0,118,2,0,0,0,0,0,20,179533,5,0,0,0,0,0,0,'Warpwood Pod - Summon - On State Changed - Set State Destroyed (Warpwood Pod)'),
(179531,1,1,2,61,0,100,0,0,0,0,0,41,1000,0,0,0,0,0,20,179533,5,0,0,0,0,0,0,'Warpwood Pod - Summon - On State Changed - Despawn (Warpwood Pod)'),
(179531,1,2,0,61,0,100,0,0,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Warpwood Pod - Summon - On State Changed - Delayed Despawn');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_13_00' WHERE sql_rev = '1644063517005361300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
