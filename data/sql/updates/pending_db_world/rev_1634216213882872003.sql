INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634216213882872003');

-- Remove Dark Iron Ore from various NPCs
DELETE FROM `creature_loot_template` WHERE `Entry` NOT IN (8905, 8906, 8907, 8908, 8923, 9502) AND `Item` = 11370;

