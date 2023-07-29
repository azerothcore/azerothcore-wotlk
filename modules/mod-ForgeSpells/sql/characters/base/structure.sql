-- Put only sql structure in this file (create table if exists, delete table, alter table etc...).
-- If you don't use this database, then delete this file.
DROP TABLE IF EXISTS `acore_characters`.`character_spell_charges`;
CREATE TABLE IF NOT EXISTS `acore_characters`.`character_spell_charges` (
  `guid` INT unsigned NOT NULL DEFAULT 0 COMMENT 'Global Unique Identifier, Low part',
  `classMask0` INT unsigned NOT NULL DEFAULT 0,
  `classMask1` INT unsigned NOT NULL DEFAULT 0,
  `classMask2` INT unsigned NOT NULL DEFAULT 0,
  `maxCharges` INT unsigned NOT NULL DEFAULT 0,
  `currentCharges` INT unsigned NOT NULL DEFAULT 0,
  `maxDuration` INT unsigned NOT NULL DEFAULT 0,
  `currentDuration` INT unsigned NOT NULL DEFAULT 0,
  `chargeAura` INT unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`,`classMask0`,`classMask1`,`classMask2`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;
