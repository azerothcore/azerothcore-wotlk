-- DB update 2024_11_25_00 -> 2024_11_25_01
-- 
-- Adds "Taunt Immunity" to Boss "Hex Lord Malacrass" (Zul'aman)
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 256 WHERE `entry` = 24239;
