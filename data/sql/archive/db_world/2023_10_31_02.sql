-- DB update 2023_10_31_01 -> 2023_10_31_02
-- Fire Nova Totem VII - Cast Fire Nova (Rank 7)
UPDATE `creature_template_spell` SET `Spell` = 25537, `VerifiedBuild` = 42328 WHERE `CreatureID` = 15483 AND `Index` = 0;
