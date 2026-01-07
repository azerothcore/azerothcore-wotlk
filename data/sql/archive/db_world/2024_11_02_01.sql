-- DB update 2024_11_02_00 -> 2024_11_02_01
--
-- Headless Horseman: NO_MOVE_FLAGS_UPDATE - Creature won't update movement flags
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 512 WHERE (`entry` = 23682);
