-- DB update 2022_12_06_20 -> 2022_12_06_21
--
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (18498,18499,18500,18501,18503) AND `source_type`=0 AND `id`=12;
INSERT INTO `smart_scripts` VALUES
(18498,0,12,0,54,0,100,0,0,0,0,0,0,11,33422,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Unliving Soldier - on just summoned - cast Phase In'),
(18499,0,12,0,54,0,100,0,0,0,0,0,0,11,33422,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Unliving Sorcerer - on just summoned - cast Phase In'),
(18500,0,12,0,54,0,100,0,0,0,0,0,0,11,33422,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Unliving Cleric - on just summoned - cast Phase In'),
(18501,0,12,0,54,0,100,0,0,0,0,0,0,11,33422,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Unliving Stalker - on just summoned - cast Phase In'),
(18503,0,12,0,54,0,100,0,0,0,0,0,0,11,33422,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Phantasmal Possessor - on just summoned - cast Phase In');
