-- DB update 2020_10_08_00 -> 2020_10_11_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_10_08_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_10_08_00 2020_10_11_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1600981837360679324'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1600981837360679324');

/* Brewfest Horde and Allianz */
/* (C) Toxic/ICC 2020 */
/* Synthebrew Goggles and Ram Racing Reins Fix*/
DELETE FROM `smart_scripts` WHERE `entryorguid` = 24510 and `source_type` = 0 and `id` IN (3,4,5,6);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(24510, 0, 3, 4, 62, 0, 100, 0, 8958, 6, 0, 0, 0, 11, 44262, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, "Driz Tumblequick - On Gossip Option 0 Selected - Cast \"Create Item - Ram Racing Reins\""),
(24510, 0, 4, 0, 61, 0, 100, 0, 8958, 6, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, "Driz Tumblequick - On Gossip Option 0 Selected - Close Gossip"),
(24510, 0, 5, 6, 62, 0, 100, 0, 8960, 0, 0, 0, 0, 11, 44262, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, "Driz Tumblequick - On Gossip Option 0 Selected - Cast \"Create Item - Ram Racing Reins\""),
(24510, 0, 6, 0, 61, 0, 100, 0, 8960, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, "Driz Tumblequick - On Gossip Option 0 Selected - Close Gossip");

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 and `SourceGroup` IN (10603,10604) AND `SourceEntry`= 1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15, 10603, 1, 0, 0, 2, 0, 46735, 1, 1, 1, 0, 0, "", "Gossip Option when player has no item Synthebrew Goggles"),
(15, 10604, 1, 0, 0, 2, 0, 46735, 1, 1, 1, 0, 0, "", "Gossip Option when player has no item Synthebrew Goggles");

DELETE FROM `smart_scripts` WHERE `entryorguid` = 24657 and `source_type` = 0 and `id` IN (0,1,2,3,4,5,6);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(24657, 0, 0, 0, 10, 0, 100, 0, 1, 25, 1000, 1000, 0, 11, 43714, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, "Glodrak Huntsniper <Ram Racing Apprentice> - Within 0-25 Range - Cast \"Brewfest - Throw Keg - DND\""),
(24657, 0, 1, 2, 8, 0, 100, 0, 43662, 0, 0, 0, 0, 85, 44601, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, "Glodrak Huntsniper <Ram Racing Apprentice> - On SpellHit - Cast \"Brewfest - Relay Race - Intro - Assign Kill Credit\""),
(24657, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 85, 43755, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, "Glodrak Huntsniper <Ram Racing Apprentice> - Within 0-25 Range - Cast \"Brewfest - Daily - Relay Race - Player - Increase Mount Duration - DND\""),
(24657, 0, 3, 4, 62, 0, 100, 0, 10603, 0, 0, 0, 0, 11, 66592, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, "Glodrak Huntsniper - On Gossip Option 0 Selected - Cast \"Create Item - Synthebrew Goggles\""),
(24657, 0, 4, 0, 61, 0, 100, 0, 10603, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, "Glodrak Huntsniper - On Gossip Option 0 Selected - Close Gossip"),
(24657, 0, 5, 6, 62, 0, 100, 0, 10604, 0, 0, 0, 0, 11, 66592, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, "Glodrak Huntsniper - On Gossip Option 0 Selected - Cast \"Create Item - Synthebrew Goggles\""),
(24657, 0, 6, 0, 61, 0, 100, 0, 10604, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, "Glodrak Huntsniper - On Gossip Option 0 Selected - Close Gossip");

DELETE FROM `smart_scripts` WHERE `entryorguid` = 23486 and `source_type` = 0 and `id` IN (1,2,3);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(23486, 0, 1, 0, 61, 0, 100, 0, 10604, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, "Goldark Snipehunter - On Gossip Option 0 Selected - Close Gossip"),
(23486, 0, 2, 3, 62, 0, 100, 0, 10603, 0, 0, 0, 0, 11, 66592, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, "Goldark Snipehunter - On Gossip Option 0 Selected - Cast \"Create Item - Synthebrew Goggles\""),
(23486, 0, 3, 0, 61, 0, 100, 0, 10603, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, "Goldark Snipehunter - On Gossip Option 0 Selected - Close Gossip");

DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (10603,10604) AND `OptionID`= 0;
INSERT INTO `gossip_menu_option` (`MenuID`,`OptionID`,`OptionIcon`,`OptionText`,`OptionBroadcastTextID`,`OptionType`,`OptionNpcFlag`,`ActionMenuID`,`ActionPoiID`,`BoxCoded`,`BoxMoney`,`BoxText`,`BoxBroadcastTextID`,`VerifiedBuild`) VALUES 
(10603, 0, 0, "I\d like a pair of Synthebrew Goggles.", 35220, 1, 1, 0, 0, 0, 0, "", 0, 0),
(10604, 0, 0, "I\d like a pair of Synthebrew Goggles.", 35220, 1, 1, 0, 0, 0, 0, "", 0, 0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
