INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1649660925472546752');
-- Vaelastrasz should be immune to interrupts
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854239 WHERE (`entry` = 13020);
