-- DB update 2021_04_25_08 -> 2021_04_25_09
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_04_25_08';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_04_25_08 2021_04_25_09 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1618709045226609356'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`)
VALUES ('1618709045226609356');

# Delete current loot reference loot templates for Broken Tooth
DELETE
FROM `creature_loot_template`
WHERE Comment LIKE '%Broken Tooth - (ReferenceTable%';

# Delete the junk Broken Tooth currently drops like Melon Juice
DELETE
FROM `creature_loot_template`
WHERE `Entry` = 2850
  AND Item NOT IN (1688, 4580, 8146);

# Update chance for Long Soft Tail
UPDATE `creature_loot_template` SET Chance = 19 WHERE Entry = 2850 AND Item = 1688;

# Update chance for Sabertooth Fang
UPDATE `creature_loot_template` SET Chance = 11 WHERE Entry = 2850 AND Item = 4580;

# Add Thick Leather to Broken Tooth loot table
INSERT INTO `creature_loot_template`
VALUES (2850, 4304, 0, 3, 0, 1, 0, 1, 1, 'Broken Tooth - Thick Leather');

# Add a guaranteed green to drop
INSERT INTO creature_loot_template
VALUES (2850, 7493, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Captain''s Bracers'),
       (2850, 7492, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Captain''s Cloak'),
       (2850, 9885, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Huntsman''s Boots'),
       (2850, 7461, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Knight''s Bracers'),
       (2850, 7483, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Ranger Cloak'),
       (2850, 7474, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Regal Cloak'),
       (2850, 7476, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Regal Sash'),
       (2850, 7441, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Sentinel Cap'),
       (2850, 7448, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Sentinel Girdle'),
       (2850, 9879, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Sorcerer Bracelets'),
       (2850, 9876, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Sorcerer Slippers'),
       (2850, 7435, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Twilight Mantle'),
       (2850, 7430, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Twilight Robe'),
       (2850, 9848, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Conjurer''s Gloves'),
       (2850, 9850, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Conjurer''s Mantle'),
       (2850, 9890, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Huntsman''s Cape'),
       (2850, 7459, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Knight''s Pauldrons'),
       (2850, 9864, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Renegade Boots'),
       (2850, 9871, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Renegade Leggings'),
       (2850, 9875, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Sorcerer Sash'),
       (2850, 9856, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Archer''s Boots'),
       (2850, 9852, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Conjurer''s Robe'),
       (2850, 7447, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Sentinel Bracers'),
       (2850, 9877, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Sorcerer Cloak'),
       (2850, 7434, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Twilight Boots'),
       (2850, 9849, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Conjurer''s Hood'),
       (2850, 9844, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Conjurer''s Vest'),
       (2850, 9886, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Huntsman''s Bands'),
       (2850, 7454, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Knight''s Breastplate'),
       (2850, 9870, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Renegade Circlet'),
       (2850, 7438, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Twilight Belt'),
       (2850, 7433, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Twilight Gloves'),
       (2850, 7431, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Twilight Pants'),
       (2850, 7455, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Knight''s Legguards'),
       (2850, 7443, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Sentinel Gloves'),
       (2850, 9862, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Archer''s Trousers'),
       (2850, 7462, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Knight''s Girdle'),
       (2850, 9872, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Renegade Pauldrons'),
       (2850, 9880, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Sorcerer Gloves'),
       (2850, 7437, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Twilight Cuffs'),
       (2850, 9851, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Conjurer''s Breeches'),
       (2850, 7458, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Knight''s Boots'),
       (2850, 7444, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Sentinel Boots'),
       (2850, 7432, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Twilight Cowl'),
       (2850, 9863, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Archer''s Shoulderpads'),
       (2850, 7457, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Knight''s Gauntlets'),
       (2850, 9866, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Renegade Chestguard'),
       (2850, 9896, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Jazeraint Bracers'),
       (2850, 7446, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Sentinel Cloak'),
       (2850, 7445, 0, 0, 0, 1, 1, 1, 1, 'Broken Tooth - Sentinel Shoulders');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
