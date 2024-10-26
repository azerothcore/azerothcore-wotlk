-- DB update 2024_08_13_03 -> 2024_08_17_00
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |256, `mechanic_immune_mask` = `mechanic_immune_mask`|33554432  WHERE `entry` = 22950;
