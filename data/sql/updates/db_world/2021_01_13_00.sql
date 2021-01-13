-- DB update 2021_01_12_01 -> 2021_01_13_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_01_12_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_01_12_01 2021_01_13_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1609035890119156900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1609035890119156900');

/* Filling in *_loot_template comment fields */

/* CREATURE */
UPDATE `creature_loot_template`
LEFT JOIN `item_template` ON `creature_loot_template`.`item` = `item_template`.`entry`
INNER JOIN `creature_template` ON `creature_loot_template`.`entry` = `creature_template`.`lootid`
SET `creature_loot_template`.`comment` = 
(CASE
    WHEN `creature_loot_template`.`reference` = 0 
    THEN CONCAT(`creature_template`.`name`, ' - ', `item_template`.`name`)
    ELSE CONCAT(`creature_template`.`name`, ' - ', '(ReferenceTable)')
END)
WHERE `creature_loot_template`.`comment` = '' OR `creature_loot_template`.`comment` IS NULL;

/* DISENCHANT */
UPDATE `disenchant_loot_template`
LEFT JOIN `item_template` ON `disenchant_loot_template`.`item` = `item_template`.`entry`
SET `disenchant_loot_template`.`comment` = 
(CASE
    WHEN `disenchant_loot_template`.`reference` = 0 
    THEN `item_template`.`name`
    ELSE '(ReferenceTable)'
END)
WHERE `disenchant_loot_template`.`comment` = '' OR `disenchant_loot_template`.`comment` IS NULL;

/* FISHING */
UPDATE `fishing_loot_template`
LEFT JOIN `item_template` ON `fishing_loot_template`.`item` = `item_template`.`entry`
SET `fishing_loot_template`.`comment` = 
(CASE
    WHEN `fishing_loot_template`.`reference` = 0 
    THEN `item_template`.`name`
    ELSE '(ReferenceTable)'
END)
WHERE `fishing_loot_template`.`comment` = '' OR `fishing_loot_template`.`comment` IS NULL;

/* GAMEOBJECT */
UPDATE `gameobject_loot_template`
LEFT JOIN `item_template` ON `gameobject_loot_template`.`item` = `item_template`.`entry`
INNER JOIN `gameobject_template` ON `gameobject_loot_template`.`entry` = `gameobject_template`.`DATA1`
SET `gameobject_loot_template`.`comment` = 
(CASE
    WHEN `gameobject_loot_template`.`reference` = 0 
    THEN CONCAT(`gameobject_template`.`name`, ' - ', `item_template`.`name`)
    ELSE CONCAT(`gameobject_template`.`name`, ' - ', '(ReferenceTable)')
END)
WHERE `gameobject_loot_template`.`comment` = '' OR `gameobject_loot_template`.`comment` IS NULL;

/* ITEM */
UPDATE `item_loot_template`
LEFT JOIN `item_template` AS `i1` ON `item_loot_template`.`item` = `i1`.`entry`
INNER JOIN `item_template` AS `i2` ON `item_loot_template`.`entry` = `i2`.`entry`
SET `item_loot_template`.`comment` = 
(CASE
    WHEN `item_loot_template`.`reference` = 0 
    THEN CONCAT(`i2`.`name`, ' - ', `i1`.`name`)
    ELSE CONCAT(`i2`.`name`, ' - ', '(ReferenceTable)')
END)
WHERE `item_loot_template`.`comment` = '' OR `item_loot_template`.`comment` IS NULL;

/* MAIL */
UPDATE `mail_loot_template`
INNER JOIN `item_template` ON `mail_loot_template`.`item` = `item_template`.`entry`
SET `mail_loot_template`.`comment` = `item_template`.`name`
WHERE `mail_loot_template`.`comment` = '' OR `mail_loot_template`.`comment` IS NULL;

/* MILLING */
UPDATE `milling_loot_template`
SET `milling_loot_template`.`comment` = '(ReferenceTable)'
WHERE `milling_loot_template`.`comment` = '' OR `milling_loot_template`.`comment` IS NULL;

/* PICKPOCKETING */
UPDATE `pickpocketing_loot_template`
LEFT JOIN `item_template` ON `pickpocketing_loot_template`.`item` = `item_template`.`entry`
INNER JOIN `creature_template` ON `pickpocketing_loot_template`.`entry` = `creature_template`.`entry`
SET `pickpocketing_loot_template`.`comment` = 
(CASE
    WHEN `pickpocketing_loot_template`.`reference` = 0 
    THEN CONCAT(`creature_template`.`name`, ' - ', `item_template`.`name`)
    ELSE CONCAT(`creature_template`.`name`, ' - ', '(ReferenceTable)')
END)
WHERE `pickpocketing_loot_template`.`comment` = '' OR `pickpocketing_loot_template`.`comment` IS NULL;

/* PROSPECTING */
UPDATE `prospecting_loot_template`
LEFT JOIN `item_template` ON `prospecting_loot_template`.`item` = `item_template`.`entry`
SET `prospecting_loot_template`.`comment` = 
(CASE
    WHEN `prospecting_loot_template`.`reference` = 0 
    THEN `item_template`.`name`
    ELSE '(ReferenceTable)'
END)
WHERE `prospecting_loot_template`.`comment` = '' OR `prospecting_loot_template`.`comment` IS NULL;

/* REFERENCE */
UPDATE `reference_loot_template`
LEFT JOIN `item_template` ON `reference_loot_template`.`item` = `item_template`.`entry`
SET `reference_loot_template`.`comment` = 
(CASE
    WHEN `reference_loot_template`.`reference` = 0 
    THEN `item_template`.`name`
    ELSE '(ReferenceTable)'
END)
WHERE `reference_loot_template`.`comment` = '' OR `reference_loot_template`.`comment` IS NULL;

/* SKINNING */
UPDATE `skinning_loot_template`
LEFT JOIN `item_template` ON `skinning_loot_template`.`item` = `item_template`.`entry`
INNER JOIN `creature_template` ON `skinning_loot_template`.`entry` = `creature_template`.`entry`
SET `skinning_loot_template`.`comment` = 
(CASE
    WHEN `skinning_loot_template`.`reference` = 0 
    THEN CONCAT(`creature_template`.`name`, ' - ', `item_template`.`name`)
    ELSE CONCAT(`creature_template`.`name`, ' - ', '(ReferenceTable)')
END)
WHERE `skinning_loot_template`.`comment` = '' OR `skinning_loot_template`.`comment` IS NULL;

/* SPELL */
UPDATE `spell_loot_template`
LEFT JOIN `item_template` ON `spell_loot_template`.`item` = `item_template`.`entry`
SET `spell_loot_template`.`comment` = 
(CASE
    WHEN `spell_loot_template`.`reference` = 0 
    THEN `item_template`.`name`
    ELSE '(ReferenceTable)'
END)
WHERE `spell_loot_template`.`comment` = '' OR `spell_loot_template`.`comment` IS NULL;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
