INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1550009247084015800');

-- Originally from Shin
-- creature_template https://github.com/azerothcore/azerothcore-wotlk/pull/1322/files
ALTER TABLE `creature_template`
  CHANGE `baseattacktime` `BaseAttackTime` INT(10) UNSIGNED DEFAULT 0  NOT NULL,
  CHANGE `rangeattacktime` `RangeAttackTime` INT(10) UNSIGNED DEFAULT 0  NOT NULL,
  CHANGE `Health_mod` `HealthModifier` FLOAT DEFAULT 1  NOT NULL,
  CHANGE `Mana_mod` `ManaModifier` FLOAT DEFAULT 1  NOT NULL,
  CHANGE `Armor_mod` `ArmorModifier` FLOAT DEFAULT 1  NOT NULL,
  CHANGE `dmg_multiplier` `DamageModifier` FLOAT DEFAULT 1  NOT NULL,
  CHANGE `VerifiedBuild` `VerifiedBuild` SMALLINT(5) DEFAULT '0';
  
-- Smart_Scripts https://github.com/azerothcore/azerothcore-wotlk/pull/1324/files
ALTER TABLE `smart_scripts`
  ADD COLUMN `event_param5` INT(10) UNSIGNED DEFAULT 0 NOT NULL AFTER `event_param4`,
  ADD COLUMN `target_param4` INT(10) UNSIGNED DEFAULT 0 NOT NULL AFTER `target_param3`;
  
--gameobject_template_addon https://github.com/azerothcore/azerothcore-wotlk/pull/1368
DROP TABLE IF EXISTS `gameobject_template_addon`;
CREATE TABLE `gameobject_template_addon`(
    `entry` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
    `faction` smallint(5) unsigned NOT NULL DEFAULT '0',
    `flags` int(10) unsigned NOT NULL DEFAULT '0',
    `mingold` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
    `maxgold` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
    PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `gameobject_template_addon` (`entry`, `faction`, `flags`)
SELECT `entry`, `faction`, `flags` FROM `gameobject_template`;

ALTER TABLE `gameobject_template`
DROP COLUMN `faction`,
DROP COLUMN `flags`,
CHANGE COLUMN `VerifiedBuild` `VerifiedBuild` smallint(5) DEFAULT '0';