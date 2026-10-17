-- DB update 2025_01_14_00 -> 2025_01_14_01
--
-- Removes all the plaque texts.
DELETE FROM `page_text` WHERE `id` IN (2151, 2152, 2153, 2171, 2172, 2173, 2174, 2175, 2176, 2177, 2178);

-- Adds the correct plaque texts from the sniff `V 3.4.3.53788` (credits to sniff: @heyitsbench)
INSERT INTO `page_text` (`ID`, `Text`, `NextPageID`, `VerifiedBuild`) VALUES
(2175, "Invar One-Arm$BThe first Chief Assassin of the Scarlet Crusade$BCitizen of Dalaran$BLast seen on the shores of Northrend", 0, 53788),
(2151, "Arellas Fireleaf$BHigh Wizard of the Scarlet Crusade$BCitizen of Quel'Thalas$BLocked in eternal combat with the Necromancer Diesalven", 0, 53788),
(2174, "Holia Sunshield$BDefender of the Scarlet Crusade$BKilled while slaying the Dreadlord Beltheris", 0, 53788),
(2172, "Ferren Marcus$BHigh Abbot of the Scarlet Monastery$BCitizen of Stratholme$BKilled defending the Scarlet Monastery at the First Summertide Assault", 0, 53788),
(2178, "Yana Bloodspear$BThe Second Chief Assassin of the Scarlet Crusade$BCitizen of Dalaran$BLost in the Tirisfal Glades", 0, 53788),
(2176, "Orman of Stromgarde$BThe first Captain General of the Scarlet Crusade$BCitizen of Stromgarde$BLost at the mouth of Icecrown Glacier", 0, 53788),
(2171, "Fellari Swiftarrow$BRanger Captain of the Scarlet Crusade$BCitizen of Quel'Thalas$BLost in the forests of Silverpine", 0, 53788),
(2153, "Dorgar Stoenbrow$BWarrior of the Scarlet Crusade$BLord of the Red Caverns$BLast seen in the Mountains of Alterac", 0, 53788),
(2177, "Valea Twinblades$BWarrior of the Scarlet Crusade$BCitizen of Alterac$BLast seen deep in the Eastern Plaguelands", 0, 53788),
(2173, "Harthal Truesight$BLord Paladin of the Scarlet Crusade$BCitizen of Azeroth - Knight of the Silver Hand$BLast seen entering the cursed city of Stratholme", 0, 53788),
(2152, "Admiral Barean Westwind$BGrand Admiral of the Scarlet Fleet$BCitizen of Kul'Tiras$BLost off the Frozen Coast of Northrend", 0, 53788);
