--
-- Quests 10262 and 10308 ask for Zaxxis Insignias, but the three Zaxxis mobs that drop them
-- advertise no quest item, so the client shows no objective when you hover them. The marker
-- comes from creature_questitem, which nothing referenced for this item.
--
DELETE FROM `creature_questitem` WHERE (`CreatureEntry` IN (18875, 19641, 19642)) AND (`Idx` = 0);
INSERT INTO `creature_questitem` (`CreatureEntry`, `Idx`, `ItemId`, `VerifiedBuild`) VALUES
(18875, 0, 29209, 0),
(19641, 0, 29209, 0),
(19642, 0, 29209, 0);
