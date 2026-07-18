-- DB update 2026_07_16_01 -> 2026_07_18_00
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|4|16|8388608 WHERE `entry` IN (28781, 32796);
