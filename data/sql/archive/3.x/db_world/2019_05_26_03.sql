-- DB update 2019_05_26_02 -> 2019_05_26_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_05_26_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_05_26_02 2019_05_26_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1558483908826919700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1558483908826919700');

-- Defias Gunpowder SAI on loot spawn Defias Taskmaster aggro player who loot it
UPDATE `gameobject_template` SET `AIName`="SmartGameObjectAI" WHERE `entry`=17155;
DELETE FROM `smart_scripts` WHERE `entryorguid`=17155 AND `source_type`=1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(17155,1,0,0,70,0,100,0,2,0,0,0,12,4417,3,120000,1,0,0,8,0,0,0,-123.77,-613.586,14.126,6.035,'Defias Gunpowder - On Gossip Hello - Summon Creature Defias Taskmaster (No Repeat)');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
