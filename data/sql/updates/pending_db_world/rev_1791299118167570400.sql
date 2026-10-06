-- Elwynn Forest Wolf: UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC (sniff build 50375)
UPDATE `creature_template` SET `unit_flags` = `unit_flags` | 768, `VerifiedBuild` = 50375 WHERE `entry` = 33286;
