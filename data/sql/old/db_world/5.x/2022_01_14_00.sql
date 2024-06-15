-- DB update 2022_01_13_03 -> 2022_01_14_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_13_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_13_03 2022_01_14_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1641662589341242300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641662589341242300');

DELETE FROM `reference_loot_template` WHERE `item` IN (2020,1680,1986,1677,1933);

DELETE FROM `creature_loot_template` WHERE `entry`=539 AND `item`=2020;
INSERT INTO `creature_loot_template` VALUES
(539,2020,0,1.07,0,1,0,1,1,'Pygmy Venom Web Spider - Hollowfang Blade');

DELETE FROM `creature_loot_template` WHERE `entry`=723 AND `item`=1680;
INSERT INTO `creature_loot_template` VALUES
(723,1680,0,32,0,1,0,1,1,'Mosh\'Ogg Butcher - Headchopper');

DELETE FROM `creature_loot_template` WHERE `entry`=709 AND `item`=1986;
INSERT INTO `creature_loot_template` VALUES
(709,1986,0,3.19,0,1,0,1,1,'Mosh\'Ogg Warmonger - Gutrender');

DELETE FROM `creature_loot_template` WHERE `entry`=680 AND `item`=1677;
INSERT INTO `creature_loot_template` VALUES
(680,1677,0,2.72,0,1,0,1,1,'Mosh\'Ogg Lord - Drake-scale Vest');

DELETE FROM `creature_loot_template` WHERE `entry`=619 AND `item`=1933;
INSERT INTO `creature_loot_template` VALUES
(619,1933,0,5.76,0,1,0,1,1,'Defias Conjurer - Staff of Conjuring');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_14_00' WHERE sql_rev = '1641662589341242300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
