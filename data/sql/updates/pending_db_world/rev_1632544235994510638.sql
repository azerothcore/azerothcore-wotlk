INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632544235994510638');

-- Remove various high-level consumeables from Scorpid Reaver
DELETE FROM `creature_loot_template` WHERE `Entry` = 4140 AND `Item` IN (4425, 8766, 8932, 8950, 8953, 13443, 13446);

