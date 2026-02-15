-- DB update 2026_01_31_00 -> 2026_01_31_01
--
UPDATE `creature_template` SET `faction` = 634 WHERE (`entry` IN (23772, 29479));
