-- DB update 2026_04_20_02 -> 2026_04_20_03
--
-- Update Guvan to train beyond starter priest spells
UPDATE `creature_default_trainer` SET `TrainerId` = 11 WHERE (`CreatureId` = 17482);
