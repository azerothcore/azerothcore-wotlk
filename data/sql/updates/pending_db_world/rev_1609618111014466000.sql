INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1609618111014466000');
DELETE FROM `npc_trainer` WHERE (`ID` = 17482) AND (`SpellID` = -200012);
INSERT INTO `npc_trainer` (`ID`, `SpellID`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqLevel`) VALUES
(17482, -200012, 0, 0, 0, 0);
