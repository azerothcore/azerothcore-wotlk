-- DB update 2025_01_11_01 -> 2025_01_12_00
--
-- Removes `Monster - Axe, 2H Horde Massive Spiked` from creature `Rorgish Jowl`
UPDATE `creature_equip_template` SET `ItemID1` = 0 WHERE (`CreatureID` = 10639 AND `ItemID1` = 14870);
