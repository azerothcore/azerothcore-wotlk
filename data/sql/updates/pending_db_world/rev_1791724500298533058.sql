-- The core now preserves friendly reactions to the player-controlled Siege Tank.
-- Remove the temporary UNIT_FLAG2_IGNORE_REPUTATION workaround without changing other flags.
UPDATE `creature_template` SET `unit_flags2` = `unit_flags2` & ~4 WHERE (`entry` = 25334);
