-- DB update 2026_03_29_02 -> 2026_03_30_00
-- Move Majordomo Executus Ragnaros summoning gossip chain to database
-- Previously handled entirely in C++ script (sGossipHello/sGossipSelect)

-- Add gossip_menu entries (MenuID -> TextID) for the gossip chain
DELETE FROM `gossip_menu` WHERE `MenuID` IN (4093, 4108, 4109);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(4093, 4995),
(4109, 5011),
(4108, 5012);
