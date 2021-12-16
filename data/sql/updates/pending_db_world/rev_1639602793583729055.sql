INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639602793583729055');

-- remove item from loot table
DELETE FROM `creature_loot_template` WHERE  `Entry`=14277 AND `Item`=3820 AND `Reference`=0 AND `GroupId`=0;
