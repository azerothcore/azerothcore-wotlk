INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630927565231100667');

-- Remove Frost Oil from Vilebranch Witch Doctor, Tar Creeper, and Deadwood Gardener
DELETE FROM `creature_loot_template` WHERE `Entry` IN (2640, 6527, 7154) AND `Item` = 3829;

