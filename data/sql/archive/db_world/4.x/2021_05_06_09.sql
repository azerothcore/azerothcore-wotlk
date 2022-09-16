-- DB update 2021_05_06_08 -> 2021_05_06_09
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_06_08';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_06_08 2021_05_06_09 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1619824464997653100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619824464997653100');

UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=4888, `OptionText`="The bank" WHERE `OptionBroadcastTextID`=7066;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=0, `OptionText`="The guild master" WHERE `OptionBroadcastTextID`=2870;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=4893, `OptionText`="The inn" WHERE `OptionBroadcastTextID`=7075;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=0, `OptionText`="The mailbox" WHERE `OptionBroadcastTextID` IN (45381, 5514, 4895);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=0, `OptionText`="The auction house" WHERE `OptionBroadcastTextID` IN (44627, 5515);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=0, `OptionText`="The zeppelin master" WHERE `OptionBroadcastTextID`=5518;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=0, `OptionText`="The weapon master" WHERE `OptionBroadcastTextID` IN (15230, 7253);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=8521, `OptionText`="The stable master" WHERE `OptionBroadcastTextID` IN (45383,8521);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=0, `OptionText`="The officers' lounge" WHERE `OptionBroadcastTextID`=9756;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=0, `OptionText`="The battlemaster" WHERE `OptionBroadcastTextID` IN (19209, 10359);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
