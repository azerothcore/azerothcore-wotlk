-- Issue #27553: Zaxxis Insignia quest item marker missing on Zaxxis Raiders/Stalkers
DELETE FROM `creature_questitem` WHERE `CreatureEntry` IN (18875, 19641, 19642) AND `Idx` = 0;
INSERT INTO `creature_questitem` (`CreatureEntry`, `Idx`, `ItemId`, `VerifiedBuild`) VALUES
(18875, 0, 29209, 0),
(19641, 0, 29209, 0),
(19642, 0, 29209, 0);
