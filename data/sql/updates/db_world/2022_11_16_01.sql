-- DB update 2022_11_16_00 -> 2022_11_16_01
-- Remove Garrick Padfoot rage generation
UPDATE `creature_template` SET `ManaModifier` = 0 WHERE (`entry` = 103);
