INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1644590484974206900');

ALTER TABLE `spell_dbc` CHANGE COLUMN `Field227` `EffectBonusMultiplier_1` FLOAT DEFAULT 0 NOT NULL;
ALTER TABLE `spell_dbc` CHANGE COLUMN `Field228` `EffectBonusMultiplier_2` FLOAT DEFAULT 0 NOT NULL;
ALTER TABLE `spell_dbc` CHANGE COLUMN `Field229` `EffectBonusMultiplier_3` FLOAT DEFAULT 0 NOT NULL;
