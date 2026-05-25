-- DB update 2024_12_08_02 -> 2024_12_09_00
--
-- Removed the requirement of the player needing to have Blacksmithing to Interact with her
UPDATE `creature_template` SET `trainer_spell` = 0 WHERE (`entry` = 29505);
