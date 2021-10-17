-- DB update 2019_02_14_02 -> 2019_02_14_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_02_14_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_02_14_02 2019_02_14_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1550101831834633300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1550101831834633300');

-- Fallen Hero of the Horde 
-- Fixes gossip text and completion of quest
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=840;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14,840,1451,0,1,9,0,2801,0,0,0,0,0,"","Show gossip text 1451 if player has quest 'A Tale of Sorrow' taken");

DELETE FROM `gossip_menu` WHERE `MenuID` IN (841, 842);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(841,1392),
(842,1411);

UPDATE `gossip_menu_option` SET `OptionText`="Why are you here?", `OptionBroadcastTextID`=3582, `ActionMenuID`=841 WHERE `MenuID`=840 AND `OptionID`=0;
DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (841, 842);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(841,0,0,"Continue with your story.",3601,1,1,842,0,0,0,"",0,0),
(842,0,0,"Tragic...",3830,1,1,0,0,0,0,"",0,0);

DELETE FROM `smart_scripts` WHERE `entryorguid`=7572;
INSERT INTO `smart_scripts` VALUES 
(7572, 0, 0, 2, 62, 0, 100, 1, 842, 0, 0, 0, 0, 26, 2784, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fallen Hero of the Horde - On Gossip Option 0 Selected - Quest Credit \'Fall From Grace\''),
(7572, 0, 1, 3, 62, 0, 100, 1, 881, 0, 0, 0, 0, 26, 2801, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fallen Hero of the Horde - On Gossip Option 1 Selected - Quest Credit \'A Tale of Sorrow\''),
(7572, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fallen Hero of the Horde - On Gossip Option 0 Selected - Close Gossip'),
(7572, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fallen Hero of the Horde - On Gossip Option 1 Selected - Close Gossip');


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
