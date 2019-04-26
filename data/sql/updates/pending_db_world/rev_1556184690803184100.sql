INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1556184690803184100');

-- Alterac Ram faction Stormpike Guard 
UPDATE `creature_template` SET `faction`='7' WHERE `entry` IN (10990, 22726, 31921, 37237);

-- Frostwolf faction Frostwolf Clan
UPDATE `creature_template` SET `faction`='7' WHERE `entry` IN (10981, 22737, 31975, 37294);
