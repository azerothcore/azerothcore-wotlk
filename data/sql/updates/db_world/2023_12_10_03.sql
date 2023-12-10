-- DB update 2023_12_10_02 -> 2023_12_10_03
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|1073741824 WHERE `entry` IN (21964, 21965, 21966);
