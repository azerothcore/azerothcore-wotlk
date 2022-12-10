-- DB update 2021_12_02_00 -> 2021_12_02_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_02_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_02_00 2021_12_02_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1637960273581355100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637960273581355100');

UPDATE `creature_template` SET `AiName`='', `ScriptName`='boss_lord_valthalak' WHERE `entry`=16042;
DELETE FROM `smart_scripts` WHERE `entryorguid`=16042 AND `source_type`=0;

DELETE FROM `creature_text` WHERE `creatureid`=16042;
INSERT INTO `creature_text` VALUES
(16042,0,0,'Muahahahaha! What is this pathetic spectacle I see before me? Well, what are you waiting for? I hunger, and you look as if you may make for a passable appetizer!',14,0,100,0,0,0,11967,0,'Lord Valthalak - Talk Summon'),
(16042,1,0,'Your insolence is appalling, fool! I shall feast on your soul!',12,0,100,0,0,0,11955,0,'Lord Valthalak - Talk Aggro'),
(16042,2,0,'I\'ve gone easy on you thus far, but now you bore me. Witness the magnificence of my power, and despair!',14,0,100,0,0,0,11769,0,'Lord Valthalak - Talk 40% hp'),
(16042,3,0,'I will not die again! Not to the likes of you!',14,0,100,0,0,0,11770,0,'Lord Valthalak - Talk 15% hp');

DELETE FROM `smart_scripts` WHERE `entryorguid`=16066 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(16066,0,0,0,0,0,100,2,3000,5000,7000,9000,11,18663,0,0,0,0,0,2,0,0,0,0,0,0,0,"Spectral Assassin - In Combat - Cast 18663 (Normal Dungeon)"),
(16066,0,1,0,0,0,100,3,10000,15000,0,0,11,27177,0,0,0,0,0,6,0,0,0,0,0,0,0,"Spectral Assassin - In Combat - Cast 27177 (Normal Dungeon)");

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_02_01' WHERE sql_rev = '1637960273581355100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
