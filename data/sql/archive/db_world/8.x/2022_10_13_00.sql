-- DB update 2022_10_11_08 -> 2022_10_13_00
--
ALTER TABLE `spell_proc`
  CHANGE `spellId` `SpellId` INT(11) NOT NULL DEFAULT 0 FIRST,
  CHANGE `schoolMask` `SchoolMask` TINYINT(3) UNSIGNED NOT NULL DEFAULT 0 AFTER `SpellId`,
  CHANGE `spellFamilyName` `SpellFamilyName` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0 AFTER `SchoolMask`,
  CHANGE `spellFamilyMask0` `SpellFamilyMask0` INT(10) UNSIGNED NOT NULL DEFAULT 0 AFTER `SpellFamilyName`,
  CHANGE `spellFamilyMask1` `SpellFamilyMask1` INT(10) UNSIGNED NOT NULL DEFAULT 0 AFTER `SpellFamilyMask0`,
  CHANGE `spellFamilyMask2` `SpellFamilyMask2` INT(10) UNSIGNED NOT NULL DEFAULT 0 AFTER `SpellFamilyMask1`,
  CHANGE `typeMask` `ProcFlags` INT(10) UNSIGNED NOT NULL DEFAULT 0 AFTER `SpellFamilyMask2`,
  CHANGE `spellTypeMask` `SpellTypeMask` INT(10) UNSIGNED NOT NULL DEFAULT 0 AFTER `ProcFlags`,
  CHANGE `spellPhaseMask` `SpellPhaseMask` INT(10) UNSIGNED NOT NULL DEFAULT 0 AFTER `SpellTypeMask`,
  CHANGE `hitMask` `HitMask` INT(10) UNSIGNED NOT NULL DEFAULT 0 AFTER `SpellPhaseMask`,
  CHANGE `attributesMask` `AttributesMask` INT(10) UNSIGNED NOT NULL DEFAULT 0 AFTER `HitMask`,
  CHANGE `ratePerMinute` `ProcsPerMinute` FLOAT NOT NULL DEFAULT 0 AFTER `AttributesMask`,
  CHANGE `chance` `Chance` FLOAT NOT NULL DEFAULT 0 AFTER `ProcsPerMinute`,
  CHANGE `cooldown` `Cooldown` INT(10) UNSIGNED NOT NULL DEFAULT 0 AFTER `Chance`,
  CHANGE `charges` `Charges` TINYINT(3) UNSIGNED NOT NULL DEFAULT 0 AFTER `Cooldown`;
  