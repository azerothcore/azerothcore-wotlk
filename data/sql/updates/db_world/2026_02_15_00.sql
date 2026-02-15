-- DB update 2026_02_13_03 -> 2026_02_15_00
DELETE FROM `waypoint_data` WHERE `id` IN (304490, 304520, 304510);

-- CREATURE_FLAG_EXTRA_HARD_RESET
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 0x80000000 WHERE (`entry` = 28860);
