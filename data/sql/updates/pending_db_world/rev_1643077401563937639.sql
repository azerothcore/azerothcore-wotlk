INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643077401563937639');

UPDATE `gameobject_loot_template` SET `Chance`= 25 WHERE  `Entry`=9677 AND `Item` IN (10715, 10717, 10718, 10722);
