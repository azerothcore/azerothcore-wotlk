-- DB update 2025_12_26_03 -> 2025_12_26_04
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1 WHERE (`entry` = 16506);
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|2|8|16|64|512|1024|4096|8192|32768|65536|131072|262144|524288|1048576|4194304|8388608|67108864|134217728|268435456|536870912 WHERE (`entry` = 29274);
