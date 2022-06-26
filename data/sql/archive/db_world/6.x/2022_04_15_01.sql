-- DB update 2022_04_15_00 -> 2022_04_15_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_15_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_15_00 2022_04_15_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1621544089475974100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621544089475974100');

DELETE FROM `gossip_menu` WHERE (`MenuID` = 9676) AND (`TextID` IN (13287));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(9676, 13287);

DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 9676) AND (`OptionID` IN (0));
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(9676, 0, 0, 'I''m ready to battle the dreadlord, sire.', 28508, 1, 1, 0, 0, 0, 0, '', 0, 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_15_01' WHERE sql_rev = '1621544089475974100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
