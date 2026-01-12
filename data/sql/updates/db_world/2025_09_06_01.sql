-- DB update 2025_09_06_00 -> 2025_09_06_01
--
UPDATE `creature_template` SET `RegenHealth` = 0 WHERE (`entry` IN (16136, 16172));
