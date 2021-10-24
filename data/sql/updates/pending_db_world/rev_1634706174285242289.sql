INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634706174285242289');

-- fixed Chicken Egg (id 11110) error loot
DELETE FROM `creature_loot_template` WHERE `Entry` = 525 AND `Item` = 11110; 
