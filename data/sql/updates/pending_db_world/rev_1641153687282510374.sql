INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641153687282510374');

-- Removes Ez-Thro Dynamite II  from mob. Item is not a Mod Drop Item per UDB verification
DELETE FROM `creature_loot_template` WHERE  `Entry`=12178 AND `Item`=18588 AND `Reference`=0 AND `GroupId`=0;
DELETE FROM `creature_loot_template` WHERE  `Entry`=13136 AND `Item`=18588 AND `Reference`=0 AND `GroupId`=0;
