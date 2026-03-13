-- DB update 2026_01_02_03 -> 2026_01_02_04
-- Makes sure the wyrm always has loot, had no gold given now it gives between 9 to 45 silver.
UPDATE `creature_template` SET `mingold` = 900, `maxgold` = 45000 WHERE `entry` = 17907;
