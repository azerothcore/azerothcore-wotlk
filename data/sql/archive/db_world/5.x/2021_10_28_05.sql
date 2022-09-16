-- DB update 2021_10_28_04 -> 2021_10_28_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_28_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_28_04 2021_10_28_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1634741438848895794'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634741438848895794');

SET @SIMONE_MENUID := 5868;
SET @PRECIOUS_MENUID := 5869;
SET @FRANKLIN_MENUID := 5870;
SET @ARTORIUS_MENUID := 5871;
SET @NELSON_MENUID := 5872;

-- Add the new gossip menus
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(@FRANKLIN_MENUID, 7043),
(@ARTORIUS_MENUID, 7045),
(@NELSON_MENUID, 7044);

-- Add the gossip options
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(@SIMONE_MENUID, 0, 0, "I am not fooled by your disguise, temptress. Your time to die has come.", 9755, 1, 1, 0, 0, 0, 0, NULL, 0, 0),
(@FRANKLIN_MENUID, 0, 0, "So you are Klinfran the Crazed? Sad, I was expecting an actual challenge. Do you dare face me in your true form?", 9754, 1, 1, 0, 0, 0, 0, NULL, 0, 0),
(@ARTORIUS_MENUID, 0, 0, "I know you as Artorius the Doombringer. Show yourself, demon! Face me!", 9751, 1, 1, 0, 0, 0, 0, NULL, 0, 0),
(@NELSON_MENUID, 0, 0, "A gnome? How pathetic. Face me, demon!", 9753, 1, 1, 0, 0, 0, 0, NULL, 0, 0);

-- Update creature template gossip_menu_id
UPDATE `creature_template` SET `gossip_menu_id` = @FRANKLIN_MENUID WHERE (`entry` = 14529);
UPDATE `creature_template` SET `gossip_menu_id` = @ARTORIUS_MENUID WHERE (`entry` = 14531);
UPDATE `creature_template` SET `gossip_menu_id` = @NELSON_MENUID WHERE (`entry` = 14536);

-- Delete the unneeded/unused creature texts
DELETE FROM `creature_text` WHERE `CreatureID` IN (14527, 14529, 14531, 14536);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_28_05' WHERE sql_rev = '1634741438848895794';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
