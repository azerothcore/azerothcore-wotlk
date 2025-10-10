-- DB update 2025_10_06_00 -> 2025_10_07_00

-- Remove Disarm Immunity
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` &~ 4 WHERE (`entry` IN (31368, 29306));
