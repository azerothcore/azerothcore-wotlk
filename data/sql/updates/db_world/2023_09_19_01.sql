-- DB update 2023_09_19_00 -> 2023_09_19_01
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|16 WHERE `entry` = 17543;
