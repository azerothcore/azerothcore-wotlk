-- DB update 2024_12_10_02 -> 2024_12_11_00
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|16|2048, `flags_extra` = `flags_extra`|256 WHERE `entry` = 24549;
