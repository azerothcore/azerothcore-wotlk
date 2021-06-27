INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624770439358526029');

-- Remove Crisp Spider Meat from Deviate Lurker and Deviate Creeper
DELETE FROM `creature_loot_template` WHERE `Entry` IN (3632, 3641) AND `Item` = 1081;


