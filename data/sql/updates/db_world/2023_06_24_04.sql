-- DB update 2023_06_24_03 -> 2023_06_24_04
DELETE FROM `npc_trainer` WHERE `SpellID` = 41321;
INSERT INTO `npc_trainer` (`ID`, `SpellID`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqLevel`, `ReqSpell`) VALUES
(201013, 41321, 50000, 202, 350, 0, 0);
