-- DB update 2025_03_30_00 -> 2025_03_30_01

-- Remove Immune to Distract Flag
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`& ~8 WHERE (`entry` = 25741);
