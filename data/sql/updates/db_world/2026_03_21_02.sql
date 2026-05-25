-- DB update 2026_03_21_01 -> 2026_03_21_02
--
-- swap trainers of Engineering (33611) and Leatherworking (33612) bookshelf creature entries
UPDATE `creature_default_trainer` SET `TrainerId` = 91 WHERE (`CreatureId` = 33611);
UPDATE `creature_default_trainer` SET `TrainerId` = 62 WHERE (`CreatureId` = 33612);
