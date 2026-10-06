-- DB update 2026_10_05_03 -> 2026_10_06_00
-- Male Frost Leopard and Male Icepaw Bear: UNIT_FLAG_IMMUNE_TO_PC (sniff build 58558)
UPDATE `creature_template` SET `unit_flags` = `unit_flags` | 256, `VerifiedBuild` = 58558
WHERE `entry` IN (33007, 33008);
