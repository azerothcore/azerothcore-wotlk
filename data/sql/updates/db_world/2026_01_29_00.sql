-- DB update 2026_01_28_00 -> 2026_01_29_00
--
-- Add BreadcrumbForQuestId column to quest_template_addon
--

ALTER TABLE `quest_template_addon`
ADD COLUMN `BreadcrumbForQuestId` mediumint unsigned NOT NULL DEFAULT '0' AFTER `ExclusiveGroup`;

-- Assisting Arch Druid Runetotem
UPDATE `quest_template_addon` SET `NextQuestID` = 0, `ExclusiveGroup` = 0, `BreadcrumbForQuestId` = 3761 WHERE `ID` IN (936, 3762, 3784);

-- Assisting Arch Druid Staghelm
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0, `BreadcrumbForQuestId` = 3764 WHERE `ID` IN (3763, 3789, 3790, 10520);

-- Lost Deathstalkers
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 429 WHERE `ID` = 428;

-- On Guard in Stonetalon
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1085 WHERE `ID` = 1070;

-- The Crown of Will
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 518 WHERE `ID` = 495;

-- Camp Mojache
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 7489 WHERE `ID` = 7492;

-- Feathermoon Stronghold
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 7488 WHERE `ID` = 7494;

-- Journey to Stonetalon Peak
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1057 WHERE `ID` = 1056;

-- Castpipe's Task
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 2930 WHERE `ID` = 2931;

-- Kayneth Stillwind
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1011 WHERE `ID` = 4581;

-- Carendin Summons
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1472 WHERE `ID` = 10605;

-- Seeking Strahad (Horde)
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0, `BreadcrumbForQuestId` = 1801 WHERE `ID` IN (2996, 3001);

-- Seeking Strahad (Alliance)
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1758 WHERE `ID` = 1798;

-- A Helping Hand
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 9517 WHERE `ID` = 9533;

-- Trouble In Darkshore?
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 729 WHERE `ID` = 730;

-- Yorus Barleybrew
UPDATE `quest_template_addon` SET `NextQuestID` = 0, `ExclusiveGroup` = 0, `BreadcrumbForQuestId` = 1699 WHERE `ID` IN (1698, 10371);

-- Speak with Ruga
UPDATE `quest_template_addon` SET `PrevQuestId` = 0 WHERE `ID` = 1824;
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1824 WHERE `ID` = 1823;

-- A Strange One
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 4505 WHERE `ID` = 6605;

-- A Call to Arms: The Plaguelands! (horde)
UPDATE `quest_template_addon` SET `NextQuestID` = 0, `ExclusiveGroup` = 0, `BreadcrumbForQuestId` = 5096 WHERE `ID` IN (5093, 5094, 5095, 10374);

-- A Call to Arms: The Plaguelands! (alliance)
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0, `BreadcrumbForQuestId` = 5092 WHERE `ID` IN (5066, 5090, 5091, 10373);

-- Trouble in Winterspring!
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 5082 WHERE `ID` = 6603;

-- Neeka Bloodscar
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1420 WHERE `ID` = 1418;

-- Taking Back Silithus
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0, `BreadcrumbForQuestId` = 8280 WHERE `ID` IN (8275, 8276);

-- To Winterspring! & Starfall
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0, `BreadcrumbForQuestId` = 5244 WHERE `ID` IN (5249, 5250);

-- Tinkee Steamboil
UPDATE `quest_template_addon` SET `PrevQuestID` = 4810 WHERE `ID` = 4734;
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 4734 WHERE `ID` = 4907;

-- Westbrook Garrison Needs Help!
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11 WHERE `ID` = 239;

-- Elmore's Task
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE `ID` = 353;
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 353 WHERE `ID` = 1097;

-- Brother Anton
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 261 WHERE `ID` = 6141;

-- Chillwind Camp
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE `ID` = 8414;
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8414 WHERE `ID` = 8415;

-- Report to Jennea
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1920 WHERE `ID` = 1919;

-- High Sorcerer Andromath
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1938 WHERE `ID` = 1939;

-- Vital Supplies
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE `ID` = 1395;
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1395 WHERE `ID` = 1477;

-- Tabetha's Task
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 2846 WHERE `ID` = 2861;

-- James Hyal
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE `ID` = 1302;
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1302 WHERE `ID` = 1301;

-- Morgan Stern
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1204 WHERE `ID` = 1260;

-- Mayara Brightwing
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 4764 WHERE `ID` = 4766;

-- Tinkmaster Overspark
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 2922 WHERE `ID` = 2923;

-- Knowledge of the Orb of Orahil
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0, `BreadcrumbForQuestId` = 1799 WHERE `ID` IN (4965, 4967, 4968, 4969);

-- In Search of Menara Voidrender
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0, `BreadcrumbForQuestId` = 1796 WHERE `ID` IN (4736, 4737, 4738, 4739);

-- Gakin's Summons / The Slaughtered Lamb
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0, `BreadcrumbForQuestId` = 1688 WHERE `ID` IN (1685, 1715);

-- Gakin's Summons
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE `ID` = 1716;
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1716 WHERE `ID` = 1717;

-- Jonespyre's Request
UPDATE `quest_template_addon` SET `PrevQuestID` = 3785 WHERE `ID` = 3791;
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0, `BreadcrumbForQuestId` = 3791 WHERE `ID` IN (3787, 3788);

-- Malin's Request
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 691 WHERE `ID` = 690;

-- Report to Anastasia
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1960 WHERE `ID` = 1959;

-- Speak with Deino
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1944 WHERE `ID` = 1943;

-- Torwa Pathfinder
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE `ID` = 9052;
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 9052 WHERE `ID` = 9063;

-- The Hermit
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 148 WHERE `ID` = 165;

-- Deliveries to Sven
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 95 WHERE `ID` = 164;

-- Raven Hill
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 5 WHERE `ID` = 163;

-- Enraged Wildkin
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 4861 WHERE `ID` = 6604;

-- Ironband's Excavation
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 297 WHERE `ID` = 436;

-- Stonegear's Search
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 466 WHERE `ID` = 467;

-- Mountaineer Stormpike's Task
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1338 WHERE `ID` = 1339;

-- Report to Mountaineer Rockgar
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE `ID` = 455;
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 455 WHERE `ID` = 468;

-- Find Bingles
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 2038 WHERE `ID` = 2039;

-- The Greenwarden
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 276 WHERE `ID` = 463;

-- Rejold's New Brew
UPDATE `quest_template_addon` SET `PrevQuestID` = 315 WHERE `ID` = 413;
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 413 WHERE `ID` = 415;

-- Klockmort's Essentials
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 2924 WHERE `ID` = 2925;

-- Speak with Shoni
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 2040 WHERE `ID` = 2041;

-- Imperial Plate Armor
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 7652 WHERE `ID` IN (10891, 10892);

-- I Know A Guy... / To Gadgetzan You Go!
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 6610 WHERE `ID` IN (6611, 6612);

-- Alliance Trauma
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 6624 WHERE `ID` = 6625;

-- I Got Nothin' Left!
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 6607 WHERE `ID` = 6609;

-- Trollbane
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 639 WHERE `ID` = 638;

-- Horde Trauma
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 6622 WHERE `ID` = 6623;

-- The Hermit of Witch Hill / The Hermit of Swamplight Manor
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1218 WHERE `ID` IN (11177, 11225);

-- Vivian Lagrave
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 4134 WHERE `ID` = 4133;

-- Vivian Lagrave and the Darkstone Tablet
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 4768 WHERE `ID` = 4769;

-- Yuka Screwspigot
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 4136 WHERE `ID` = 4324;

-- Help Watcher Biggs
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1396 WHERE `ID` = 9609;

-- Taking a Stand
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 12503 WHERE `ID` = 12795;
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE `ID` IN (12503, 12596);

-- The Exiles of Ulduar
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 12930 WHERE `ID` = 12885;

-- Assist Exarch Orelis
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE `ID` = 10241;
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 10241 WHERE `ID` = 11038;

-- Off To Area 52 / Out of This World Produce! / A Strange Vision / Parts for the Rocket-Chief / A Mystifying Vision
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0, `BreadcrumbForQuestId` = 10186 WHERE `ID` IN (10183, 11036, 11037, 11040, 11042);

-- Horde Warlock Voidwalker questlines
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` IN (10789, 1478, 1473, 1471, 10790, 1506, 1501, 1504, 10788, 9529, 9619);
UPDATE `quest_template_addon` SET `PrevQuestId` = 1473 WHERE `ID` = 1471;
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1473 WHERE `ID` IN (10789, 1478);
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1501 WHERE `ID` IN (10790, 1506);
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 9529 WHERE `ID` = 10788;

-- Horde Mage level 10 quests
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` IN (1881, 1883, 9402);
UPDATE `quest_template_addon` SET `PrevQuestId` = 0 WHERE `ID` = 1884;
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1882 WHERE `ID` = 1881;
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1884 WHERE `ID` = 1883;
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 1882 WHERE `ID` IN (1882, 1884, 9402);

-- Alliance Mage level 10 quests
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` IN (1860, 1879);
UPDATE `quest_template_addon` SET `PrevQuestId` = 0 WHERE `ID` = 1880;
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1861 WHERE `ID` = 1860;
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1880 WHERE `ID` = 1879;
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 1861 WHERE `ID` IN (1861, 1880, 9595);

-- SI:7 / Erion's Behest / Kingly Shakedown
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0, `BreadcrumbForQuestId` = 2260 WHERE `ID` = 2259;
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0, `BreadcrumbForQuestId` = 2298 WHERE `ID` = 2299;
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0, `BreadcrumbForQuestId` = 2281 WHERE `ID` IN (2260, 2298, 2300);

-- Alliance Rogue level 10 quests
UPDATE `quest_template_addon` SET `PrevQuestId` = 0, `ExclusiveGroup` = 2206 WHERE `ID` IN (2206, 2238, 2242);
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` IN (2218, 2205, 2241);
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 2238 WHERE `ID` = 2218;
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 2206 WHERE `ID` = 2205;
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 2242 WHERE `ID` = 2241;

-- Find Sage Mistwalker (breadcrumb for The Artifacts of Steel Gate)
UPDATE `quest_template_addon` SET `PrevQuestID` = 0, `ExclusiveGroup` = 0 WHERE (`ID` = 11286);
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0, `BreadcrumbForQuestId` = 11286 WHERE `ID` = 11287;

-- Judgment Day Comes! (Alliance/Horde breadcrumbs for Honor Above All Else)
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 13036 WHERE `ID` IN (13226, 13227);

-- Remove redundant conditions now handled by BreadcrumbForQuestId
-- Quest 8280 (Securing the Supply Lines) no longer needs conditions requiring 8275/8276 rewarded
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 19 AND `SourceEntry` = 8280 AND `ConditionTypeOrReference` = 8 AND `ConditionValue1` IN (8275, 8276);

-- Judgment Day Comes! (13226/13227) no longer needs conditions checking 13036 (Honor Above All Else)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 19 AND `SourceEntry` IN (13226, 13227) AND `ConditionValue1` = 13036;
