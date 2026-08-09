-- Thorim (32865/33147): HARD_RESET - despawn/respawn at spawn on evade.
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 0x80000000 WHERE `entry` IN (32865, 33147);
