-- DB update 2026_03_30_00 -> 2026_03_31_00
-- Valithria Dreamwalker
UPDATE `creature_template` SET `flags_extra` = `flags_extra` & ~128 WHERE `entry` = 37950;
