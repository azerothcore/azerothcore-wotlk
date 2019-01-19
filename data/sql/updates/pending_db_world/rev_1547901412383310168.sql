INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1547901412383310168');

ALTER TABLE `creature_template`
  CHANGE `baseattacktime` `BaseAttackTime` INT(10) UNSIGNED DEFAULT 0  NOT NULL,
  CHANGE `rangeattacktime` `RangeAttackTime` INT(10) UNSIGNED DEFAULT 0  NOT NULL,
  CHANGE `Health_mod` `HealthModifier` FLOAT DEFAULT 1  NOT NULL,
  CHANGE `Mana_mod` `ManaModifier` FLOAT DEFAULT 1  NOT NULL,
  CHANGE `Armor_mod` `ArmorModifier` FLOAT DEFAULT 1  NOT NULL,
  CHANGE `dmg_multiplier` `DamageModifier` FLOAT DEFAULT 1  NOT NULL,
  CHANGE `VerifiedBuild` `VerifiedBuild` SMALLINT(5) DEFAULT '0';
