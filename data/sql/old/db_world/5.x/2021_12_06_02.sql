-- DB update 2021_12_06_01 -> 2021_12_06_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_06_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_06_01 2021_12_06_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638445356401170100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638445356401170100');

UPDATE `creature` SET `spawntimesecs`=60 WHERE `id`=15664;
UPDATE `smart_scripts` SET `event_param1`=6763 WHERE `entryorguid` IN (15664) AND `source_type`=0 AND `id` IN (0,1);
UPDATE `conditions` SET `SourceGroup`=6763 WHERE `SourceTypeOrReferenceId`=15 AND `ConditionTypeOrReference`=2 AND `ConditionValue1`=21211;
DELETE FROM `gossip_menu` WHERE `MenuID`=21252 AND `TextID`=8077;
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 21251 AND `OptionID` = 0;
UPDATE `creature_template` SET `gossip_menu_id`=6763 WHERE `entry`=15664;

DELETE FROM `gossip_menu` WHERE `MenuID` = 6763;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(6763, 8076); 

DELETE FROM `gossip_menu_option` WHERE `MenuID` = 6763;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`) VALUES
(6763, 0, 0, 'Sprinkle some of the reindeer dust onto Metzen.', 0, 1, 1, 6761);

DELETE FROM `spell_scripts` WHERE `id`=25952;
INSERT INTO `spell_scripts` (`id`,`effIndex`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
(25952,0,0,18,0,0,0,0,0,0,0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_06_02' WHERE sql_rev = '1638445356401170100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
