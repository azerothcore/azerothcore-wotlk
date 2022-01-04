INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641313085677965557');

-- Removes Handful of Copper Bolt loot from creatures who are not suppose to have it
DELETE FROM `creature_loot_template` WHERE (`Entry` IN (2044, 2673, 6250)) AND (`Item`= 4359);
