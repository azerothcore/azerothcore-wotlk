-- DB update 2023_12_10_01 -> 2023_12_10_02
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1 WHERE `entry` IN (21225, 21230, 21873, 21865);

UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|4|8|16|32|64|256|512|1024|2048|4096|8192|65536|131072|4194304|8388608|67108864|536870912 WHERE `entry` = 21218;
