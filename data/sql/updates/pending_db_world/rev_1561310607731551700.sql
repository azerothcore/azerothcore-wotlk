INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1561310607731551700');

-- Warsong Marksman corpses on Garrosh's Landing should be dead
UPDATE `creature_addon` SET `bytes1`=0,`auras`=29266 WHERE `guid` IN (110545,110546,110540,110541,110544,110547,110551,110552,110553,110554);
