-- DB update 2019_01_10_00 -> 2019_01_12_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_01_10_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_01_10_00 2019_01_12_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1547251001073984601'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1547251001073984601');

SET @ENTRY := 33810;

UPDATE `creature_template` SET `modelid1` = 28880, `modelid2` = 0, `modelid3` = 0, `modelid4` = 0, `AIName`='SmartAI' WHERE `entry` = @ENTRY;

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY, @ENTRY * 100, @ENTRY * 100 + 1, @ENTRY * 100 + 2);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(@ENTRY,0,0,0,54,0,100,0,0,0,0,0,11,52619,0,0,0,0,0,1,0,0,0,0,0,0,0,'Sen''Jin Fetish - Just Summoned - Cast Spell ''Enchanted Tiki Warrior: Enchanted Tiki Warrior Glow Visual'' (52619) on self'),
(@ENTRY,0,1,0,54,0,100,0,0,0,0,0,87,@ENTRY * 100,@ENTRY * 100 + 1,@ENTRY * 100 + 2,0,0,0,1,0,0,0,0,0,0,0,'Sen''Jin Fetish - Just Summoned - Call Random Script'),
(@ENTRY * 100,9,0,0,54,0,100,0,0,0,0,0,11,52614,0,0,0,0,0,1,0,0,0,0,0,0,0,'Sen''Jin Fetish - Just Summoned - Cast Spell ''Enchanted Tiki Warrior: Enchanted Tiki Warrior Visual 01'' (52614) on self'),
(@ENTRY * 100 + 1,9,0,0,54,0,100,0,0,0,0,0,11,52617,0,0,0,0,0,1,0,0,0,0,0,0,0,'Sen''Jin Fetish - Just Summoned - Cast Spell ''Enchanted Tiki Warrior: Enchanted Tiki Warrior Visual 02'' (52617) on self'),
(@ENTRY * 100 + 2,9,0,0,54,0,100,0,0,0,0,0,11,52618,0,0,0,0,0,1,0,0,0,0,0,0,0,'Sen''Jin Fetish - Just Summoned - Cast Spell ''Enchanted Tiki Warrior: Enchanted Tiki Warrior Visual 03'' (52618) on self');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
