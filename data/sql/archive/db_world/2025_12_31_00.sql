-- DB update 2025_12_30_00 -> 2025_12_31_00
UPDATE `creature_template` SET `speed_walk` = 0.640000009536743164, `speed_run` = 0.57142857142 WHERE `entry` IN (27737, 31208);
