-- DB update 2023_03_21_03 -> 2023_03_21_04
--
DELETE FROM `npc_trainer` WHERE `SpellID`=60969 AND `ID` IN (201040, 201041);
INSERT INTO `npc_trainer` (`ID`, `SpellID`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqLevel`, `ReqSpell`) VALUES
(201040, 60969, 105000, 197, 300, 0, 0);
