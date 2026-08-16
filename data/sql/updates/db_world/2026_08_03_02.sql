-- DB update 2026_08_03_01 -> 2026_08_03_02
-- Runic Colossus and Ancient Rune Giant spawn immune to players until activated (sniff build 68887)
UPDATE `creature_template` SET `unit_flags` = `unit_flags` | 256, `VerifiedBuild` = 68887 WHERE `entry` IN (32872, 32873);
