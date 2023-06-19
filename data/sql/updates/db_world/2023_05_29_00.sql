-- DB update 2023_05_28_04 -> 2023_05_29_00
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|16|64|256|1024|2048|4096|65536|8388608|33554432 WHERE `entry` = 21102;

