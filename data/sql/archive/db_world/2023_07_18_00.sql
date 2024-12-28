-- DB update 2023_07_17_01 -> 2023_07_18_00
--
UPDATE `creature_template` SET `skinloot` = 0 WHERE `entry` IN (2966, 2961, 2955);
