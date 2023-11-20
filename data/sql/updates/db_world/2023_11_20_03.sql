-- DB update 2023_11_20_02 -> 2023_11_20_03
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |2147483648 where `entry` = 21212;
