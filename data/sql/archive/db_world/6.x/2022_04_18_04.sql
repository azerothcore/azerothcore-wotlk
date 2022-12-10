-- DB update 2022_04_18_03 -> 2022_04_18_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_18_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_18_03 2022_04_18_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1649549626279664100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1649549626279664100');

-- Gryan Stoutmantle gossip
DELETE FROM `gossip_menu` WHERE `MenuID` = 61029;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (61029, 50020);
UPDATE `creature_template` SET `gossip_menu_id` = 61029 WHERE `entry` = 234;

-- Farmer_Furlbrow
DELETE FROM `gossip_menu` WHERE `MenuID` = 61030;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (61030, 50019);
UPDATE `creature_template` SET `gossip_menu_id` = 61030 WHERE `entry` = 237;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_18_04' WHERE sql_rev = '1649549626279664100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
