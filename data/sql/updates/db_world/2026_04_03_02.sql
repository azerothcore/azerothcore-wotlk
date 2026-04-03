-- DB update 2026_04_03_01 -> 2026_04_03_02
-- Add CREATURE_FLAG_EXTRA_CANNOT_ENTER_COMBAT to Toxic Tunnel (Naxxramas)
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 0x00002000 WHERE `entry` = 16400;
