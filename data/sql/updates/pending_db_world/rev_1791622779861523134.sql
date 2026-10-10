--
-- Argent Raid Spectator - Generic Bunny: invisible trigger, not selectable, immune to players and NPCs
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 128, `unit_flags` = `unit_flags` | 0x2000000 | 0x200 | 0x100, `VerifiedBuild` = 50250 WHERE (`entry` = 35016);
