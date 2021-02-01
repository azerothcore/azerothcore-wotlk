-- DB update 2019_05_26_03 -> 2019_05_27_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_05_26_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_05_26_03 2019_05_27_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1558616423152525700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1558616423152525700');

-- Cast "Summon Spire Spiderling" with a 10% chance if opening "Spire Spider Egg" (IDs 175606 & 175588) 
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` IN (175606,175588);
DELETE FROM `smart_scripts` WHERE `source_type` = 1 AND `entryorguid` IN (175606,175588);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(175606,1,0,0,70,0,10,0,2,0,0,0,0,11,16453,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spire Spider Egg - On GO State Changed 2 (10% Chance) - Cast ''Summon Spire Spiderling'''),
(175588,1,0,0,70,0,10,0,2,0,0,0,0,11,16453,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spire Spider Egg - On GO State Changed 2 (10% Chance) - Cast ''Summon Spire Spiderling''');

-- Linked Trap for "Spire Spider Egg" (ID 175588) is not needed
UPDATE `gameobject_template` SET `Data7` = 0 WHERE `entry` = 175588;

-- Spire Spiderling SAI (ID 10375)
DELETE FROM `smart_scripts` WHERE `entryorguid`=10375 AND `source_type`=0;
UPDATE creature_template SET AIName="SmartAI" WHERE entry=10375;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(10375,0,0,0,1,0,100,0,0,0,0,0,89,15,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Spire Spiderling - Out of Combat - Random Move"),
(10375,0,1,0,7,0,100,0,0,0,0,0,41,150,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Spire Spiderling - On Evade - Despawn");

-- Spire Spider SAI (ID 10374)
DELETE FROM `smart_scripts` WHERE `entryorguid`=10374 AND `source_type`=0;
UPDATE creature_template SET AIName="SmartAI" WHERE entry=10374;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(10374,0,0,0,6,0,100,2,0,0,0,0,11,16103,3,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Spire Spider - On Death - Cast 'Summon Spire Spiderling'"),
(10374,0,1,0,0,0,100,2,15000,15000,15000,15000,11,16104,0,0,0,0,0,2,0,0,0,0.0,0.0,0.0,0.0,"Spire Spider - In Combat - Cast 'Crystallize'"),
(10374,0,2,0,1,0,100,0,0,0,0,0,89,20,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Spire Spider - Out of Combat - Random move");

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
