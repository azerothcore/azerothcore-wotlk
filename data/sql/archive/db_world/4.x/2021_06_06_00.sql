-- DB update 2021_06_05_02 -> 2021_06_06_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_05_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_05_02 2021_06_06_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1622547209752619743'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622547209752619743');

UPDATE `item_template` SET `minMoneyLoot` = 0, `maxMoneyLoot` = 1500 WHERE `Entry` = 20766; -- Slimy Bag
UPDATE `item_template` SET `minMoneyLoot` = 500, `maxMoneyLoot` = 2000 WHERE `Entry` = 20767; -- Scum Covered Bag
UPDATE `item_template` SET `minMoneyLoot` = 1000, `maxMoneyLoot` = 2500 WHERE `Entry` = 20768; -- Oozing Bag

UPDATE `item_loot_template` SET `GroupId` = 1 WHERE `Entry` IN (20766, 20767, 20768) AND
`Item` IN (929, 1710, 3385, 3827, 3928, 6149); -- Consumables
UPDATE `item_loot_template` SET `GroupId` = 2 WHERE `Entry` IN (20766, 20767, 20768) AND
`Item` IN (765, 785, 2447, 2449, 2450, 2452, 2453, 3356, 3357, 3818, 3819, 3820, 3821, 4625, 8831, 8838, 8839, 8845, 8846, 13463, 13464); -- Herbs
UPDATE `item_loot_template` SET `GroupId` = 3 WHERE `Entry` IN
(20766, 20767, 20768) AND
`Item` IN (1529, 1705, 7909, 3864, 7910); -- Gems

-- Add missing recipes
DELETE FROM `item_loot_template` WHERE `Entry` IN (20766, 20767, 20768) AND
`Item` IN (3608, 5774, 11167, 7090, 4300, 8029, 7993, 7975, 9295, 8389, 8387, 7992, 7990, 3395, 10312, 10315, 10301, 10320, 8386, 8390, 11225, 15746, 14496, 14466, 14474, 12704, 14504, 14506, 15737, 14470, 12683, 12684, 15757, 14484, 14494, 14508);
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(20766, 3608, 0, 0.24, 0, 1, 4, 1, 1, 'Slimy Bag - Plans: Mighty Iron Hammer'),
(20766, 5774, 0, 0.24, 0, 1, 4, 1, 1, 'Slimy Bag - Pattern: Green Silk Pack'),
(20766, 11167, 0, 0.24, 0, 1, 4, 1, 1, 'Slimy Bag - Formula: Enchant Boots - Lesser Spirit'),
(20766, 7090, 0, 0.24, 0, 1, 4, 1, 1, 'Slimy Bag - Pattern: Green Silk Armor'),
(20766, 4300, 0, 0.24, 0, 1, 4, 1, 1, 'Slimy Bag - Pattern: Guardian Leather Bracers'),
(20767, 8029, 0, 0.20, 0, 1, 4, 1, 1, 'Scum Covered Bag - Plans: Wicked Mithril Blade'),
(20767, 7993, 0, 0.11, 0, 1, 4, 1, 1, 'Scum Covered Bag - Plans: Dazzling Mithril Rapier'),
(20767, 7975, 0, 0.11, 0, 1, 4, 1, 1, 'Scum Covered Bag - Plans: Heavy Mithril Pants'),
(20767, 9295, 0, 0.11, 0, 1, 4, 1, 1, 'Scum Covered Bag - Recipe: Invisibility Potion'),
(20767, 8389, 0, 0.10, 0, 1, 4, 1, 1, 'Scum Covered Bag - Pattern: Big Voodoo Pants'),
(20767, 8387, 0, 0.09, 0, 1, 4, 1, 1, 'Scum Covered Bag - Pattern: Big Voodoo Mask'),
(20767, 7992, 0, 0.08, 0, 1, 4, 1, 1, 'Scum Covered Bag - Plans: Blue Glittering Axe'),
(20767, 7990, 0, 0.07, 0, 1, 4, 1, 1, 'Scum Covered Bag - Plans: Heavy Mithril Helm'),
(20767, 3395, 0, 0.06, 0, 1, 4, 1, 1, 'Scum Covered Bag - Recipe: Limited Invulnerability Potion'),
(20767, 10312, 0, 0.06, 0, 1, 4, 1, 1, 'Scum Covered Bag - Pattern: Red Mageweave Gloves'),
(20767, 10315, 0, 0.06, 0, 1, 4, 1, 1, 'Scum Covered Bag - Pattern: Red Mageweave Shoulders'),
(20767, 10301, 0, 0.06, 0, 1, 4, 1, 1, 'Scum Covered Bag - Pattern: White Bandit Mask'),
(20767, 10320, 0, 0.06, 0, 1, 4, 1, 1, 'Scum Covered Bag - Pattern: Red Mageweave Headband'),
(20767, 8386, 0, 0.06, 0, 1, 4, 1, 1, 'Scum Covered Bag - Pattern: Big Voodoo Robe'),
(20767, 8390, 0, 0.06, 0, 1, 4, 1, 1, 'Scum Covered Bag - Pattern: Big Voodoo Cloak'),
(20767, 11225, 0, 0.06, 0, 1, 4, 1, 1, 'Scum Covered Bag - Formula: Enchant Bracer - Greater Stamina'),
(20768, 15746, 0, 0.13, 0, 1, 4, 1, 1, 'Oozing Bag - Pattern: Chimeric Leggings'),
(20768, 14496, 0, 0.11, 0, 1, 4, 1, 1, 'Oozing Bag - Pattern: Felcloth Hood'),
(20768, 14466, 0, 0.09, 0, 1, 4, 1, 1, 'Oozing Bag - Pattern: Frostweave Tunic'),
(20768, 14474, 0, 0.09, 0, 1, 4, 1, 1, 'Oozing Bag - Pattern: Frostweave Gloves'),
(20768, 12704, 0, 0.09, 0, 1, 4, 1, 1, 'Oozing Bag - Plans: Thorium Leggings'),
(20768, 14504, 0, 0.09, 0, 1, 4, 1, 1, 'Oozing Bag - Pattern: Runecloth Shoulders'),
(20768, 14506, 0, 0.09, 0, 1, 4, 1, 1, 'Oozing Bag - Pattern: Felcloth Robe'),
(20768, 15737, 0, 0.07, 0, 1, 4, 1, 1, 'Oozing Bag - Pattern: Chimeric Boots'),
(20768, 14470, 0, 0.07, 0, 1, 4, 1, 1, 'Oozing Bag - Pattern: Runecloth Tunic'),
(20768, 12683, 0, 0.07, 0, 1, 4, 1, 1, 'Oozing Bag - Plans: Thorium Belt'),
(20768, 12684, 0, 0.07, 0, 1, 4, 1, 1, 'Oozing Bag - Plans: Thorium Bracers'),
(20768, 15757, 0, 0.07, 0, 1, 4, 1, 1, 'Oozing Bag - Pattern: Wicked Leather Pants'),
(20768, 14484, 0, 0.07, 0, 1, 4, 1, 1, 'Oozing Bag - Pattern: Brightcloth Cloak'),
(20768, 14494, 0, 0.07, 0, 1, 4, 1, 1, 'Oozing Bag - Pattern: Brightcloth Pants'),
(20768, 14508, 0, 0.07, 0, 1, 4, 1, 1, 'Oozing Bag - Pattern: Felcloth Shoulders');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_06_00' WHERE sql_rev = '1622547209752619743';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
