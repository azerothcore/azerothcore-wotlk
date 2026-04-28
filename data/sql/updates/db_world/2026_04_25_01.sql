-- DB update 2026_04_25_00 -> 2026_04_25_01
-- Ironhand Guardian (entry 8982) should never enter combat
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 0x2000 WHERE `entry` = 8982;
