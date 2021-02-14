INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1613263139054916400');

DELETE FROM `npc_trainer` WHERE (`ID` = 11867) AND (`SpellID` IN (200));
INSERT INTO `npc_trainer` (`ID`, `SpellID`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqLevel`) VALUES
(11867, 200, 10000, 0, 0, 20);
