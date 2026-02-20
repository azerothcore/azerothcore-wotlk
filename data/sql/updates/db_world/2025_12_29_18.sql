-- DB update 2025_12_29_17 -> 2025_12_29_18
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` &~ 32 WHERE `entry` IN (30084, 32187);
