-- DB update 2026_03_22_02 -> 2026_03_22_03
--
CREATE TABLE `creature_immunities` (
  `ID` int NOT NULL,
  `SchoolMask` tinyint NOT NULL DEFAULT '0',
  `DispelTypeMask` smallint NOT NULL DEFAULT '0',
  `MechanicsMask` bigint NOT NULL DEFAULT '0',
  `Effects` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `Auras` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `ImmuneAoE` tinyint(1) NOT NULL DEFAULT '0',
  `ImmuneChain` tinyint(1) NOT NULL DEFAULT '0',
  `Comment` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `creature_template` ADD `CreatureImmunitiesId` int NOT NULL DEFAULT '0' AFTER `RegenHealth`;

UPDATE `creature_template` SET `CreatureImmunitiesId`=COALESCE((SELECT ci.`ID` FROM `creature_immunities` ci WHERE ci.`SchoolMask`=`spell_school_immune_mask` AND ci.`MechanicsMask`=`mechanic_immune_mask`*2),0);

ALTER TABLE `creature_template`
  DROP `spell_school_immune_mask`,
  DROP `mechanic_immune_mask`;

ALTER TABLE `creature_template` DROP COLUMN `scale`;
