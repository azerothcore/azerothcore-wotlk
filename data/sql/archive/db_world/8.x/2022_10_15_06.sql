-- DB update 2022_10_15_05 -> 2022_10_15_06
--
-- Remove skinning loot from Giant Buzzard
UPDATE `creature_template` SET `skinloot` = 0 WHERE `entry` = 2831;
DELETE FROM `skinning_loot_template` WHERE `Entry` = 2831;
