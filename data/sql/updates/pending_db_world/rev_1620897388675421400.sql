INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620897388675421400');

DELETE FROM `skinning_loot_template` WHERE `Entry` BETWEEN 60041 AND 60048;
DELETE FROM `skinning_loot_template` WHERE `Entry` IN (2725,4323,4324,5278,2447,2726,4328,4329,4331,4334,4339,10678,14398,12129,5276,8196,8197,8198);
INSERT INTO `skinning_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(60042,4234,0,35,0,1,1,1,2,"Heavy Leather"),
(60042,4235,0,5,0,1,1,1,1,"Heavy Hide"),
(60042,4304,0,50,0,1,1,1,2,"Thick Leather"),
(60042,8165,0,5,0,1,1,1,2,"Worn Dragonscale"),
(60042,8169,0,5,0,1,1,1,1,"Thick Hide");
