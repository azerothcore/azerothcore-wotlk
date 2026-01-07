-- DB update 2025_11_18_00 -> 2025_11_18_01
-- despawn on evade
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|0x80000000 WHERE `entry` IN (26631, 31350);
