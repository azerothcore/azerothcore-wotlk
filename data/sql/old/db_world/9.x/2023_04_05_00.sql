-- DB update 2023_04_04_14 -> 2023_04_05_00
--
-- Removes strange rows from creature_template_spell
DELETE FROM `creature_template_spell` WHERE `CreatureID`=290;
