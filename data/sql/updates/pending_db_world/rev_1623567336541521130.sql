INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623567336541521130');

-- Deletes Empty Tainted/Cursed Jars from various creatures
DELETE FROM `creature_loot_template` WHERE `Entry` IN (742, 2655, 2656, 5308, 5331, 5424, 5833, 6201, 6508, 6556, 6557, 6559, 7086, 7086, 7092, 7093, 7126, 7132, 8959, 9477, 11053, 12221) AND `Item` IN (11948, 11914);
