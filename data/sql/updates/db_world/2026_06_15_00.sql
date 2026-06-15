-- DB update 2026_06_14_02 -> 2026_06_15_00
-- Auriaya (33515/34175): HARD_RESET - despawn/respawn at spawn on evade.
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 0x80000000 WHERE `entry` IN (33515, 34175);
