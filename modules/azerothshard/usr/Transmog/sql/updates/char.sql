CREATE TABLE IF NOT EXISTS `custom_transmogrification` (
    `GUID` INT(10) UNSIGNED NOT NULL DEFAULT '0',
    `FakeOwner` INT(10) UNSIGNED NOT NULL DEFAULT '0',
    `FakeEntry` INT(10) UNSIGNED NOT NULL DEFAULT '0'
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB;

REPLACE INTO custom_transmogrification (GUID, FakeOwner, FakeEntry) SELECT guid, FakeOwner, FakeEntry FROM item_instance WHERE FakeOwner != 0 AND FakeEntry != 0;
ALTER TABLE `item_instance`
    DROP COLUMN `FakeEntry`,
    DROP COLUMN `FakeOwner`;
ALTER TABLE `custom_transmogrification`
    DROP COLUMN `FakeOwner`;
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE TABLE `custom_transmogrification_sets` (
  `Owner` int(10) unsigned NOT NULL COMMENT 'Player guidlow',
  `PresetID` tinyint(3) unsigned NOT NULL COMMENT 'Preset identifier',
  `SetName` text COMMENT 'SetName',
  `SetData` text COMMENT 'Slot1 Entry1 Slot2 Entry2',
  PRIMARY KEY (`Owner`,`PresetID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
ALTER TABLE `custom_transmogrification`
    COMMENT='6_1',
    ADD INDEX `Owner` (`Owner`);

ALTER TABLE `custom_transmogrification_sets`
    COMMENT='6_1';
ALTER TABLE `custom_transmogrification`
	COMMENT='6_2',
	COLLATE='utf8_general_ci';
