INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634048043586591327');

-- Fixes disenchanting loot for Dusty Mail Boots
UPDATE `item_template` SET `DisenchantID` = 45 WHERE `entry` = 19509;
