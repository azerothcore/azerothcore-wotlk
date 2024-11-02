--
-- Headless Horseman: NO_MOVE_FLAGS_UPDATE - Creature won't update movement flags
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 512 WHERE (`entry` = 23682);
