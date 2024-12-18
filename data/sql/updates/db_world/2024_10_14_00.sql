-- DB update 2024_10_13_04 -> 2024_10_14_00
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |2097152 WHERE `entry` IN (22949, 22950, 22951, 22952);
