INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620897388675421400');

DELETE FROM `skinning_loot_template` WHERE `Entry`=60042;
INSERT INTO `skinning_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(60042,4234,0,35,0,1,1,1,2,"Heavy Leather"),
(60042,4235,0,5,0,1,1,1,1,"Heavy Hide"),
(60042,4304,0,50,0,1,1,1,2,"Thick Leather"),
(60042,8165,0,5,0,1,1,1,2,"Worn Dragonscale"),
(60042,8169,0,5,0,1,1,1,1,"Thick Hide");
