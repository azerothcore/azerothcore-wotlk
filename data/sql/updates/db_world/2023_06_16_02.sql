-- DB update 2023_06_16_01 -> 2023_06_16_02
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|8|16|64|128|1024|2048|4096|8192|65536|8388608|536870912 WHERE `entry`=20993;

