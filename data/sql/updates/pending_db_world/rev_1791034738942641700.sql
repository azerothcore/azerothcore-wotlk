-- The Lich King (Yogg-Saron Icecrown illusion): UNIT_FLAG_IMMUNE_TO_PC
UPDATE `creature_template` SET `unit_flags` = `unit_flags` | 256, `VerifiedBuild` = 68974 WHERE `entry` = 33441;
