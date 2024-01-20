-- DB update 2023_07_16_02 -> 2023_07_16_03
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` | 8388608, `flags_extra` = 1073741824 WHERE `entry` in (19389, 21350);

