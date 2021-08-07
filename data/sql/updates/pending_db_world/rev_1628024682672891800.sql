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
INSERT INTO `creature_template_addon` (`entry`, `auras`) VALUES ('14880', '11838');

-- 20% chance to reset threat  on melee attack done
UPDATE `creature_template_addon` SET `auras`='13767' WHERE  `entry`=9032;
-- Crest Killer, also added missing aura Thrash
DELETE FROM `creature_template_addon` WHERE `entry`=9680;
INSERT INTO `creature_template_addon` VALUES (9680, 0, 0, 0, 0, 0, 0, '13767 3417');

-- 10% chance to reset threat  on melee attack done
UPDATE `creature_template_addon` SET `auras`='25592' WHERE  `entry`=15323;
