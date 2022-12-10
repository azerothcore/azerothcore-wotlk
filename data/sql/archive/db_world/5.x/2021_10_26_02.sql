-- DB update 2021_10_26_01 -> 2021_10_26_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_26_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_26_01 2021_10_26_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1635085785347733398'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635085785347733398');

-- Add missing gossip text
DELETE FROM `gossip_menu` WHERE `MenuID`=5852 AND `TextID`=7014;
INSERT INTO `gossip_menu` (`MenuID`,`TextID`) VALUES (5852, 7014);

-- Add missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE `MenuID`=5851;
INSERT INTO `gossip_menu_option` (`MenuID`,`OptionID`,`OptionIcon`,`OptionText`,`OptionBroadcastTextID`,`OptionType`,`OptionNpcFlag`,`ActionMenuID`,`ActionPoiID`,`BoxCoded`,`BoxMoney`,`BoxText`,`BoxBroadcastTextID`,`VerifiedBuild`) VALUES
(5851,0,0,"Chief Bloodhoof, this may sound like an odd request... but I have a young ward who is quite shy.  You are a hero to him, and he asked me to get your hoofprint.",9670,1,1,5852,0,0,0,NULL,0,0);

-- Condition for Cairne Bloodhoof Gossip menu option condition type Quest taken
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=5851 AND `SourceEntry`=0 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 5851, 0, 0, 0, 9, 0, 925, 0, 0, 0, 0, 0, '', 'Show gossip menu 5851 option id 0 if quest Cairne''s Hoofprint has been taken.');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_26_02' WHERE sql_rev = '1635085785347733398';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
