-- DB update 2022_03_12_02 -> 2022_03_12_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_12_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_12_02 2022_03_12_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1646152616244410200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1646152616244410200');

SET @NPC := 35073;
SET @GOSSIP_MENU_ID := 10631;
SET @ITEM_ID := 46978;
SET @QUEST_ID := 14111;

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = @NPC;

DELETE FROM `gossip_menu_option` WHERE `MenuId` = @GOSSIP_MENU_ID;
INSERT INTO `gossip_menu_option` (`MenuId`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`) VALUES
(@GOSSIP_MENU_ID, 0, 0, "I lost my totems. Can you help?", 35455, 1, 1, 0, 0);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup` = @GOSSIP_MENU_ID;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15, @GOSSIP_MENU_ID, 0, 0, 0, 8, 0, @QUEST_ID, 0, 0, 0, 0, '', 'Requires Quest Completed'),
(15, @GOSSIP_MENU_ID, 0, 0, 0, 2, 0, @ITEM_ID, 1, 0, 1, 0, '', 'Requires Missing Item');

DELETE FROM `smart_scripts` WHERE `entryorguid`=@NPC AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@NPC, 0, 0, 1, 62, 0, 100, 0, @GOSSIP_MENU_ID, 0, 0, 0, 56, @ITEM_ID, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Farsser Eannu - On Gossip Option Select - Add Item to Player'),
(@NPC, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Farsser Eannu - On Gossip Option Select - Close Gossip');

SET @NPC := 35068;
SET @GOSSIP_MENU_ID := 10630;
SET @QUEST_ID := 14100;

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = @NPC;

DELETE FROM `gossip_menu_option` WHERE `MenuId` = @GOSSIP_MENU_ID;
INSERT INTO `gossip_menu_option` (`MenuId`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`) VALUES
(@GOSSIP_MENU_ID, 0, 0, "I lost my totems. Can you help?", 35455, 1, 1, 0, 0);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup` = @GOSSIP_MENU_ID;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15, @GOSSIP_MENU_ID, 0, 0, 0, 8, 0, @QUEST_ID, 0, 0, 0, 0, '', 'Requires Quest Completed'),
(15, @GOSSIP_MENU_ID, 0, 0, 0, 2, 0, @ITEM_ID, 1, 0, 1, 0, '', 'Requires Missing Item');

DELETE FROM `smart_scripts` WHERE `entryorguid`=@NPC AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@NPC, 0, 0, 1, 62, 0, 100, 0, @GOSSIP_MENU_ID, 0, 0, 0, 56, @ITEM_ID, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Gotura Fourwinds - On Gossip Option Select - Add Item to Player'),
(@NPC, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Gotura Fourwinds - On Gossip Option Select - Close Gossip');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_12_03' WHERE sql_rev = '1646152616244410200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
