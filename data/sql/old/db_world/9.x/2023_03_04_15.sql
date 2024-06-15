-- DB update 2023_03_04_14 -> 2023_03_04_15
-- Detected build: V3_4_0_46368
UPDATE `creature_template` SET `unit_flags` = 33554688 WHERE (`entry` = 18778);
UPDATE `creature_template` SET `unit_flags` = 33555200 WHERE (`entry` = 18726);
