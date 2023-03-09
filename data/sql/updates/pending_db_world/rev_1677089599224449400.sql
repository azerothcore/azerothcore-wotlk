--
DELETE FROM `npc_trainer` WHERE `SpellID`=60969;
INSERT INTO `npc_trainer` (`ID`, `SpellID`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqLevel`, `ReqSpell`) VALUES
(201040, 60969, 105000, 197, 300, 0, 0);
