-- DB update 2026_11_20_02 -> 2026_11_20_03
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 0x80000000 WHERE `entry` IN (33113, 34003);
