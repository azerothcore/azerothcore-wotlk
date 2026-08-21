-- DB update 2026_08_20_03 -> 2026_08_20_04
-- Webwood Lurker should advertise Small Spider Leg for quest 4161, Recipe of the Kaldorei.
DELETE FROM `creature_questitem` WHERE (`CreatureEntry` = 1998) AND (`Idx` = 1);
INSERT INTO `creature_questitem` (`CreatureEntry`, `Idx`, `ItemId`, `VerifiedBuild`) VALUES
(1998, 1, 5465, 0);
