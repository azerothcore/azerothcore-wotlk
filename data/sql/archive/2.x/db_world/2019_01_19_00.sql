-- DB update 2019_01_15_00 -> 2019_01_19_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_01_15_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_01_15_00 2019_01_19_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1547680093399033872'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1547680093399033872');

SET
@QUEST_ALIEN_EGG            :=   4821,
@ID_NPC_HAGAR_LIGHTNINGHOOF :=  10539,
@ID_NPC_YOUNG_ARIKARA       :=  10581,
@ID_NPC_DOG_SIRE            :=  10582,
@GUID_NPC_DOG_SIRE          :=  21563,
@ID_GO_ALIEN_EGG            := 175567,
@SOUND_G_DRAGONEGGBLACK     :=   4785,
@SOUND_WINDSERPANTAGGRO     :=    590,
@SOUND_WINDSERPANTSTAND1    :=    591;


UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = @ID_NPC_HAGAR_LIGHTNINGHOOF;

DELETE FROM `smart_scripts` WHERE `entryorguid` = @ID_NPC_HAGAR_LIGHTNINGHOOF;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(@ID_NPC_HAGAR_LIGHTNINGHOOF,0,0,0,20,0,100,0,@QUEST_ALIEN_EGG,0,0,0,50,@ID_GO_ALIEN_EGG,0,0,0,0,0,8,0,0,0,-5444.77,-2399.78,89.2602,0.711648,CONCAT('Hagar Lightninghoof - On Quest ''Alien Egg'' (',@QUEST_ALIEN_EGG,') Finished - Summon GO Alien Egg (',@ID_GO_ALIEN_EGG,')'));


UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI', `flags` = 68 WHERE `entry` = @ID_GO_ALIEN_EGG;

DELETE FROM `smart_scripts` WHERE `entryorguid` = @ID_GO_ALIEN_EGG;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(@ID_GO_ALIEN_EGG,1,0,1,63,0,100,1,0,0,0,0,67,1,6000,6000,0,0,100,1,0,0,0,0,0,0,0,'Alien Egg - On Just Created - Create Timed Event ID 1'),
(@ID_GO_ALIEN_EGG,1,1,0,61,0,100,1,0,0,0,0,70,0,0,0,0,0,0,10,@GUID_NPC_DOG_SIRE,@ID_NPC_DOG_SIRE,0,0,0,0,0,CONCAT('Alien Egg - Linked - Respawn Dog ''Sire'' (GUID ',@GUID_NPC_DOG_SIRE,', ID ',@ID_NPC_DOG_SIRE,')')),
(@ID_GO_ALIEN_EGG,1,2,3,59,0,100,1,1,0,0,0,4,@SOUND_G_DRAGONEGGBLACK,0,0,0,0,0,18,10,0,0,0,0,0,0,CONCAT('Alien Egg - On Timed Event ID 1 - Play Sound ',@SOUND_G_DRAGONEGGBLACK)),
(@ID_GO_ALIEN_EGG,1,3,4,61,0,100,1,0,0,0,0,9,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Alien Egg - Linked - Activate GO'),
(@ID_GO_ALIEN_EGG,1,4,0,61,0,100,1,0,0,0,0,67,2,1000,1000,0,0,100,1,0,0,0,0,0,0,0,'Alien Egg - Linked - Create Timed Event ID 2'),
(@ID_GO_ALIEN_EGG,1,5,6,59,0,100,1,2,0,0,0,12,@ID_NPC_YOUNG_ARIKARA,3,300000,0,0,0,1,0,0,0,0,0,0,0,CONCAT('Alien Egg - On Timed Event ID 2 - Summon Young Arikara (',@ID_NPC_YOUNG_ARIKARA,')')),
(@ID_GO_ALIEN_EGG,1,6,0,61,0,100,1,0,0,0,0,67,3,10000,10000,0,0,100,1,0,0,0,0,0,0,0,'Alien Egg - Linked - Create Timed Event ID 3'),
(@ID_GO_ALIEN_EGG,1,7,0,59,0,100,1,3,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Alien Egg - On Timed Event ID 3 - Force Despawn');


UPDATE `creature_template` SET `AIName` = 'SmartAI', `unit_flags` = 2, `flags_extra` = 2, `rank` = 0 WHERE `entry` = @ID_NPC_YOUNG_ARIKARA;

DELETE FROM `smart_scripts` WHERE `entryorguid` = @ID_NPC_YOUNG_ARIKARA;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(@ID_NPC_YOUNG_ARIKARA,0,0,0,63,0,100,1,0,0,0,0,67,1,2000,2000,0,0,100,1,0,0,0,0,0,0,0,'Young Arikara - On Just Created - Create Timed Event ID 1'),
(@ID_NPC_YOUNG_ARIKARA,0,1,2,59,0,100,1,1,0,0,0,4,@SOUND_WINDSERPANTAGGRO,0,0,0,0,0,18,50,0,0,0,0,0,0,CONCAT('Young Arikara - On Timed Event ID 1 - Play Sound ',@SOUND_WINDSERPANTAGGRO)),
(@ID_NPC_YOUNG_ARIKARA,0,2,3,61,0,100,1,0,0,0,0,70,0,0,0,0,0,0,10,@GUID_NPC_DOG_SIRE,@ID_NPC_DOG_SIRE,0,0,0,0,0,CONCAT('Young Arikara - Linked - Respawn Dog ''Sire'' (GUID ',@GUID_NPC_DOG_SIRE,', ID ',@ID_NPC_DOG_SIRE,')')),
(@ID_NPC_YOUNG_ARIKARA,0,3,0,61,0,100,1,0,0,0,0,69,1,0,0,0,0,0,19,@ID_NPC_DOG_SIRE,100,0,0,0,0,0,CONCAT('Young Arikara - Linked - Move to Dog ''Sire'' (',@ID_NPC_DOG_SIRE,') Point 1')),
(@ID_NPC_YOUNG_ARIKARA,0,4,0,34,0,100,1,0,1,0,0,67,2,1000,1000,0,0,100,1,0,0,0,0,0,0,0,'Young Arikara - On Reached Point 1 - Create Timed Event ID 2'),
(@ID_NPC_YOUNG_ARIKARA,0,5,6,59,0,100,1,2,0,0,0,70,0,0,0,0,0,0,10,@GUID_NPC_DOG_SIRE,@ID_NPC_DOG_SIRE,0,0,0,0,0,CONCAT('Young Arikara - On Timed Event ID 2 - Respawn Dog ''Sire'' (GUID ',@GUID_NPC_DOG_SIRE,', ID ',@ID_NPC_DOG_SIRE,')')),
(@ID_NPC_YOUNG_ARIKARA,0,6,0,61,0,100,1,0,0,0,0,69,2,0,0,0,0,0,19,@ID_NPC_DOG_SIRE,100,0,0,0,0,0,CONCAT('Young Arikara - Linked - Move to Dog ''Sire'' (',@ID_NPC_DOG_SIRE,') Point 2')),
(@ID_NPC_YOUNG_ARIKARA,0,7,0,34,0,100,1,0,2,0,0,67,3,500,500,0,0,100,1,0,0,0,0,0,0,0,'Young Arikara - On Reached Point 2 - Create Timed Event ID 3'),
(@ID_NPC_YOUNG_ARIKARA,0,8,9,59,0,100,1,3,0,0,0,70,0,0,0,0,0,0,10,@GUID_NPC_DOG_SIRE,@ID_NPC_DOG_SIRE,0,0,0,0,0,CONCAT('Young Arikara - On Timed Event ID 3 - Respawn Dog ''Sire'' (GUID ',@GUID_NPC_DOG_SIRE,', ID ',@ID_NPC_DOG_SIRE,')')),
(@ID_NPC_YOUNG_ARIKARA,0,9,0,61,0,100,1,0,0,0,0,69,3,0,0,0,0,0,19,@ID_NPC_DOG_SIRE,100,0,0,0,0,0,CONCAT('Young Arikara - Linked - Move to Dog ''Sire'' (',@ID_NPC_DOG_SIRE,') Point 3')),
(@ID_NPC_YOUNG_ARIKARA,0,10,11,34,0,100,1,0,3,0,0,5,35,0,0,0,0,0,1,0,0,0,0,0,0,0,'Young Arikara - On Reached Point 3 - Play Emote 35'),
(@ID_NPC_YOUNG_ARIKARA,0,11,12,61,0,100,1,0,0,0,0,51,0,0,0,0,0,0,19,@ID_NPC_DOG_SIRE,100,0,0,0,0,0,CONCAT('Young Arikara - Linked - Kill Dog ''Sire'' (',@ID_NPC_DOG_SIRE,')')),
(@ID_NPC_YOUNG_ARIKARA,0,12,0,61,0,100,1,0,0,0,0,67,4,2000,2000,0,0,100,1,0,0,0,0,0,0,0,'Young Arikara - Linked - Create Timed Event ID 4'),
(@ID_NPC_YOUNG_ARIKARA,0,13,0,59,0,100,1,4,0,0,0,69,4,0,0,0,0,0,8,0,0,0,-5466.48,-2439.17,89.4323,3.03714,'Young Arikara - On Timed Event ID 4 - Move to Point 4'),
(@ID_NPC_YOUNG_ARIKARA,0,14,15,34,0,100,1,0,4,0,0,4,@SOUND_WINDSERPANTSTAND1,0,0,0,0,0,18,50,0,0,0,0,0,0,CONCAT('Young Arikara - On Reached Point 4 - Play Sound ',@SOUND_WINDSERPANTSTAND1)),
(@ID_NPC_YOUNG_ARIKARA,0,15,0,61,0,100,1,0,0,0,0,67,5,1000,1000,0,0,100,1,0,0,0,0,0,0,0,'Young Arikara - Linked - Create Timed Event ID 5'),
(@ID_NPC_YOUNG_ARIKARA,0,16,0,59,0,100,1,5,0,0,0,69,5,0,0,0,0,0,8,0,0,0,-5489.68,-2433.03,89.1573,2.75832,'Young Arikara - On Timed Event ID 5 - Move to Point 5'),
(@ID_NPC_YOUNG_ARIKARA,0,17,0,34,0,100,1,0,5,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Young Arikara - On Reached Point 5 - Force Despawn');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
