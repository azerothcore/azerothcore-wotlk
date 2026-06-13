-- DB update 2025_11_09_00 -> 2025_11_09_01
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|64 WHERE `entry` IN (28220, 28218, 28242, 28103, 28212, 28207, 28170);
