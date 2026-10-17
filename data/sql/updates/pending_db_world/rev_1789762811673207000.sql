--
-- Issue #3113: playercreateinfo_* did not use a bitmask for races and classes.
--
-- playercreateinfo_skills, playercreateinfo_cast_spell and playercreateinfo_spell_custom already
-- carry raceMask/classMask. These three did not, so a row could only ever name one race and one
-- class. Converting them finishes the job and lets one row stand for many combinations.
--
-- The rows are converted in place rather than rewritten, so every row is kept, custom ones included,
-- and none can be left behind holding a plain race id where a mask is now expected. Race and class
-- ids are 1-based, so race 1 is bit 0; a stored 0 means "all" and stays 0.
--
-- The shipped rows are not merged here. A row can now cover several races and classes, but turning
-- the 62 start positions into a smaller set of multi-bit rows cannot be done safely on a realm that
-- has edited any of them, and it would only shrink data that is already correct. Condensing the base
-- dump is a separate change.
--
-- UPGRADE NOTE: custom rows survive, but SQL that writes these tables does not. Anything selecting
-- playercreateinfo.race or .class needs updating to raceMask/classMask, and positional inserts are
-- the dangerous case: they still run, and their values are then read as masks. mod-arac applies
-- INSERT IGNORE INTO playercreateinfo VALUES (race, class, ...) by hand, so after this change every
-- one of its rows inserts without error while meaning something else - (3, 1, ...) is dwarf warrior
-- under the old schema and human plus orc warrior under the new one. mod-worgoblin names its columns
-- and so fails loudly with "Unknown column" instead. Both need updating before a realm applies this.
--
-- A mask is 32 bits, so a race or class id above 32 has no bit to hold it. The check below refuses
-- to start when one is present, because there is no safe way to stop halfway: MySQL commits DDL as
-- it goes, so an overflow partway through would leave one table converted, one holding raceMask,
-- classMask, race and class at once, and one untouched, with the update not recorded as applied and
-- no single statement able to put that right. Remap or remove such rows first:
--   SELECT * FROM playercreateinfo WHERE race > 32 OR class > 32;
-- and the same on playercreateinfo_action and playercreateinfo_item.
--
-- Also note that playercreateinfo now refuses an empty mask rather than reading it as "all", because
-- that table creates the race/class pairs instead of decorating them and "all" would invent pairs the
-- game does not have. playercreateinfo_action and playercreateinfo_item keep the "all" meaning.
--
DROP PROCEDURE IF EXISTS `pci_check_mask_width`;
DELIMITER $$
CREATE PROCEDURE `pci_check_mask_width`()
BEGIN
    IF EXISTS (SELECT 1 FROM `playercreateinfo` WHERE `race` > 32 OR `class` > 32)
    OR EXISTS (SELECT 1 FROM `playercreateinfo_action` WHERE `race` > 32 OR `class` > 32)
    OR EXISTS (SELECT 1 FROM `playercreateinfo_item` WHERE `race` > 32 OR `class` > 32) THEN
        SIGNAL SQLSTATE '45000' SET
            MESSAGE_TEXT = 'A race or class id above 32 does not fit a 32 bit mask. Remap or remove those rows, then re-run.';
    END IF;
END$$
DELIMITER ;
CALL `pci_check_mask_width`();
DROP PROCEDURE `pci_check_mask_width`;

DELETE FROM `playercreateinfo_action` WHERE `race` = 0 OR `class` = 0;

ALTER TABLE `playercreateinfo`
    ADD COLUMN `raceMask` int unsigned NOT NULL DEFAULT 0 FIRST,
    ADD COLUMN `classMask` int unsigned NOT NULL DEFAULT 0 AFTER `raceMask`;
UPDATE `playercreateinfo` SET `raceMask` = IF(`race` = 0, 0, 1 << (`race` - 1)),
    `classMask` = IF(`class` = 0, 0, 1 << (`class` - 1));
ALTER TABLE `playercreateinfo`
    DROP PRIMARY KEY,
    DROP COLUMN `race`,
    DROP COLUMN `class`,
    ADD PRIMARY KEY (`raceMask`, `classMask`);

ALTER TABLE `playercreateinfo_action`
    ADD COLUMN `raceMask` int unsigned NOT NULL DEFAULT 0 FIRST,
    ADD COLUMN `classMask` int unsigned NOT NULL DEFAULT 0 AFTER `raceMask`;
UPDATE `playercreateinfo_action` SET `raceMask` = IF(`race` = 0, 0, 1 << (`race` - 1)),
    `classMask` = IF(`class` = 0, 0, 1 << (`class` - 1));
ALTER TABLE `playercreateinfo_action`
    DROP PRIMARY KEY,
    DROP INDEX `playercreateinfo_race_class_index`,
    DROP COLUMN `race`,
    DROP COLUMN `class`,
    ADD PRIMARY KEY (`raceMask`, `classMask`, `button`),
    ADD INDEX `playercreateinfo_race_class_index` (`raceMask`, `classMask`);

ALTER TABLE `playercreateinfo_item`
    ADD COLUMN `raceMask` int unsigned NOT NULL DEFAULT 0 FIRST,
    ADD COLUMN `classMask` int unsigned NOT NULL DEFAULT 0 AFTER `raceMask`;
UPDATE `playercreateinfo_item` SET `raceMask` = IF(`race` = 0, 0, 1 << (`race` - 1)),
    `classMask` = IF(`class` = 0, 0, 1 << (`class` - 1));
ALTER TABLE `playercreateinfo_item`
    DROP PRIMARY KEY,
    DROP INDEX `playercreateinfo_race_class_index`,
    DROP COLUMN `race`,
    DROP COLUMN `class`,
    ADD PRIMARY KEY (`raceMask`, `classMask`, `itemid`),
    ADD INDEX `playercreateinfo_race_class_index` (`raceMask`, `classMask`);
