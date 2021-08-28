INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630148697901793648');

-- Minimum of 3 Thorium Ore drops from Rich Thorium Vein
UPDATE `gameobject_loot_template` SET `MinCount` = 3 WHERE `Item` = 10620 AND `Entry` = 12883;
-- Minimum of 4 Dense Stone drops from Rich Thorium Vein
UPDATE `gameobject_loot_template` SET `MinCount` = 4 WHERE `Item` = 12365 AND `Entry` = 12883;

