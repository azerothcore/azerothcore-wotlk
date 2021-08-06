INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627805665809266322');

-- Delete 'Recipe: Savory Deviate Delight' from RLT 24701
DELETE FROM `reference_loot_template` WHERE `Entry` = 24701 AND `Item` = 6661;

