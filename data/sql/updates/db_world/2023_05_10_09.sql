-- DB update 2023_05_10_08 -> 2023_05_10_09
--
-- Remove ability from creature that doesn't exist
DELETE FROM `creature_template_spell` WHERE  `CreatureID`=601 AND `Index`=0;
