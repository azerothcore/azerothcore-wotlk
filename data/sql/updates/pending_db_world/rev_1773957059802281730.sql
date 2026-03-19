--
-- swap trainers of creature entries 33612 33611
UPDATE `creature_default_trainer` SET `TrainerId` = 91 WHERE (`CreatureId` = 33611);
UPDATE `creature_default_trainer` SET `TrainerId` = 62 WHERE (`CreatureId` = 33612);
