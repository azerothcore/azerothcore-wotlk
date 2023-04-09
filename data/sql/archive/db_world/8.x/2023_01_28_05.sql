-- DB update 2023_01_28_04 -> 2023_01_28_05
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|4|8|16|32|64|1024|65536|4194304|8388608|67108864 WHERE `entry` IN (15725, 15728, 15334, 15726, 15802);
