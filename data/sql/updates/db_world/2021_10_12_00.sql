-- DB update 2021_10_10_38 -> 2021_10_12_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_10_38';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_10_38 2021_10_12_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1628024682672891800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628024682672891800');

-- spell id 9205, 50% chance to reset threat on melee attack done
UPDATE `creature_template_addon` SET `auras`='9205' WHERE `entry` IN (15318, 15521);
-- Loro, also found missing passive aura "shield spike" in sniffs
DELETE FROM `creature_template_addon` WHERE  `entry`=5714;
INSERT INTO `creature_template_addon` (`entry`, `auras`) VALUES (5714, '9205 12782');
UPDATE `creature_template_addon` SET `auras`='9205' WHERE  `entry`=2440;

-- 25% chance to reset threat  on melee attack done
UPDATE `creature_template_addon` SET `auras`='11838' WHERE  `entry` IN (7267, 10478, 14605);
DELETE FROM `creature_template_addon` WHERE  `entry`=14880;
INSERT INTO `creature_template_addon` (`entry`, `auras`) VALUES (14880, '11838');

-- 20% chance to reset threat  on melee attack done
UPDATE `creature_template_addon` SET `auras`='13767' WHERE  `entry`=9032;
-- Crest Killer, also added missing aura Thrash
DELETE FROM `creature_template_addon` WHERE `entry`=9680;
INSERT INTO `creature_template_addon` VALUES (9680, 0, 0, 0, 0, 0, 0, '13767 3417');

-- 10% chance to reset threat  on melee attack done
UPDATE `creature_template_addon` SET `auras`='25592' WHERE  `entry`=15323;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_12_00' WHERE sql_rev = '1628024682672891800';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
