INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623303655379442308');

-- Unify and increase drop chance for Diabolical Plans to 8% (was 1.2% .. 3%)
UPDATE `creature_loot_template` SET `Chance`=8 WHERE `Item` IN (23777, 23797);
