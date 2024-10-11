-- DB update 2020_08_09_01 -> 2020_08_10_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_08_09_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_08_09_01 2020_08_10_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1592611528011042200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1592611528011042200');

-- Add sniffed gossip texts to menu
DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (8095, 8096, 8100);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`)VALUES 
(8095, 0, 2, 'Show me where I can fly.', 12271, 4, 8192, 0, 0, 0, 0, '', 0, 0),
(8096, 0, 0, 'Send me to Honor Point!', 18200, 1, 1, 0, 0, 0, 0, '', 0, 0),
(8096, 1, 0, 'Send me to the Abyssal Shelf!', 17936, 1, 1, 0, 0, 0, 0, '', 0, 0),
(8100, 0, 0, 'Send me to Shatter Point!', 17937, 1, 1, 0, 0, 0, 0, '', 0, 0);

-- Migrate NPC to use SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '', `gossip_menu_id` = 8096 WHERE `entry` = 20235;

-- Condition: Gossip menu ID 0 needs either quest ID 10163 or quest ID 10346 to be incomplete.
-- Condition: Gossip menu ID 1 needs quest ID 10382 to be complete
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`= 15 AND `SourceGroup` = 8096 AND `SourceEntry`IN (0,1);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,8096,0,0,0,9,0,10163,0,0,0,0,'','Gryphoneer Windbellow - Show gossip option 0 if player has taken quest ID 10163 OR'),
(15,8096,0,0,1,9,0,10346,0,0,0,0,'','Gryphoneer Windbellow - Show gossip option 0 if player has taken quest ID 10346 AND'),
(15,8096,1,0,0,28,0,10382,0,0,0,0,'','Gryphoneer Windbellow - Show gossip option 1 if quest ID 10382 is completed');

-- Create SmartAI for Gryphoneer Windbellow
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 20235);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20235,0,0,2,62,0,100,0,8096,0,0,0,11,33899,0,0,0,0,0,7,0,0,0,0,0,0,0,'Gryphoneer Windbellow - On Gossip Option 0 Selected - Cast Spell 33899'),
(20235,0,1,2,62,0,100,0,8096,1,0,0,11,35065,0,0,0,0,0,7,0,0,0,0,0,0,0,'Gryphoneer Windbellow - On Gossip Option 1 Selected - Cast Spell 35065'),
(20235,0,2,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Gryphoneer Windbellow - On Linked Actions - Close Gossip');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
