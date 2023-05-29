-- DB update 2022_12_31_01 -> 2022_12_31_02
--
UPDATE `creature_template` SET `detection_range` = 0 WHERE (`entry` = 17256);
