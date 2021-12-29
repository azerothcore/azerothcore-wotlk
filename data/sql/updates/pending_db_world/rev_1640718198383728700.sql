INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640718198383728700');

-- Remove 'Jingling Bell' should not drop from any creature
DELETE FROM `creature_loot_template` WHERE `Item`=21308;
