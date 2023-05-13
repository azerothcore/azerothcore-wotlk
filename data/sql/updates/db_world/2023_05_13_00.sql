-- DB update 2023_05_12_03 -> 2023_05_13_00
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|2|16|64|256|512|1024|2048|4096|8192|131072|524288|4194304|8388608|33554432, `flags_extra` = `flags_extra`|256 WHERE `entry` = 16473;
