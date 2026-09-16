-- DB update 2026_09_10_01 -> 2026_09_10_02
-- Freya's 25-man entry never got the HARD_RESET its 10-man entry carries
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 0x80000000 WHERE `entry` = 33360;
