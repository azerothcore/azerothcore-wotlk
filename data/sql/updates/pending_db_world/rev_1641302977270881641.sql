INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641302977270881641');

-- Removes improper loot Broken Silithid Chitin from Silithus Rare Zora
DELETE FROM `creature_loot_template` WHERE  `Entry`=14474 AND `Item`=20499 AND `Reference`=0 AND `GroupId`=0;
