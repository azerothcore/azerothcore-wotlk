INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636923395116068300');

-- Remove Fifth Mosharu Tablet from Smolderthorn Shadow Priest
DELETE FROM `creature_loot_template` WHERE `item` = 12740;
