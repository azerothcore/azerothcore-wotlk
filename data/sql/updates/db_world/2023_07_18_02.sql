-- DB update 2023_07_18_01 -> 2023_07_18_02
-- Darting Hatchling (pet)
UPDATE `creature_template_addon` SET `auras` = 62586 WHERE `entry` = 35396;
UPDATE `creature_template` SET `ScriptName` = 'npc_pet_darting_hatchling' WHERE `entry` = 35396;
