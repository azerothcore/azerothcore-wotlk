--
DELETE FROM `npc_trainer` WHERE `SpellID`=-201041 AND `ID` IN (18749, 18772, 26964, 33613, 33636, 33684);
INSERT INTO `npc_trainer` (`ID`, `SpellID`) VALUES
-- Flying Carpet
(18749, -201041), -- Dalinna <Master Tailoring Trainer>
(18772, -201041), -- Hama <Master Tailoring Trainer>
(26964, -201041), -- Alexandra McQueen <Grand Master Tailoring Trainer>
(33613, -201041), -- Tailoring
(33636, -201041), -- Miralisse <Master Tailoring Trainer>
(33684, -201041); -- Weaver Aoa <Master Tailoring Trainer>
