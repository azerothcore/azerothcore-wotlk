--
DELETE FROM `npc_trainer` WHERE `SpellID`=60969 AND `ID` IN (18749, 18772, 26964, 33613, 33636, 33684);
INSERT INTO `npc_trainer` (`ID`, `SpellID`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqLevel`, `ReqSpell`) VALUES
-- Flying Carpet
(18749, 60969, 105000, 197, 300, 0, 0), -- Dalinna <Master Tailoring Trainer>
(18772, 60969, 105000, 197, 300, 0, 0), -- Hama <Master Tailoring Trainer>
(26964, 60969, 105000, 197, 300, 0, 0), -- Alexandra McQueen <Grand Master Tailoring Trainer>
(33613, 60969, 105000, 197, 300, 0, 0), -- Tailoring
(33636, 60969, 105000, 197, 300, 0, 0), -- Miralisse <Master Tailoring Trainer>
(33684, 60969, 105000, 197, 300, 0, 0); -- Weaver Aoa <Master Tailoring Trainer>
