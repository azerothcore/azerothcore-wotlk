-- DB update 2026_04_21_00 -> 2026_04_21_01
--
-- Mai'ah the mage trainer only trains up to level 6
UPDATE `creature_default_trainer` SET `TrainerId` = 17 WHERE (`CreatureId` = 5884);
-- Shanda night elf priest trainer only trainers up to level 6
UPDATE `creature_default_trainer` SET `TrainerId` = 12 WHERE (`CreatureId` = 3595);
