-- Fixes Horn of Winter rank chain
UPDATE `npc_trainer` SET `ReqSpell` = 57330 WHERE `SpellID` = 57623; -- Rank 2 requires Rank 1
