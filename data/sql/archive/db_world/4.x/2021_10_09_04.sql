-- DB update 2021_10_09_03 -> 2021_10_09_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_09_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_09_03 2021_10_09_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1632554476888218890'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632554476888218890');

-- Add vendor option to Innkeeper Shaussiy
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 347 AND `OptionID` = 3;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(347, 3, 1, 'Let me browse your goods.', 2823, 3, 128, 0, 0, 0, 0, '', 0, 0);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_09_04' WHERE sql_rev = '1632554476888218890';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
