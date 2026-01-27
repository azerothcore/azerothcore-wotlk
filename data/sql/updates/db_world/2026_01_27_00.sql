-- DB update 2026_01_26_02 -> 2026_01_27_00
-- Adds "Disoriented" and "Sapped" Immunties to "Maruading Crust Burster" outcome from MoP and Retail
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` | 2 | 536870912 WHERE `entry` = 16857;
