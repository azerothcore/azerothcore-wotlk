-- DB update 2023_04_09_08 -> 2023_04_09_09
--
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=1 AND `SourceGroup` IN (17370,18608) AND `SourceEntry`=23894;
INSERT INTO `conditions` VALUES
(1,17370,23894,0,0,22,0,542,0,0,0,0,0,'','Drop Fel Orc Blood Vial only inside Blood Furnace'),
(1,18608,23894,0,0,22,0,542,0,0,0,0,0,'','Drop Fel Orc Blood Vial only inside Blood Furnace');
