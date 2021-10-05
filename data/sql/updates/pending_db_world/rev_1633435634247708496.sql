INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633435634247708496');

-- Giant Clam(2264) Vile reef loot fixes

-- Increased the loot chance for Blue Pearl(4611) to 100%
UPDATE `gameobject_loot_template` SET `Chance` = 100 WHERE (`Entry` = 2264) AND (`Item` = 4611);
-- Increased the loot chance for Giant Clam Meat(4655) to 35%
UPDATE `gameobject_loot_template` SET `Chance` = 35 WHERE (`Entry` = 2264) AND (`Item` = 4655);

