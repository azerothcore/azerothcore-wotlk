-- DB update 2018_06_26_00 -> 2018_06_29_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2018_06_26_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2018_06_26_00 2018_06_29_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1530226452517673074'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1530226452517673074');

-- Delete duplicate Midsummer Celebrants in Tanaris
DELETE FROM `creature` WHERE `guid` IN (86895,94715,94717,94716,94733,94513,94724,94586,94726,94696);

-- Festival Fire Breathing (Spell 45385) for Fire Eaters and Flame Eaters:
-- Master Fire Eater (NPC 25975)
-- Flame Eater (NPC 25994)
-- Master Flame Eater (NPC 26113)
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (25975,25994,26113);
INSERT INTO `smart_scripts`
(`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(25975,0,0,0,60,0,100,0,5000,10000,15000,20000,11,45385,0,0,0,0,0,1,0,0,0,0,0,0,0,'spell cast'),
(25994,0,0,0,60,0,100,0,5000,10000,15000,20000,11,45385,0,0,0,0,0,1,0,0,0,0,0,0,0,'spell cast'),
(26113,0,0,0,60,0,100,0,5000,10000,15000,20000,11,45385,0,0,0,0,0,1,0,0,0,0,0,0,0,'spell cast');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (25975,25994,26113);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
