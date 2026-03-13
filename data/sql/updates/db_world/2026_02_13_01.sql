-- DB update 2026_02_13_00 -> 2026_02_13_01
--
-- uint8 to uint32 conversion for maxcount in npc_vendor
-- game_event_npc_vendor does not need to be updated
ALTER TABLE `npc_vendor` MODIFY COLUMN `maxcount` int unsigned DEFAULT 0 NOT NULL;

DELETE FROM `npc_vendor` WHERE (`entry` = 29561) AND (`item` IN (21177));
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `VerifiedBuild`) VALUES
(29561, 0, 21177, 300, 600, 0, 0);
