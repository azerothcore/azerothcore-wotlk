-- DB update 2023_04_19_01 -> 2023_04_19_02
--
-- Remove skinning loot from Buzzard creatures
UPDATE `creature_template` SET `skinloot` = 0 WHERE `entry` IN (5982, 5983, 5436, 7376);
DELETE FROM `skinning_loot_template` WHERE `Entry` IN (5982, 5983);
