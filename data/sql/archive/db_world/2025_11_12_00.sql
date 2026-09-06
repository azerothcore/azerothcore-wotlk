-- DB update 2025_11_11_03 -> 2025_11_12_00
--
-- remove `DISABLE_MOVE`
UPDATE `creature_template` SET `unit_flags` = `unit_flags` & ~4 WHERE (`entry` = 28998);
