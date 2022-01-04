INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641313085677965557');

-- Removes Handful of Copper Bolt loot from creatures who are not suppose to have it
DELETE FROM `creature_loot_template` WHERE  `Entry`=2044 AND `Item`=4359 AND `Reference`=0 AND `GroupId`=0;
DELETE FROM `creature_loot_template` WHERE  `Entry`=2673 AND `Item`=4359 AND `Reference`=0 AND `GroupId`=1;
DELETE FROM `creature_loot_template` WHERE  `Entry`=6250 AND `Item`=4359 AND `Reference`=0 AND `GroupId`=0;
