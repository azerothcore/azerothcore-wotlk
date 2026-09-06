-- DB update 2025_04_15_00 -> 2025_04_15_01
-- Singularity speed
UPDATE `creature_template` SET `speed_walk` = 2, `speed_run` = 0.7142 WHERE (`entry` = 25855);
