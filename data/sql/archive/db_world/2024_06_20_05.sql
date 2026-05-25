-- DB update 2024_06_20_04 -> 2024_06_20_05
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |256, `mechanic_immune_mask` = `mechanic_immune_mask`|64|256|2048 WHERE `entry` = 22954;
