-- creature_template modifiers measured from the sniff corpus (scripts/creature-modifiers.py)
-- 1410 entries

-- Forest Spider: DamageModifier 1 -> 0.9 (melee, TBC, 113 swings, k 0.914-0.899)
UPDATE `creature_template` SET `DamageModifier` = 0.9 WHERE `entry` = 30;
-- Stormwind City Guard: DamageModifier 1 -> 2 (sheet, TBC, 7344 sheets, exp 1 (AC 2))
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 68;
-- Infernal: DamageModifier 1 -> 3.15 (sheet, WotLK, 3 sheets, exp 2 (AC 2)); ArmorModifier 1 -> 1.85 (armor, WotLK, 3 sheets, 1.836 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.85, `DamageModifier` = 3.15 WHERE `entry` = 89;
-- Riverpaw Brute: DamageModifier 1 -> 1.3 (melee, WotLK, 72 swings, k 1.305-1.327)
UPDATE `creature_template` SET `DamageModifier` = 1.3 WHERE `entry` = 124;
-- Murloc Warrior: DamageModifier 1 -> 1.35 (melee, WotLK, 342 swings, k 1.325-1.343)
UPDATE `creature_template` SET `DamageModifier` = 1.35 WHERE `entry` = 171;
-- Blue Dragonspawn: DamageModifier 2.4 -> 3.25 (melee, WotLK, 56 swings, k 3.290-3.309)
UPDATE `creature_template` SET `DamageModifier` = 3.25 WHERE `entry` = 193;
-- Stalvan Mistmantle: DamageModifier 1 -> 1.7 (melee, WotLK, 37 swings, k 1.681-1.691)
UPDATE `creature_template` SET `DamageModifier` = 1.7 WHERE `entry` = 315;
-- Grizzle Halfmane: DamageModifier 4.6 -> 12 (sheet, TBC, 56 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 347;
-- Corporal Keeshan: DamageModifier 2.4 -> 1.7 (melee, WotLK, 165 swings, k 1.673-1.686)
UPDATE `creature_template` SET `DamageModifier` = 1.7 WHERE `entry` = 349;
-- Dungar Longdrink: DamageModifier 4.6 -> 3.5 (sheet, TBC, 190 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 352;
-- Redridge Brute: DamageModifier 1 -> 1.25 (melee, WotLK, 644 swings, k 1.242-1.236)
UPDATE `creature_template` SET `DamageModifier` = 1.25 WHERE `entry` = 426;
-- Shadowhide Slayer: DamageModifier 1 -> 1.2 (melee, WotLK, 204 swings, k 1.189-1.185)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 431;
-- Defias Rogue Wizard: DamageModifier 1 -> 0.95 (melee, WotLK, 62 swings, k 0.937-0.959)
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 474;
-- Water Elemental: ArmorModifier 1 -> 1.1 (armor, TBC, 2267 sheets, 0.717 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.1 WHERE `entry` = 510;
-- Insane Ghoul: DamageModifier 1 -> 1.25 (melee, WotLK, 58 swings, k 1.235-1.254)
UPDATE `creature_template` SET `DamageModifier` = 1.25 WHERE `entry` = 511;
-- Thor: DamageModifier 4.6 -> 3.5 (sheet, TBC, 50 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 523;
-- Bloodscalp Berserker: DamageModifier 1 -> 1.3 (melee, WotLK, 393 swings, k 1.289-1.298)
UPDATE `creature_template` SET `DamageModifier` = 1.3 WHERE `entry` = 597;
-- Stranglethorn Raptor: DamageModifier 1 -> 1.25 (melee, WotLK, 491 swings, k 1.239-1.247)
UPDATE `creature_template` SET `DamageModifier` = 1.25 WHERE `entry` = 685;
-- Jungle Stalker: DamageModifier 1 -> 1.2 (melee, WotLK, 819 swings, k 1.192-1.198)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 687;
-- Ironforge Mountaineer: ArmorModifier 1 -> 1.2 (armor, TBC, 126 sheets, 1.215 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.2 WHERE `entry` = 727;
-- Sin'Dall: DamageModifier 1 -> 1.4 (melee, WotLK, 109 swings, k 1.375-1.381)
UPDATE `creature_template` SET `DamageModifier` = 1.4 WHERE `entry` = 729;
-- Marsh Inkspewer: ExperienceModifier 1 -> 0.8 (xp, WotLK, 7 kills, 0.71 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.8 WHERE `entry` = 750;
-- Marsh Oracle: ExperienceModifier 1 -> 1.1 (xp, WotLK, 7 kills, 0.71 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 1.1 WHERE `entry` = 752;
-- Skullsplitter Berserker: DamageModifier 1 -> 1.25 (melee, WotLK, 120 swings, k 1.246-1.239)
UPDATE `creature_template` SET `DamageModifier` = 1.25 WHERE `entry` = 783;
-- Young Jungle Stalker: DamageModifier 1 -> 1.2 (melee, WotLK, 85 swings, k 1.182-1.193)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 854;
-- Young Stranglethorn Raptor: DamageModifier 1 -> 1.25 (melee, WotLK, 35 swings, k 1.228-1.251)
UPDATE `creature_template` SET `DamageModifier` = 1.25 WHERE `entry` = 855;
-- Young Lashtail Raptor: DamageModifier 1 -> 1.25 (melee, WotLK, 30 swings, k 1.226-1.240); ExperienceModifier 1 -> 0.8 (xp, TBC, 6 kills, 0.83 at median)
UPDATE `creature_template` SET `DamageModifier` = 1.25, `ExperienceModifier` = 0.8 WHERE `entry` = 856;
-- Donal Osgood: DamageModifier 4.6 -> 12 (sheet, TBC, 61 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 857;
-- Saltscale Forager: DamageModifier 1 -> 1.7 (melee, Classic, 181 swings, k 1.685-1.694)
UPDATE `creature_template` SET `DamageModifier` = 1.7 WHERE `entry` = 877;
-- Erlan Drudgemoor: DamageModifier 1 -> 1.25 (melee, WotLK, 39 swings, k 1.248-1.252)
UPDATE `creature_template` SET `DamageModifier` = 1.25 WHERE `entry` = 880;
-- Keras Wolfheart: DamageModifier 4.6 -> 12 (sheet, TBC, 59 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 907;
-- Ariena Stormfeather: DamageModifier 4.6 -> 3.5 (sheet, TBC, 54 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 931;
-- Mosshide Brute: DamageModifier 1 -> 1.25 (melee, WotLK, 45 swings, k 1.233-1.238)
UPDATE `creature_template` SET `DamageModifier` = 1.25 WHERE `entry` = 1012;
-- Elder Razormaw: DamageModifier 1 -> 1.2 (melee, WotLK, 42 swings, k 1.187-1.185)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 1019;
-- Mottled Raptor: DamageModifier 1 -> 1.2 (melee, WotLK, 168 swings, k 1.178-1.187)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 1020;
-- Mottled Scytheclaw: DamageModifier 1 -> 1.2 (melee, WotLK, 158 swings, k 1.188-1.186)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 1022;
-- Mottled Razormaw: DamageModifier 1 -> 1.2 (melee, WotLK, 164 swings, k 1.188-1.198)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 1023;
-- Gan'zulah: DamageModifier 1 -> 1.25 (melee, WotLK, 36 swings, k 1.274-1.252)
UPDATE `creature_template` SET `DamageModifier` = 1.25 WHERE `entry` = 1061;
-- Mire Lord: DamageModifier 1 -> 1.75 (melee, TBC, 32 swings, k 1.752-1.750)
UPDATE `creature_template` SET `DamageModifier` = 1.75 WHERE `entry` = 1081;
-- Sawtooth Crocolisk: DamageModifier 1 -> 1.1 (melee, WotLK, 85 swings, k 1.097-1.100)
UPDATE `creature_template` SET `DamageModifier` = 1.1 WHERE `entry` = 1082;
-- Young Sawtooth Crocolisk: DamageModifier 1 -> 1.1 (melee, WotLK, 72 swings, k 1.081-1.094)
UPDATE `creature_template` SET `DamageModifier` = 1.1 WHERE `entry` = 1084;
-- Sawtooth Snapper: DamageModifier 1 -> 1.1 (melee, WotLK, 126 swings, k 1.088-1.090)
UPDATE `creature_template` SET `DamageModifier` = 1.1 WHERE `entry` = 1087;
-- Mistvale Gorilla: DamageModifier 1 -> 1.2 (melee, WotLK, 38 swings, k 1.195-1.201)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 1108;
-- Jungle Thunderer: DamageModifier 1 -> 1.2 (melee, WotLK, 48 swings, k 1.181-1.180)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 1114;
-- Frostmane Snowstrider: DamageModifier 1 -> 0.95 (melee, TBC, 70 swings, k 0.928-0.960)
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 1121;
-- Frostmane Shadowcaster: DamageModifier 1 -> 0.95 (melee, WotLK, 48 swings, k 0.935-0.961)
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 1124;
-- Mountaineer Kadrell: ArmorModifier 1 -> 1.2 (armor, TBC, 11 sheets, 1.215 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.2 WHERE `entry` = 1340;
-- Thysta: DamageModifier 4.6 -> 3.5 (sheet, TBC, 163 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 1387;
-- Wetlands Crocolisk: DamageModifier 1 -> 1.1 (sheet, WotLK, 1 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 1.1 WHERE `entry` = 1400;
-- Young Wetlands Crocolisk: DamageModifier 1 -> 1.1 (melee, WotLK, 124 swings, k 1.079-1.089)
UPDATE `creature_template` SET `DamageModifier` = 1.1 WHERE `entry` = 1417;
-- Zanzil Hunter: DamageModifier 1 -> 1.7 (melee, WotLK, 274 swings, k 1.692-1.696)
UPDATE `creature_template` SET `DamageModifier` = 1.7 WHERE `entry` = 1489;
-- Gorlash: ExperienceModifier 1 -> 1.25 (xp, WotLK, 4 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 1.25 WHERE `entry` = 1492;
-- Deathguard Dillinger: ArmorModifier 1 -> 1.2 (armor, TBC, 2 sheets, 1.214 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.2 WHERE `entry` = 1496;
-- Darkeye Bonecaster: ExperienceModifier 1 -> 0.33 (xp, TBC, 10 kills, 0.60 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.33 WHERE `entry` = 1522;
-- Ironjaw Basilisk: DamageModifier 1 -> 1.6 (melee, WotLK, 33 swings, k 1.581-1.598)
UPDATE `creature_template` SET `DamageModifier` = 1.6 WHERE `entry` = 1551;
-- King Mukla: ExperienceModifier 1 -> 2 (xp, WotLK, 4 kills, 0.75 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 2 WHERE `entry` = 1559;
-- Shellei Brondir: DamageModifier 4.6 -> 3.5 (sheet, TBC, 263 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 1571;
-- Thorgrum Borrelson: DamageModifier 4.6 -> 3.5 (sheet, TBC, 8 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 1572;
-- Gryth Thurden: DamageModifier 4.6 -> 3.5 (sheet, TBC, 93 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 1573;
-- Deathguard Burgess: ArmorModifier 1 -> 1.2 (armor, TBC, 4 sheets, 1.213 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.2 WHERE `entry` = 1652;
-- Defias Watchman: DamageModifier 1.7 -> 1 (melee, WotLK, 59 swings, k 0.980-0.971)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 1725;
-- Deathguard Terrence: ArmorModifier 1 -> 1.2 (armor, TBC, 5 sheets, 1.214 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.2 WHERE `entry` = 1738;
-- Deathguard Lawrence: ArmorModifier 1 -> 1.2 (armor, TBC, 2 sheets, 1.214 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.2 WHERE `entry` = 1743;
-- Deathguard Mort: ArmorModifier 1 -> 1.2 (armor, TBC, 4 sheets, 1.213 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.2 WHERE `entry` = 1744;
-- Deathguard Morris: ArmorModifier 1 -> 1.2 (armor, TBC, 4 sheets, 1.214 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.2 WHERE `entry` = 1745;
-- Deathguard Cyrus: ArmorModifier 1 -> 1.2 (armor, TBC, 4 sheets, 1.214 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.2 WHERE `entry` = 1746;
-- Mottled Worg: DamageModifier 1 -> 1.05 (melee, TBC, 88 swings, k 1.060-1.079)
UPDATE `creature_template` SET `DamageModifier` = 1.05 WHERE `entry` = 1766;
-- Moonrage Darkrunner: DamageModifier 1 -> 0.95 (melee, TBC, 32 swings, k 0.935-0.961)
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 1770;
-- High Priest Thel'danis: DamageModifier 1 -> 1.2 (melee, WotLK, 33 swings, k 1.206-1.195)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 1854;
-- Voidwalker: DamageModifier 1 -> 0.9 (melee, WotLK, 48 swings, k 0.898-0.898)
UPDATE `creature_template` SET `DamageModifier` = 0.9 WHERE `entry` = 1860;
-- Pyrewood Watcher: DamageModifier 1 -> 1.7 (melee, Classic, 66 swings, k 1.665-1.688)
UPDATE `creature_template` SET `DamageModifier` = 1.7 WHERE `entry` = 1891;
-- Pyrewood Elder: DamageModifier 1 -> 1.7 (melee, Classic, 76 swings, k 1.687-1.689)
UPDATE `creature_template` SET `DamageModifier` = 1.7 WHERE `entry` = 1895;
-- Bloodsnout Worg: DamageModifier 1 -> 1.1 (melee, Classic, 70 swings, k 1.066-1.087)
UPDATE `creature_template` SET `DamageModifier` = 1.1 WHERE `entry` = 1923;
-- Tirisfal Farmer: DamageModifier 1 -> 1.15 (melee, WotLK, 119 swings, k 1.159-1.176)
UPDATE `creature_template` SET `DamageModifier` = 1.15 WHERE `entry` = 1934;
-- Stormwind City Patroller: DamageModifier 1.6 -> 1 (sheet, TBC, 1691 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 1976;
-- Gnarlpine Shaman: DamageModifier 1 -> 0.95 (melee, WotLK, 36 swings, k 0.924-0.948)
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 2009;
-- Bloodfeather Sorceress: DamageModifier 1 -> 0.95 (melee, TBC, 36 swings, k 0.932-0.962)
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 2018;
-- Elder Nightsaber: DamageModifier 1 -> 0.95 (melee, TBC, 208 swings, k 0.960-0.947)
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 2033;
-- Feral Nightsaber: DamageModifier 1 -> 0.9 (melee, WotLK, 35 swings, k 0.909-0.938)
UPDATE `creature_template` SET `DamageModifier` = 0.9 WHERE `entry` = 2034;
-- Lord Melenas: DamageModifier 1 -> 0.95 (melee, TBC, 34 swings, k 0.924-0.948)
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 2038;
-- Councilman Cooper: DamageModifier 1 -> 1.7 (melee, Classic, 44 swings, k 1.668-1.691)
UPDATE `creature_template` SET `DamageModifier` = 1.7 WHERE `entry` = 2065;
-- Councilman Brunswick: DamageModifier 1 -> 1.7 (melee, Classic, 35 swings, k 1.665-1.694)
UPDATE `creature_template` SET `DamageModifier` = 1.7 WHERE `entry` = 2067;
-- Lord Mayor Morrison: DamageModifier 1 -> 1.7 (melee, Classic, 34 swings, k 1.704-1.683)
UPDATE `creature_template` SET `DamageModifier` = 1.7 WHERE `entry` = 2068;
-- Conservator Ilthalaine: DamageModifier 1 -> 0.98 (sheet, TBC, 52 sheets, exp 0 (AC 0)); ArmorModifier 1 -> 1.05 (armor, TBC, 52 sheets, 1.118 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.05, `DamageModifier` = 0.98 WHERE `entry` = 2079;
-- Deathguard Gavin: ArmorModifier 1 -> 1.2 (armor, TBC, 4 sheets, 1.213 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.2 WHERE `entry` = 2209;
-- Deathguard Royann: ArmorModifier 1 -> 1.2 (armor, TBC, 4 sheets, 1.213 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.2 WHERE `entry` = 2210;
-- Karos Razok: DamageModifier 4.6 -> 3.5 (sheet, TBC, 89 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 2226;
-- Crushridge Mage: DamageModifier 1 -> 1.7 (melee, Classic, 33 swings, k 1.681-1.707)
UPDATE `creature_template` SET `DamageModifier` = 1.7 WHERE `entry` = 2255;
-- Borgus Stoutarm: DamageModifier 4.6 -> 3.5 (sheet, TBC, 1 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 2299;
-- Aethalas: DamageModifier 4.6 -> 12 (sheet, TBC, 59 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 2302;
-- Nagaz: DamageModifier 1 -> 1.25 (melee, TBC, 33 swings, k 1.261-1.236)
UPDATE `creature_template` SET `DamageModifier` = 1.25 WHERE `entry` = 2320;
-- Elemental Slave: DamageModifier 1 -> 1.7 (melee, WotLK, 62 swings, k 1.683-1.696)
UPDATE `creature_template` SET `DamageModifier` = 1.7 WHERE `entry` = 2359;
-- Daggerspine Shorehunter: DamageModifier 1 -> 1.1 (melee, WotLK, 174 swings, k 1.077-1.093)
UPDATE `creature_template` SET `DamageModifier` = 1.1 WHERE `entry` = 2369;
-- Southshore Guard: DamageModifier 1 -> 2 (melee, WotLK, 306 swings, k 1.994-1.995)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 2386;
-- Zarise: DamageModifier 4.6 -> 3.5 (sheet, TBC, 296 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 2389;
-- Tarren Mill Deathguard: DamageModifier 1 -> 2 (melee, WotLK, 148 swings, k 1.992-1.987)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 2405;
-- Felicia Maline: DamageModifier 4.6 -> 3.5 (sheet, TBC, 480 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 2409;
-- Darla Harris: DamageModifier 4.6 -> 3.5 (sheet, TBC, 142 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 2432;
-- Remote-Controlled Golem: DamageModifier 2 -> 1 (melee, TBC, 114 swings, k 0.988-0.980)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 2520;
-- Garr Salthoof: DamageModifier 1 -> 1.7 (melee, WotLK, 41 swings, k 1.696-1.702)
UPDATE `creature_template` SET `DamageModifier` = 1.7 WHERE `entry` = 2549;
-- Highland Strider: DamageModifier 1 -> 1.2 (melee, WotLK, 509 swings, k 1.178-1.196)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 2559;
-- Highland Thrasher: DamageModifier 1 -> 1.2 (melee, WotLK, 329 swings, k 1.183-1.198)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 2560;
-- Highland Fleshstalker: DamageModifier 1 -> 1.2 (melee, WotLK, 97 swings, k 1.182-1.199)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 2561;
-- Plains Creeper: ExperienceModifier 1 -> 1.05 (xp, WotLK, 6 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 1.05 WHERE `entry` = 2563;
-- Boulderfist Lord: ExperienceModifier 1 -> 1.1 (xp, WotLK, 8 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 1.1 WHERE `entry` = 2571;
-- Syndicate Prowler: DamageModifier 1 -> 0.8 (melee, WotLK, 129 swings, k 0.782-0.794)
UPDATE `creature_template` SET `DamageModifier` = 0.8 WHERE `entry` = 2588;
-- Syndicate Mercenary: DamageModifier 1 -> 1.2 (melee, WotLK, 172 swings, k 1.199-1.191)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 2589;
-- Fozruk: DamageModifier 1 -> 1.1 (melee, WotLK, 78 swings, k 1.085-1.091)
UPDATE `creature_template` SET `DamageModifier` = 1.1 WHERE `entry` = 2611;
-- Vilebranch Headhunter: DamageModifier 1 -> 2.75 (melee, Classic, 65 swings, k 2.720-2.696)
UPDATE `creature_template` SET `DamageModifier` = 2.75 WHERE `entry` = 2641;
-- Vilebranch Soul Eater: DamageModifier 1 -> 3.25 (melee, Classic, 93 swings, k 3.216-3.209)
UPDATE `creature_template` SET `DamageModifier` = 3.25 WHERE `entry` = 2647;
-- Witherbark Sadist: DamageModifier 1 -> 1.1 (melee, WotLK, 185 swings, k 1.090-1.091)
UPDATE `creature_template` SET `DamageModifier` = 1.1 WHERE `entry` = 2653;
-- Highvale Ranger: DamageModifier 1 -> 1.1 (melee, WotLK, 200 swings, k 1.085-1.091)
UPDATE `creature_template` SET `DamageModifier` = 1.1 WHERE `entry` = 2694;
-- Hanashi: DamageModifier 1 -> 7 (sheet, TBC, 2 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 7 WHERE `entry` = 2704;
-- Shadra: DamageModifier 7.5 -> 5 (melee, Classic, 57 swings, k 4.993-4.992)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 2707;
-- Forsaken Bodyguard: DamageModifier 1 -> 0.5 (melee, WotLK, 51 swings, k 0.491-0.483)
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 2721;
-- Stromgarde Cavalryman: DamageModifier 1 -> 0.5 (melee, TBC, 53 swings, k 0.484-0.502)
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 2738;
-- Blacklash: DamageModifier 1 -> 3.75 (melee, Classic, 40 swings, k 3.669-3.713)
UPDATE `creature_template` SET `DamageModifier` = 3.75 WHERE `entry` = 2757;
-- Hematus: DamageModifier 1 -> 3.75 (melee, Classic, 80 swings, k 3.696-3.710)
UPDATE `creature_template` SET `DamageModifier` = 3.75 WHERE `entry` = 2759;
-- Marez Cowl: ExperienceModifier 1 -> 2 (xp, WotLK, 3 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 2 WHERE `entry` = 2783;
-- Kurden Bloodclaw: DamageModifier 4.6 -> 12 (sheet, TBC, 11 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 2804;
-- Urda: DamageModifier 4.6 -> 3.5 (sheet, TBC, 18 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 2851;
-- Gringer: DamageModifier 4.6 -> 3.5 (sheet, TBC, 252 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 2858;
-- Gyll: DamageModifier 4.6 -> 3.5 (sheet, TBC, 223 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 2859;
-- Gorrik: DamageModifier 4.6 -> 3.5 (sheet, TBC, 12 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 2861;
-- Magregan Deepshadow: DamageModifier 1 -> 1.8 (melee, Classic, 35 swings, k 1.787-1.802)
UPDATE `creature_template` SET `DamageModifier` = 1.8 WHERE `entry` = 2932;
-- Lanie Reed: DamageModifier 4.6 -> 3.5 (sheet, TBC, 57 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 2941;
-- Puppet of Helcular: DamageModifier 5 -> 1 (melee, WotLK, 85 swings, k 0.996-0.996)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 2946;
-- Palemane Skinner: DamageModifier 1 -> 0.95 (melee, WotLK, 37 swings, k 0.918-0.940)
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 2950;
-- Bristleback Battleboar: DamageModifier 1 -> 0.9 (melee, Classic, 48 swings, k 0.937-0.901)
UPDATE `creature_template` SET `DamageModifier` = 0.9 WHERE `entry` = 2954;
-- Windfury Harpy: DamageModifier 1 -> 1.2 (melee, WotLK, 31 swings, k 1.217-1.185)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 2962;
-- Venture Co. Worker: DamageModifier 1 -> 1.2 (melee, WotLK, 90 swings, k 1.198-1.210)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 2978;
-- Tal: DamageModifier 4.6 -> 3.5 (sheet, TBC, 192 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 2995;
-- Razormane Quilboar: ExperienceModifier 1 -> 1.2 (xp, WotLK, 8 kills, 0.50 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 1.2 WHERE `entry` = 3111;
-- Razormane Scout: ExperienceModifier 1 -> 1.15 (xp, WotLK, 6 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 1.15 WHERE `entry` = 3112;
-- Razormane Dustrunner: DamageModifier 1 -> 0.95 (melee, WotLK, 34 swings, k 0.923-0.964); ExperienceModifier 1 -> 1.15 (xp, WotLK, 4 kills, 1.00 at median)
UPDATE `creature_template` SET `DamageModifier` = 0.95, `ExperienceModifier` = 1.15 WHERE `entry` = 3113;
-- Razormane Battleguard: ExperienceModifier 1 -> 1.15 (xp, WotLK, 5 kills, 0.60 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 1.15 WHERE `entry` = 3114;
-- Dustwind Savage: DamageModifier 1 -> 1.3 (melee, WotLK, 123 swings, k 1.291-1.289)
UPDATE `creature_template` SET `DamageModifier` = 1.3 WHERE `entry` = 3117;
-- Kolkar Outrunner: DamageModifier 1 -> 0.95 (melee, TBC, 38 swings, k 0.925-0.947); ExperienceModifier 1 -> 0.6 (xp, TBC, 4 kills, 1.00 at median)
UPDATE `creature_template` SET `DamageModifier` = 0.95, `ExperienceModifier` = 0.6 WHERE `entry` = 3120;
-- Kul Tiras Sailor: DamageModifier 1 -> 0.9 (melee, Classic, 160 swings, k 0.909-0.899)
UPDATE `creature_template` SET `DamageModifier` = 0.9 WHERE `entry` = 3128;
-- Burning Blade Thug: DamageModifier 1 -> 1.2 (melee, TBC, 61 swings, k 1.172-1.209)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 3195;
-- Voodoo Troll: DamageModifier 1 -> 0.95 (melee, WotLK, 77 swings, k 0.929-0.959)
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 3206;
-- Hexed Troll: DamageModifier 1 -> 0.95 (melee, WotLK, 43 swings, k 0.925-0.962)
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 3207;
-- Lost Barrens Kodo: DamageModifier 1 -> 0.9 (melee, Classic, 33 swings, k 0.865-0.894); ExperienceModifier 1 -> 0.9 (xp, WotLK, 5 kills, 0.60 at median)
UPDATE `creature_template` SET `DamageModifier` = 0.9, `ExperienceModifier` = 0.9 WHERE `entry` = 3234;
-- Barrens Kodo: DamageModifier 1 -> 0.9 (melee, TBC, 36 swings, k 0.924-0.900)
UPDATE `creature_template` SET `DamageModifier` = 0.9 WHERE `entry` = 3236;
-- Savannah Highmane: DamageModifier 1 -> 0.95 (melee, TBC, 45 swings, k 0.933-0.959)
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 3243;
-- Silithid Swarmer: DamageModifier 1 -> 0.8 (melee, TBC, 114 swings, k 0.779-0.792)
UPDATE `creature_template` SET `DamageModifier` = 0.8 WHERE `entry` = 3252;
-- Doras: DamageModifier 4.6 -> 3.5 (sheet, TBC, 236 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 3310;
-- Bael'dun Foreman: DamageModifier 1 -> 0.85 (melee, WotLK, 55 swings, k 0.839-0.847)
UPDATE `creature_template` SET `DamageModifier` = 0.85 WHERE `entry` = 3375;
-- Southsea Cannoneer: DamageModifier 1 -> 1.2 (melee, WotLK, 101 swings, k 1.177-1.193)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 3382;
-- Savannah Huntress: DamageModifier 1 -> 0.95 (melee, WotLK, 130 swings, k 0.943-0.958)
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 3415;
-- Teldrassil Sentinel: DamageModifier 3 -> 1 (sheet, TBC, 1299 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 3571;
-- Devrak: DamageModifier 4.6 -> 3.5 (sheet, TBC, 368 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 3615;
-- Devouring Ectoplasm: ExperienceModifier 1 -> 0.12 (xp, WotLK, 6 kills, 0.67 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.12 WHERE `entry` = 3638;
-- Raene Wolfrunner: DamageModifier 4.6 -> 10 (sheet, TBC, 71 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 10 WHERE `entry` = 3691;
-- Felmusk Rogue: ArmorModifier 1 -> 0.95 (armor, WotLK, 1 sheets, 0.95 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.95 WHERE `entry` = 3759;
-- Felslayer: DamageModifier 1 -> 0.75 (sheet, WotLK, 2 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.75 WHERE `entry` = 3774;
-- Forsaken Infiltrator: DamageModifier 1 -> 1.2 (melee, TBC, 53 swings, k 1.188-1.202)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 3806;
-- Elder Ashenvale Bear: ExperienceModifier 1 -> 1.1 (xp, TBC, 4 kills, 0.50 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 1.1 WHERE `entry` = 3810;
-- Vesprystus: DamageModifier 4.6 -> 3.5 (sheet, TBC, 27 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 3838;
-- Caylais Moonfeather: DamageModifier 4.6 -> 3.5 (sheet, TBC, 306 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 3841;
-- Brakgul Deathbringer: DamageModifier 4.6 -> 12 (sheet, TBC, 25 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 3890;
-- Aayndia Floralwind: DamageModifier 1 -> 0.5 (sheet, TBC, 30 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 3967;
-- Arias'ta Bladesinger: DamageModifier 1 -> 0.5 (sheet, TBC, 59 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 4087;
-- Sildanair: DamageModifier 1 -> 0.5 (sheet, TBC, 60 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 4089;
-- Astarii Starseeker: DamageModifier 1 -> 0.5 (sheet, TBC, 31 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 4090;
-- Jandria: DamageModifier 1 -> 0.5 (sheet, TBC, 31 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 4091;
-- Lariia: DamageModifier 1 -> 0.5 (sheet, TBC, 22 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 4092;
-- Galak Mauler: DamageModifier 1 -> 1.3 (melee, WotLK, 129 swings, k 1.299-1.302)
UPDATE `creature_template` SET `DamageModifier` = 1.3 WHERE `entry` = 4095;
-- Highperch Patriarch: DamageModifier 1 -> 0.9 (melee, TBC, 39 swings, k 0.888-0.889)
UPDATE `creature_template` SET `DamageModifier` = 0.9 WHERE `entry` = 4110;
-- Needles Cougar: DamageModifier 1 -> 1.2 (melee, WotLK, 152 swings, k 1.170-1.186); ExperienceModifier 1 -> 0.95 (xp, WotLK, 3 kills, 0.67 at median)
UPDATE `creature_template` SET `DamageModifier` = 1.2, `ExperienceModifier` = 0.95 WHERE `entry` = 4124;
-- Jeen'ra Nightrunner: DamageModifier 1 -> 0.5 (sheet, TBC, 41 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 4138;
-- Jocaste: DamageModifier 1 -> 0.5 (sheet, TBC, 49 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 4146;
-- Idriana: DamageModifier 1 -> 0.5 (sheet, TBC, 32 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 4155;
-- Lysheana: DamageModifier 1 -> 0.5 (sheet, TBC, 52 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 4161;
-- Syurna: DamageModifier 1 -> 0.5 (sheet, TBC, 16 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 4163;
-- Firodren Mooncaller: DamageModifier 1 -> 0.5 (sheet, TBC, 4 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 4204;
-- Dorion: DamageModifier 1 -> 0.5 (sheet, TBC, 40 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 4205;
-- Erion Shadewhisper: DamageModifier 1 -> 0.5 (sheet, TBC, 15 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 4214;
-- Anishar: DamageModifier 1 -> 0.5 (sheet, TBC, 16 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 4215;
-- Mathrengyl Bearwalker: DamageModifier 1 -> 0.5 (sheet, TBC, 49 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 4217;
-- Denatharion: DamageModifier 1 -> 0.5 (sheet, TBC, 42 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 4218;
-- Fylerian Nightwing: DamageModifier 1 -> 0.5 (sheet, TBC, 42 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 4219;
-- Mydrannul: DamageModifier 1 -> 0.5 (sheet, TBC, 11 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 4241;
-- Geofram Bouldertoe: DamageModifier 1 -> 0.5 (sheet, TBC, 49 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 4254;
-- Golnir Bouldertoe: DamageModifier 1 -> 0.5 (sheet, TBC, 50 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 4256;
-- Bengus Deepforge: DamageModifier 1 -> 0.5 (sheet, TBC, 93 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 4258;
-- Darnassus Sentinel: DamageModifier 1 -> 1.7 (sheet, TBC, 1004 sheets, exp 1 (AC 2))
UPDATE `creature_template` SET `DamageModifier` = 1.7 WHERE `entry` = 4262;
-- Daelyshia: DamageModifier 4.6 -> 3.5 (sheet, TBC, 21 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 4267;
-- Scarlet Wizard: DamageModifier 1.7 -> 1.9 (melee, WotLK, 127 swings, k 1.891-1.888)
UPDATE `creature_template` SET `DamageModifier` = 1.9 WHERE `entry` = 4300;
-- Scarlet Tracking Hound: DamageModifier 2.4 -> 1.7 (melee, WotLK, 242 swings, k 1.680-1.685)
UPDATE `creature_template` SET `DamageModifier` = 1.7 WHERE `entry` = 4304;
-- Unfettered Spirit: DamageModifier 2.4 -> 1 (melee, WotLK, 817 swings, k 0.987-0.994)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 4308;
-- Tharm: DamageModifier 4.6 -> 3.5 (sheet, TBC, 53 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 4312;
-- Gorkas: DamageModifier 4.6 -> 3.5 (sheet, TBC, 15 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 4314;
-- Nyse: DamageModifier 4.6 -> 3.5 (sheet, TBC, 172 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 4317;
-- Thyssiana: DamageModifier 4.6 -> 3.5 (sheet, TBC, 17 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 4319;
-- Baldruc: DamageModifier 4.6 -> 3.5 (sheet, TBC, 147 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 4321;
-- Bubbling Swamp Ooze: DamageModifier 1 -> 1.2 (melee, WotLK, 147 swings, k 1.193-1.196)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 4394;
-- Teloren: DamageModifier 4.6 -> 3.5 (sheet, TBC, 10 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 4407;
-- Giant Darkfang Spider: DamageModifier 1 -> 1.2 (melee, TBC, 35 swings, k 1.243-1.191)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 4415;
-- Vilebranch Warrior: DamageModifier 1 -> 2.5 (melee, Classic, 122 swings, k 2.597-2.594)
UPDATE `creature_template` SET `DamageModifier` = 2.5 WHERE `entry` = 4465;
-- Emerald Ooze: ExperienceModifier 1 -> 0.95 (xp, TBC, 3 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.95 WHERE `entry` = 4469;
-- Overlord Mok'Morokk: DamageModifier 2.4 -> 2 (melee, WotLK, 43 swings, k 1.994-2.005)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 4500;
-- Stone Rumbler: DamageModifier 1.7 -> 1 (melee, TBC, 31 swings, k 0.958-0.999)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 4528;
-- Michael Garrett: DamageModifier 4.6 -> 3.5 (sheet, TBC, 232 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 4551;
-- Geltharis: DamageModifier 1 -> 1.35 (melee, TBC, 32 swings, k 1.398-1.338)
UPDATE `creature_template` SET `DamageModifier` = 1.35 WHERE `entry` = 4619;
-- Magram Windchaser: ExperienceModifier 1 -> 0.95 (xp, WotLK, 25 kills, 0.56 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.95 WHERE `entry` = 4641;
-- Maraudine Mauler: DamageModifier 1 -> 1.15 (melee, Classic, 57 swings, k 1.133-1.143)
UPDATE `creature_template` SET `DamageModifier` = 1.15 WHERE `entry` = 4656;
-- Burning Blade Felsworn: DamageModifier 1 -> 1.35 (melee, WotLK, 124 swings, k 1.335-1.347)
UPDATE `creature_template` SET `DamageModifier` = 1.35 WHERE `entry` = 4666;
-- Hatefury Shadowstalker: ExperienceModifier 1 -> 0.95 (xp, WotLK, 35 kills, 0.60 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.95 WHERE `entry` = 4674;
-- Lesser Infernal: DamageModifier 1 -> 1.2 (melee, Classic, 64 swings, k 1.199-1.192)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 4676;
-- Doomwarder: DamageModifier 1 -> 1.25 (melee, Classic, 33 swings, k 1.235-1.243)
UPDATE `creature_template` SET `DamageModifier` = 1.25 WHERE `entry` = 4677;
-- Starving Bonepaw: DamageModifier 1 -> 0.28 (melee, Classic, 43 swings, k 0.281-0.287)
UPDATE `creature_template` SET `DamageModifier` = 0.28 WHERE `entry` = 4689;
-- Slitherblade Myrmidon: DamageModifier 1 -> 1.25 (melee, WotLK, 79 swings, k 1.243-1.245)
UPDATE `creature_template` SET `DamageModifier` = 1.25 WHERE `entry` = 4714;
-- Hulking Gritjaw Basilisk: DamageModifier 1 -> 1.2 (melee, WotLK, 134 swings, k 1.183-1.197)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 4729;
-- Fallenroot Shadowstalker: DamageModifier 1.7 -> 2.5 (melee, Classic, 51 swings, k 2.459-2.438)
UPDATE `creature_template` SET `DamageModifier` = 2.5 WHERE `entry` = 4798;
-- Twilight Acolyte: DamageModifier 1.7 -> 1.2 (melee, Classic, 68 swings, k 1.179-1.192)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 4809;
-- Barbed Crustacean: DamageModifier 1.7 -> 0.75 (melee, TBC, 42 swings, k 0.751-0.734)
UPDATE `creature_template` SET `DamageModifier` = 0.75 WHERE `entry` = 4823;
-- Aku'mai Snapjaw: DamageModifier 1.7 -> 0.75 (melee, Classic, 72 swings, k 0.752-0.747)
UPDATE `creature_template` SET `DamageModifier` = 0.75 WHERE `entry` = 4825;
-- Stonevault Cave Lurker: DamageModifier 2.4 -> 1.9 (melee, Classic, 71 swings, k 1.888-1.882)
UPDATE `creature_template` SET `DamageModifier` = 1.9 WHERE `entry` = 4850;
-- Stonevault Rockchewer: DamageModifier 2.4 -> 1 (melee, WotLK, 263 swings, k 0.996-0.994)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 4851;
-- Stonevault Oracle: DamageModifier 2.4 -> 1.8 (melee, TBC, 120 swings, k 1.797-1.788)
UPDATE `creature_template` SET `DamageModifier` = 1.8 WHERE `entry` = 4852;
-- Stone Steward: DamageModifier 2.4 -> 3 (melee, TBC, 84 swings, k 2.990-2.993)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 4860;
-- Shrike Bat: DamageModifier 2.4 -> 1.9 (melee, TBC, 56 swings, k 1.888-1.884)
UPDATE `creature_template` SET `DamageModifier` = 1.9 WHERE `entry` = 4861;
-- Jadespine Basilisk: DamageModifier 2.4 -> 2 (melee, Classic, 37 swings, k 1.991-1.963)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 4863;
-- Obsidian Golem: DamageModifier 1 -> 1.8 (melee, Classic, 135 swings, k 1.781-1.793)
UPDATE `creature_template` SET `DamageModifier` = 1.8 WHERE `entry` = 4872;
-- Theramore Guard: DamageModifier 1 -> 2 (sheet, TBC, 2559 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 4979;
-- Deviate Lasher: DamageModifier 1 -> 1.15 (melee, TBC, 158 swings, k 1.157-1.151)
UPDATE `creature_template` SET `DamageModifier` = 1.15 WHERE `entry` = 5055;
-- Innkeeper Firebrew: DamageModifier 1 -> 0.5 (sheet, TBC, 7 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5111;
-- Daera Brightspear: DamageModifier 1 -> 0.5 (sheet, TBC, 60 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5115;
-- Olmin Burningbeard: DamageModifier 1 -> 0.5 (sheet, TBC, 73 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5116;
-- Regnus Thundergranite: DamageModifier 1 -> 0.5 (sheet, TBC, 74 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5117;
-- Brogun Stoneshield: DamageModifier 4.6 -> 12 (sheet, TBC, 56 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 5118;
-- Jondor Steelbrow: DamageModifier 1 -> 0.5 (sheet, TBC, 46 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5130;
-- Reyna Stonebranch: DamageModifier 1 -> 0.5 (sheet, TBC, 89 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5137;
-- Theodrus Frostbeard: DamageModifier 1 -> 0.5 (sheet, TBC, 47 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5141;
-- Braenna Flintcrag: DamageModifier 1 -> 0.5 (sheet, TBC, 48 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5142;
-- Toldren Deepiron: DamageModifier 1 -> 0.5 (sheet, TBC, 48 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5143;
-- Bink: DamageModifier 1 -> 0.5 (sheet, TBC, 48 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5144;
-- Juli Stormkettle: DamageModifier 1 -> 0.5 (sheet, TBC, 47 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5145;
-- Nittlebur Sparkfizzle: DamageModifier 1 -> 0.5 (sheet, TBC, 47 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5146;
-- Valgar Highforge: DamageModifier 1 -> 0.5 (sheet, TBC, 47 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5147;
-- Beldruk Doombrow: DamageModifier 1 -> 0.5 (sheet, TBC, 47 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5148;
-- Brandur Ironhammer: DamageModifier 1 -> 0.5 (sheet, TBC, 40 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5149;
-- Grumnus Steelshaper: DamageModifier 1 -> 0.5 (sheet, TBC, 94 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5164;
-- Hulfdan Blackbeard: DamageModifier 1 -> 0.5 (sheet, TBC, 27 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5165;
-- Ormyr Flinteye: DamageModifier 1 -> 0.5 (sheet, TBC, 27 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5166;
-- Fenthwick: DamageModifier 1 -> 0.5 (sheet, TBC, 27 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5167;
-- Thistleheart: DamageModifier 1 -> 0.5 (sheet, TBC, 19 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5171;
-- Briarthorn: DamageModifier 1 -> 0.5 (sheet, TBC, 18 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5172;
-- Alexander Calder: DamageModifier 1 -> 0.5 (sheet, TBC, 18 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5173;
-- Murk Worm: DamageModifier 2.4 -> 2.75 (melee, TBC, 104 swings, k 2.814-2.808)
UPDATE `creature_template` SET `DamageModifier` = 2.75 WHERE `entry` = 5226;
-- Saturated Ooze: DamageModifier 2.4 -> 2.75 (melee, TBC, 33 swings, k 2.775-2.794)
UPDATE `creature_template` SET `DamageModifier` = 2.75 WHERE `entry` = 5228;
-- Gordunni Brute: DamageModifier 1 -> 1.1 (melee, WotLK, 223 swings, k 1.097-1.098)
UPDATE `creature_template` SET `DamageModifier` = 1.1 WHERE `entry` = 5232;
-- Woodpaw Brute: DamageModifier 1 -> 1.25 (melee, WotLK, 92 swings, k 1.242-1.240)
UPDATE `creature_template` SET `DamageModifier` = 1.25 WHERE `entry` = 5253;
-- Atal'ai Warrior: DamageModifier 2.4 -> 2.75 (melee, Classic, 53 swings, k 2.878-2.870)
UPDATE `creature_template` SET `DamageModifier` = 2.75 WHERE `entry` = 5256;
-- Groddoc Ape: DamageModifier 1 -> 1.25 (melee, WotLK, 51 swings, k 1.242-1.251)
UPDATE `creature_template` SET `DamageModifier` = 1.25 WHERE `entry` = 5260;
-- Groddoc Thunderer: DamageModifier 1 -> 1.25 (melee, Classic, 138 swings, k 1.245-1.241)
UPDATE `creature_template` SET `DamageModifier` = 1.25 WHERE `entry` = 5262;
-- Mummified Atal'ai: DamageModifier 2.4 -> 1 (melee, WotLK, 111 swings, k 0.994-0.997)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 5263;
-- Unliving Atal'ai: DamageModifier 2.4 -> 3 (melee, TBC, 46 swings, k 2.997-3.008)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 5267;
-- Atal'ai Corpse Eater: DamageModifier 2.4 -> 3 (melee, Classic, 86 swings, k 2.991-3.003)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 5270;
-- Atal'ai Deathwalker: DamageModifier 2.4 -> 3 (melee, TBC, 54 swings, k 3.084-3.100)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 5271;
-- Nightmare Scalebane: DamageModifier 2.4 -> 3 (melee, TBC, 72 swings, k 3.099-3.096)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 5277;
-- Nightmare Wyrmkin: DamageModifier 2.4 -> 3.25 (melee, TBC, 31 swings, k 3.194-3.097)
UPDATE `creature_template` SET `DamageModifier` = 3.25 WHERE `entry` = 5280;
-- Nightmare Wanderer: DamageModifier 2.4 -> 3 (melee, TBC, 87 swings, k 2.980-3.000)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 5283;
-- Feral Scar Yeti: DamageModifier 1 -> 1.2 (melee, WotLK, 493 swings, k 1.191-1.200)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 5292;
-- Hatecrest Screamer: ExperienceModifier 1 -> 0.95 (xp, WotLK, 12 kills, 0.75 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.95 WHERE `entry` = 5335;
-- Northspring Slayer: DamageModifier 1 -> 1.15 (melee, WotLK, 88 swings, k 1.141-1.144)
UPDATE `creature_template` SET `DamageModifier` = 1.15 WHERE `entry` = 5364;
-- Dunemaul Brute: DamageModifier 1 -> 1.15 (melee, WotLK, 887 swings, k 1.147-1.148)
UPDATE `creature_template` SET `DamageModifier` = 1.15 WHERE `entry` = 5474;
-- Erika Tate: DamageModifier 1 -> 0.5 (sheet, TBC, 66 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5483;
-- Brother Benjamin: DamageModifier 1 -> 0.5 (sheet, TBC, 25 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5484;
-- Brother Joshua: DamageModifier 1 -> 0.5 (sheet, TBC, 9 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5489;
-- Arthur the Faithful: DamageModifier 1 -> 0.5 (sheet, TBC, 22 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5491;
-- Katherine the Pure: DamageModifier 1 -> 0.5 (sheet, TBC, 15 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5492;
-- Catherine Leland: DamageModifier 1 -> 0.5 (sheet, TBC, 87 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5494;
-- Ursula Deline: DamageModifier 1 -> 0.5 (sheet, TBC, 11 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5495;
-- Sandahl: DamageModifier 1 -> 0.5 (sheet, TBC, 11 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5496;
-- Jennea Cannon: DamageModifier 1 -> 0.5 (sheet, TBC, 353 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5497;
-- Elsharin: DamageModifier 1 -> 0.5 (sheet, TBC, 394 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5498;
-- Tel'Athir: DamageModifier 1 -> 0.5 (sheet, TBC, 613 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5500;
-- Eldraeith: DamageModifier 1 -> 0.5 (sheet, TBC, 605 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5503;
-- Thulman Flintcrag: DamageModifier 1 -> 0.5 (sheet, TBC, 51 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5510;
-- Therum Deepforge: DamageModifier 1 -> 0.5 (sheet, TBC, 51 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5511;
-- Kaita Deepforge: DamageModifier 1 -> 0.5 (sheet, TBC, 51 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5512;
-- Gelman Stonehand: DamageModifier 1 -> 0.5 (sheet, TBC, 47 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5513;
-- Brooke Stonebraid: DamageModifier 1 -> 0.5 (sheet, TBC, 47 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5514;
-- Einris Brightspear: DamageModifier 1 -> 0.5 (sheet, TBC, 21 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5515;
-- Ulfir Ironbeard: DamageModifier 1 -> 0.5 (sheet, TBC, 25 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5516;
-- Thorfin Stoneshield: DamageModifier 1 -> 0.5 (sheet, TBC, 43 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5517;
-- Billibub Cogspinner: DamageModifier 1 -> 0.5 (sheet, TBC, 40 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5519;
-- Spackle Thornberry: DamageModifier 1 -> 0.5 (sheet, TBC, 11 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5520;
-- Jillian Tanner: DamageModifier 1 -> 0.5 (sheet, TBC, 82 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5565;
-- Sellandus: DamageModifier 1 -> 0.5 (sheet, TBC, 994 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 5567;
-- Ironforge Guard: DamageModifier 1 -> 2 (sheet, TBC, 3525 sheets, exp 1 (AC 2))
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 5595;
-- Twilight Dark Shaman: ExperienceModifier 1 -> 0.95 (xp, WotLK, 29 kills, 0.72 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.95 WHERE `entry` = 5860;
-- Ironeye the Invincible: DamageModifier 2.4 -> 1.75 (melee, TBC, 44 swings, k 1.741-1.742)
UPDATE `creature_template` SET `DamageModifier` = 1.75 WHERE `entry` = 5935;
-- Tooga: DamageModifier 1 -> 0.2 (melee, TBC, 105 swings, k 0.198-0.200)
UPDATE `creature_template` SET `DamageModifier` = 0.2 WHERE `entry` = 5955;
-- Snickerfang Hyena: DamageModifier 1 -> 1.15 (sheet, WotLK, 2 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 1.15 WHERE `entry` = 5985;
-- Felguard Sentry: DamageModifier 1 -> 1.2 (melee, TBC, 221 swings, k 1.171-1.197)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 6011;
-- Breyk: DamageModifier 4.6 -> 3.5 (sheet, TBC, 129 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 6026;
-- Caverndeep Ambusher: DamageModifier 1.7 -> 1 (melee, WotLK, 79 swings, k 0.997-0.992)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 6207;
-- Caverndeep Pillager: DamageModifier 1 -> 1.7 (melee, Classic, 89 swings, k 1.702-1.688)
UPDATE `creature_template` SET `DamageModifier` = 1.7 WHERE `entry` = 6210;
-- Leprous Machinesmith: DamageModifier 1.7 -> 1 (melee, Classic, 79 swings, k 0.986-0.997)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 6224;
-- Arcane Nullifier X-21: DamageModifier 1.7 -> 2.38 (melee, WotLK, 162 swings, k 2.392-2.376)
UPDATE `creature_template` SET `DamageModifier` = 2.38 WHERE `entry` = 6232;
-- Kurdram Stonehammer: DamageModifier 1 -> 0.5 (sheet, TBC, 182 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 6297;
-- Delfrum Flintbeard: DamageModifier 1 -> 0.5 (sheet, TBC, 184 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 6299;
-- Gorbold Steelhand: DamageModifier 1 -> 0.5 (sheet, TBC, 186 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 6301;
-- Jubahl Corpseseeker: DamageModifier 1 -> 0.5 (sheet, TBC, 20 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 6382;
-- Anguished Dead: DamageModifier 2.4 -> 1.7 (melee, WotLK, 215 swings, k 1.697-1.700)
UPDATE `creature_template` SET `DamageModifier` = 1.7 WHERE `entry` = 6426;
-- Haunting Phantasm: DamageModifier 2.4 -> 1.7 (melee, WotLK, 73 swings, k 1.692-1.686)
UPDATE `creature_template` SET `DamageModifier` = 1.7 WHERE `entry` = 6427;
-- Illusionary Phantasm: DamageModifier 7.5 -> 1.7 (melee, WotLK, 122 swings, k 1.695-1.701)
UPDATE `creature_template` SET `DamageModifier` = 1.7 WHERE `entry` = 6493;
-- Devilsaur: DamageModifier 2.4 -> 3.5 (melee, Classic, 32 swings, k 3.488-3.397)
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 6498;
-- Ravasaur: DamageModifier 1 -> 1.3 (melee, WotLK, 384 swings, k 1.291-1.301)
UPDATE `creature_template` SET `DamageModifier` = 1.3 WHERE `entry` = 6505;
-- Ravasaur Runner: DamageModifier 1 -> 1.3 (melee, WotLK, 306 swings, k 1.291-1.291)
UPDATE `creature_template` SET `DamageModifier` = 1.3 WHERE `entry` = 6506;
-- Ravasaur Hunter: DamageModifier 1 -> 1.3 (melee, WotLK, 72 swings, k 1.286-1.295)
UPDATE `creature_template` SET `DamageModifier` = 1.3 WHERE `entry` = 6507;
-- Venomhide Ravasaur: DamageModifier 1 -> 1.3 (melee, WotLK, 713 swings, k 1.292-1.296)
UPDATE `creature_template` SET `DamageModifier` = 1.3 WHERE `entry` = 6508;
-- Bloodpetal Lasher: DamageModifier 1 -> 1.3 (melee, WotLK, 101 swings, k 1.292-1.307)
UPDATE `creature_template` SET `DamageModifier` = 1.3 WHERE `entry` = 6509;
-- Bloodpetal Flayer: DamageModifier 1 -> 1.3 (melee, WotLK, 79 swings, k 1.297-1.289)
UPDATE `creature_template` SET `DamageModifier` = 1.3 WHERE `entry` = 6510;
-- Bloodpetal Thresher: DamageModifier 1 -> 1.3 (melee, WotLK, 100 swings, k 1.292-1.299)
UPDATE `creature_template` SET `DamageModifier` = 1.3 WHERE `entry` = 6511;
-- Bloodpetal Trapper: DamageModifier 1 -> 1.3 (melee, WotLK, 118 swings, k 1.296-1.300)
UPDATE `creature_template` SET `DamageModifier` = 1.3 WHERE `entry` = 6512;
-- Tar Beast: DamageModifier 1 -> 1.3 (melee, WotLK, 71 swings, k 1.292-1.298)
UPDATE `creature_template` SET `DamageModifier` = 1.3 WHERE `entry` = 6517;
-- Tar Lurker: DamageModifier 1 -> 1.3 (melee, WotLK, 517 swings, k 1.299-1.298)
UPDATE `creature_template` SET `DamageModifier` = 1.3 WHERE `entry` = 6518;
-- Tar Lord: DamageModifier 1 -> 1.3 (melee, WotLK, 377 swings, k 1.294-1.298)
UPDATE `creature_template` SET `DamageModifier` = 1.3 WHERE `entry` = 6519;
-- Tar Creeper: DamageModifier 1 -> 1.3 (melee, WotLK, 67 swings, k 1.314-1.299)
UPDATE `creature_template` SET `DamageModifier` = 1.3 WHERE `entry` = 6527;
-- Gorishi Worker: DamageModifier 1 -> 1.2 (melee, TBC, 30 swings, k 1.226-1.191)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 6552;
-- Uhk'loc: DamageModifier 1 -> 1.25 (sheet, WotLK, 1 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 1.25 WHERE `entry` = 6585;
-- Thalon: DamageModifier 4.6 -> 3.5 (sheet, TBC, 22 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 6726;
-- Earthen Rocksmasher: DamageModifier 2.4 -> 1.15 (melee, Classic, 78 swings, k 1.159-1.145)
UPDATE `creature_template` SET `DamageModifier` = 1.15 WHERE `entry` = 7011;
-- Venomlash Scorpid: DamageModifier 2.4 -> 2 (melee, Classic, 57 swings, k 1.995-2.000)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 7022;
-- Blackrock Slayer: DamageModifier 1 -> 1.25 (melee, WotLK, 61 swings, k 1.245-1.252)
UPDATE `creature_template` SET `DamageModifier` = 1.25 WHERE `entry` = 7027;
-- Shadowforge Geologist: DamageModifier 2.4 -> 2 (melee, TBC, 41 swings, k 2.086-2.092)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 7030;
-- Thaurissan Spy: DamageModifier 1 -> 1.2 (melee, WotLK, 63 swings, k 1.200-1.197)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 7036;
-- Cleft Scorpid: DamageModifier 2.4 -> 1 (melee, TBC, 72 swings, k 0.981-0.988)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 7078;
-- Jaedenar Enforcer: DamageModifier 1 -> 1.1 (melee, WotLK, 107 swings, k 1.095-1.086)
UPDATE `creature_template` SET `DamageModifier` = 1.1 WHERE `entry` = 7114;
-- Stonevault Ambusher: DamageModifier 2.4 -> 1 (melee, TBC, 61 swings, k 0.983-0.997)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 7175;
-- Shayis Steelfury: DamageModifier 1 -> 0.5 (sheet, TBC, 8 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 7230;
-- Kelgruk Bloodaxe: DamageModifier 1 -> 0.5 (sheet, TBC, 8 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 7231;
-- Borgus Steelhand: DamageModifier 1 -> 0.5 (sheet, TBC, 48 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 7232;
-- Ferocitas the Dream Eater: DamageModifier 1 -> 0.95 (melee, Classic, 38 swings, k 0.955-0.924)
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 7234;
-- Gnarlpine Mystic: DamageModifier 1 -> 0.95 (melee, TBC, 374 swings, k 0.926-0.935)
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 7235;
-- Sandfury Shadowhunter: DamageModifier 2.4 -> 2.5 (melee, TBC, 343 swings, k 2.590-2.592)
UPDATE `creature_template` SET `DamageModifier` = 2.5 WHERE `entry` = 7246;
-- Sandfury Soul Eater: DamageModifier 2.4 -> 2.5 (melee, TBC, 46 swings, k 2.605-2.592)
UPDATE `creature_template` SET `DamageModifier` = 2.5 WHERE `entry` = 7247;
-- Sandfury Guardian: DamageModifier 2.4 -> 2.5 (melee, TBC, 66 swings, k 2.616-2.589)
UPDATE `creature_template` SET `DamageModifier` = 2.5 WHERE `entry` = 7268;
-- Scarab: DamageModifier 2.4 -> 1.3 (melee, TBC, 393 swings, k 1.290-1.298)
UPDATE `creature_template` SET `DamageModifier` = 1.3 WHERE `entry` = 7269;
-- Zul'Farrak Dead Hero: DamageModifier 1 -> 1.2 (melee, TBC, 72 swings, k 1.184-1.200)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 7276;
-- Zul'Farrak Zombie: DamageModifier 7.5 -> 2.5 (melee, TBC, 907 swings, k 2.387-2.396)
UPDATE `creature_template` SET `DamageModifier` = 2.5 WHERE `entry` = 7286;
-- Dink: DamageModifier 1 -> 0.5 (sheet, TBC, 48 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 7312;
-- Withered Battle Boar: DamageModifier 1.7 -> 1 (melee, TBC, 110 swings, k 0.991-0.990)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 7333;
-- Splinterbone Skeleton: DamageModifier 1.7 -> 1 (melee, Classic, 118 swings, k 0.985-0.995)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 7343;
-- Splinterbone Warrior: DamageModifier 1.7 -> 1.5 (melee, TBC, 76 swings, k 1.496-1.489)
UPDATE `creature_template` SET `DamageModifier` = 1.5 WHERE `entry` = 7344;
-- Splinterbone Centurion: DamageModifier 1.7 -> 1.5 (melee, TBC, 104 swings, k 1.483-1.488)
UPDATE `creature_template` SET `DamageModifier` = 1.5 WHERE `entry` = 7346;
-- Boneflayer Ghoul: DamageModifier 1.7 -> 1.9 (melee, Classic, 102 swings, k 1.891-1.880)
UPDATE `creature_template` SET `DamageModifier` = 1.9 WHERE `entry` = 7347;
-- Thorn Eater Ghoul: DamageModifier 1.7 -> 1.8 (melee, TBC, 46 swings, k 1.797-1.796)
UPDATE `creature_template` SET `DamageModifier` = 1.8 WHERE `entry` = 7348;
-- Freezing Spirit: DamageModifier 1.7 -> 2 (melee, Classic, 102 swings, k 1.986-1.990)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 7353;
-- Earthen Stonebreaker: DamageModifier 2.4 -> 1.25 (melee, TBC, 221 swings, k 1.239-1.246)
UPDATE `creature_template` SET `DamageModifier` = 1.25 WHERE `entry` = 7396;
-- Galak Flame Guard: DamageModifier 1 -> 1.3 (melee, WotLK, 38 swings, k 1.295-1.291)
UPDATE `creature_template` SET `DamageModifier` = 1.3 WHERE `entry` = 7404;
-- Deadly Cleft Scorpid: DamageModifier 2.4 -> 1 (melee, TBC, 43 swings, k 0.980-0.994)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 7405;
-- Thelman Slatefist: DamageModifier 4.6 -> 12 (sheet, TBC, 4 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 7410;
-- Taim Ragetotem: DamageModifier 4.6 -> 12 (sheet, TBC, 12 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 7427;
-- Cobalt Wyrmkin: DamageModifier 2.4 -> 3.5 (melee, WotLK, 71 swings, k 3.592-3.583)
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 7435;
-- Cobalt Scalebane: DamageModifier 2.4 -> 3.75 (melee, WotLK, 96 swings, k 3.700-3.683)
UPDATE `creature_template` SET `DamageModifier` = 3.75 WHERE `entry` = 7436;
-- Leprous Assistant: DamageModifier 1.7 -> 1 (melee, TBC, 187 swings, k 0.973-0.982)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 7603;
-- Sergeant Bly: DamageModifier 2.4 -> 1.25 (melee, TBC, 193 swings, k 1.241-1.248)
UPDATE `creature_template` SET `DamageModifier` = 1.25 WHERE `entry` = 7604;
-- Weegli Blastfuse: DamageModifier 2.4 -> 1.15 (melee, WotLK, 308 swings, k 1.141-1.145)
UPDATE `creature_template` SET `DamageModifier` = 1.15 WHERE `entry` = 7607;
-- Murta Grimgut: DamageModifier 2.4 -> 1.2 (melee, TBC, 76 swings, k 1.187-1.197)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 7608;
-- Grol the Destroyer: DamageModifier 2.4 -> 6.5 (melee, WotLK, 156 swings, k 6.532-6.500)
UPDATE `creature_template` SET `DamageModifier` = 6.5 WHERE `entry` = 7665;
-- Lady Sevine: DamageModifier 2.4 -> 4 (melee, WotLK, 904 swings, k 3.891-3.898)
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 7667;
-- Servant of Razelikh: DamageModifier 1 -> 1.4 (melee, WotLK, 102 swings, k 1.395-1.397)
UPDATE `creature_template` SET `DamageModifier` = 1.4 WHERE `entry` = 7668;
-- Servant of Grol: DamageModifier 1 -> 1.1 (melee, Classic, 41 swings, k 1.091-1.104)
UPDATE `creature_template` SET `DamageModifier` = 1.1 WHERE `entry` = 7669;
-- Servant of Allistarj: DamageModifier 1 -> 1.2 (melee, Classic, 69 swings, k 1.196-1.200)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 7670;
-- Servant of Sevine: DamageModifier 1 -> 1.3 (melee, Classic, 40 swings, k 1.293-1.299)
UPDATE `creature_template` SET `DamageModifier` = 1.3 WHERE `entry` = 7671;
-- Felcular: DamageModifier 1 -> 4 (melee, Classic, 49 swings, k 4.067-4.006)
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 7735;
-- Witherbark Bloodling: DamageModifier 1 -> 0.75 (melee, Classic, 41 swings, k 0.777-0.762)
UPDATE `creature_template` SET `DamageModifier` = 0.75 WHERE `entry` = 7768;
-- Hazzali Parasite: DamageModifier 1 -> 0.8 (melee, WotLK, 167 swings, k 0.792-0.799)
UPDATE `creature_template` SET `DamageModifier` = 0.8 WHERE `entry` = 7769;
-- Sandfury Drudge: DamageModifier 1 -> 1.25 (melee, WotLK, 603 swings, k 1.242-1.246)
UPDATE `creature_template` SET `DamageModifier` = 1.25 WHERE `entry` = 7788;
-- Sandfury Cretin: DamageModifier 7.5 -> 2.5 (melee, WotLK, 139 swings, k 2.523-2.487)
UPDATE `creature_template` SET `DamageModifier` = 2.5 WHERE `entry` = 7789;
-- Bera Stonehammer: DamageModifier 4.6 -> 3.5 (sheet, TBC, 24 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 7823;
-- Bulkrek Ragefist: DamageModifier 4.6 -> 3.5 (sheet, TBC, 122 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 7824;
-- Hadoken Swiftstrider: DamageModifier 2.4 -> 3 (sheet, TBC, 157 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 7875;
-- Mulgore Protector: DamageModifier 3 -> 1 (melee, TBC, 32 swings, k 0.985-0.995)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 7975;
-- Deathguard Elite: DamageModifier 1 -> 2 (melee, WotLK, 411 swings, k 2.002-1.999)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 7980;
-- Blastmaster Emi Shortfuse: DamageModifier 1.7 -> 1 (melee, WotLK, 42 swings, k 0.994-0.985)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 7998;
-- Guthrum Thunderfist: DamageModifier 4.6 -> 3.5 (sheet, TBC, 13 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 8018;
-- Fyldren Moonfeather: DamageModifier 4.6 -> 3.5 (sheet, TBC, 3 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 8019;
-- Shyn: DamageModifier 4.6 -> 3.5 (sheet, TBC, 183 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 8020;
-- Sul'lithuz Sandcrawler: DamageModifier 2.4 -> 2.75 (melee, TBC, 121 swings, k 2.795-2.797)
UPDATE `creature_template` SET `DamageModifier` = 2.75 WHERE `entry` = 8095;
-- Witch Doctor Uzer'i: DamageModifier 1 -> 14.5 (sheet, TBC, 152 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 14.5 WHERE `entry` = 8115;
-- Camp Mojache Brave: DamageModifier 1.6 -> 1 (melee, Classic, 53 swings, k 0.994-0.999)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 8147;
-- Oozeling: DamageModifier 2.4 -> 1.25 (melee, WotLK, 152 swings, k 1.235-1.240)
UPDATE `creature_template` SET `DamageModifier` = 1.25 WHERE `entry` = 8257;
-- Highlord Mastrogonde: DamageModifier 2.4 -> 3 (melee, WotLK, 34 swings, k 3.098-3.088)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 8282;
-- Slime Maggot: DamageModifier 2.4 -> 1.3 (melee, TBC, 448 swings, k 1.294-1.297)
UPDATE `creature_template` SET `DamageModifier` = 1.3 WHERE `entry` = 8311;
-- Atal'ai Deathwalker's Spirit: DamageModifier 7.5 -> 3.5 (melee, Classic, 35 swings, k 3.527-3.494)
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 8317;
-- Atal'ai Slave: DamageModifier 2.4 -> 1.35 (melee, TBC, 283 swings, k 1.346-1.350)
UPDATE `creature_template` SET `DamageModifier` = 1.35 WHERE `entry` = 8318;
-- Nightmare Whelp: DamageModifier 2.4 -> 1.5 (melee, TBC, 243 swings, k 1.503-1.502)
UPDATE `creature_template` SET `DamageModifier` = 1.5 WHERE `entry` = 8319;
-- Deep Lurker: DamageModifier 2.4 -> 3 (melee, TBC, 42 swings, k 2.907-2.915)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 8384;
-- Hakkari Minion: DamageModifier 1 -> 1.35 (melee, TBC, 83 swings, k 1.355-1.342)
UPDATE `creature_template` SET `DamageModifier` = 1.35 WHERE `entry` = 8437;
-- Raze: DamageModifier 1 -> 1.5 (sheet, TBC, 3 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 1.5 WHERE `entry` = 8441;
-- Skeletal Servant: DamageModifier 3.5 -> 1 (melee, WotLK, 89 swings, k 0.987-1.000)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 8477;
-- Kalaran Windblade: DamageModifier 2.4 -> 4.5 (sheet, TBC, 58 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 4.5 WHERE `entry` = 8479;
-- Dark Iron Sentry: DamageModifier 7.5 -> 3.75 (melee, Classic, 91 swings, k 3.717-3.733)
UPDATE `creature_template` SET `DamageModifier` = 3.75 WHERE `entry` = 8504;
-- Plaguehound Runt: DamageModifier 1 -> 1.25 (melee, WotLK, 994 swings, k 1.244-1.245)
UPDATE `creature_template` SET `DamageModifier` = 1.25 WHERE `entry` = 8596;
-- Frenzied Plaguehound: DamageModifier 1 -> 0.63 (sheet, WotLK, 1 sheets, exp 0 (AC 0)); ArmorModifier 1 -> 0.8 (armor, WotLK, 1 sheets, 1.0 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.8, `DamageModifier` = 0.63 WHERE `entry` = 8598;
-- Alexandra Constantine: DamageModifier 4.6 -> 3.5 (sheet, TBC, 8 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 8609;
-- Kroum: DamageModifier 4.6 -> 3.5 (sheet, TBC, 19 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 8610;
-- Linken: DamageModifier 1 -> 0.5 (sheet, TBC, 107 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 8737;
-- Sandfury Acolyte: DamageModifier 1 -> 1.2 (melee, TBC, 127 swings, k 1.185-1.197)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 8876;
-- Sandfury Zealot: DamageModifier 1 -> 1.25 (melee, WotLK, 63 swings, k 1.243-1.251)
UPDATE `creature_template` SET `DamageModifier` = 1.25 WHERE `entry` = 8877;
-- Anvilrage Warden: DamageModifier 3.5 -> 3 (melee, Classic, 76 swings, k 2.989-3.004)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 8890;
-- Anvilrage Guardsman: DamageModifier 3.5 -> 3 (melee, Classic, 201 swings, k 3.090-3.090)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 8891;
-- Doomforge Craftsman: DamageModifier 3.5 -> 1.7 (melee, Classic, 83 swings, k 1.698-1.696)
UPDATE `creature_template` SET `DamageModifier` = 1.7 WHERE `entry` = 8897;
-- Anvilrage Reservist: DamageModifier 3.5 -> 1 (melee, WotLK, 205 swings, k 0.995-0.999)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 8901;
-- Shadowforge Senator: DamageModifier 3.5 -> 1.8 (melee, Classic, 52 swings, k 1.785-1.802)
UPDATE `creature_template` SET `DamageModifier` = 1.8 WHERE `entry` = 8904;
-- Twilight's Hammer Torturer: DamageModifier 3.5 -> 3 (melee, Classic, 35 swings, k 3.095-3.117)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 8912;
-- Twilight's Hammer Ambassador: DamageModifier 3.5 -> 1.75 (melee, Classic, 58 swings, k 1.739-1.750)
UPDATE `creature_template` SET `DamageModifier` = 1.75 WHERE `entry` = 8915;
-- Weapon Technician: DamageModifier 3.5 -> 1.8 (melee, Classic, 63 swings, k 1.804-1.787)
UPDATE `creature_template` SET `DamageModifier` = 1.8 WHERE `entry` = 8920;
-- Bloodhound: DamageModifier 3.5 -> 3 (melee, Classic, 182 swings, k 2.997-2.998)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 8921;
-- Hilary: DamageModifier 1 -> 0.42 (sheet, TBC, 280 sheets, exp 0 (AC 0)); ArmorModifier 1 -> 1.5 (armor, TBC, 280 sheets, 1.875 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.5, `DamageModifier` = 0.42 WHERE `entry` = 8962;
-- Shawn: DamageModifier 1 -> 0.42 (sheet, TBC, 279 sheets, exp 0 (AC 0)); ArmorModifier 1 -> 1.5 (armor, TBC, 279 sheets, 1.875 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.5, `DamageModifier` = 0.42 WHERE `entry` = 8965;
-- Sraaz: DamageModifier 1 -> 0.5 (sheet, TBC, 89 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 9099;
-- Donova Snowden: DamageModifier 1 -> 5 (sheet, TBC, 34 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 9298;
-- Scarlet Warder: DamageModifier 2.4 -> 3.5 (melee, WotLK, 281 swings, k 3.397-3.393)
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 9447;
-- Scarlet Praetorian: DamageModifier 2.4 -> 3.75 (melee, WotLK, 42 swings, k 3.691-3.708)
UPDATE `creature_template` SET `DamageModifier` = 3.75 WHERE `entry` = 9448;
-- Scarlet Cleric: DamageModifier 2.4 -> 3.5 (melee, WotLK, 146 swings, k 3.387-3.396)
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 9449;
-- Scarlet Enchanter: DamageModifier 2.4 -> 3.5 (melee, WotLK, 70 swings, k 3.480-3.500)
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 9452;
-- Warlord Krom'zar: DamageModifier 7.5 -> 2 (melee, WotLK, 33 swings, k 2.025-1.999)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 9456;
-- Enraged Felbat: DamageModifier 2 -> 3.5 (melee, WotLK, 35 swings, k 3.469-3.449)
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 9521;
-- Enraged Gryphon: DamageModifier 2 -> 3.5 (melee, WotLK, 59 swings, k 3.478-3.506)
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 9526;
-- Arei: DamageModifier 1 -> 1.5 (melee, WotLK, 89 swings, k 1.496-1.498)
UPDATE `creature_template` SET `DamageModifier` = 1.5 WHERE `entry` = 9598;
-- Ember Worg: DamageModifier 1 -> 1.15 (melee, WotLK, 56 swings, k 1.141-1.150)
UPDATE `creature_template` SET `DamageModifier` = 1.15 WHERE `entry` = 9690;
-- Flamekin Spitter: DamageModifier 1 -> 0.3 (sheet, WotLK, 4 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.3 WHERE `entry` = 9776;
-- Flamekin Sprite: DamageModifier 1 -> 0.3 (sheet, WotLK, 7 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.3 WHERE `entry` = 9777;
-- Flamekin Torcher: DamageModifier 1 -> 0.3 (melee, WotLK, 43 swings, k 0.295-0.295)
UPDATE `creature_template` SET `DamageModifier` = 0.3 WHERE `entry` = 9778;
-- Salia: DamageModifier 1 -> 1.15 (melee, Classic, 33 swings, k 1.151-1.146)
UPDATE `creature_template` SET `DamageModifier` = 1.15 WHERE `entry` = 9860;
-- Lanti'gah: DamageModifier 1 -> 0.98 (sheet, TBC, 14 sheets, exp 0 (AC 0)); ArmorModifier 1 -> 1.05 (armor, TBC, 14 sheets, 1.118 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.05, `DamageModifier` = 0.98 WHERE `entry` = 9990;
-- Lakeshire Guard: DamageModifier 0.4 -> 2 (melee, WotLK, 146 swings, k 1.995-1.994)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 10037;
-- Night Watch Guard: DamageModifier 1 -> 2 (melee, WotLK, 279 swings, k 2.002-2.000)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 10038;
-- Silvaria: DamageModifier 1 -> 0.5 (sheet, TBC, 47 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 10089;
-- Belia Thundergranite: DamageModifier 1 -> 0.5 (sheet, TBC, 62 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 10090;
-- Vault Warder: DamageModifier 2.4 -> 3 (melee, Classic, 39 swings, k 3.108-3.007)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 10120;
-- Rookery Whelp: DamageModifier 1 -> 2.5 (melee, WotLK, 880 swings, k 2.491-2.496)
UPDATE `creature_template` SET `DamageModifier` = 2.5 WHERE `entry` = 10161;
-- Rokaro: DamageModifier 4.6 -> 12 (sheet, TBC, 18 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 10182;
-- Halycon: DamageModifier 3.5 -> 6.5 (melee, WotLK, 31 swings, k 6.577-6.539)
UPDATE `creature_template` SET `DamageModifier` = 6.5 WHERE `entry` = 10220;
-- Rotgath Stonebeard: DamageModifier 1 -> 0.5 (sheet, TBC, 94 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 10276;
-- Groum Stonebeard: DamageModifier 1 -> 0.5 (sheet, TBC, 94 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 10277;
-- Jaron Stoneshaper: DamageModifier 1 -> 9.5 (sheet, TBC, 5 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 9.5 WHERE `entry` = 10301;
-- Emberstrife: DamageModifier 4.6 -> 5 (sheet, WotLK, 1 sheets, exp 0 (AC 0)); ArmorModifier 1 -> 0.8 (armor, WotLK, 1 sheets, 1.0 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.8, `DamageModifier` = 5 WHERE `entry` = 10321;
-- Gyth: DamageModifier 3.5 -> 5 (melee, WotLK, 183 swings, k 4.996-5.002)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 10339;
-- Kergul Bloodaxe: DamageModifier 4.6 -> 12 (sheet, TBC, 23 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 10360;
-- Omusa Thunderhorn: DamageModifier 4.6 -> 3.5 (sheet, TBC, 110 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 10378;
-- Ravaged Cadaver: DamageModifier 3.5 -> 3.75 (melee, Classic, 103 swings, k 3.686-3.698)
UPDATE `creature_template` SET `DamageModifier` = 3.75 WHERE `entry` = 10381;
-- Plague Ghoul: DamageModifier 3.5 -> 4.75 (melee, Classic, 58 swings, k 4.775-4.703)
UPDATE `creature_template` SET `DamageModifier` = 4.75 WHERE `entry` = 10405;
-- Rockwing Gargoyle: DamageModifier 3.5 -> 3.75 (melee, Classic, 32 swings, k 3.837-3.752)
UPDATE `creature_template` SET `DamageModifier` = 3.75 WHERE `entry` = 10408;
-- Patchwork Horror: DamageModifier 3.5 -> 6 (melee, Classic, 30 swings, k 6.080-5.898)
UPDATE `creature_template` SET `DamageModifier` = 6 WHERE `entry` = 10414;
-- Crimson Guardsman: DamageModifier 3.5 -> 3.75 (melee, Classic, 328 swings, k 3.795-3.785)
UPDATE `creature_template` SET `DamageModifier` = 3.75 WHERE `entry` = 10418;
-- Crimson Gallant: DamageModifier 3.5 -> 4 (melee, Classic, 64 swings, k 4.010-4.002)
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 10424;
-- Nerub'enkan: DamageModifier 3.5 -> 7.5 (melee, WotLK, 45 swings, k 7.443-7.437)
UPDATE `creature_template` SET `DamageModifier` = 7.5 WHERE `entry` = 10437;
-- Baron Rivendare: DamageModifier 3.5 -> 8 (melee, WotLK, 33 swings, k 7.953-7.967)
UPDATE `creature_template` SET `DamageModifier` = 8 WHERE `entry` = 10440;
-- Plagued Rat: DamageModifier 1 -> 0.4 (melee, WotLK, 952 swings, k 0.393-0.393)
UPDATE `creature_template` SET `DamageModifier` = 0.4 WHERE `entry` = 10441;
-- Plagued Insect: DamageModifier 1 -> 0.4 (melee, WotLK, 431 swings, k 0.393-0.393)
UPDATE `creature_template` SET `DamageModifier` = 0.4 WHERE `entry` = 10461;
-- Scholomance Necromancer: DamageModifier 3.5 -> 4 (melee, Classic, 66 swings, k 3.884-3.903)
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 10477;
-- Unstable Corpse: DamageModifier 3.5 -> 0.5 (melee, Classic, 81 swings, k 0.499-0.500)
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 10480;
-- Plagued Maggot: DamageModifier 1 -> 0.4 (melee, WotLK, 54 swings, k 0.391-0.395)
UPDATE `creature_template` SET `DamageModifier` = 0.4 WHERE `entry` = 10536;
-- Gryfe: DamageModifier 4.6 -> 2 (sheet, TBC, 96 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 10583;
-- Mother Smolderweb: DamageModifier 3.5 -> 5.75 (melee, WotLK, 40 swings, k 5.677-5.672)
UPDATE `creature_template` SET `DamageModifier` = 5.75 WHERE `entry` = 10596;
-- Plagued Hatchling: DamageModifier 3.5 -> 4 (melee, Classic, 35 swings, k 3.882-3.925)
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 10678;
-- Bile Slime: DamageModifier 1 -> 2 (melee, WotLK, 480 swings, k 1.990-1.995)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 10697;
-- Temporal Parasite: DamageModifier 1 -> 0.33 (melee, WotLK, 136 swings, k 0.324-0.328)
UPDATE `creature_template` SET `DamageModifier` = 0.33 WHERE `entry` = 10717;
-- Grimtotem Reaver: DamageModifier 1 -> 1.15 (melee, WotLK, 46 swings, k 1.136-1.158)
UPDATE `creature_template` SET `DamageModifier` = 1.15 WHERE `entry` = 10761;
-- Ursius: DamageModifier 1 -> 0.65 (sheet, WotLK, 1 sheets, exp 0 (AC 0)); ArmorModifier 1 -> 0.72 (armor, WotLK, 1 sheets, 0.753 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.72, `DamageModifier` = 0.65 WHERE `entry` = 10806;
-- Winterfall Runner: DamageModifier 1 -> 1.2 (melee, WotLK, 41 swings, k 1.195-1.195)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 10916;
-- Rotting Worm: DamageModifier 0.5 -> 0.8 (melee, WotLK, 319 swings, k 0.787-0.797)
UPDATE `creature_template` SET `DamageModifier` = 0.8 WHERE `entry` = 10925;
-- Succubus Minion: DamageModifier 1 -> 1.15 (melee, WotLK, 645 swings, k 1.135-1.148)
UPDATE `creature_template` SET `DamageModifier` = 1.15 WHERE `entry` = 10928;
-- Silver Hand Disciple: DamageModifier 7.5 -> 3.75 (melee, WotLK, 152 swings, k 3.788-3.803)
UPDATE `creature_template` SET `DamageModifier` = 3.75 WHERE `entry` = 10949;
-- Bloodletter: DamageModifier 7.5 -> 3.75 (melee, WotLK, 35 swings, k 3.797-3.784)
UPDATE `creature_template` SET `DamageModifier` = 3.75 WHERE `entry` = 10954;
-- Fallen Hero: DamageModifier 7.5 -> 4 (melee, WotLK, 117 swings, k 3.986-3.990)
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 10996;
-- Captured Arko'narin: DamageModifier 1 -> 3 (melee, WotLK, 135 swings, k 3.001-3.082)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 11016;
-- Illusory Wraith: DamageModifier 1 -> 0.4 (melee, Classic, 73 swings, k 0.392-0.395)
UPDATE `creature_template` SET `DamageModifier` = 0.4 WHERE `entry` = 11027;
-- Darianna: DamageModifier 1 -> 0.5 (sheet, TBC, 52 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 11083;
-- Maethrya: DamageModifier 4.6 -> 3.5 (sheet, TBC, 61 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 11138;
-- Yugrek: DamageModifier 4.6 -> 3.5 (sheet, TBC, 3 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 11139;
-- Spectral Betrayer: DamageModifier 1 -> 0.4 (melee, WotLK, 1467 swings, k 0.391-0.393)
UPDATE `creature_template` SET `DamageModifier` = 0.4 WHERE `entry` = 11288;
-- Hakkari Shadow Hunter: ArmorModifier 1.15 -> 1 (armor, TBC, 1 sheets, 0.82 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1 WHERE `entry` = 11339;
-- Hakkari Blood Priest: ArmorModifier 1.15 -> 1 (armor, TBC, 4 sheets, 0.82 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1 WHERE `entry` = 11340;
-- Gurubashi Axe Thrower: DamageModifier 4.05 -> 5 (melee, TBC, 56 swings, k 4.975-4.999)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 11350;
-- Gurubashi Blood Drinker: ArmorModifier 1.1 -> 1 (armor, TBC, 2 sheets, 1.011 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1 WHERE `entry` = 11353;
-- Son of Hakkar: DamageModifier 7.15 -> 5 (melee, Classic, 126 swings, k 4.981-5.007)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 11357;
-- Zulian Tiger: DamageModifier 8.85 -> 4 (melee, WotLK, 60 swings, k 3.981-4.005)
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 11361;
-- Zulian Panther: DamageModifier 15.7 -> 5 (melee, Classic, 43 swings, k 4.975-5.018)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 11365;
-- Bloodseeker Bat: DamageModifier 1.25 -> 2.5 (melee, WotLK, 82 swings, k 2.492-2.488)
UPDATE `creature_template` SET `DamageModifier` = 2.5 WHERE `entry` = 11368;
-- Razzashi Adder: DamageModifier 4.2 -> 6 (melee, TBC, 49 swings, k 5.995-6.008)
UPDATE `creature_template` SET `DamageModifier` = 6 WHERE `entry` = 11372;
-- Hooktooth Frenzy: DamageModifier 2.4 -> 4 (melee, TBC, 77 swings, k 3.976-4.002)
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 11374;
-- Eldreth Spectre: DamageModifier 5 -> 4 (melee, Classic, 45 swings, k 3.869-3.916)
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 11473;
-- Skeletal Highborne: DamageModifier 5 -> 1 (melee, Classic, 31 swings, k 0.991-1.002)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 11476;
-- Jergosh the Invoker: DamageModifier 2.4 -> 1.95 (melee, TBC, 58 swings, k 1.971-1.945)
UPDATE `creature_template` SET `DamageModifier` = 1.95 WHERE `entry` = 11518;
-- Necrofiend: DamageModifier 3.5 -> 1 (melee, Classic, 37 swings, k 0.992-0.999)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 11551;
-- Undead Ravager: DamageModifier 1 -> 1.25 (melee, WotLK, 80 swings, k 1.236-1.237)
UPDATE `creature_template` SET `DamageModifier` = 1.25 WHERE `entry` = 11561;
-- Flamewaker Priest: DamageModifier 13 -> 11 (melee, WotLK, 31 swings, k 11.203-11.080)
UPDATE `creature_template` SET `DamageModifier` = 11 WHERE `entry` = 11662;
-- Flame Imp: DamageModifier 7.5 -> 3 (melee, WotLK, 34 swings, k 3.012-3.011)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 11669;
-- Mannoroc Lasher: DamageModifier 1 -> 1.1 (melee, WotLK, 72 swings, k 1.086-1.091)
UPDATE `creature_template` SET `DamageModifier` = 1.1 WHERE `entry` = 11697;
-- Stonelash Pincer: ExperienceModifier 1 -> 1.05 (xp, TBC, 8 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 1.05 WHERE `entry` = 11736;
-- Hakkari Witch Doctor: ArmorModifier 1.1 -> 1.4 (armor, TBC, 1 sheets, 1.142 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.4 WHERE `entry` = 11831;
-- Buliwyf Stonehand: DamageModifier 2.4 -> 7 (sheet, TBC, 32 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 7 WHERE `entry` = 11865;
-- Ilyenia Moonfire: DamageModifier 2.4 -> 3.5 (sheet, TBC, 86 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 11866;
-- Woo Ping: DamageModifier 2.4 -> 7 (sheet, TBC, 927 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 7 WHERE `entry` = 11867;
-- Sayoc: DamageModifier 2.4 -> 7 (sheet, TBC, 2 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 7 WHERE `entry` = 11868;
-- Ansekhwa: DamageModifier 2.4 -> 7 (sheet, TBC, 189 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 7 WHERE `entry` = 11869;
-- Archibald: DamageModifier 2.4 -> 7 (sheet, TBC, 58 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 7 WHERE `entry` = 11870;
-- Twilight Geolord: ExperienceModifier 1 -> 0.95 (xp, TBC, 4 kills, 0.75 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.95 WHERE `entry` = 11881;
-- Mercutio Filthgorger: DamageModifier 1 -> 2 (melee, WotLK, 44 swings, k 2.029-1.998)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 11886;
-- Crypt Robber: DamageModifier 1 -> 1.5 (melee, WotLK, 167 swings, k 1.497-1.493)
UPDATE `creature_template` SET `DamageModifier` = 1.5 WHERE `entry` = 11887;
-- Shardi: DamageModifier 4.6 -> 3.5 (sheet, TBC, 254 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 11899;
-- Brakkar: DamageModifier 4.6 -> 3.5 (sheet, TBC, 6 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 11900;
-- Andruk: DamageModifier 4.6 -> 3.5 (sheet, TBC, 86 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 11901;
-- Gogger Stonepounder: DamageModifier 1 -> 1.3 (melee, TBC, 60 swings, k 1.274-1.281)
UPDATE `creature_template` SET `DamageModifier` = 1.3 WHERE `entry` = 11918;
-- Demon Portal Guardian: DamageModifier 1 -> 1.7 (melee, Classic, 60 swings, k 1.700-1.696)
UPDATE `creature_template` SET `DamageModifier` = 1.7 WHERE `entry` = 11937;
-- Crimson Elite: DamageModifier 7.5 -> 4 (melee, Classic, 338 swings, k 4.006-3.998)
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 12128;
-- Glordrum Steelbeard: DamageModifier 4.6 -> 12 (sheet, TBC, 60 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 12197;
-- Martin Lindsey: DamageModifier 4.6 -> 12 (sheet, TBC, 16 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 12198;
-- Crimson Courier: DamageModifier 4.6 -> 6 (melee, WotLK, 130 swings, k 5.989-5.996)
UPDATE `creature_template` SET `DamageModifier` = 6 WHERE `entry` = 12337;
-- Damned Soul: DamageModifier 0.8 -> 1 (melee, TBC, 50 swings, k 0.994-0.995)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 12378;
-- Unliving Caretaker: DamageModifier 0.6 -> 1 (melee, TBC, 168 swings, k 0.993-0.999)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 12379;
-- Unliving Resident: DamageModifier 0.7 -> 1 (melee, WotLK, 91 swings, k 0.994-0.997)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 12380;
-- Melris Malagan: DamageModifier 1 -> 2 (melee, WotLK, 74 swings, k 1.996-2.001)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 12480;
-- Justine Demalier: DamageModifier 1 -> 2 (melee, WotLK, 61 swings, k 1.992-2.003)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 12481;
-- Mishellena: DamageModifier 4.6 -> 3.5 (sheet, TBC, 1 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 12578;
-- Bibilfaz Featherwhistle: DamageModifier 4.6 -> 3.5 (sheet, TBC, 12 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 12596;
-- Vhulgra: DamageModifier 4.6 -> 3.5 (sheet, TBC, 185 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 12616;
-- Mastok Wrilehiss: DamageModifier 2.4 -> 10 (sheet, TBC, 185 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 10 WHERE `entry` = 12737;
-- Faustron: DamageModifier 4.6 -> 3.5 (sheet, TBC, 2 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 12740;
-- Captain Dirgehammer: ArmorModifier 1 -> 0.1 (armor, TBC, 3 sheets, 0.097 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.1 WHERE `entry` = 12777;
-- Captain O'Neal: ArmorModifier 1 -> 0.1 (armor, TBC, 3 sheets, 0.097 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.1 WHERE `entry` = 12782;
-- Mounted Ironforge Mountaineer: ArmorModifier 1 -> 1.2 (armor, TBC, 14 sheets, 1.215 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.2 WHERE `entry` = 12996;
-- Whip Lasher: DamageModifier 1 -> 0.75 (melee, TBC, 66 swings, k 0.746-0.748)
UPDATE `creature_template` SET `DamageModifier` = 0.75 WHERE `entry` = 13022;
-- Bixi Wobblebonk: DamageModifier 2.4 -> 7 (sheet, TBC, 32 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 7 WHERE `entry` = 13084;
-- Crimson Bodyguard: DamageModifier 2.4 -> 3.75 (melee, WotLK, 685 swings, k 3.797-3.798)
UPDATE `creature_template` SET `DamageModifier` = 3.75 WHERE `entry` = 13118;
-- Hive'Ashi Drone: DamageModifier 1 -> 1.2 (melee, TBC, 67 swings, k 1.200-1.198)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 13136;
-- Carrion Swarmer: DamageModifier 5 -> 1.25 (melee, TBC, 250 swings, k 1.238-1.244)
UPDATE `creature_template` SET `DamageModifier` = 1.25 WHERE `entry` = 13160;
-- Winterfall Ambusher: ExperienceModifier 1 -> 0.25 (xp, WotLK, 3 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.25 WHERE `entry` = 14372;
-- Expeditionary Mountaineer: DamageModifier 2.4 -> 1.5 (melee, TBC, 181 swings, k 1.489-1.496)
UPDATE `creature_template` SET `DamageModifier` = 1.5 WHERE `entry` = 14390;
-- Overlord Runthak: DamageModifier 4.6 -> 12 (sheet, TBC, 1033 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 14392;
-- Expeditionary Priest: DamageModifier 2.4 -> 1.7 (melee, WotLK, 108 swings, k 1.683-1.694)
UPDATE `creature_template` SET `DamageModifier` = 1.7 WHERE `entry` = 14393;
-- Major Mattingly: DamageModifier 4.6 -> 12 (sheet, TBC, 2666 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 14394;
-- Seeker Thompson: DamageModifier 4.6 -> 2.75 (melee, Classic, 38 swings, k 2.899-2.823)
UPDATE `creature_template` SET `DamageModifier` = 2.75 WHERE `entry` = 14404;
-- Duskstalker: DamageModifier 1 -> 1.1 (melee, TBC, 65 swings, k 1.081-1.107)
UPDATE `creature_template` SET `DamageModifier` = 1.1 WHERE `entry` = 14430;
-- Xorothian Imp: DamageModifier 5 -> 1 (melee, Classic, 654 swings, k 0.994-0.992)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 14482;
-- Dread Guard: DamageModifier 5 -> 3.5 (melee, TBC, 227 swings, k 3.498-3.492)
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 14483;
-- High Priest Thekal: DamageModifier 17.55 -> 13 (melee, WotLK, 55 swings, k 13.167-13.017)
UPDATE `creature_template` SET `DamageModifier` = 13 WHERE `entry` = 14509;
-- Corrupted Spirit: DamageModifier 7.5 -> 4.25 (melee, Classic, 64 swings, k 4.277-4.285)
UPDATE `creature_template` SET `DamageModifier` = 4.25 WHERE `entry` = 14512;
-- Banal Spirit: DamageModifier 1 -> 1.05 (melee, Classic, 62 swings, k 1.069-1.073)
UPDATE `creature_template` SET `DamageModifier` = 1.05 WHERE `entry` = 14514;
-- Simone the Inconspicuous: DamageModifier 4.6 -> 5 (sheet, TBC, 2 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 14527;
-- Precious: DamageModifier 4.6 -> 1 (sheet, TBC, 2 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 14528;
-- Franklin the Friendly: DamageModifier 4.6 -> 5 (sheet, TBC, 2 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 14529;
-- Razzashi Venombrood: DamageModifier 10 -> 5 (melee, TBC, 188 swings, k 5.005-5.003)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 14532;
-- Overseer Maltorius: DamageModifier 1 -> 4 (melee, Classic, 50 swings, k 3.975-3.960)
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 14621;
-- Field Marshal Afrasiabi: DamageModifier 4.6 -> 12 (sheet, TBC, 1528 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 14721;
-- Silas Darkmoon: DamageModifier 4.6 -> 1 (sheet, TBC, 2 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 14823;
-- Withered Mistress: DamageModifier 11.7 -> 5 (melee, WotLK, 71 swings, k 5.000-4.987)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 14825;
-- Sacrificed Troll: DamageModifier 1.5 -> 1 (melee, WotLK, 88 swings, k 0.997-0.996)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 14826;
-- Flik: DamageModifier 1 -> 0.98 (sheet, TBC, 4 sheets, exp 0 (AC 0)); ArmorModifier 1 -> 1.05 (armor, TBC, 4 sheets, 1.118 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.05, `DamageModifier` = 0.98 WHERE `entry` = 14860;
-- Atal'ai Mistress: DamageModifier 9.6 -> 7 (sheet, TBC, 1 sheets, exp 0 (AC 0)); ArmorModifier 1.1 -> 1.3 (armor, TBC, 1 sheets, 1.332 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.3, `DamageModifier` = 7 WHERE `entry` = 14882;
-- Voodoo Slave: DamageModifier 10.3 -> 5 (sheet, TBC, 2 sheets, exp 0 (AC 0)); ArmorModifier 1.1 -> 1.4 (armor, TBC, 2 sheets, 1.142 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.4, `DamageModifier` = 5 WHERE `entry` = 14883;
-- Kartra Bloodsnarl: DamageModifier 4.6 -> 12 (sheet, TBC, 17 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 14942;
-- Elfarran: DamageModifier 4.6 -> 12 (sheet, TBC, 6 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 14981;
-- Lylandris: DamageModifier 4.6 -> 12 (sheet, TBC, 61 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 14982;
-- Deze Snowbane: DamageModifier 4.6 -> 12 (sheet, TBC, 33 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 15006;
-- Sir Malory Wheeler: DamageModifier 4.6 -> 12 (sheet, TBC, 8 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 15007;
-- Lady Hoteshem: DamageModifier 4.6 -> 12 (sheet, TBC, 6 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 15008;
-- Zandalarian Emissary: DamageModifier 2.4 -> 4 (sheet, TBC, 477 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 15076;
-- Zulian Prowler: DamageModifier 2.25 -> 1 (melee, Classic, 113 swings, k 0.995-0.999)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 15101;
-- Obsidian Eradicator: DamageModifier 22.5 -> 20 (melee, WotLK, 37 swings, k 19.979-20.036)
UPDATE `creature_template` SET `DamageModifier` = 20 WHERE `entry` = 15262;
-- Hive'Zara Wasp: DamageModifier 12.6 -> 10 (melee, WotLK, 90 swings, k 9.983-9.994)
UPDATE `creature_template` SET `DamageModifier` = 10 WHERE `entry` = 15325;
-- Hive'Zara Stinger: DamageModifier 12.6 -> 5 (melee, WotLK, 69 swings, k 4.977-4.983)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 15327;
-- Qiraji Swarmguard: DamageModifier 17.65 -> 20 (melee, WotLK, 33 swings, k 19.763-20.002)
UPDATE `creature_template` SET `DamageModifier` = 20 WHERE `entry` = 15343;
-- Kurinnaxx: DamageModifier 18.05 -> 16 (melee, WotLK, 44 swings, k 15.988-16.063)
UPDATE `creature_template` SET `DamageModifier` = 16 WHERE `entry` = 15348;
-- Horde Warbringer: DamageModifier 4.6 -> 0.64 (sheet, TBC, 105 sheets, exp 0 (AC 2))
UPDATE `creature_template` SET `DamageModifier` = 0.64 WHERE `entry` = 15350;
-- Alliance Brigadier General: DamageModifier 4.6 -> 0.64 (sheet, TBC, 198 sheets, exp 0 (AC 2))
UPDATE `creature_template` SET `DamageModifier` = 0.64 WHERE `entry` = 15351;
-- Apprentice Mirveda: DamageModifier 1 -> 0.95 (melee, TBC, 45 swings, k 0.935-0.931)
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 15402;
-- Qiraji Wasp: DamageModifier 7.5 -> 2.5 (melee, WotLK, 4980 swings, k 2.396-2.393)
UPDATE `creature_template` SET `DamageModifier` = 2.5 WHERE `entry` = 15414;
-- Qiraji Drone: DamageModifier 7.5 -> 4.5 (melee, WotLK, 6059 swings, k 4.397-4.395)
UPDATE `creature_template` SET `DamageModifier` = 4.5 WHERE `entry` = 15421;
-- Qiraji Tank: DamageModifier 7.5 -> 2.5 (melee, WotLK, 5167 swings, k 2.396-2.393)
UPDATE `creature_template` SET `DamageModifier` = 2.5 WHERE `entry` = 15422;
-- Anubisath Conqueror: DamageModifier 7.5 -> 7 (melee, WotLK, 569 swings, k 6.977-6.989)
UPDATE `creature_template` SET `DamageModifier` = 7 WHERE `entry` = 15424;
-- Ironforge Brigade Footman: DamageModifier 4.6 -> 3 (melee, WotLK, 67 swings, k 2.998-2.984)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 15442;
-- Spectral Stallion: DamageModifier 5 -> 15.5 (melee, TBC, 58 swings, k 15.220-15.294)
UPDATE `creature_template` SET `DamageModifier` = 15.5 WHERE `entry` = 15548;
-- Eversong Green Keeper: ExperienceModifier 1 -> 2.38 (xp, TBC, 12 kills, 0.83 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 2.38 WHERE `entry` = 15636;
-- Amani Axe Thrower: ExperienceModifier 1 -> 2.38 (xp, TBC, 8 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 2.38 WHERE `entry` = 15641;
-- Amani Shadowpriest: ExperienceModifier 1 -> 2.5 (xp, TBC, 6 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 2.5 WHERE `entry` = 15642;
-- Amani Berserker: ExperienceModifier 1 -> 2.5 (xp, TBC, 5 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 2.5 WHERE `entry` = 15643;
-- Wretched Thug: DamageModifier 1 -> 0.95 (melee, WotLK, 115 swings, k 0.931-0.943); ExperienceModifier 1 -> 2.5 (xp, TBC, 7 kills, 1.00 at median)
UPDATE `creature_template` SET `DamageModifier` = 0.95, `ExperienceModifier` = 2.5 WHERE `entry` = 15645;
-- Manawraith: DamageModifier 1 -> 0.95 (melee, WotLK, 37 swings, k 0.918-0.940)
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 15648;
-- Crazed Dragonhawk: DamageModifier 1 -> 0.95 (melee, WotLK, 397 swings, k 0.932-0.942); ExperienceModifier 1 -> 2.38 (xp, TBC, 26 kills, 0.77 at median)
UPDATE `creature_template` SET `DamageModifier` = 0.95, `ExperienceModifier` = 2.38 WHERE `entry` = 15650;
-- Darkwraith: DamageModifier 1 -> 0.95 (melee, WotLK, 57 swings, k 0.936-0.960)
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 15657;
-- Grimscale Oracle: DamageModifier 1 -> 0.95 (melee, WotLK, 643 swings, k 0.933-0.941)
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 15669;
-- Moroes: DamageModifier 17 -> 12.5 (melee, WotLK, 63 swings, k 12.781-12.653)
UPDATE `creature_template` SET `DamageModifier` = 12.5 WHERE `entry` = 15687;
-- Terestian Illhoof: DamageModifier 20 -> 15 (melee, WotLK, 37 swings, k 14.906-14.844)
UPDATE `creature_template` SET `DamageModifier` = 15 WHERE `entry` = 15688;
-- The Curator: DamageModifier 22 -> 16.5 (melee, WotLK, 413 swings, k 16.684-16.668)
UPDATE `creature_template` SET `DamageModifier` = 16.5 WHERE `entry` = 15691;
-- Lesser Silithid Flayer: DamageModifier 7.5 -> 1.2 (melee, Classic, 56 swings, k 1.211-1.200)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 15749;
-- Silithid Flayer: DamageModifier 7.5 -> 1.2 (melee, Classic, 56 swings, k 1.225-1.197)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 15752;
-- Apprentice Loralthalis: DamageModifier 1 -> 0.95 (sheet, TBC, 16 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 15924;
-- Thaelis the Hungerer: DamageModifier 1 -> 0.95 (melee, TBC, 32 swings, k 0.917-0.941)
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 15949;
-- Grimscale Seer: DamageModifier 1 -> 0.95 (melee, WotLK, 596 swings, k 0.927-0.934)
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 15950;
-- Duskwither Apprentice: DamageModifier 1 -> 0.95 (melee, TBC, 93 swings, k 0.962-0.943)
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 15965;
-- Lady Dena Kennedy: DamageModifier 4.6 -> 2 (sheet, TBC, 113 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 15991;
-- Mokvar: DamageModifier 1 -> 1.2 (sheet, TBC, 147 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 16012;
-- Deliana: DamageModifier 1 -> 1.2 (sheet, TBC, 84 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 16013;
-- Mux Manascrambler: DamageModifier 1 -> 1.2 (sheet, TBC, 260 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 16014;
-- Lord Valthalak: DamageModifier 35 -> 13 (melee, WotLK, 37 swings, k 13.080-12.976)
UPDATE `creature_template` SET `DamageModifier` = 13 WHERE `entry` = 16042;
-- Lefty: DamageModifier 7.5 -> 1.75 (melee, WotLK, 38 swings, k 1.731-1.722)
UPDATE `creature_template` SET `DamageModifier` = 1.75 WHERE `entry` = 16049;
-- Rotfang: DamageModifier 7.5 -> 1.75 (melee, WotLK, 74 swings, k 1.764-1.717)
UPDATE `creature_template` SET `DamageModifier` = 1.75 WHERE `entry` = 16050;
-- Spectral Assassin: DamageModifier 1 -> 2 (melee, WotLK, 30 swings, k 2.000-1.986)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 16066;
-- Kwee Q. Peddlefeet: DamageModifier 1 -> 0.42 (sheet, TBC, 47 sheets, exp 0 (AC 0)); ArmorModifier 1 -> 1.5 (armor, TBC, 47 sheets, 1.875 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.5, `DamageModifier` = 0.42 WHERE `entry` = 16075;
-- Gnashjaw: DamageModifier 1 -> 2.5 (melee, WotLK, 48 swings, k 2.613-2.604)
UPDATE `creature_template` SET `DamageModifier` = 2.5 WHERE `entry` = 16095;
-- Wretched Hooligan: DamageModifier 1 -> 0.95 (melee, WotLK, 121 swings, k 0.924-0.936); ExperienceModifier 1 -> 2.5 (xp, TBC, 12 kills, 0.75 at median)
UPDATE `creature_template` SET `DamageModifier` = 0.95, `ExperienceModifier` = 2.5 WHERE `entry` = 16162;
-- Nerubian Overseer: DamageModifier 4.6 -> 4 (melee, WotLK, 54 swings, k 3.873-3.898)
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 16184;
-- Skymaster Sunwing: DamageModifier 4.6 -> 3.5 (sheet, TBC, 264 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 16189;
-- Skymistress Gloaming: DamageModifier 4.6 -> 3.5 (sheet, TBC, 18 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 16192;
-- Silvermoon Guardian: ArmorModifier 1 -> 1.2 (armor, TBC, 1644 sheets, 1.214 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.2 WHERE `entry` = 16221;
-- Silvermoon City Guardian: DamageModifier 1 -> 2 (sheet, TBC, 1628 sheets, exp 1 (AC 2))
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 16222;
-- Guard Didier: DamageModifier 7.5 -> 1 (melee, WotLK, 84 swings, k 0.997-0.989)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 16226;
-- Bragok: DamageModifier 4.6 -> 2 (sheet, TBC, 202 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 16227;
-- Tranquillien Scout: DamageModifier 1 -> 1.2 (melee, WotLK, 106 swings, k 1.196-1.196)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 16242;
-- Luzran: DamageModifier 1.7 -> 2 (melee, WotLK, 55 swings, k 1.988-1.985)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 16245;
-- Knucklerot: DamageModifier 1.7 -> 2 (melee, WotLK, 56 swings, k 1.988-1.985)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 16246;
-- High Executor Mavren: DamageModifier 1 -> 1.2 (sheet, TBC, 166 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 16252;
-- Kanaria: ArmorModifier 1 -> 0.95 (armor, TBC, 116 sheets, 0.884 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.95 WHERE `entry` = 16272;
-- Aldaron the Reckless: DamageModifier 1 -> 0.95 (melee, TBC, 52 swings, k 0.927-0.946)
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 16294;
-- Ranger Lilatha: DamageModifier 1 -> 1.25 (sheet, TBC, 10 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 1.25 WHERE `entry` = 16295;
-- Arcane Devourer: DamageModifier 1 -> 0.95 (melee, WotLK, 56 swings, k 0.938-0.963)
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 16304;
-- Dreadbone Sentinel: ExperienceModifier 1 -> 1.05 (xp, TBC, 46 kills, 0.54 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 1.05 WHERE `entry` = 16305;
-- Deathcage Sorcerer: ExperienceModifier 1 -> 1.05 (xp, TBC, 6 kills, 0.67 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 1.05 WHERE `entry` = 16308;
-- Nerubis Guard: ExperienceModifier 1 -> 0.9 (xp, TBC, 49 kills, 0.55 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.9 WHERE `entry` = 16313;
-- Deatholme Darkmage: ExperienceModifier 1 -> 1.05 (xp, TBC, 8 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 1.05 WHERE `entry` = 16318;
-- Darnassian Druid: ExperienceModifier 1 -> 0.95 (xp, TBC, 13 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.95 WHERE `entry` = 16331;
-- Darnassian Huntress: ExperienceModifier 1 -> 0.95 (xp, TBC, 3 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.95 WHERE `entry` = 16332;
-- Arcane Reaver: ExperienceModifier 1 -> 1.15 (xp, TBC, 9 kills, 0.56 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 1.15 WHERE `entry` = 16339;
-- Shadowpine Ripper: ExperienceModifier 1 -> 0.6 (xp, TBC, 15 kills, 0.80 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.6 WHERE `entry` = 16340;
-- Shadowpine Headhunter: ExperienceModifier 1 -> 0.13 (xp, TBC, 11 kills, 0.55 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.13 WHERE `entry` = 16344;
-- Spindleweb Lurker: ExperienceModifier 1 -> 0.95 (xp, TBC, 12 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.95 WHERE `entry` = 16351;
-- Flameshocker: DamageModifier 7.5 -> 1 (melee, WotLK, 716 swings, k 1.001-0.996)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 16383;
-- Pallid Horror: DamageModifier 7.5 -> 3 (melee, Classic, 38 swings, k 2.996-3.007)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 16394;
-- Zombified Grimscale: ExperienceModifier 1 -> 0.9 (xp, TBC, 18 kills, 0.56 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.9 WHERE `entry` = 16402;
-- Withered Grimscale: ExperienceModifier 1 -> 0.9 (xp, TBC, 22 kills, 0.59 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.9 WHERE `entry` = 16403;
-- Phantom Attendant: DamageModifier 10 -> 8 (melee, TBC, 96 swings, k 7.996-8.009)
UPDATE `creature_template` SET `DamageModifier` = 8 WHERE `entry` = 16406;
-- Phantom Guardsman: DamageModifier 9 -> 12 (melee, TBC, 35 swings, k 11.939-12.017)
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 16425;
-- Skeletal Trooper: DamageModifier 1 -> 0.9 (melee, WotLK, 59 swings, k 0.913-0.935)
UPDATE `creature_template` SET `DamageModifier` = 0.9 WHERE `entry` = 16438;
-- Maiden of Virtue: DamageModifier 25 -> 18.5 (melee, WotLK, 46 swings, k 18.640-18.831)
UPDATE `creature_template` SET `DamageModifier` = 18.5 WHERE `entry` = 16457;
-- Ghostly Philanthropist: DamageModifier 10 -> 16 (melee, TBC, 47 swings, k 16.403-16.017)
UPDATE `creature_template` SET `DamageModifier` = 16 WHERE `entry` = 16470;
-- Proenitus: DamageModifier 1 -> 0.95 (sheet, TBC, 119 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 16477;
-- Keilnei: ArmorModifier 1 -> 0.95 (armor, TBC, 90 sheets, 0.92 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.95 WHERE `entry` = 16499;
-- Aurelon: ArmorModifier 1 -> 0.95 (armor, TBC, 97 sheets, 0.92 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.95 WHERE `entry` = 16501;
-- Kore: DamageModifier 1 -> 0.95 (sheet, TBC, 92 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 16503;
-- Botanist Taerix: DamageModifier 1 -> 0.98 (sheet, TBC, 62 sheets, exp 0 (AC 0)); ArmorModifier 1 -> 1.05 (armor, TBC, 62 sheets, 1.118 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.05, `DamageModifier` = 0.98 WHERE `entry` = 16514;
-- Vindicator Aldar: DamageModifier 1 -> 0.95 (sheet, TBC, 65 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 16535;
-- Tolaan: DamageModifier 1 -> 0.98 (sheet, TBC, 20 sheets, exp 0 (AC 0)); ArmorModifier 1 -> 1.05 (armor, TBC, 20 sheets, 1.118 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.05, `DamageModifier` = 0.98 WHERE `entry` = 16546;
-- Tandrine: DamageModifier 1 -> 2 (sheet, TBC, 39 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 16568;
-- Thrallmar Grunt: DamageModifier 1 -> 2 (melee, WotLK, 256 swings, k 1.989-1.989)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 16580;
-- Champion Bachi: DamageModifier 1 -> 0.57 (sheet, TBC, 84 sheets, exp 0 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 0.57 WHERE `entry` = 16681;
-- Karen Wentworth: DamageModifier 4.6 -> 12 (sheet, TBC, 78 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 16694;
-- Gurak: DamageModifier 4.6 -> 12 (sheet, TBC, 64 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 16695;
-- Krukk: DamageModifier 4.6 -> 12 (sheet, TBC, 78 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 16696;
-- Exodar Peacekeeper: DamageModifier 1 -> 2 (sheet, TBC, 1310 sheets, exp 1 (AC 2))
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 16733;
-- Caedmos: DamageModifier 1 -> 0.57 (sheet, TBC, 22 sheets, exp 0 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 0.57 WHERE `entry` = 16756;
-- Amaan the Wise: DamageModifier 2 -> 1 (sheet, TBC, 89 sheets, exp 1 (AC 1)); ArmorModifier 1 -> 0.1 (armor, TBC, 89 sheets, 0.083 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.1, `DamageModifier` = 1 WHERE `entry` = 16796;
-- Festival Loremaster: DamageModifier 4.6 -> 1 (sheet, TBC, 86 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 16817;
-- Festival Talespinner: DamageModifier 2.5 -> 0.64 (sheet, TBC, 230 sheets, exp 0 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 0.64 WHERE `entry` = 16818;
-- Force Commander Danath Trollbane: DamageModifier 2 -> 10 (sheet, TBC, 56 sheets, exp 1 (AC 1)); ArmorModifier 1 -> 0.1 (armor, TBC, 56 sheets, 0.083 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.1, `DamageModifier` = 10 WHERE `entry` = 16819;
-- Lieutenant Amadi: DamageModifier 1 -> 3 (sheet, TBC, 45 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 16820;
-- Flightmaster Krill Bitterhue: DamageModifier 4.6 -> 2 (sheet, TBC, 143 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 16822;
-- Humphry: DamageModifier 1 -> 3 (sheet, TBC, 62 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 16823;
-- Sid Limbardi: DamageModifier 1 -> 3 (sheet, TBC, 114 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 16826;
-- Honor Guard Wesilow: DamageModifier 1 -> 3 (sheet, TBC, 44 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 16827;
-- Magus Zabraxis: DamageModifier 1 -> 3 (sheet, TBC, 76 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 16829;
-- Field Commander Romus: DamageModifier 4.6 -> 10 (sheet, TBC, 8 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 10 WHERE `entry` = 16830;
-- Anchorite Obadei: DamageModifier 2 -> 1 (sheet, TBC, 116 sheets, exp 1 (AC 1)); ArmorModifier 1 -> 0.1 (armor, TBC, 116 sheets, 0.083 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.1, `DamageModifier` = 1 WHERE `entry` = 16834;
-- Foreman Biggums: DamageModifier 1 -> 3 (sheet, TBC, 62 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 16837;
-- Advisor Sevel: DamageModifier 1 -> 3 (melee, TBC, 120 swings, k 2.989-3.003)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 16840;
-- Watch Commander Relthorn Netherwane: DamageModifier 4.6 -> 10 (sheet, TBC, 11 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 10 WHERE `entry` = 16841;
-- Honor Hold Defender: DamageModifier 1 -> 3 (sheet, TBC, 140 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 16842;
-- Honor Hold Cavalryman: DamageModifier 1 -> 3 (melee, WotLK, 46 swings, k 3.030-3.003)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 16843;
-- Mag'har Grunt: ExperienceModifier 1 -> 0.65 (xp, WotLK, 54 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.65 WHERE `entry` = 16846;
-- Debilitated Mag'har Grunt: ExperienceModifier 1 -> 0.65 (xp, WotLK, 41 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.65 WHERE `entry` = 16847;
-- Gremni Longbeard: DamageModifier 2 -> 1 (sheet, TBC, 19 sheets, exp 1 (AC 1)); ArmorModifier 1 -> 0.1 (armor, TBC, 19 sheets, 0.083 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.1, `DamageModifier` = 1 WHERE `entry` = 16850;
-- Mirren Longbeard: DamageModifier 2 -> 1 (sheet, TBC, 16 sheets, exp 1 (AC 1)); ArmorModifier 1 -> 0.1 (armor, TBC, 16 sheets, 0.083 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.1, `DamageModifier` = 1 WHERE `entry` = 16851;
-- Caretaker Dilandrus: DamageModifier 7.5 -> 3 (sheet, TBC, 40 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 16856;
-- Silanna: ArmorModifier 1 -> 0.95 (armor, TBC, 7 sheets, 0.884 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.95 WHERE `entry` = 16862;
-- Bleeding Hollow Dark Shaman: DamageModifier 1.3 -> 1 (melee, WotLK, 274 swings, k 0.999-0.997)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 16873;
-- Arator the Redeemer: DamageModifier 4.6 -> 3 (sheet, TBC, 139 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 16886;
-- Blistering Oozeling: ExperienceModifier 1 -> 0.05 (xp, WotLK, 121 kills, 0.70 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.05 WHERE `entry` = 16903;
-- Unyielding Footman: DamageModifier 0.5 -> 1 (melee, TBC, 447 swings, k 0.991-0.998)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 16904;
-- Sergeant Kan'ren: ArmorModifier 1 -> 1.05 (armor, TBC, 115 sheets, 0.986 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.05 WHERE `entry` = 16924;
-- Dreghood Geomancer: ExperienceModifier 1 -> 0.65 (xp, WotLK, 5 kills, 0.60 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.65 WHERE `entry` = 16937;
-- Dreghood Brute: ExperienceModifier 1 -> 0.65 (xp, WotLK, 28 kills, 0.50 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.65 WHERE `entry` = 16938;
-- Mo'arg Engineer: ExperienceModifier 1 -> 2 (xp, TBC, 4 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 2 WHERE `entry` = 16945;
-- Gan'arg Servant: DamageModifier 0.83 -> 0.77 (sheet, WotLK, 2 sheets, exp 1 (AC 1)); ArmorModifier 1 -> 0.8 (armor, WotLK, 2 sheets, 1.0 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.8, `DamageModifier` = 0.77 WHERE `entry` = 16947;
-- Netherhound: ExperienceModifier 1 -> 0.4 (xp, WotLK, 25 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.4 WHERE `entry` = 16950;
-- Arch Mage Xintor: DamageModifier 0.5 -> 1 (melee, WotLK, 66 swings, k 0.991-0.995)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 16977;
-- Illidari Taskmaster: ExperienceModifier 1 -> 0.75 (xp, WotLK, 93 kills, 0.91 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.75 WHERE `entry` = 17058;
-- Phantom Hound: DamageModifier 1 -> 4.5 (melee, WotLK, 39 swings, k 4.467-4.516)
UPDATE `creature_template` SET `DamageModifier` = 4.5 WHERE `entry` = 17067;
-- Spirit of the Vale: DamageModifier 1.2 -> 3.33 (sheet, TBC, 10 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 3.33 WHERE `entry` = 17087;
-- Shadowy Summoner: ArmorModifier 1.14 -> 1 (armor, TBC, 15 sheets, 0.818 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1 WHERE `entry` = 17088;
-- Firmanvaar: ArmorModifier 1 -> 0.95 (armor, TBC, 93 sheets, 0.92 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.95 WHERE `entry` = 17089;
-- Windyreed Scavenger: DamageModifier 2 -> 1 (melee, WotLK, 84 swings, k 0.997-1.000)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 17139;
-- Windyreed Wretch: DamageModifier 2 -> 1 (melee, WotLK, 34 swings, k 0.994-1.003)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 17141;
-- Felguard Legionnaire: ExperienceModifier 1 -> 2 (xp, TBC, 3 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 2 WHERE `entry` = 17152;
-- Bristlelimb Windcaller: DamageModifier 1 -> 0.95 (melee, WotLK, 36 swings, k 0.918-0.962)
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 17184;
-- Crazed Wildkin: DamageModifier 1 -> 0.85 (melee, WotLK, 87 swings, k 0.838-0.839)
UPDATE `creature_template` SET `DamageModifier` = 0.85 WHERE `entry` = 17189;
-- Siltfin Oracle: DamageModifier 1 -> 0.95 (melee, TBC, 71 swings, k 0.937-0.959)
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 17191;
-- Anchorite Fateema: ArmorModifier 1 -> 0.95 (armor, TBC, 208 sheets, 0.884 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.95 WHERE `entry` = 17214;
-- Anchorite Truuen: DamageModifier 1 -> 1.2 (sheet, TBC, 8 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 17238;
-- Admiral Odesyus: DamageModifier 2.6 -> 1 (sheet, TBC, 82 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 17240;
-- Hellfire Channeler: DamageModifier 20 -> 17 (melee, TBC, 72 swings, k 17.094-16.763)
UPDATE `creature_template` SET `DamageModifier` = 17 WHERE `entry` = 17256;
-- Fiendish Imp: DamageModifier 1.1 -> 0.75 (melee, WotLK, 51 swings, k 0.745-0.750)
UPDATE `creature_template` SET `DamageModifier` = 0.75 WHERE `entry` = 17267;
-- Venture Co. Gemologist: DamageModifier 1 -> 0.95 (melee, TBC, 39 swings, k 0.919-0.940)
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 17279;
-- Sentinel Luciel Starwhisper: DamageModifier 2.4 -> 2 (sheet, TBC, 43 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 17287;
-- Gnarl: DamageModifier 2.4 -> 1.7 (sheet, TBC, 20 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 1.7 WHERE `entry` = 17310;
-- Irradiated Wildkin: DamageModifier 1 -> 0.7 (melee, WotLK, 89 swings, k 0.676-0.684)
UPDATE `creature_template` SET `DamageModifier` = 0.7 WHERE `entry` = 17324;
-- The Kurken: DamageModifier 1 -> 1.15 (melee, TBC, 35 swings, k 1.172-1.170)
UPDATE `creature_template` SET `DamageModifier` = 1.15 WHERE `entry` = 17447;
-- Gunny: DamageModifier 2 -> 3 (sheet, TBC, 48 sheets, exp 1 (AC 1)); ArmorModifier 1 -> 0.08 (armor, TBC, 48 sheets, 0.084 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.08, `DamageModifier` = 3 WHERE `entry` = 17479;
-- Stillpine Raider: DamageModifier 1 -> 0.23 (melee, WotLK, 71 swings, k 0.228-0.234)
UPDATE `creature_template` SET `DamageModifier` = 0.23 WHERE `entry` = 17495;
-- The Big Bad Wolf: DamageModifier 24 -> 18.5 (melee, WotLK, 35 swings, k 18.398-18.183)
UPDATE `creature_template` SET `DamageModifier` = 18.5 WHERE `entry` = 17521;
-- Tzerak: DamageModifier 1 -> 1.1 (melee, WotLK, 32 swings, k 1.071-1.086)
UPDATE `creature_template` SET `DamageModifier` = 1.1 WHERE `entry` = 17528;
-- Romulo: DamageModifier 14 -> 10.5 (melee, WotLK, 54 swings, k 10.568-10.629)
UPDATE `creature_template` SET `DamageModifier` = 10.5 WHERE `entry` = 17533;
-- Julianne: DamageModifier 12 -> 9 (melee, WotLK, 35 swings, k 8.898-9.067)
UPDATE `creature_template` SET `DamageModifier` = 9 WHERE `entry` = 17534;
-- Void Anomaly: DamageModifier 1 -> 0.75 (melee, TBC, 67 swings, k 0.720-0.745)
UPDATE `creature_template` SET `DamageModifier` = 0.75 WHERE `entry` = 17550;
-- Laando: DamageModifier 4.6 -> 2 (sheet, TBC, 97 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 17554;
-- Stephanos: DamageModifier 4.6 -> 2 (sheet, TBC, 18 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 17555;
-- Sunhawk Saboteur: DamageModifier 1.7 -> 1.95 (melee, WotLK, 123 swings, k 1.966-1.980)
UPDATE `creature_template` SET `DamageModifier` = 1.95 WHERE `entry` = 17609;
-- Prince Malchezaar's Axes: DamageModifier 1 -> 2.11 (melee, WotLK, 42 swings, k 2.099-2.114)
UPDATE `creature_template` SET `DamageModifier` = 2.11 WHERE `entry` = 17650;
-- Logistics Officer Ulrike: DamageModifier 1 -> 1.7 (sheet, TBC, 23 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 1.7 WHERE `entry` = 17657;
-- Knight-Lord Bloodvalor: DamageModifier 0.5 -> 1 (sheet, TBC, 95 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 17717;
-- Watcher Leesa'oh: DamageModifier 2 -> 1 (sheet, TBC, 14 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 17831;
-- Lethyn Moonfire: DamageModifier 2 -> 1 (sheet, TBC, 14 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 17834;
-- Ysiel Windsinger: DamageModifier 0.4 -> 1 (sheet, TBC, 11 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 17841;
-- Thrall: DamageModifier 7 -> 10 (melee, WotLK, 71 swings, k 10.121-10.031)
UPDATE `creature_template` SET `DamageModifier` = 10 WHERE `entry` = 17852;
-- Dire Wolf: DamageModifier 1.9 -> 3.75 (melee, WotLK, 81 swings, k 3.733-3.748)
UPDATE `creature_template` SET `DamageModifier` = 3.75 WHERE `entry` = 17854;
-- Expedition Warden: DamageModifier 1.3 -> 2 (melee, TBC, 53 swings, k 2.038-1.985)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 17855;
-- Fhwoor: DamageModifier 0.3 -> 1 (sheet, TBC, 3 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 17877;
-- Crypt Fiend: DamageModifier 14.27 -> 7 (melee, WotLK, 145 swings, k 6.983-6.997)
UPDATE `creature_template` SET `DamageModifier` = 7 WHERE `entry` = 17897;
-- Abomination: DamageModifier 17 -> 11.5 (melee, WotLK, 151 swings, k 11.646-11.665)
UPDATE `creature_template` SET `DamageModifier` = 11.5 WHERE `entry` = 17898;
-- Ashyen: DamageModifier 1 -> 2.6 (sheet, TBC, 3 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 2.6 WHERE `entry` = 17900;
-- Keleth: DamageModifier 1 -> 3.65 (sheet, TBC, 6 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.65 WHERE `entry` = 17901;
-- Lauranna Thar'well: DamageModifier 2 -> 1 (sheet, TBC, 9 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 17909;
-- Alliance Footman: DamageModifier 2 -> 4.5 (melee, WotLK, 234 swings, k 4.436-4.442)
UPDATE `creature_template` SET `DamageModifier` = 4.5 WHERE `entry` = 17919;
-- Alliance Rifleman: DamageModifier 2 -> 4.5 (melee, WotLK, 110 swings, k 4.431-4.449)
UPDATE `creature_template` SET `DamageModifier` = 4.5 WHERE `entry` = 17921;
-- Horde Grunt: DamageModifier 2 -> 4.5 (melee, WotLK, 713 swings, k 4.437-4.436)
UPDATE `creature_template` SET `DamageModifier` = 4.5 WHERE `entry` = 17932;
-- Tauren Warrior: DamageModifier 3 -> 6 (melee, WotLK, 124 swings, k 6.020-5.992)
UPDATE `creature_template` SET `DamageModifier` = 6 WHERE `entry` = 17933;
-- Horde Headhunter: DamageModifier 2 -> 4.5 (melee, WotLK, 163 swings, k 4.429-4.445)
UPDATE `creature_template` SET `DamageModifier` = 4.5 WHERE `entry` = 17934;
-- Ancient Wisp: DamageModifier 1 -> 4.75 (melee, WotLK, 33 swings, k 4.655-4.694)
UPDATE `creature_template` SET `DamageModifier` = 4.75 WHERE `entry` = 17946;
-- Buddy: DamageModifier 2 -> 1 (melee, WotLK, 56 swings, k 0.996-0.995)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 17953;
-- Kayra Longmane: DamageModifier 2.5 -> 1 (melee, WotLK, 152 swings, k 0.997-1.007)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 17969;
-- Demolitionist Legoso: DamageModifier 1.7 -> 1.5 (sheet, TBC, 22 sheets, exp 0 (AC 0)); ArmorModifier 3 -> 1 (armor, TBC, 22 sheets, 0.852 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1, `DamageModifier` = 1.5 WHERE `entry` = 17982;
-- Vindicator Corin: DamageModifier 1.7 -> 1.5 (sheet, TBC, 22 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 1.5 WHERE `entry` = 17986;
-- Anchorite Ahuurn: DamageModifier 2 -> 5 (sheet, TBC, 20 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 18003;
-- Vindicator Idaar: DamageModifier 2 -> 1 (sheet, TBC, 20 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18004;
-- Ruam: DamageModifier 2 -> 1 (sheet, TBC, 18 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18007;
-- Ikuti: DamageModifier 2 -> 1 (sheet, TBC, 123 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18008;
-- Defender Adrielle: DamageModifier 1 -> 1.5 (sheet, TBC, 65 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 1.5 WHERE `entry` = 18020;
-- Defender Sorli: DamageModifier 1 -> 1.5 (sheet, TBC, 76 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 1.5 WHERE `entry` = 18024;
-- Knight-Defender Zunade: DamageModifier 1 -> 1.5 (sheet, TBC, 298 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 1.5 WHERE `entry` = 18030;
-- Azuremyst Peacekeeper: DamageModifier 1 -> 2 (sheet, TBC, 356 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 18038;
-- Elementalist Untrag: DamageModifier 2 -> 1 (sheet, TBC, 10 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18071;
-- Elementalist Morgh: DamageModifier 2 -> 1 (sheet, TBC, 10 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18074;
-- Kataru: DamageModifier 1 -> 1.2 (melee, WotLK, 38 swings, k 1.213-1.199)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 18080;
-- Dreghood Drudge: ExperienceModifier 1 -> 0.7 (xp, WotLK, 18 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.7 WHERE `entry` = 18122;
-- Wrekt Slave: DamageModifier 1 -> 0.65 (melee, WotLK, 564 swings, k 0.650-0.647); ExperienceModifier 1 -> 0.7 (xp, WotLK, 13 kills, 1.00 at median)
UPDATE `creature_template` SET `DamageModifier` = 0.65, `ExperienceModifier` = 0.7 WHERE `entry` = 18123;
-- Hemet Nesingwary: DamageModifier 1.7 -> 1 (sheet, TBC, 26 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18180;
-- Horde Halaani Guard: DamageModifier 0.3 -> 1 (melee, WotLK, 97 swings, k 0.999-1.000)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18192;
-- Shado 'Fitz' Farstrider: DamageModifier 1.7 -> 1.15 (sheet, TBC, 26 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1.15 WHERE `entry` = 18200;
-- Tamed Sporebat: DamageModifier 1 -> 0.3 (melee, WotLK, 295 swings, k 0.292-0.293)
UPDATE `creature_template` SET `DamageModifier` = 0.3 WHERE `entry` = 18201;
-- Murkblood Raider: ExperienceModifier 1 -> 0.9 (xp, WotLK, 54 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.9 WHERE `entry` = 18203;
-- Murkblood Scavenger: DamageModifier 0.55 -> 0.5 (melee, WotLK, 263 swings, k 0.494-0.502); ExperienceModifier 1 -> 0.25 (xp, WotLK, 94 kills, 1.00 at median)
UPDATE `creature_template` SET `DamageModifier` = 0.5, `ExperienceModifier` = 0.25 WHERE `entry` = 18207;
-- Kurenai Captive: DamageModifier 0.4 -> 1 (melee, WotLK, 72 swings, k 1.000-1.001)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18209;
-- Murkblood Brute: ExperienceModifier 1 -> 0.8 (xp, WotLK, 12 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.8 WHERE `entry` = 18211;
-- Mudfin Frenzy: ExperienceModifier 1 -> 0.25 (xp, WotLK, 16 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.25 WHERE `entry` = 18212;
-- Harold Lane: DamageModifier 1.7 -> 1 (sheet, TBC, 26 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18218;
-- Andarl: DamageModifier 2 -> 1 (sheet, TBC, 133 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18252;
-- Gezhe: DamageModifier 0.3 -> 1 (sheet, TBC, 8 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18265;
-- Warrant Officer Tracy Proudwell: ArmorModifier 1 -> 0.07 (armor, TBC, 53 sheets, 0.072 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.07 WHERE `entry` = 18266;
-- Zerid: DamageModifier 2 -> 1 (sheet, TBC, 8 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18276;
-- Kristen Dipswitch: DamageModifier 0.01 -> 0.75 (melee, WotLK, 128 swings, k 0.748-0.750)
UPDATE `creature_template` SET `DamageModifier` = 0.75 WHERE `entry` = 18294;
-- Prospector Conall: ArmorModifier 1.07 -> 1 (armor, TBC, 22 sheets, 1.011 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1 WHERE `entry` = 18295;
-- Shadrek: DamageModifier 2 -> 1 (sheet, TBC, 8 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18333;
-- Consortium Recruiter: DamageModifier 2 -> 1 (sheet, TBC, 11 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18335;
-- Corki: DamageModifier 0.4 -> 1 (sheet, TBC, 44 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18369;
-- Bertelm: DamageModifier 2 -> 1 (sheet, TBC, 133 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18387;
-- Thander: DamageModifier 2 -> 1 (sheet, TBC, 135 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18389;
-- Ros'eleth: DamageModifier 2 -> 1 (sheet, TBC, 137 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18390;
-- Warden Moi'bff Jill: DamageModifier 4.6 -> 40 (sheet, TBC, 77 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 40 WHERE `entry` = 18408;
-- Huntress Kima: DamageModifier 2 -> 1 (sheet, TBC, 65 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18416;
-- Garokk: DamageModifier 2 -> 12 (sheet, TBC, 1 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 18439;
-- Earthbinder Tavgren: DamageModifier 2 -> 1 (sheet, TBC, 33 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18446;
-- Shienor Talonite: DamageModifier 0.7 -> 1 (melee, WotLK, 271 swings, k 0.997-0.999)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18449;
-- Shienor Sorcerer: DamageModifier 0.7 -> 1 (melee, WotLK, 38 swings, k 0.989-1.005)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18450;
-- Shienor Wing Guard: DamageModifier 1.5 -> 1 (melee, TBC, 73 swings, k 1.014-1.001)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18451;
-- Skithian Dreadhawk: DamageModifier 0.7 -> 1 (melee, WotLK, 295 swings, k 1.000-0.996)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18452;
-- Skithian Windripper: DamageModifier 0.7 -> 1 (melee, WotLK, 296 swings, k 1.000-0.999)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18453;
-- Jenai Starwhisper: DamageModifier 2 -> 1 (sheet, TBC, 140 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18459;
-- Empoor: DamageModifier 2 -> 0.65 (sheet, TBC, 1 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 0.65 WHERE `entry` = 18482;
-- Voren'thal the Seer: DamageModifier 2.4 -> 1 (sheet, TBC, 8 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18530;
-- Sharth Voldoun: ExperienceModifier 1 -> 1.5 (xp, WotLK, 4 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 1.5 WHERE `entry` = 18554;
-- Theloria Shadecloak: DamageModifier 2 -> 1 (sheet, TBC, 18 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18565;
-- Sal'salabim: DamageModifier 1.3 -> 4.5 (melee, WotLK, 33 swings, k 4.467-4.463)
UPDATE `creature_template` SET `DamageModifier` = 4.5 WHERE `entry` = 18584;
-- Raliq the Drunk: DamageModifier 4.6 -> 4 (sheet, TBC, 31 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 18585;
-- Coosh'coosh: DamageModifier 4.6 -> 4 (sheet, TBC, 1 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 18586;
-- Floon: DamageModifier 2 -> 1.65 (sheet, TBC, 40 sheets, exp 0 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1.65 WHERE `entry` = 18588;
-- Arcanist Adyria: DamageModifier 0.3 -> 1 (sheet, TBC, 58 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18596;
-- Sha'nir: DamageModifier 0.3 -> 1 (sheet, TBC, 27 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18597;
-- Seth: DamageModifier 1 -> 0.42 (sheet, TBC, 27 sheets, exp 0 (AC 0)); ArmorModifier 1 -> 1.5 (armor, TBC, 27 sheets, 1.875 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.5, `DamageModifier` = 0.42 WHERE `entry` = 18653;
-- Taela Everstride: DamageModifier 2 -> 1 (sheet, TBC, 138 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18704;
-- Lieutenant Gravelhammer: DamageModifier 2 -> 1 (sheet, TBC, 132 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18713;
-- Private Weeks: DamageModifier 2 -> 1 (sheet, TBC, 29 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18715;
-- Shadowy Initiate: DamageModifier 2.4 -> 1 (sheet, TBC, 3 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18716;
-- Shadowy Laborer: DamageModifier 2.6 -> 1 (sheet, TBC, 2 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18717;
-- Shadowy Hunter: DamageModifier 2 -> 1 (melee, WotLK, 36 swings, k 0.992-0.994)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18718;
-- Shadowy Advisor: DamageModifier 2 -> 1 (sheet, TBC, 1 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18719;
-- Captain Auric Sunchaser: DamageModifier 1.7 -> 1 (sheet, TBC, 131 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18745;
-- Shimmerscale Eel: ExperienceModifier 1 -> 0.65 (xp, WotLK, 86 kills, 0.99 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.65 WHERE `entry` = 18750;
-- Isla Starmane: DamageModifier 2 -> 1 (sheet, TBC, 75 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18760;
-- Lebowski: ArmorModifier 1 -> 0.1 (armor, TBC, 96 sheets, 0.105 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.1 WHERE `entry` = 18775;
-- Kuma: DamageModifier 4.6 -> 2 (sheet, TBC, 86 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 18785;
-- Munci: DamageModifier 4.6 -> 2 (sheet, TBC, 20 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 18788;
-- Furgu: DamageModifier 4.6 -> 2 (sheet, TBC, 62 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 18789;
-- Alchemist Gribble: DamageModifier 1 -> 2 (sheet, TBC, 73 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 18802;
-- Furnan Skysoar: DamageModifier 4.6 -> 2 (sheet, TBC, 36 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 18809;
-- Wrathbringer: DamageModifier 1.75 -> 1 (melee, WotLK, 69 swings, k 0.994-1.000)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18858;
-- Warp Aberration: DamageModifier 2 -> 1 (melee, WotLK, 40 swings, k 0.985-1.003)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18865;
-- Disembodied Vindicator: DamageModifier 0.3 -> 1 (melee, WotLK, 262 swings, k 0.997-0.997)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18872;
-- Disembodied Protector: DamageModifier 0.4 -> 1 (melee, WotLK, 157 swings, k 0.995-0.998)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18873;
-- Sundered Rumbler: DamageModifier 1.75 -> 1 (melee, WotLK, 74 swings, k 0.996-0.997)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18881;
-- Ear-Biter: DamageModifier 1.6 -> 12 (sheet, TBC, 5 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 18895;
-- Caregiver Ophera Windfury: ArmorModifier 1 -> 0.1 (armor, TBC, 89 sheets, 0.1 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.1 WHERE `entry` = 18906;
-- Amish Wildhammer: DamageModifier 2 -> 11 (sheet, TBC, 10 sheets, exp 1 (AC 1)); ArmorModifier 1 -> 0.08 (armor, TBC, 10 sheets, 0.084 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.08, `DamageModifier` = 11 WHERE `entry` = 18931;
-- Nutral: DamageModifier 3 -> 2 (sheet, TBC, 48 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 18940;
-- Undercity Mage: DamageModifier 3 -> 2.75 (melee, WotLK, 34 swings, k 2.752-2.791)
UPDATE `creature_template` SET `DamageModifier` = 2.75 WHERE `entry` = 18971;
-- Z'kral: DamageModifier 1.3 -> 1 (melee, WotLK, 74 swings, k 0.993-0.996)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 18974;
-- Heckling Fel Sprite: ExperienceModifier 1 -> 0.4 (xp, WotLK, 71 kills, 0.92 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.4 WHERE `entry` = 18978;
-- Seer Skaltesh: DamageModifier 1 -> 0.57 (sheet, TBC, 40 sheets, exp 0 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 0.57 WHERE `entry` = 18985;
-- Ironforge Paladin: DamageModifier 3 -> 2.75 (melee, TBC, 50 swings, k 2.790-2.825)
UPDATE `creature_template` SET `DamageModifier` = 2.75 WHERE `entry` = 18986;
-- Gnomeregan Conjuror: ArmorModifier 1 -> 0.09 (armor, TBC, 8 sheets, 0.07 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.09 WHERE `entry` = 19007;
-- Borto: DamageModifier 1 -> 0.57 (sheet, TBC, 25 sheets, exp 0 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 0.57 WHERE `entry` = 19017;
-- Wazat: DamageModifier 2 -> 1 (sheet, TBC, 5 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 19035;
-- Araac: DamageModifier 0.5 -> 1 (sheet, TBC, 34 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 19051;
-- Flamewaker Imp: DamageModifier 0.4 -> 0.35 (melee, WotLK, 54 swings, k 0.341-0.347); ExperienceModifier 1 -> 0.3 (xp, WotLK, 35 kills, 0.91 at median)
UPDATE `creature_template` SET `DamageModifier` = 0.35, `ExperienceModifier` = 0.3 WHERE `entry` = 19136;
-- "Shotgun" Jones: DamageModifier 1.7 -> 1 (sheet, TBC, 76 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 19137;
-- Kurenai Pitfighter: DamageModifier 2 -> 1 (sheet, TBC, 36 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 19141;
-- Telaari Jailor: DamageModifier 2 -> 1 (sheet, TBC, 26 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 19156;
-- Raging Colossus: DamageModifier 1.5 -> 1.65 (melee, TBC, 47 swings, k 1.664-1.669)
UPDATE `creature_template` SET `DamageModifier` = 1.65 WHERE `entry` = 19188;
-- Fel Handler: DamageModifier 3 -> 0.8 (melee, TBC, 134 swings, k 0.798-0.794); ExperienceModifier 1 -> 0.8 (xp, WotLK, 27 kills, 1.00 at median)
UPDATE `creature_template` SET `DamageModifier` = 0.8, `ExperienceModifier` = 0.8 WHERE `entry` = 19190;
-- Mountain Gronn: DamageModifier 4.6 -> 4 (melee, WotLK, 69 swings, k 4.004-3.992)
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 19201;
-- Sergeant Shatterskull: DamageModifier 4 -> 1 (melee, WotLK, 63 swings, k 1.000-1.002)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 19256;
-- Arcanist Torseldori: DamageModifier 2 -> 1 (melee, WotLK, 37 swings, k 0.984-1.007)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 19257;
-- Bloodmage: DamageModifier 1.5 -> 1 (melee, WotLK, 220 swings, k 0.997-1.000)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 19258;
-- Tola'thion: DamageModifier 2.4 -> 1 (sheet, TBC, 17 sheets, exp 1 (AC 1)); ArmorModifier 1 -> 0.12 (armor, TBC, 17 sheets, 0.096 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.12, `DamageModifier` = 1 WHERE `entry` = 19293;
-- Earthbinder Galandria Nightbreeze: DamageModifier 0.4 -> 2 (sheet, TBC, 8 sheets, exp 1 (AC 1)); ArmorModifier 1 -> 0.11 (armor, TBC, 8 sheets, 0.087 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.11, `DamageModifier` = 2 WHERE `entry` = 19294;
-- Innkeeper Biribi: DamageModifier 1 -> 3 (sheet, TBC, 143 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 19296;
-- Forward Commander Kingston: DamageModifier 2.4 -> 1 (sheet, TBC, 14 sheets, exp 1 (AC 1)); ArmorModifier 1 -> 0.08 (armor, TBC, 14 sheets, 0.084 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.08, `DamageModifier` = 1 WHERE `entry` = 19310;
-- Supply Officer Shandria: ArmorModifier 1 -> 0.12 (armor, TBC, 14 sheets, 0.096 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.12 WHERE `entry` = 19314;
-- Legassi: DamageModifier 2 -> 1 (sheet, TBC, 18 sheets, exp 1 (AC 1)); ArmorModifier 1 -> 0.09 (armor, TBC, 18 sheets, 0.095 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.09, `DamageModifier` = 1 WHERE `entry` = 19344;
-- "Screaming" Screed Luckheed: DamageModifier 2.4 -> 1 (sheet, TBC, 19 sheets, exp 1 (AC 1)); ArmorModifier 1 -> 0.1 (armor, TBC, 19 sheets, 0.1 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.1, `DamageModifier` = 1 WHERE `entry` = 19367;
-- Felguard Lieutenant: DamageModifier 7.5 -> 2 (melee, WotLK, 189 swings, k 1.998-1.997)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 19391;
-- Azuremyst Vindicator: DamageModifier 0.3 -> 0.9 (melee, TBC, 48 swings, k 0.921-0.902)
UPDATE `creature_template` SET `DamageModifier` = 0.9 WHERE `entry` = 19407;
-- Wing Commander Dabir'ee: DamageModifier 2.4 -> 1 (sheet, TBC, 14 sheets, exp 1 (AC 1)); ArmorModifier 1 -> 0.08 (armor, TBC, 14 sheets, 0.084 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.08, `DamageModifier` = 1 WHERE `entry` = 19409;
-- Ramdor the Mad: DamageModifier 2 -> 1 (sheet, TBC, 49 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 19417;
-- Raging Shardling: DamageModifier 1.5 -> 1 (melee, WotLK, 208 swings, k 0.996-0.999)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 19419;
-- Goliathon Shardling: DamageModifier 2.2 -> 0.5 (melee, WotLK, 132 swings, k 0.494-0.500)
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 19420;
-- Peasant Worker: DamageModifier 1 -> 3 (melee, WotLK, 65 swings, k 3.048-3.083)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 19444;
-- Grillok "Darkeye": ExperienceModifier 1 -> 1.5 (xp, WotLK, 4 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 1.5 WHERE `entry` = 19457;
-- Tamed Ravager: DamageModifier 1 -> 0.5 (melee, WotLK, 198 swings, k 0.498-0.500)
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 19461;
-- Darkened Spirit: DamageModifier 6.34 -> 4.5 (melee, WotLK, 44 swings, k 4.395-4.467)
UPDATE `creature_template` SET `DamageModifier` = 4.5 WHERE `entry` = 19480;
-- Ekkorash the Inquisitor: DamageModifier 1.4 -> 1 (melee, WotLK, 32 swings, k 0.988-0.991)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 19493;
-- Lower City Operative: DamageModifier 0.3 -> 2 (melee, WotLK, 678 swings, k 1.999-1.998)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 19501;
-- Scryer Guardian: DamageModifier 1.7 -> 1 (melee, WotLK, 60 swings, k 0.996-0.999)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 19504;
-- Netherstorm Agent: DamageModifier 1.6 -> 2 (melee, TBC, 99 swings, k 1.996-1.986)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 19541;
-- Abjurist Belmara: DamageModifier 2 -> 1 (melee, WotLK, 31 swings, k 0.987-0.995)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 19546;
-- Ember of Al'ar: DamageModifier 10 -> 7.5 (melee, WotLK, 169 swings, k 7.487-7.511)
UPDATE `creature_template` SET `DamageModifier` = 7.5 WHERE `entry` = 19551;
-- Nethergarde Advisor: DamageModifier 0.6 -> 0.8 (melee, WotLK, 171 swings, k 0.777-0.787)
UPDATE `creature_template` SET `DamageModifier` = 0.8 WHERE `entry` = 19566;
-- Watcher Theronus: DamageModifier 0.6 -> 0.57 (sheet, TBC, 8 sheets, exp 0 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 0.57 WHERE `entry` = 19567;
-- Netherologist Coppernickels: DamageModifier 0.6 -> 1 (sheet, TBC, 1 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 19569;
-- Warp-Raider Nesaad: ExperienceModifier 1 -> 1.2 (xp, WotLK, 8 kills, 0.75 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 1.2 WHERE `entry` = 19641;
-- Shadowfiend: ArmorModifier 1 -> 1.15 (armor, TBC, 1 sheets, 0.934 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.15 WHERE `entry` = 19668;
-- Mamdy the "Ologist": DamageModifier 2 -> 1 (sheet, TBC, 19 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 19669;
-- "Captain" Kaftiz: DamageModifier 2 -> 3.33 (sheet, TBC, 19 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 3.33 WHERE `entry` = 19676;
-- "Slim": DamageModifier 1 -> 3 (sheet, TBC, 19 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 19679;
-- Nether Anomaly: DamageModifier 1.8 -> 0.25 (melee, WotLK, 5354 swings, k 0.247-0.249)
UPDATE `creature_template` SET `DamageModifier` = 0.25 WHERE `entry` = 19686;
-- Clarissa: DamageModifier 0.5 -> 1 (sheet, TBC, 34 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 19693;
-- "Dirty" Larry: DamageModifier 1.4 -> 4.5 (sheet, TBC, 1 sheets, exp 1 (AC 1)); ArmorModifier 1 -> 0.08 (armor, TBC, 1 sheets, 0.081 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.08, `DamageModifier` = 4.5 WHERE `entry` = 19720;
-- "Epic" Malone: DamageModifier 0.4 -> 1 (melee, WotLK, 32 swings, k 0.997-1.006)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 19725;
-- "Creepjack": DamageModifier 0.4 -> 1 (melee, WotLK, 30 swings, k 1.006-1.006)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 19726;
-- Nether Beast: DamageModifier 1.75 -> 1 (melee, WotLK, 760 swings, k 0.998-1.000)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 19731;
-- Daggerfen Servant: ExperienceModifier 1 -> 0.4 (xp, WotLK, 33 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.4 WHERE `entry` = 19733;
-- Wrathwalker: DamageModifier 1 -> 1.25 (sheet, WotLK, 4 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1.25 WHERE `entry` = 19740;
-- Artifact Seeker: DamageModifier 0.4 -> 1 (melee, WotLK, 50 swings, k 0.995-1.001)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 19852;
-- Sir Maximus Adams: DamageModifier 10 -> 6.75 (sheet, TBC, 297 sheets, exp 0 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 6.75 WHERE `entry` = 19855;
-- Max Luna: DamageModifier 1.2 -> 12 (sheet, TBC, 335 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 19859;
-- Lord Robin Daris: DamageModifier 9 -> 6.75 (melee, WotLK, 39 swings, k 6.742-6.764)
UPDATE `creature_template` SET `DamageModifier` = 6.75 WHERE `entry` = 19876;
-- Severed Spirit: DamageModifier 1.3 -> 1 (melee, WotLK, 152 swings, k 0.993-0.999)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 19881;
-- Andormu: DamageModifier 4.6 -> 1 (sheet, TBC, 4 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 19932;
-- Agent Proudwell: DamageModifier 1 -> 3 (sheet, TBC, 8 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 19942;
-- Bloodmaul Lookout: DamageModifier 1.4 -> 1 (melee, WotLK, 46 swings, k 0.989-0.985)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 19956;
-- Bladespire Battlemage: ExperienceModifier 1 -> 0.06 (xp, WotLK, 5 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.06 WHERE `entry` = 19996;
-- Bladespire Enforcer: ExperienceModifier 1 -> 0.06 (xp, WotLK, 10 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.06 WHERE `entry` = 19997;
-- Bloodwarder Legionnaire: DamageModifier 28 -> 21 (melee, WotLK, 97 swings, k 21.064-21.005)
UPDATE `creature_template` SET `DamageModifier` = 21 WHERE `entry` = 20031;
-- Bloodwarder Vindicator: DamageModifier 32 -> 24 (melee, WotLK, 79 swings, k 23.898-24.012)
UPDATE `creature_template` SET `DamageModifier` = 24 WHERE `entry` = 20032;
-- Astromancer: DamageModifier 14 -> 10.5 (melee, WotLK, 53 swings, k 10.485-10.514)
UPDATE `creature_template` SET `DamageModifier` = 10.5 WHERE `entry` = 20033;
-- Star Scryer: DamageModifier 16 -> 12 (melee, WotLK, 30 swings, k 12.076-12.068)
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 20034;
-- Bloodwarder Squire: DamageModifier 24 -> 18 (melee, WotLK, 47 swings, k 17.865-17.928)
UPDATE `creature_template` SET `DamageModifier` = 18 WHERE `entry` = 20036;
-- Phoenix-Hawk Hatchling: DamageModifier 14 -> 10.5 (melee, WotLK, 115 swings, k 10.542-10.497)
UPDATE `creature_template` SET `DamageModifier` = 10.5 WHERE `entry` = 20038;
-- Crystalcore Sentinel: DamageModifier 28 -> 21 (melee, WotLK, 38 swings, k 20.980-21.086)
UPDATE `creature_template` SET `DamageModifier` = 21 WHERE `entry` = 20041;
-- Apprentice Star Scryer: DamageModifier 10 -> 3 (melee, WotLK, 59 swings, k 2.983-3.002)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 20043;
-- Novice Astromancer: DamageModifier 10 -> 3.75 (melee, WotLK, 70 swings, k 3.738-3.752)
UPDATE `creature_template` SET `DamageModifier` = 3.75 WHERE `entry` = 20044;
-- Crimson Hand Centurion: DamageModifier 15 -> 19.5 (melee, WotLK, 41 swings, k 19.640-19.584)
UPDATE `creature_template` SET `DamageModifier` = 19.5 WHERE `entry` = 20048;
-- Crimson Hand Blood Knight: DamageModifier 16 -> 21 (melee, WotLK, 33 swings, k 20.979-21.039)
UPDATE `creature_template` SET `DamageModifier` = 21 WHERE `entry` = 20049;
-- Darkcrest Sentry: ExperienceModifier 1 -> 0.25 (xp, WotLK, 12 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.25 WHERE `entry` = 20079;
-- Bloodscale Sentry: ExperienceModifier 1 -> 0.25 (xp, WotLK, 4 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.25 WHERE `entry` = 20090;
-- Nether-Stalker: DamageModifier 2 -> 1 (melee, TBC, 59 swings, k 1.003-1.002)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 20101;
-- Jihi: DamageModifier 4.6 -> 21.5 (sheet, TBC, 15 sheets, exp 1 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 21.5 WHERE `entry` = 20118;
-- Mahul: DamageModifier 4.6 -> 21.5 (sheet, TBC, 17 sheets, exp 1 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 21.5 WHERE `entry` = 20119;
-- Tolo: DamageModifier 1.6 -> 12 (sheet, TBC, 6 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 20120;
-- Zula Slagfury: DamageModifier 1 -> 0.5 (sheet, TBC, 28 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 20125;
-- Vengeful Unyielding Footman: DamageModifier 2 -> 1 (melee, WotLK, 192 swings, k 0.990-0.999)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 20137;
-- Culuthas: ExperienceModifier 1 -> 1.5 (xp, WotLK, 4 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 1.5 WHERE `entry` = 20138;
-- Bogflare Needler: DamageModifier 0.4 -> 1 (melee, WotLK, 101 swings, k 0.994-1.000)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 20197;
-- Ambassador's Honor Guard: DamageModifier 1.2 -> 0.5 (melee, WotLK, 32 swings, k 0.503-0.496)
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 20199;
-- Apprentice Tedon: DamageModifier 1 -> 0.98 (sheet, TBC, 64 sheets, exp 0 (AC 0)); ArmorModifier 1 -> 1.05 (armor, TBC, 64 sheets, 1.118 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.05, `DamageModifier` = 0.98 WHERE `entry` = 20227;
-- Supply Officer Pestle: ArmorModifier 1 -> 0.12 (armor, TBC, 11 sheets, 0.096 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.12 WHERE `entry` = 20231;
-- Wing Commander Gryphongar: DamageModifier 1 -> 3 (sheet, TBC, 11 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 20232;
-- Apprentice Vishael: DamageModifier 1 -> 0.98 (sheet, TBC, 64 sheets, exp 0 (AC 0)); ArmorModifier 1 -> 1.05 (armor, TBC, 64 sheets, 1.118 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.05, `DamageModifier` = 0.98 WHERE `entry` = 20233;
-- Runetog Wildhammer: DamageModifier 2 -> 11 (sheet, TBC, 12 sheets, exp 1 (AC 1)); ArmorModifier 1 -> 0.08 (armor, TBC, 12 sheets, 0.084 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.08, `DamageModifier` = 11 WHERE `entry` = 20234;
-- Gryphoneer Windbellow: DamageModifier 7.5 -> 11 (sheet, TBC, 12 sheets, exp 0 (AC 0)); ArmorModifier 1 -> 0.11 (armor, TBC, 12 sheets, 0.113 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.11, `DamageModifier` = 11 WHERE `entry` = 20235;
-- Gryphoneer Leafbeard: DamageModifier 7.5 -> 11 (sheet, TBC, 22 sheets, exp 0 (AC 0)); ArmorModifier 1 -> 0.11 (armor, TBC, 22 sheets, 0.113 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.11, `DamageModifier` = 11 WHERE `entry` = 20236;
-- Haelga Slatefist: DamageModifier 4.6 -> 12 (sheet, TBC, 74 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 20271;
-- Lylandor: DamageModifier 4.6 -> 12 (sheet, TBC, 75 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 20272;
-- Adam Eternum: DamageModifier 4.6 -> 12 (sheet, TBC, 72 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 20273;
-- Drijya: DamageModifier 0.5 -> 0.75 (melee, TBC, 41 swings, k 0.750-0.753)
UPDATE `creature_template` SET `DamageModifier` = 0.75 WHERE `entry` = 20281;
-- Dr. Boom: ExperienceModifier 1 -> 0.25 (xp, WotLK, 3 kills, 0.67 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.25 WHERE `entry` = 20284;
-- Zaxxis Ambusher: DamageModifier 1.4 -> 1 (melee, WotLK, 338 swings, k 0.997-0.998)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 20287;
-- Bogstrok Clacker: ExperienceModifier 1 -> 0.9 (xp, WotLK, 3 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.9 WHERE `entry` = 20293;
-- Oric Coe: DamageModifier 4.6 -> 12 (sheet, TBC, 72 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 20339;
-- Iravar: DamageModifier 1.2 -> 12 (sheet, TBC, 73 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 20362;
-- Kandaar: DamageModifier 1.2 -> 12 (sheet, TBC, 61 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 20374;
-- Jovil: DamageModifier 1.2 -> 12 (sheet, TBC, 6 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 20381;
-- Mitia: DamageModifier 1.2 -> 12 (sheet, TBC, 16 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 20382;
-- Enlae: DamageModifier 1.2 -> 12 (sheet, TBC, 59 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 20383;
-- Andrissa Heartspear: DamageModifier 1.2 -> 12 (sheet, TBC, 31 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 20385;
-- Lyrlia Blackshield: DamageModifier 1.2 -> 12 (sheet, TBC, 8 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 20386;
-- Althallen Brightblade: DamageModifier 1.2 -> 12 (sheet, TBC, 25 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 20388;
-- Duyash the Cruel: DamageModifier 0.8 -> 12 (sheet, TBC, 71 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 20390;
-- Eye of Culuthas: DamageModifier 1.8 -> 1 (melee, TBC, 33 swings, k 0.992-1.006)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 20394;
-- Legion Shocktrooper: DamageModifier 2 -> 1.25 (melee, TBC, 32 swings, k 1.255-1.251)
UPDATE `creature_template` SET `DamageModifier` = 1.25 WHERE `entry` = 20402;
-- Rhonsus: DamageModifier 1.8 -> 1.1 (melee, WotLK, 42 swings, k 1.090-1.095)
UPDATE `creature_template` SET `DamageModifier` = 1.1 WHERE `entry` = 20410;
-- Bessy: DamageModifier 2 -> 1 (melee, WotLK, 150 swings, k 0.999-1.001)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 20415;
-- Veneratus the Many: DamageModifier 2.9 -> 2 (melee, TBC, 39 swings, k 1.983-2.012)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 20427;
-- Ara Technician: DamageModifier 0.5 -> 0.7 (melee, TBC, 36 swings, k 0.696-0.688)
UPDATE `creature_template` SET `DamageModifier` = 0.7 WHERE `entry` = 20438;
-- Area 52 Big Bruiser: DamageModifier 1.7 -> 3 (melee, TBC, 152 swings, k 2.998-3.003)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 20484;
-- Area 52 Bruiser: DamageModifier 1.6 -> 2 (melee, TBC, 133 swings, k 1.994-1.999)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 20485;
-- Sundered Shard: DamageModifier 0.6 -> 0.4 (melee, WotLK, 38 swings, k 0.395-0.400)
UPDATE `creature_template` SET `DamageModifier` = 0.4 WHERE `entry` = 20498;
-- Fizim Blastwrench: ArmorModifier 1 -> 0.07 (armor, TBC, 14 sheets, 0.072 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.07 WHERE `entry` = 20499;
-- Tormented Soul: DamageModifier 2 -> 1 (melee, WotLK, 365 swings, k 1.000-0.997)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 20512;
-- Withered Corpse: DamageModifier 0.3 -> 1 (melee, WotLK, 51 swings, k 0.998-0.991)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 20561;
-- Shade of Mal'druk: DamageModifier 2.2 -> 1 (melee, WotLK, 40 swings, k 0.990-1.002)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 20669;
-- Bladespire Ravager: ExperienceModifier 1 -> 0.06 (xp, WotLK, 5 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.06 WHERE `entry` = 20729;
-- Silkwing Larva: DamageModifier 0.8 -> 0.85 (melee, WotLK, 253 swings, k 0.847-0.845)
UPDATE `creature_template` SET `DamageModifier` = 0.85 WHERE `entry` = 20747;
-- Captured Protectorate Vanguard: DamageModifier 1 -> 0.5 (melee, WotLK, 45 swings, k 0.503-0.499)
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 20763;
-- Warden Icoshock: DamageModifier 0.3 -> 1 (melee, TBC, 33 swings, k 1.010-0.997)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 20770;
-- Seeping Sludge Globule: DamageModifier 0.5 -> 0.1 (melee, TBC, 284 swings, k 0.099-0.100)
UPDATE `creature_template` SET `DamageModifier` = 0.1 WHERE `entry` = 20806;
-- Corki: DamageModifier 0.01 -> 1 (sheet, TBC, 1 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 20812;
-- Deathforge Summoner: ExperienceModifier 1 -> 0.9 (xp, WotLK, 13 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.9 WHERE `entry` = 20872;
-- Deathforge Imp: ExperienceModifier 1 -> 0.25 (xp, WotLK, 10 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.25 WHERE `entry` = 20887;
-- Ironspine Forgelord: DamageModifier 0.5 -> 1 (sheet, TBC, 1 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 20928;
-- Severed Defender: DamageModifier 2 -> 1 (melee, WotLK, 502 swings, k 0.996-1.000)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 20934;
-- Lieutenant Meridian: DamageModifier 2 -> 1 (sheet, TBC, 18 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 21006;
-- Outraged Raven's Wood Sapling: DamageModifier 1.8 -> 0.4 (melee, WotLK, 936 swings, k 0.399-0.397)
UPDATE `creature_template` SET `DamageModifier` = 0.4 WHERE `entry` = 21040;
-- Disembodied Exarch: DamageModifier 0.6 -> 1 (melee, WotLK, 33 swings, k 0.990-1.001)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 21058;
-- Tormented Citizen: DamageModifier 2 -> 1.05 (melee, TBC, 43 swings, k 1.069-1.080)
UPDATE `creature_template` SET `DamageModifier` = 1.05 WHERE `entry` = 21065;
-- Dancing Sword: DamageModifier 1 -> 0.5 (melee, WotLK, 43 swings, k 0.500-0.491)
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 21093;
-- Station Guard: DamageModifier 1.8 -> 2 (melee, WotLK, 385 swings, k 2.097-2.100)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 21115;
-- Felsworn Daggermaw: DamageModifier 1.35 -> 1 (melee, WotLK, 149 swings, k 0.994-1.001)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 21124;
-- Corporal Ironridge: DamageModifier 2 -> 1 (sheet, TBC, 8 sheets, exp 1 (AC 1)); ArmorModifier 1 -> 0.08 (armor, TBC, 8 sheets, 0.084 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.08, `DamageModifier` = 1 WHERE `entry` = 21133;
-- Domesticated Felboar: DamageModifier 0.6 -> 1 (melee, WotLK, 104 swings, k 1.001-0.989)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 21195;
-- Ravenous Flayer: DamageModifier 0.3 -> 1 (melee, WotLK, 904 swings, k 1.001-0.997)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 21196;
-- Dumphry: DamageModifier 1 -> 3 (sheet, TBC, 49 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 21209;
-- Legion Fel Cannon: ExperienceModifier 1 -> 0.4 (xp, TBC, 3 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.4 WHERE `entry` = 21233;
-- Dullgrom Dredger: DamageModifier 2 -> 1 (melee, WotLK, 108 swings, k 0.999-0.999)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 21254;
-- Fel Corrupter: ExperienceModifier 1 -> 0.75 (xp, WotLK, 6 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.75 WHERE `entry` = 21300;
-- Cursed Scarab: DamageModifier 1 -> 0.3 (melee, WotLK, 1433 swings, k 0.291-0.296)
UPDATE `creature_template` SET `DamageModifier` = 0.3 WHERE `entry` = 21306;
-- Netherock Crumbler: DamageModifier 1.4 -> 1 (melee, WotLK, 155 swings, k 0.994-0.995)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 21323;
-- Spirit Raven: DamageModifier 1.75 -> 1 (melee, WotLK, 39 swings, k 1.006-1.005)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 21324;
-- Thorny Growth: DamageModifier 0.4 -> 0.2 (melee, WotLK, 34 swings, k 0.196-0.198)
UPDATE `creature_template` SET `DamageModifier` = 0.2 WHERE `entry` = 21331;
-- Silkwing: DamageModifier 2 -> 0.5 (melee, WotLK, 60 swings, k 0.495-0.501)
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 21373;
-- Wyrmcult Blackwhelp: ExperienceModifier 1 -> 0.9 (xp, WotLK, 6 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.9 WHERE `entry` = 21387;
-- Station Sharpshooter: DamageModifier 1.8 -> 2 (melee, WotLK, 42 swings, k 2.079-2.084)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 21441;
-- Cursed Spirit: DamageModifier 0.3 -> 1.5 (melee, TBC, 31 swings, k 1.519-1.508)
UPDATE `creature_template` SET `DamageModifier` = 1.5 WHERE `entry` = 21449;
-- Rocknail Flayer: DamageModifier 0.27 -> 1 (melee, WotLK, 43 swings, k 1.012-0.970)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 21477;
-- Rocknail Ripper: DamageModifier 0.75 -> 1 (melee, WotLK, 211 swings, k 0.998-0.998)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 21478;
-- Death's Might: DamageModifier 2 -> 1 (melee, WotLK, 31 swings, k 0.997-1.002)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 21519;
-- Vengeful Draenei: DamageModifier 1.4 -> 1 (melee, WotLK, 77 swings, k 0.997-1.001)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 21636;
-- Corrupted Earth Elemental: DamageModifier 0.86 -> 0.6 (melee, TBC, 31 swings, k 0.603-0.597)
UPDATE `creature_template` SET `DamageModifier` = 0.6 WHERE `entry` = 21708;
-- Enslaved Netherwing Drake: DamageModifier 0.3 -> 0.6 (melee, WotLK, 109 swings, k 0.602-0.600)
UPDATE `creature_template` SET `DamageModifier` = 0.6 WHERE `entry` = 21722;
-- Wildhammer Defender: DamageModifier 2 -> 0.45 (melee, WotLK, 26047 swings, k 0.449-0.448)
UPDATE `creature_template` SET `DamageModifier` = 0.45 WHERE `entry` = 21736;
-- Shadowmoon Zealot: DamageModifier 1.75 -> 1 (melee, WotLK, 79 swings, k 0.992-1.000)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 21788;
-- Illidari Overseer: ArmorModifier 1 -> 0.5 (armor, WotLK, 2 sheets, 0.5 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.5 WHERE `entry` = 21808;
-- Sha'tar Vindicator: DamageModifier 4 -> 2 (melee, WotLK, 1989 swings, k 1.997-2.000)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 21858;
-- Felboar: DamageModifier 1.75 -> 1 (melee, WotLK, 54 swings, k 0.991-1.002)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 21878;
-- Tidewalker Lurker: DamageModifier 6 -> 4.5 (melee, WotLK, 44 swings, k 4.553-4.482)
UPDATE `creature_template` SET `DamageModifier` = 4.5 WHERE `entry` = 21920;
-- Shadowlord Deathwail: DamageModifier 2 -> 6 (melee, WotLK, 104 swings, k 5.985-5.997)
UPDATE `creature_template` SET `DamageModifier` = 6 WHERE `entry` = 22006;
-- Vengeful Husk: DamageModifier 0.3 -> 1 (melee, TBC, 92 swings, k 1.005-1.000)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 22045;
-- Decrepit Clefthoof: DamageModifier 1.3 -> 1 (melee, TBC, 44 swings, k 1.012-1.004)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 22105;
-- Fear Fiend: DamageModifier 1.2 -> 1 (sheet, WotLK, 4 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 22204;
-- Hellfire Wardling: DamageModifier 2.3 -> 0.6 (melee, TBC, 138 swings, k 0.593-0.599)
UPDATE `creature_template` SET `DamageModifier` = 0.6 WHERE `entry` = 22259;
-- High Priest Orglum: DamageModifier 1 -> 3 (sheet, TBC, 125 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 22278;
-- Furnace Guard: ArmorModifier 0.96 -> 1 (armor, WotLK, 12 sheets, 1.0 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1 WHERE `entry` = 22291;
-- Rotting Forest-Rager: DamageModifier 2 -> 1 (melee, WotLK, 31 swings, k 0.995-0.999)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 22307;
-- Malevolent Hatchling: DamageModifier 2 -> 1 (melee, WotLK, 56 swings, k 1.005-1.003)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 22337;
-- Scout Navrin: DamageModifier 2.6 -> 1 (sheet, TBC, 137 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 22364;
-- Hand of Kargath: DamageModifier 1.5 -> 2.75 (melee, WotLK, 49 swings, k 2.782-2.783)
UPDATE `creature_template` SET `DamageModifier` = 2.75 WHERE `entry` = 22374;
-- Minion of Terokk: DamageModifier 2 -> 1.5 (melee, WotLK, 54 swings, k 1.490-1.496); ExperienceModifier 1 -> 0.05 (xp, WotLK, 14 kills, 1.00 at median)
UPDATE `creature_template` SET `DamageModifier` = 1.5, `ExperienceModifier` = 0.05 WHERE `entry` = 22376;
-- Caravan Defender: DamageModifier 0.4 -> 3 (melee, TBC, 75 swings, k 2.987-3.008)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 22407;
-- Lakotae: DamageModifier 0.4 -> 1 (sheet, TBC, 123 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 22420;
-- Skywing: DamageModifier 2 -> 1 (melee, WotLK, 188 swings, k 0.994-0.999)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 22424;
-- Vekax: DamageModifier 0.4 -> 1 (sheet, TBC, 39 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 22429;
-- Lonika Stillblade: DamageModifier 0.3 -> 1 (sheet, TBC, 32 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 22442;
-- Chief Archaeologist Letoll: DamageModifier 2 -> 1 (melee, TBC, 41 swings, k 1.003-1.000)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 22458;
-- Explorers' League Researcher: DamageModifier 0.6 -> 1 (melee, WotLK, 100 swings, k 0.997-1.000)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 22464;
-- Anchorite Ensham: DamageModifier 1 -> 3 (sheet, TBC, 125 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 22477;
-- Halu: DamageModifier 4.6 -> 2 (sheet, TBC, 124 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 22485;
-- Foul Purge: DamageModifier 1 -> 0.3 (melee, WotLK, 186 swings, k 0.295-0.296)
UPDATE `creature_template` SET `DamageModifier` = 0.3 WHERE `entry` = 22506;
-- Morthis Whisperwing: DamageModifier 1.7 -> 1 (sheet, TBC, 2 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 22832;
-- Cenarion Dreamwarden: DamageModifier 1.4 -> 1.15 (melee, TBC, 323 swings, k 1.147-1.149)
UPDATE `creature_template` SET `DamageModifier` = 1.15 WHERE `entry` = 22835;
-- Ashtongue Feral Spirit: DamageModifier 26 -> 19.5 (melee, WotLK, 42 swings, k 19.598-19.629)
UPDATE `creature_template` SET `DamageModifier` = 19.5 WHERE `entry` = 22849;
-- Illidari Succubus: DamageModifier 1.1 -> 1 (melee, WotLK, 328 swings, k 0.999-1.000)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 22860;
-- Supremus: DamageModifier 70 -> 52 (melee, WotLK, 35 swings, k 51.697-52.643)
UPDATE `creature_template` SET `DamageModifier` = 52 WHERE `entry` = 22898;
-- Phantasmal Lash: DamageModifier 0.5 -> 0.75 (melee, TBC, 330 swings, k 0.746-0.747)
UPDATE `creature_template` SET `DamageModifier` = 0.75 WHERE `entry` = 22902;
-- Gorrim: DamageModifier 4.6 -> 3.5 (sheet, TBC, 17 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 22931;
-- Suralais Farwind: DamageModifier 4.6 -> 3.5 (sheet, TBC, 42 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 22935;
-- Temple Concubine: DamageModifier 20 -> 2.75 (melee, WotLK, 167 swings, k 2.781-2.786)
UPDATE `creature_template` SET `DamageModifier` = 2.75 WHERE `entry` = 22939;
-- Grok: DamageModifier 1.5 -> 1 (sheet, TBC, 3 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 22940;
-- Charming Courtesan: DamageModifier 4 -> 3 (melee, WotLK, 156 swings, k 3.009-2.999)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 22955;
-- Talonsworn Forest-Rager: DamageModifier 1.2 -> 3 (melee, WotLK, 35 swings, k 2.967-3.022)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 23029;
-- Little Noah: ArmorModifier 1 -> 0.35 (armor, TBC, 81 sheets, 0.378 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.35 WHERE `entry` = 23050;
-- Talonpriest Ishaal: DamageModifier 3.75 -> 1.05 (melee, WotLK, 35 swings, k 1.069-1.079)
UPDATE `creature_template` SET `DamageModifier` = 1.05 WHERE `entry` = 23066;
-- Gan'arg Underling: DamageModifier 1 -> 2 (melee, WotLK, 520 swings, k 1.998-2.003)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 23199;
-- Illidari Elite: DamageModifier 5 -> 3.75 (melee, WotLK, 740 swings, k 3.749-3.749)
UPDATE `creature_template` SET `DamageModifier` = 3.75 WHERE `entry` = 23226;
-- Bonechewer Combatant: DamageModifier 40 -> 30 (melee, WotLK, 2203 swings, k 29.997-29.995)
UPDATE `creature_template` SET `DamageModifier` = 30 WHERE `entry` = 23239;
-- Bash'ir Subprimal: DamageModifier 7.5 -> 4 (melee, WotLK, 180 swings, k 3.988-3.999)
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 23247;
-- Bash'ir Reckoner: DamageModifier 7.5 -> 4 (melee, WotLK, 33 swings, k 3.967-3.901)
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 23332;
-- Skyguard Prisoner: DamageModifier 1.2 -> 1 (melee, WotLK, 67 swings, k 0.996-1.002)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 23383;
-- Sanctum Defender: DamageModifier 1.2 -> 1 (melee, WotLK, 99 swings, k 1.002-0.996)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 23435;
-- Plagued Dragonflayer Tribesman: DamageModifier 1 -> 0.2 (melee, WotLK, 420 swings, k 0.213-0.211)
UPDATE `creature_template` SET `DamageModifier` = 0.2 WHERE `entry` = 23564;
-- Akil'zon: DamageModifier 14 -> 22 (melee, WotLK, 53 swings, k 21.909-21.783)
UPDATE `creature_template` SET `DamageModifier` = 22 WHERE `entry` = 23574;
-- Mindless Abomination: DamageModifier 7.5 -> 0.42 (sheet, WotLK, 3 sheets, exp 1 (AC 2))
UPDATE `creature_template` SET `DamageModifier` = 0.42 WHERE `entry` = 23575;
-- Amani Dragonhawk Hatchling: DamageModifier 9 -> 2.25 (melee, WotLK, 102 swings, k 2.249-2.250)
UPDATE `creature_template` SET `DamageModifier` = 2.25 WHERE `entry` = 23598;
-- Dyslix Silvergrub: DamageModifier 4.6 -> 2 (sheet, TBC, 167 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 23612;
-- Chill Nymph: ExperienceModifier 1 -> 1.05 (xp, WotLK, 18 kills, 0.72 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 1.05 WHERE `entry` = 23678;
-- Headless Horseman: DamageModifier 7.5 -> 19.5 (melee, WotLK, 214 swings, k 19.679-19.520)
UPDATE `creature_template` SET `DamageModifier` = 19.5 WHERE `entry` = 23682;
-- Cassa Crimsonwing: DamageModifier 1 -> 2 (sheet, TBC, 150 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 23704;
-- Stone Giant: ExperienceModifier 1 -> 1.5 (xp, WotLK, 12 kills, 0.67 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 1.5 WHERE `entry` = 23725;
-- Valgarde Defender: DamageModifier 4.6 -> 5 (melee, WotLK, 2060 swings, k 4.998-4.999)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 23739;
-- Captured Raptor: DamageModifier 1 -> 2 (melee, WotLK, 239 swings, k 1.985-1.999)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 23741;
-- Dark Ranger Lyana: DamageModifier 4.6 -> 3 (melee, WotLK, 32 swings, k 2.980-3.010)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 23778;
-- Sergeant Amelyn: DamageModifier 1 -> 2 (sheet, TBC, 117 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 23835;
-- Zelfrax: DamageModifier 1 -> 1.2 (melee, WotLK, 36 swings, k 1.178-1.197)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 23864;
-- Ember Clutch Ancient: DamageModifier 4.6 -> 1 (melee, WotLK, 451 swings, k 0.997-0.998)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 23870;
-- Coren Direbrew: DamageModifier 7.5 -> 19.5 (melee, WotLK, 101 swings, k 19.450-19.469)
UPDATE `creature_template` SET `DamageModifier` = 19.5 WHERE `entry` = 23872;
-- Goreclaw the Ravenous: DamageModifier 1 -> 1.35 (melee, WotLK, 51 swings, k 1.335-1.353)
UPDATE `creature_template` SET `DamageModifier` = 1.35 WHERE `entry` = 23873;
-- Amani'shi Savage: DamageModifier 1.2 -> 0.8 (melee, WotLK, 95 swings, k 0.820-0.815)
UPDATE `creature_template` SET `DamageModifier` = 0.8 WHERE `entry` = 23889;
-- Hungry Plaguehound: DamageModifier 1 -> 0.07 (sheet, WotLK, 2 sheets, exp 2 (AC 2))
UPDATE `creature_template` SET `DamageModifier` = 0.07 WHERE `entry` = 23943;
-- Forsaken Deckhand: DamageModifier 1 -> 0.1 (melee, WotLK, 33680 swings, k 0.100-0.099)
UPDATE `creature_template` SET `DamageModifier` = 0.1 WHERE `entry` = 23982;
-- Sepulchral Overseer: DamageModifier 4.6 -> 4 (melee, WotLK, 35 swings, k 3.951-4.018)
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 23993;
-- Dragonflayer Hunting Hound: DamageModifier 1 -> 0.5 (melee, WotLK, 162 swings, k 0.497-0.499)
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 23994;
-- Glacion: DamageModifier 4.6 -> 3 (melee, WotLK, 125 swings, k 2.987-2.995); ExperienceModifier 1 -> 1.5 (xp, WotLK, 6 kills, 0.67 at median)
UPDATE `creature_template` SET `DamageModifier` = 3, `ExperienceModifier` = 1.5 WHERE `entry` = 24019;
-- Amani Lynx: DamageModifier 5 -> 10.5 (melee, WotLK, 80 swings, k 10.448-10.388)
UPDATE `creature_template` SET `DamageModifier` = 10.5 WHERE `entry` = 24043;
-- Spirit of the Lynx: DamageModifier 20 -> 16 (melee, WotLK, 31 swings, k 15.695-15.876)
UPDATE `creature_template` SET `DamageModifier` = 16 WHERE `entry` = 24143;
-- Plagued Dragonflayer Rune-Caster: DamageModifier 1 -> 0.18 (melee, WotLK, 75 swings, k 0.180-0.179)
UPDATE `creature_template` SET `DamageModifier` = 0.18 WHERE `entry` = 24198;
-- Plagued Dragonflayer Handler: DamageModifier 1 -> 0.5 (melee, WotLK, 58 swings, k 0.502-0.494)
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 24199;
-- Yorus the Flesh Harvester: DamageModifier 1 -> 2 (melee, WotLK, 55 swings, k 1.989-2.003)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 24214;
-- Bjorn Halgurdsson: DamageModifier 4.6 -> 4 (melee, WotLK, 149 swings, k 3.999-4.003)
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 24238;
-- Nizzle: DamageModifier 4.6 -> 2 (sheet, TBC, 113 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 24366;
-- Nether-Stalker Mah'duun: DamageModifier 1.3 -> 1 (sheet, TBC, 32 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 24370;
-- Megalith: DamageModifier 4.6 -> 2 (melee, WotLK, 33 swings, k 1.977-1.987); ExperienceModifier 1 -> 1.5 (xp, WotLK, 3 kills, 0.67 at median)
UPDATE `creature_template` SET `DamageModifier` = 2, `ExperienceModifier` = 1.5 WHERE `entry` = 24371;
-- Lydell: DamageModifier 4.6 -> 2 (melee, WotLK, 175 swings, k 1.997-1.993)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 24458;
-- Minor Voidwalker: DamageModifier 1 -> 0.5 (melee, WotLK, 136 swings, k 0.493-0.497)
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 24476;
-- Syndicate Thief: DamageModifier 1 -> 1.2 (melee, TBC, 108 swings, k 1.196-1.200)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 24477;
-- Hozzer: DamageModifier 4.6 -> 3 (melee, WotLK, 116 swings, k 3.025-2.983)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 24547;
-- Riplash Myrmidon: DamageModifier 1 -> 0.1 (melee, WotLK, 177 swings, k 0.099-0.099); ExperienceModifier 1 -> 0.33 (xp, WotLK, 6 kills, 0.83 at median)
UPDATE `creature_template` SET `DamageModifier` = 0.1, `ExperienceModifier` = 0.33 WHERE `entry` = 24576;
-- Phoenix: DamageModifier 1 -> 5 (melee, WotLK, 49 swings, k 4.964-5.019)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 24674;
-- Caylee Dak: ArmorModifier 1.11 -> 1 (armor, TBC, 3 sheets, 0.816 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1 WHERE `entry` = 24727;
-- Nexus Watcher: DamageModifier 4.6 -> 4 (melee, WotLK, 43 swings, k 4.003-3.967)
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 24770;
-- Trained Rock Falcon: DamageModifier 1 -> 0.1 (sheet, WotLK, 7 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 0.1 WHERE `entry` = 24783;
-- Spectral Sailor: DamageModifier 1 -> 0.5 (melee, WotLK, 106 swings, k 0.496-0.498)
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 24796;
-- Storm Giant: DamageModifier 4.6 -> 7 (melee, WotLK, 114 swings, k 7.048-7.009)
UPDATE `creature_template` SET `DamageModifier` = 7 WHERE `entry` = 24812;
-- Stonevault Pillager: DamageModifier 7.5 -> 1.7 (melee, TBC, 109 swings, k 1.691-1.700)
UPDATE `creature_template` SET `DamageModifier` = 1.7 WHERE `entry` = 24830;
-- Abdul the Insane: DamageModifier 7.5 -> 3 (melee, WotLK, 53 swings, k 2.977-2.961)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 24900;
-- Razorthorn Flayer: DamageModifier 1.4 -> 1 (melee, WotLK, 110 swings, k 0.994-0.994)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 24920;
-- Erratic Sentry: DamageModifier 1.5 -> 1 (melee, WotLK, 139 swings, k 0.996-0.999)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 24972;
-- Irespeaker: DamageModifier 1.5 -> 1 (melee, TBC, 180 swings, k 0.996-0.995); ExperienceModifier 1 -> 1.45 (xp, WotLK, 23 kills, 0.52 at median)
UPDATE `creature_template` SET `DamageModifier` = 1, `ExperienceModifier` = 1.45 WHERE `entry` = 24999;
-- Abyssal Flamewalker: DamageModifier 1.3 -> 1 (melee, TBC, 41 swings, k 0.987-1.004)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 25001;
-- Unleashed Hellion: DamageModifier 1.4 -> 1 (melee, WotLK, 184 swings, k 1.001-0.998); ExperienceModifier 1 -> 1.45 (xp, WotLK, 37 kills, 0.51 at median)
UPDATE `creature_template` SET `DamageModifier` = 1, `ExperienceModifier` = 1.45 WHERE `entry` = 25002;
-- Emissary of Hate: DamageModifier 2 -> 1.2 (melee, WotLK, 45 swings, k 1.192-1.189); ExperienceModifier 1 -> 1.45 (xp, WotLK, 10 kills, 0.50 at median)
UPDATE `creature_template` SET `DamageModifier` = 1.2, `ExperienceModifier` = 1.45 WHERE `entry` = 25003;
-- Skeletal Ravager: DamageModifier 0.25 -> 0.2 (melee, WotLK, 16669 swings, k 0.198-0.199)
UPDATE `creature_template` SET `DamageModifier` = 0.2 WHERE `entry` = 25028;
-- Wrath Enforcer: DamageModifier 1.6 -> 1.2 (sheet, WotLK, 1 sheets, exp 1 (AC 1))
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 25030;
-- Pit Overlord: DamageModifier 6.5 -> 2 (melee, WotLK, 2000 swings, k 1.998-2.000)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 25031;
-- Eredar Sorcerer: DamageModifier 12 -> 3 (melee, WotLK, 298 swings, k 2.998-3.000)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 25033;
-- Darkspine Myrmidon: DamageModifier 1.3 -> 1 (melee, WotLK, 309 swings, k 0.997-0.998)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 25060;
-- Darkspine Siren: DamageModifier 1.4 -> 1 (melee, WotLK, 30 swings, k 0.967-1.010)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 25073;
-- Greengill Slave: DamageModifier 1 -> 0.33 (melee, WotLK, 260 swings, k 0.328-0.326)
UPDATE `creature_template` SET `DamageModifier` = 0.33 WHERE `entry` = 25084;
-- Grikkin Copperspring: DamageModifier 1 -> 0.85 (sheet, TBC, 5 sheets, exp 1 (AC 2))
UPDATE `creature_template` SET `DamageModifier` = 0.85 WHERE `entry` = 25176;
-- Winterfin Gatherer: DamageModifier 1 -> 0.33 (melee, WotLK, 82 swings, k 0.328-0.327)
UPDATE `creature_template` SET `DamageModifier` = 0.33 WHERE `entry` = 25198;
-- Crypt Crawler: ExperienceModifier 1 -> 0.65 (xp, WotLK, 13 kills, 0.54 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.65 WHERE `entry` = 25227;
-- Risen Crypt Lord: ExperienceModifier 1 -> 0.25 (xp, WotLK, 3 kills, 0.67 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.25 WHERE `entry` = 25228;
-- Warsong Battleguard: DamageModifier 1 -> 5 (melee, WotLK, 414 swings, k 4.999-5.003)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 25242;
-- Justicar Julia Celeste: DamageModifier 4.6 -> 5 (melee, WotLK, 84 swings, k 4.980-5.014)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 25264;
-- Counselor Talbot: DamageModifier 4.6 -> 6 (melee, WotLK, 74 swings, k 6.049-6.170)
UPDATE `creature_template` SET `DamageModifier` = 6 WHERE `entry` = 25301;
-- Valiance Keep Footman: DamageModifier 1 -> 0.5 (melee, WotLK, 6512 swings, k 0.498-0.504)
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 25313;
-- Longrunner Proudhoof: DamageModifier 1 -> 1.1 (melee, WotLK, 219 swings, k 1.099-1.100)
UPDATE `creature_template` SET `DamageModifier` = 1.1 WHERE `entry` = 25335;
-- Force-Commander Steeljaw: ExperienceModifier 1 -> 1.5 (xp, WotLK, 4 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 1.5 WHERE `entry` = 25359;
-- Brittle Skeleton: ExperienceModifier 1 -> 0.02 (xp, WotLK, 6 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.02 WHERE `entry` = 25377;
-- Raging Boiler: DamageModifier 1.2 -> 1 (melee, WotLK, 3384 swings, k 0.997-0.998)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 25417;
-- Offspring of Magmothregar: DamageModifier 1 -> 0.25 (melee, WotLK, 106 swings, k 0.250-0.249); ExperienceModifier 1 -> 0.25 (xp, WotLK, 27 kills, 1.00 at median)
UPDATE `creature_template` SET `DamageModifier` = 0.25, `ExperienceModifier` = 0.25 WHERE `entry` = 25433;
-- Warsong Captain: DamageModifier 4.6 -> 1 (melee, WotLK, 31 swings, k 0.999-1.009)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 25446;
-- Ith'rix the Harvester: DamageModifier 7.5 -> 3.5 (melee, WotLK, 84 swings, k 3.509-3.495)
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE `entry` = 25453;
-- Sand Turtle: ExperienceModifier 1 -> 1.05 (xp, WotLK, 6 kills, 0.67 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 1.05 WHERE `entry` = 25482;
-- Mootoo the Younger: DamageModifier 4.6 -> 2 (melee, WotLK, 141 swings, k 1.994-2.001)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 25504;
-- Varidus the Flenser: DamageModifier 7.5 -> 5 (melee, WotLK, 259 swings, k 4.991-5.003)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 25618;
-- Captured Tuskarr Prisoner: DamageModifier 1 -> 0.1 (melee, WotLK, 145 swings, k 0.099-0.099)
UPDATE `creature_template` SET `DamageModifier` = 0.1 WHERE `entry` = 25636;
-- Coldarra Mage Slayer: DamageModifier 1 -> 0.5 (melee, WotLK, 635 swings, k 0.496-0.498); ExperienceModifier 1 -> 0.75 (xp, WotLK, 61 kills, 0.79 at median)
UPDATE `creature_template` SET `DamageModifier` = 0.5, `ExperienceModifier` = 0.75 WHERE `entry` = 25718;
-- Shadowstalker Getry: DamageModifier 7.5 -> 3 (melee, WotLK, 164 swings, k 3.020-2.995)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 25729;
-- En'kilah Necrolord: DamageModifier 7.5 -> 15 (melee, WotLK, 44 swings, k 14.885-15.065)
UPDATE `creature_template` SET `DamageModifier` = 15 WHERE `entry` = 25730;
-- Kaskala Defender: DamageModifier 1 -> 1.2 (melee, WotLK, 61259 swings, k 1.199-1.198)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 25764;
-- Lord Kryxix: DamageModifier 1 -> 1.25 (melee, WotLK, 37 swings, k 1.255-1.249)
UPDATE `creature_template` SET `DamageModifier` = 1.25 WHERE `entry` = 25768;
-- Nedar, Lord of Rhinos: DamageModifier 4.6 -> 1.95 (melee, WotLK, 36 swings, k 1.981-1.960)
UPDATE `creature_template` SET `DamageModifier` = 1.95 WHERE `entry` = 25801;
-- Kaw the Mammoth Destroyer: DamageModifier 4.6 -> 1.5 (melee, WotLK, 151 swings, k 1.494-1.500)
UPDATE `creature_template` SET `DamageModifier` = 1.5 WHERE `entry` = 25802;
-- Harold Lane: DamageModifier 4.6 -> 4 (melee, WotLK, 86 swings, k 3.984-4.004)
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 25804;
-- D.E.H.T.A. Enforcer: DamageModifier 4.6 -> 5 (melee, WotLK, 32 swings, k 4.930-5.040)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 25819;
-- Northsea Thug: ExperienceModifier 1 -> 0.8 (xp, WotLK, 17 kills, 0.76 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.8 WHERE `entry` = 25843;
-- Minion of Kaw: ExperienceModifier 1 -> 0.1 (xp, WotLK, 35 kills, 0.83 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.1 WHERE `entry` = 25880;
-- Gerald Green: DamageModifier 4.6 -> 3 (melee, WotLK, 117 swings, k 2.987-2.997)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 26083;
-- Kor'kron Elite: DamageModifier 7.5 -> 1 (melee, WotLK, 133 swings, k 0.995-0.999)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 26183;
-- Drowned Guardian: DamageModifier 1 -> 0.2 (melee, WotLK, 136 swings, k 0.199-0.200)
UPDATE `creature_template` SET `DamageModifier` = 0.2 WHERE `entry` = 26224;
-- Grizzly Hills Giant: DamageModifier 4.6 -> 0.5 (melee, WotLK, 9224 swings, k 0.500-0.500)
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 26261;
-- Crystalline Ice Giant: DamageModifier 4.6 -> 5 (melee, WotLK, 30 swings, k 5.070-4.897)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 26291;
-- Hulking Jormungar: DamageModifier 4.6 -> 3 (melee, WotLK, 44 swings, k 3.068-3.005)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 26293;
-- Ice Heart Jormungar Spawn: DamageModifier 1 -> 0.5 (melee, WotLK, 40 swings, k 0.493-0.501)
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 26359;
-- Rattlebore: DamageModifier 4.6 -> 8 (melee, WotLK, 31 swings, k 7.894-7.996)
UPDATE `creature_template` SET `DamageModifier` = 8 WHERE `entry` = 26360;
-- The Anvil: DamageModifier 4.6 -> 0.5 (melee, WotLK, 50 swings, k 0.497-0.501)
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 26406;
-- Stars' Rest Sentinel: DamageModifier 4.6 -> 5 (melee, WotLK, 96 swings, k 4.997-5.005)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 26448;
-- Gamel the Cruel: DamageModifier 1 -> 1.2 (melee, WotLK, 51 swings, k 1.207-1.203)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 26449;
-- Ragnar Drakkarlund: DamageModifier 1 -> 1.2 (melee, WotLK, 33 swings, k 1.184-1.202)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 26451;
-- Leviroth: DamageModifier 1 -> 1.2 (melee, WotLK, 45 swings, k 1.190-1.202)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 26452;
-- Mistress of the Coldwind: DamageModifier 4.6 -> 5 (melee, WotLK, 52 swings, k 5.006-4.991)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 26578;
-- Under-King Anub'et'kan: DamageModifier 7.5 -> 2 (melee, WotLK, 58 swings, k 1.988-1.999)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 26608;
-- Arctic Grizzly Cub: DamageModifier 1 -> 0.5 (melee, WotLK, 33 swings, k 0.495-0.499)
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 26613;
-- Ursoc: ExperienceModifier 1 -> 7.5 (xp, WotLK, 4 kills, 0.50 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 7.5 WHERE `entry` = 26633;
-- Kilix the Unraveler: DamageModifier 4.6 -> 5 (melee, WotLK, 32 swings, k 5.172-5.033)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 26653;
-- Roanauk Icemist: DamageModifier 4.6 -> 5 (melee, WotLK, 57 swings, k 4.966-5.012)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 26654;
-- Azjol-anak Battleguard: DamageModifier 4.6 -> 5 (melee, WotLK, 83 swings, k 4.995-5.016)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 26662;
-- Anub'ar Invader: DamageModifier 1 -> 0.6 (melee, WotLK, 228 swings, k 0.597-0.599)
UPDATE `creature_template` SET `DamageModifier` = 0.6 WHERE `entry` = 26676;
-- Snowplain Disciple: DamageModifier 1 -> 0.5 (melee, WotLK, 151 swings, k 0.500-0.499)
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 26705;
-- Ilsa Direbrew: DamageModifier 7.5 -> 0.85 (melee, TBC, 36 swings, k 0.866-0.865)
UPDATE `creature_template` SET `DamageModifier` = 0.85 WHERE `entry` = 26764;
-- Brave Storming Sky: DamageModifier 4.6 -> 0.2 (melee, WotLK, 216 swings, k 0.197-0.200)
UPDATE `creature_template` SET `DamageModifier` = 0.2 WHERE `entry` = 26766;
-- Longrunner Taima: DamageModifier 4.6 -> 0.2 (melee, WotLK, 174 swings, k 0.198-0.199)
UPDATE `creature_template` SET `DamageModifier` = 0.2 WHERE `entry` = 26767;
-- Snow Tracker Haloke: DamageModifier 4.6 -> 0.2 (melee, WotLK, 128 swings, k 0.197-0.198)
UPDATE `creature_template` SET `DamageModifier` = 0.2 WHERE `entry` = 26768;
-- Direbrew Minion: DamageModifier 1 -> 3 (melee, WotLK, 220 swings, k 2.994-3.003)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 26776;
-- Gigantaur: DamageModifier 4.6 -> 6 (melee, WotLK, 82 swings, k 5.980-6.010)
UPDATE `creature_template` SET `DamageModifier` = 6 WHERE `entry` = 26836;
-- Dreadtalon: DamageModifier 4.6 -> 2.5 (melee, WotLK, 67 swings, k 2.492-2.479)
UPDATE `creature_template` SET `DamageModifier` = 2.5 WHERE `entry` = 26838;
-- Tecahuna: DamageModifier 6 -> 5 (melee, WotLK, 97 swings, k 5.011-5.006)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 26865;
-- Ancient Drakkari King: DamageModifier 1 -> 0.5 (melee, WotLK, 92 swings, k 0.496-0.500)
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 26871;
-- Grom'thar the Thunderbringer: DamageModifier 7.5 -> 6 (melee, WotLK, 41 swings, k 6.026-6.033)
UPDATE `creature_template` SET `DamageModifier` = 6 WHERE `entry` = 27002;
-- Bonesunder: DamageModifier 4.6 -> 1.5 (melee, WotLK, 40 swings, k 1.483-1.508)
UPDATE `creature_template` SET `DamageModifier` = 1.5 WHERE `entry` = 27006;
-- Iceshatter: ExperienceModifier 1 -> 0.75 (xp, WotLK, 4 kills, 0.75 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.75 WHERE `entry` = 27007;
-- Bloodfeast: ExperienceModifier 1 -> 2 (xp, WotLK, 3 kills, 0.67 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 2 WHERE `entry` = 27008;
-- Drakegore: ExperienceModifier 1 -> 0.75 (xp, WotLK, 4 kills, 0.75 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.75 WHERE `entry` = 27009;
-- Gorgonna: DamageModifier 4.6 -> 5 (melee, WotLK, 74 swings, k 5.011-5.030)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 27102;
-- Kreug Oathbreaker: DamageModifier 4.6 -> 9 (melee, WotLK, 117 swings, k 9.025-9.016)
UPDATE `creature_template` SET `DamageModifier` = 9 WHERE `entry` = 27105;
-- Injured Warsong Warrior: DamageModifier 1 -> 3 (melee, WotLK, 94 swings, k 2.988-2.991)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 27106;
-- 7th Legion Infantryman: DamageModifier 4.6 -> 5 (melee, WotLK, 781 swings, k 5.005-4.995)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 27160;
-- Torturer LeCraft: DamageModifier 1 -> 0.8 (melee, WotLK, 74 swings, k 0.797-0.800)
UPDATE `creature_template` SET `DamageModifier` = 0.8 WHERE `entry` = 27209;
-- High General Abbendis: DamageModifier 4.6 -> 6 (melee, WotLK, 45 swings, k 6.033-6.027); ExperienceModifier 1 -> 1.25 (xp, WotLK, 4 kills, 0.75 at median)
UPDATE `creature_template` SET `DamageModifier` = 6, `ExperienceModifier` = 1.25 WHERE `entry` = 27210;
-- Onslaught Warhorse: DamageModifier 1 -> 0.25 (melee, WotLK, 357 swings, k 0.247-0.249)
UPDATE `creature_template` SET `DamageModifier` = 0.25 WHERE `entry` = 27213;
-- Alystros the Verdant Keeper: DamageModifier 4.6 -> 6 (melee, WotLK, 224 swings, k 5.990-5.998)
UPDATE `creature_template` SET `DamageModifier` = 6 WHERE `entry` = 27249;
-- Reconstructed Frost Wyrm: DamageModifier 4.6 -> 4 (melee, WotLK, 43 swings, k 4.038-3.998)
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 27285;
-- Tur Ragepaw: DamageModifier 4.6 -> 4 (melee, WotLK, 152 swings, k 4.018-4.002)
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 27328;
-- Silverbrook Worgen: DamageModifier 1 -> 0.35 (melee, WotLK, 519 swings, k 0.349-0.348)
UPDATE `creature_template` SET `DamageModifier` = 0.35 WHERE `entry` = 27417;
-- Conquest Hold Marauder: DamageModifier 1 -> 0.6 (melee, WotLK, 771 swings, k 0.599-0.600)
UPDATE `creature_template` SET `DamageModifier` = 0.6 WHERE `entry` = 27424;
-- Sergeant Bonesnap: DamageModifier 1 -> 0.6 (melee, WotLK, 36 swings, k 0.599-0.604)
UPDATE `creature_template` SET `DamageModifier` = 0.6 WHERE `entry` = 27493;
-- Fordragon Footman: DamageModifier 4.6 -> 3 (melee, WotLK, 48 swings, k 3.017-3.131)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 27518;
-- Frigid Abomination Attacker: DamageModifier 4.6 -> 3 (melee, WotLK, 1050 swings, k 2.997-3.000)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 27531;
-- Kor'kron Vanguard: DamageModifier 4.6 -> 3 (melee, WotLK, 292 swings, k 3.000-3.000)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 27553;
-- Alliance Conscript: DamageModifier 4.6 -> 1.5 (melee, WotLK, 2481 swings, k 1.499-1.499)
UPDATE `creature_template` SET `DamageModifier` = 1.5 WHERE `entry` = 27564;
-- 7th Legion Elite: DamageModifier 4.6 -> 2 (melee, WotLK, 286 swings, k 1.997-1.998)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 27588;
-- Frail Construct: DamageModifier 1 -> 0.02 (melee, WotLK, 31 swings, k 0.020-0.019)
UPDATE `creature_template` SET `DamageModifier` = 0.02 WHERE `entry` = 27604;
-- Colossal Abomination: DamageModifier 4.6 -> 6.75 (melee, WotLK, 69 swings, k 6.656-6.835)
UPDATE `creature_template` SET `DamageModifier` = 6.75 WHERE `entry` = 27605;
-- Tatjana's Horse: DamageModifier 1 -> 0.95 (sheet, WotLK, 1 sheets, exp 2 (AC 2))
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 27626;
-- Horace Alder: DamageModifier 1 -> 0.5 (sheet, TBC, 180 sheets, exp 0 (AC 0))
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 27704;
-- Drakkari Invader: DamageModifier 1 -> 0.25 (melee, WotLK, 351 swings, k 0.248-0.249)
UPDATE `creature_template` SET `DamageModifier` = 0.25 WHERE `entry` = 27709;
-- Mindless Ghoul: DamageModifier 1 -> 0.25 (melee, WotLK, 10835 swings, k 0.247-0.249)
UPDATE `creature_template` SET `DamageModifier` = 0.25 WHERE `entry` = 27712;
-- 7th Legion Elite: DamageModifier 4.6 -> 1 (melee, WotLK, 31 swings, k 0.997-1.005)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 27713;
-- Horgrenn Hellcleave: DamageModifier 7.5 -> 12 (melee, WotLK, 42 swings, k 11.931-11.926)
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 27718;
-- Ruby Guardian: DamageModifier 4.6 -> 2 (melee, WotLK, 3083 swings, k 1.998-2.000)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 27725;
-- Lordaeron Footman: DamageModifier 7.5 -> 1 (melee, WotLK, 6622 swings, k 0.999-0.999)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 27745;
-- Conquest Hold Defender: DamageModifier 4.6 -> 2.86 (sheet, WotLK, 1 sheets, exp 2 (AC 2))
UPDATE `creature_template` SET `DamageModifier` = 2.86 WHERE `entry` = 27748;
-- Horde Conscript: DamageModifier 4.6 -> 1.5 (melee, WotLK, 3933 swings, k 1.499-1.499)
UPDATE `creature_template` SET `DamageModifier` = 1.5 WHERE `entry` = 27749;
-- Captain Drayzen: DamageModifier 4.6 -> 5 (melee, WotLK, 46 swings, k 4.990-5.027)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 27751;
-- Drakkari Invader: DamageModifier 1 -> 0.25 (melee, WotLK, 646 swings, k 0.249-0.250)
UPDATE `creature_template` SET `DamageModifier` = 0.25 WHERE `entry` = 27753;
-- Westfall Brigade Defender: DamageModifier 4.6 -> 3 (melee, WotLK, 303 swings, k 3.004-3.003)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 27758;
-- 7th Legion Rifleman: DamageModifier 1 -> 0.75 (melee, WotLK, 4940 swings, k 0.748-0.748)
UPDATE `creature_template` SET `DamageModifier` = 0.75 WHERE `entry` = 27791;
-- Tattered Abomination: ExperienceModifier 1 -> 1.1 (xp, WotLK, 14 kills, 0.50 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 1.1 WHERE `entry` = 27797;
-- Dreadbone Construct: ExperienceModifier 1 -> 1.1 (xp, WotLK, 8 kills, 0.50 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 1.1 WHERE `entry` = 27835;
-- Vanthryn the Merciless: DamageModifier 4.6 -> 5 (melee, WotLK, 43 swings, k 4.975-5.026)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 27859;
-- Luthion the Vile: ExperienceModifier 1 -> 2.5 (xp, WotLK, 3 kills, 0.67 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 2.5 WHERE `entry` = 27860;
-- Infinite Destroyer: DamageModifier 1 -> 0.8 (melee, WotLK, 239 swings, k 0.797-0.800)
UPDATE `creature_template` SET `DamageModifier` = 0.8 WHERE `entry` = 27897;
-- Rainspeaker Warrior: DamageModifier 4.6 -> 5 (melee, WotLK, 489 swings, k 4.997-4.996)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 28024;
-- Argent Shieldman: DamageModifier 1 -> 0.9 (melee, WotLK, 2234 swings, k 0.898-0.900)
UPDATE `creature_template` SET `DamageModifier` = 0.9 WHERE `entry` = 28028;
-- Argent Crusader: DamageModifier 1 -> 0.9 (melee, WotLK, 2048 swings, k 0.898-0.899)
UPDATE `creature_template` SET `DamageModifier` = 0.9 WHERE `entry` = 28029;
-- Argent Soldier: DamageModifier 1 -> 0.9 (melee, WotLK, 10694 swings, k 0.898-0.900)
UPDATE `creature_template` SET `DamageModifier` = 0.9 WHERE `entry` = 28041;
-- Frenzyheart Tracker: DamageModifier 4.6 -> 5 (melee, WotLK, 168 swings, k 4.995-4.999)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 28077;
-- Sapphire Hive Drone: DamageModifier 1 -> 0.5 (melee, WotLK, 319 swings, k 0.498-0.500)
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 28085;
-- Hardknuckle Forager: DamageModifier 1 -> 0.75 (melee, WotLK, 149 swings, k 0.748-0.747); ExperienceModifier 1 -> 0.75 (xp, WotLK, 40 kills, 0.80 at median)
UPDATE `creature_template` SET `DamageModifier` = 0.75, `ExperienceModifier` = 0.75 WHERE `entry` = 28098;
-- Urgreth of the Thousand Tombs: DamageModifier 35 -> 9 (melee, WotLK, 189 swings, k 8.982-9.002)
UPDATE `creature_template` SET `DamageModifier` = 9 WHERE `entry` = 28103;
-- Enraged Skeleton: DamageModifier 1 -> 2 (melee, WotLK, 179 swings, k 1.998-1.998)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 28104;
-- Sparktouched Oracle: DamageModifier 1 -> 0.5 (melee, WotLK, 2450 swings, k 0.499-0.500)
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 28112;
-- Retired Onslaught Warhorse: DamageModifier 1 -> 0.5 (melee, WotLK, 43 swings, k 0.500-0.501)
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 28187;
-- Hailscorn: DamageModifier 35 -> 6 (melee, WotLK, 93 swings, k 6.005-6.008)
UPDATE `creature_template` SET `DamageModifier` = 6 WHERE `entry` = 28208;
-- Bythius the Flesh-Shaper: DamageModifier 35 -> 6 (melee, WotLK, 88 swings, k 5.979-5.967)
UPDATE `creature_template` SET `DamageModifier` = 6 WHERE `entry` = 28212;
-- The Etymidian: ArmorModifier 1 -> 0.95 (armor, WotLK, 1 sheets, 1.0 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.95 WHERE `entry` = 28222;
-- Risen Reaver: DamageModifier 4.6 -> 5 (melee, WotLK, 127 swings, k 4.992-5.009)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 28242;
-- Thrym: DamageModifier 4.6 -> 15 (melee, WotLK, 69 swings, k 14.921-14.992)
UPDATE `creature_template` SET `DamageModifier` = 15 WHERE `entry` = 28243;
-- Malas the Corrupter: DamageModifier 4.6 -> 4 (melee, WotLK, 41 swings, k 3.986-4.028)
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 28255;
-- Hath'ar Skimmer: ExperienceModifier 1 -> 0.95 (xp, WotLK, 63 kills, 0.51 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.95 WHERE `entry` = 28258;
-- Servant of Freya: DamageModifier 1 -> 0.5 (melee, WotLK, 15420 swings, k 0.497-0.500)
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 28320;
-- Zim'Torga Defender: DamageModifier 1 -> 1.5 (melee, WotLK, 1727 swings, k 1.498-1.500)
UPDATE `creature_template` SET `DamageModifier` = 1.5 WHERE `entry` = 28387;
-- Death Knight Initiate: DamageModifier 1 -> 1.05 (melee, WotLK, 1041 swings, k 1.051-1.053)
UPDATE `creature_template` SET `DamageModifier` = 1.05 WHERE `entry` = 28406;
-- Rhunok: DamageModifier 4.6 -> 1 (melee, WotLK, 39 swings, k 0.990-0.997)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 28416;
-- Thalgran Blightbringer: DamageModifier 4.6 -> 3 (melee, WotLK, 94 swings, k 2.985-3.000)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 28443;
-- Broodmother Slivina: DamageModifier 4.6 -> 4 (melee, WotLK, 146 swings, k 3.990-4.003); ExperienceModifier 1 -> 1.5 (xp, WotLK, 6 kills, 0.67 at median)
UPDATE `creature_template` SET `DamageModifier` = 4, `ExperienceModifier` = 1.5 WHERE `entry` = 28467;
-- Stampy: ArmorModifier 1 -> 1.65 (armor, WotLK, 2 sheets, 1.992 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 1.65 WHERE `entry` = 28468;
-- Coldwraith: DamageModifier 1 -> 0.5 (melee, WotLK, 151 swings, k 0.514-0.526)
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 28488;
-- High Cultist Herenn: ExperienceModifier 1 -> 2.25 (xp, WotLK, 4 kills, 0.75 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 2.25 WHERE `entry` = 28601;
-- Jaloot: DamageModifier 7.5 -> 2 (melee, WotLK, 35 swings, k 1.977-2.000)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 28667;
-- Acherus Geist: DamageModifier 1 -> 1.05 (melee, WotLK, 573 swings, k 1.049-1.057)
UPDATE `creature_template` SET `DamageModifier` = 1.05 WHERE `entry` = 28709;
-- Vic's Flying Machine: DamageModifier 1 -> 0.95 (sheet, WotLK, 2 sheets, exp 2 (AC 2))
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 28710;
-- Argent Stand Defender: DamageModifier 4.6 -> 5 (melee, WotLK, 925 swings, k 4.998-4.998)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 28801;
-- Bloated Abomination: DamageModifier 1 -> 1.15 (sheet, WotLK, 1 sheets, exp 2 (AC 2))
UPDATE `creature_template` SET `DamageModifier` = 1.15 WHERE `entry` = 28843;
-- Scourge Gryphon: DamageModifier 1 -> 1.5 (melee, WotLK, 356 swings, k 1.497-1.499)
UPDATE `creature_template` SET `DamageModifier` = 1.5 WHERE `entry` = 28906;
-- Crypt Guardian: DamageModifier 2.4 -> 1.05 (melee, WotLK, 202 swings, k 1.050-1.054)
UPDATE `creature_template` SET `DamageModifier` = 1.05 WHERE `entry` = 28937;
-- Citizen of New Avalon: ExperienceModifier 1 -> 0.15 (xp, WotLK, 3 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.15 WHERE `entry` = 28942;
-- New Avalon Councilman: DamageModifier 1 -> 1.05 (melee, WotLK, 72 swings, k 1.056-1.075)
UPDATE `creature_template` SET `DamageModifier` = 1.05 WHERE `entry` = 28946;
-- Akali: DamageModifier 10 -> 30.5 (melee, WotLK, 40 swings, k 30.360-30.523)
UPDATE `creature_template` SET `DamageModifier` = 30.5 WHERE `entry` = 28952;
-- Overlord Drakuru: DamageModifier 7.5 -> 30 (melee, WotLK, 96 swings, k 30.018-30.061)
UPDATE `creature_template` SET `DamageModifier` = 30 WHERE `entry` = 28998;
-- Disgruntled Bug: DamageModifier 1 -> 0.05 (melee, WotLK, 110 swings, k 0.048-0.048)
UPDATE `creature_template` SET `DamageModifier` = 0.05 WHERE `entry` = 29017;
-- Har'koa: DamageModifier 7.5 -> 1.5 (melee, WotLK, 56 swings, k 1.489-1.489)
UPDATE `creature_template` SET `DamageModifier` = 1.5 WHERE `entry` = 29050;
-- Death Knight Champion: DamageModifier 1 -> 6.25 (melee, WotLK, 935 swings, k 6.305-6.348)
UPDATE `creature_template` SET `DamageModifier` = 6.25 WHERE `entry` = 29106;
-- Rampaging Abomination: DamageModifier 2.4 -> 20 (melee, WotLK, 96 swings, k 19.929-20.034)
UPDATE `creature_template` SET `DamageModifier` = 20 WHERE `entry` = 29115;
-- Volatile Ghoul: DamageModifier 1 -> 3 (melee, WotLK, 443 swings, k 2.990-2.998)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 29136;
-- Korfax, Champion of the Light: DamageModifier 7.5 -> 15 (melee, WotLK, 110 swings, k 15.010-15.025)
UPDATE `creature_template` SET `DamageModifier` = 15 WHERE `entry` = 29176;
-- Lord Maxwell Tyrosus: DamageModifier 7.5 -> 12 (melee, WotLK, 55 swings, k 12.327-12.044)
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 29178;
-- Duke Nicholas Zverenhoff: DamageModifier 7.5 -> 6 (melee, WotLK, 45 swings, k 5.838-6.015)
UPDATE `creature_template` SET `DamageModifier` = 6 WHERE `entry` = 29180;
-- Rampaging Abomination: DamageModifier 2.4 -> 10 (melee, WotLK, 554 swings, k 9.990-9.998)
UPDATE `creature_template` SET `DamageModifier` = 10 WHERE `entry` = 29186;
-- Flesh Behemoth: DamageModifier 7.5 -> 35 (melee, WotLK, 508 swings, k 34.972-34.975)
UPDATE `creature_template` SET `DamageModifier` = 35 WHERE `entry` = 29190;
-- Koltira Deathweaver: DamageModifier 2.4 -> 6 (melee, WotLK, 199 swings, k 5.998-5.990)
UPDATE `creature_template` SET `DamageModifier` = 6 WHERE `entry` = 29199;
-- Thassarian: DamageModifier 2.4 -> 6 (melee, WotLK, 208 swings, k 5.998-5.990)
UPDATE `creature_template` SET `DamageModifier` = 6 WHERE `entry` = 29200;
-- Orbaz Bloodbane: DamageModifier 2.4 -> 6 (melee, WotLK, 187 swings, k 5.997-6.001)
UPDATE `creature_template` SET `DamageModifier` = 6 WHERE `entry` = 29204;
-- Warrior of the Frozen Wastes: DamageModifier 7.5 -> 8 (melee, WotLK, 1929 swings, k 7.998-8.000)
UPDATE `creature_template` SET `DamageModifier` = 8 WHERE `entry` = 29206;
-- Frigid Bones: DamageModifier 1 -> 0.55 (melee, WotLK, 1394 swings, k 0.525-0.528)
UPDATE `creature_template` SET `DamageModifier` = 0.55 WHERE `entry` = 29210;
-- Volatile Ghoul: DamageModifier 1 -> 3 (melee, WotLK, 3347 swings, k 2.992-2.997)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 29219;
-- Kor: DamageModifier 1 -> 0.95 (sheet, WotLK, 1 sheets, exp 2 (AC 2))
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 29251;
-- Koloth: DamageModifier 1 -> 0.95 (sheet, WotLK, 1 sheets, exp 2 (AC 2))
UPDATE `creature_template` SET `DamageModifier` = 0.95 WHERE `entry` = 29253;
-- Niffelem Frost Giant: DamageModifier 4.6 -> 5 (melee, WotLK, 1334 swings, k 5.000-4.998)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 29351;
-- Kirgaraak: DamageModifier 4.6 -> 6 (melee, WotLK, 95 swings, k 5.986-5.999)
UPDATE `creature_template` SET `DamageModifier` = 6 WHERE `entry` = 29352;
-- Stormforged Iron Giant: DamageModifier 4.6 -> 5 (melee, WotLK, 253 swings, k 4.993-5.003)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 29375;
-- Corrupted Scarlet Onslaught: DamageModifier 1 -> 0.25 (melee, WotLK, 481 swings, k 0.249-0.249)
UPDATE `creature_template` SET `DamageModifier` = 0.25 WHERE `entry` = 29400;
-- Injured Goblin Miner: DamageModifier 1 -> 0.8 (melee, WotLK, 128 swings, k 0.801-0.800)
UPDATE `creature_template` SET `DamageModifier` = 0.8 WHERE `entry` = 29434;
-- Dolomite Giant: DamageModifier 4.6 -> 0.5 (melee, WotLK, 5113 swings, k 0.499-0.499)
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 29485;
-- Archbishop Landgren: DamageModifier 4.6 -> 7 (melee, WotLK, 44 swings, k 7.066-6.894)
UPDATE `creature_template` SET `DamageModifier` = 7 WHERE `entry` = 29542;
-- Ragemane: DamageModifier 4.6 -> 6.5 (melee, WotLK, 59 swings, k 6.467-6.516)
UPDATE `creature_template` SET `DamageModifier` = 6.5 WHERE `entry` = 29664;
-- Hyldsmeet Drakerider: DamageModifier 1 -> 0.8 (melee, WotLK, 161 swings, k 0.798-0.799)
UPDATE `creature_template` SET `DamageModifier` = 0.8 WHERE `entry` = 29694;
-- Towering Horror: DamageModifier 7.5 -> 1.5 (melee, WotLK, 238 swings, k 1.500-1.498)
UPDATE `creature_template` SET `DamageModifier` = 1.5 WHERE `entry` = 29704;
-- Stormwind Harbor Guard: DamageModifier 1 -> 2 (melee, WotLK, 540 swings, k 1.994-1.999)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 29712;
-- Stormpeak Hatchling: DamageModifier 1 -> 0.25 (melee, WotLK, 121 swings, k 0.251-0.250)
UPDATE `creature_template` SET `DamageModifier` = 0.25 WHERE `entry` = 29755;
-- Prince Navarius: DamageModifier 7.5 -> 6 (melee, WotLK, 30 swings, k 5.958-6.045)
UPDATE `creature_template` SET `DamageModifier` = 6 WHERE `entry` = 29821;
-- Lady Nightswood: DamageModifier 1 -> 0.85 (melee, WotLK, 51 swings, k 0.842-0.853)
UPDATE `creature_template` SET `DamageModifier` = 0.85 WHERE `entry` = 29858;
-- Vile: DamageModifier 1 -> 0.75 (melee, WotLK, 66 swings, k 0.745-0.748)
UPDATE `creature_template` SET `DamageModifier` = 0.75 WHERE `entry` = 29860;
-- Algar the Chosen: DamageModifier 7.5 -> 20 (melee, WotLK, 158 swings, k 20.118-20.012)
UPDATE `creature_template` SET `DamageModifier` = 20 WHERE `entry` = 29872;
-- Vargul Doombringer: DamageModifier 7.5 -> 3 (melee, WotLK, 1140 swings, k 2.997-2.999)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 29887;
-- Thrym: DamageModifier 7.5 -> 15 (melee, WotLK, 227 swings, k 14.987-15.006)
UPDATE `creature_template` SET `DamageModifier` = 15 WHERE `entry` = 29895;
-- Acolyte of Agony: DamageModifier 7.5 -> 3 (melee, WotLK, 185 swings, k 3.000-2.962)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 29934;
-- Acolyte of Pain: DamageModifier 7.5 -> 3 (melee, WotLK, 171 swings, k 2.999-3.001)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 29935;
-- Niffelem Forefather: DamageModifier 1 -> 1.2 (melee, WotLK, 85 swings, k 1.192-1.201)
UPDATE `creature_template` SET `DamageModifier` = 1.2 WHERE `entry` = 29974;
-- Earthen Elite: DamageModifier 4.6 -> 1 (melee, WotLK, 5358 swings, k 0.999-0.999)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 29980;
-- Earthen Warder: DamageModifier 1 -> 0.05 (melee, WotLK, 1610 swings, k 0.049-0.048)
UPDATE `creature_template` SET `DamageModifier` = 0.05 WHERE `entry` = 29981;
-- Iron Sentinel: DamageModifier 4.6 -> 5 (melee, WotLK, 2523 swings, k 5.000-5.000)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 29984;
-- Stinkbeard: DamageModifier 7.5 -> 8 (melee, WotLK, 36 swings, k 7.947-8.054)
UPDATE `creature_template` SET `DamageModifier` = 8 WHERE `entry` = 30017;
-- Frostborn Axemaster: DamageModifier 7.5 -> 5 (melee, WotLK, 732 swings, k 4.997-4.999)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 30065;
-- Whisker: DamageModifier 7.5 -> 5 (melee, WotLK, 55 swings, k 4.974-4.982)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 30113;
-- Cavedweller Worg: DamageModifier 1 -> 0.5 (melee, WotLK, 2301 swings, k 0.498-0.500)
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 30164;
-- Argent Champion: DamageModifier 7.5 -> 5 (melee, WotLK, 7455 swings, k 4.998-4.999)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 30188;
-- Crusader of Virtue: DamageModifier 7.5 -> 1.35 (melee, WotLK, 6900 swings, k 1.348-1.350)
UPDATE `creature_template` SET `DamageModifier` = 1.35 WHERE `entry` = 30189;
-- Vile: DamageModifier 4.6 -> 5 (melee, WotLK, 46 swings, k 4.972-5.009)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 30216;
-- Iron Colossus: DamageModifier 7.5 -> 6 (melee, WotLK, 44 swings, k 5.964-6.029)
UPDATE `creature_template` SET `DamageModifier` = 6 WHERE `entry` = 30300;
-- Tamed Jormungar: DamageModifier 7.5 -> 10.5 (sheet, WotLK, 2 sheets, exp 2 (AC 2)); ArmorModifier 1 -> 2.75 (armor, WotLK, 2 sheets, 2.983 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 2.75, `DamageModifier` = 10.5 WHERE `entry` = 30301;
-- Shadow Vault Boneguard: DamageModifier 4.6 -> 3 (melee, WotLK, 113 swings, k 2.990-3.007)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 30312;
-- Dr. Terrible: DamageModifier 7.5 -> 4 (melee, WotLK, 39 swings, k 4.018-4.019)
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 30404;
-- Frostbrood Destroyer: DamageModifier 2 -> 18 (melee, WotLK, 541 swings, k 17.991-17.984)
UPDATE `creature_template` SET `DamageModifier` = 18 WHERE `entry` = 30575;
-- Highlord Tirion Fordring: DamageModifier 35 -> 15.5 (melee, WotLK, 261 swings, k 15.282-15.278)
UPDATE `creature_template` SET `DamageModifier` = 15.5 WHERE `entry` = 30595;
-- Spiked Ghoul: ExperienceModifier 1 -> 0.9 (xp, WotLK, 31 kills, 0.97 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.9 WHERE `entry` = 30597;
-- Crusader of Virtue: DamageModifier 7.5 -> 1.35 (melee, WotLK, 1723 swings, k 1.347-1.348)
UPDATE `creature_template` SET `DamageModifier` = 1.35 WHERE `entry` = 30672;
-- Skeletal Constructor: ExperienceModifier 1 -> 0.9 (xp, WotLK, 12 kills, 0.92 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.9 WHERE `entry` = 30687;
-- Chained Abomination: ExperienceModifier 1 -> 0.9 (xp, WotLK, 3 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.9 WHERE `entry` = 30689;
-- Corpulent Horror: ExperienceModifier 1 -> 0.9 (xp, WotLK, 7 kills, 0.86 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.9 WHERE `entry` = 30696;
-- Putrid Colossus: DamageModifier 7.5 -> 3 (melee, WotLK, 744 swings, k 3.002-2.999)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 30697;
-- Morbidus: DamageModifier 7.5 -> 5 (melee, WotLK, 43 swings, k 4.967-4.994)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 30698;
-- Vile Creeper: ExperienceModifier 1 -> 0.9 (xp, WotLK, 11 kills, 0.91 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.9 WHERE `entry` = 30701;
-- Ebon Blade Champion: DamageModifier 7.5 -> 1 (melee, WotLK, 1404 swings, k 0.998-0.999)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 30703;
-- Argent Paladin: DamageModifier 1 -> 0.2 (melee, WotLK, 4304 swings, k 0.199-0.199)
UPDATE `creature_template` SET `DamageModifier` = 0.2 WHERE `entry` = 30704;
-- Nesingwary Game Warden: DamageModifier 1 -> 5 (melee, WotLK, 97 swings, k 4.980-5.009)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 30737;
-- Underking Talonox: DamageModifier 7.5 -> 1.5 (melee, WotLK, 50 swings, k 1.489-1.503)
UPDATE `creature_template` SET `DamageModifier` = 1.5 WHERE `entry` = 30830;
-- Jayde: DamageModifier 7.5 -> 10 (melee, WotLK, 161 swings, k 10.048-10.001)
UPDATE `creature_template` SET `DamageModifier` = 10 WHERE `entry` = 30839;
-- Munch: DamageModifier 7.5 -> 10 (melee, WotLK, 51 swings, k 9.925-10.007)
UPDATE `creature_template` SET `DamageModifier` = 10 WHERE `entry` = 30840;
-- Risen Soldier: DamageModifier 1 -> 0.3 (melee, WotLK, 213 swings, k 0.298-0.299); ExperienceModifier 1 -> 0.3 (xp, WotLK, 11 kills, 0.91 at median)
UPDATE `creature_template` SET `DamageModifier` = 0.3, `ExperienceModifier` = 0.3 WHERE `entry` = 30960;
-- Reanimated Captain: DamageModifier 7.5 -> 2.25 (melee, WotLK, 76 swings, k 2.246-2.251)
UPDATE `creature_template` SET `DamageModifier` = 2.25 WHERE `entry` = 30986;
-- Hideous Plaguebringer: DamageModifier 7.5 -> 2.5 (melee, WotLK, 96 swings, k 2.492-2.500)
UPDATE `creature_template` SET `DamageModifier` = 2.5 WHERE `entry` = 30987;
-- Scourgebeak Fleshripper: ExperienceModifier 1 -> 0.9 (xp, WotLK, 11 kills, 0.91 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.9 WHERE `entry` = 30988;
-- Doctor Sabnok: DamageModifier 3.5 -> 2 (melee, WotLK, 41 swings, k 1.992-2.012)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 30992;
-- Intrepid Ghoul: ExperienceModifier 1 -> 0.9 (xp, WotLK, 6 kills, 0.83 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.9 WHERE `entry` = 31015;
-- Overthane Balargarde: DamageModifier 7.5 -> 9 (melee, WotLK, 32 swings, k 9.067-9.040)
UPDATE `creature_template` SET `DamageModifier` = 9 WHERE `entry` = 31016;
-- Crusader of Virtue: DamageModifier 4.6 -> 8 (melee, WotLK, 162 swings, k 7.993-8.002)
UPDATE `creature_template` SET `DamageModifier` = 8 WHERE `entry` = 31033;
-- Val'kyr Battle-maiden: DamageModifier 2.4 -> 5.75 (melee, WotLK, 33 swings, k 5.765-5.957)
UPDATE `creature_template` SET `DamageModifier` = 5.75 WHERE `entry` = 31095;
-- Pustulent Horror: DamageModifier 4.6 -> 4 (melee, WotLK, 873 swings, k 4.013-4.031)
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 31139;
-- Coprous the Defiled: DamageModifier 4.6 -> 13 (melee, WotLK, 116 swings, k 13.074-13.040)
UPDATE `creature_template` SET `DamageModifier` = 13 WHERE `entry` = 31198;
-- Ancient Watcher: DamageModifier 4.6 -> 5 (melee, WotLK, 309 swings, k 4.923-5.003)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 31229;
-- Ebon Blade Defender: DamageModifier 1 -> 2 (melee, WotLK, 2174 swings, k 1.999-2.000)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 31250;
-- Thane Banahogg: DamageModifier 7.5 -> 12 (melee, WotLK, 41 swings, k 11.937-12.003)
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 31277;
-- Orbaz Bloodbane: DamageModifier 7.5 -> 10 (melee, WotLK, 57 swings, k 9.948-10.031)
UPDATE `creature_template` SET `DamageModifier` = 10 WHERE `entry` = 31283;
-- Margrave Dhakar: DamageModifier 7.5 -> 2 (melee, WotLK, 50 swings, k 1.991-1.969)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 31306;
-- Ebon Blade Veteran: DamageModifier 1 -> 0.15 (melee, WotLK, 223 swings, k 0.149-0.150)
UPDATE `creature_template` SET `DamageModifier` = 0.15 WHERE `entry` = 31314;
-- Ebon Blade Reaper: DamageModifier 7.5 -> 1 (melee, WotLK, 5912 swings, k 0.999-0.999)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 31316;
-- Hulking Horror: ExperienceModifier 1 -> 0.95 (xp, WotLK, 10 kills, 0.80 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.95 WHERE `entry` = 31411;
-- Valiance Commando: DamageModifier 1 -> 0.6 (melee, WotLK, 694 swings, k 0.599-0.599)
UPDATE `creature_template` SET `DamageModifier` = 0.6 WHERE `entry` = 31414;
-- Felguard Marauder: DamageModifier 7.5 -> 5 (melee, WotLK, 4813 swings, k 4.997-5.000)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 31527;
-- Stormwind Elite: DamageModifier 7.5 -> 4 (melee, WotLK, 53 swings, k 3.975-4.002)
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 31639;
-- Faceless Lurker: ExperienceModifier 1 -> 0.95 (xp, WotLK, 10 kills, 0.90 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.95 WHERE `entry` = 31691;
-- Reanimated Abomination: DamageModifier 1 -> 0.3 (sheet, WotLK, 32 sheets, exp 2 (AC 2))
UPDATE `creature_template` SET `DamageModifier` = 0.3 WHERE `entry` = 31692;
-- Blight Aberration: DamageModifier 35 -> 12 (melee, WotLK, 258 swings, k 11.980-11.992)
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 31844;
-- Scavenging Geist: ExperienceModifier 1 -> 0.95 (xp, WotLK, 23 kills, 0.70 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.95 WHERE `entry` = 31847;
-- Khanok the Impassable: DamageModifier 35 -> 12 (melee, WotLK, 253 swings, k 11.987-12.012)
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 32160;
-- Grimkor's Hound: DamageModifier 7.5 -> 3 (melee, WotLK, 37 swings, k 2.996-3.006)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 32163;
-- Plague Drenched Ghoul: DamageModifier 7.5 -> 5 (melee, WotLK, 79 swings, k 5.060-4.980)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 32176;
-- Enslaved Minion: DamageModifier 1 -> 0.5 (melee, WotLK, 163 swings, k 0.500-0.498)
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 32260;
-- Legion Invader: DamageModifier 7.5 -> 4 (melee, WotLK, 422 swings, k 3.999-3.998)
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 32269;
-- Legion Dreadwhisperer: DamageModifier 7.5 -> 3 (melee, WotLK, 326 swings, k 3.000-3.000)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 32270;
-- Legion Overlord: DamageModifier 7.5 -> 8 (melee, WotLK, 589 swings, k 7.995-7.995)
UPDATE `creature_template` SET `DamageModifier` = 8 WHERE `entry` = 32271;
-- Harbinger of Horror: ExperienceModifier 1 -> 1.45 (xp, WotLK, 5 kills, 1.00 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 1.45 WHERE `entry` = 32278;
-- Corp'rethar Guardian: DamageModifier 4.6 -> 10 (melee, WotLK, 54 swings, k 9.970-9.994); ExperienceModifier 1 -> 1.45 (xp, WotLK, 5 kills, 0.80 at median)
UPDATE `creature_template` SET `DamageModifier` = 10, `ExperienceModifier` = 1.45 WHERE `entry` = 32280;
-- Alumeth the Ascended: DamageModifier 7.5 -> 8 (melee, WotLK, 32 swings, k 7.985-8.067)
UPDATE `creature_template` SET `DamageModifier` = 8 WHERE `entry` = 32300;
-- Highlord Darion Mograine: DamageModifier 35 -> 50.5 (melee, WotLK, 61 swings, k 50.435-50.367)
UPDATE `creature_template` SET `DamageModifier` = 50.5 WHERE `entry` = 32312;
-- Cultist Shard Watcher: ExperienceModifier 1 -> 0.95 (xp, WotLK, 15 kills, 0.93 at median)
UPDATE `creature_template` SET `ExperienceModifier` = 0.95 WHERE `entry` = 32349;
-- Skeletal Reaver: DamageModifier 4.6 -> 4 (melee, WotLK, 116 swings, k 4.000-4.008)
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 32467;
-- Bone Spider: DamageModifier 2 -> 1.5 (melee, WotLK, 60 swings, k 1.497-1.495)
UPDATE `creature_template` SET `DamageModifier` = 1.5 WHERE `entry` = 32484;
-- Putridus the Ancient: DamageModifier 7.5 -> 6 (melee, WotLK, 69 swings, k 6.001-6.016)
UPDATE `creature_template` SET `DamageModifier` = 6 WHERE `entry` = 32487;
-- Ebon Blade Vindicator: DamageModifier 1 -> 3 (melee, WotLK, 697 swings, k 3.000-2.998)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 32488;
-- Frostbrood Matriarch: DamageModifier 4.6 -> 1.05 (melee, WotLK, 495 swings, k 1.029-1.025)
UPDATE `creature_template` SET `DamageModifier` = 1.05 WHERE `entry` = 32492;
-- Dancing Runeblade: DamageModifier 1 -> 2 (melee, WotLK, 208 swings, k 1.996-1.991)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 32496;
-- Shambling Zombie: DamageModifier 1 -> 0.5 (melee, WotLK, 37 swings, k 0.498-0.495)
UPDATE `creature_template` SET `DamageModifier` = 0.5 WHERE `entry` = 32503;
-- Scalesworn Elite: DamageModifier 4.6 -> 30 (melee, WotLK, 105 swings, k 29.965-30.033)
UPDATE `creature_template` SET `DamageModifier` = 30 WHERE `entry` = 32534;
-- Illidan Stormrage: DamageModifier 1 -> 30.5 (melee, WotLK, 47 swings, k 30.165-30.396)
UPDATE `creature_template` SET `DamageModifier` = 30.5 WHERE `entry` = 32588;
-- Crystalline Tangler: DamageModifier 1 -> 3 (melee, WotLK, 88 swings, k 2.990-3.007)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 32665;
-- Missy Flamecuffs: DamageModifier 7.5 -> 5 (melee, WotLK, 39 swings, k 5.024-5.032)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 32893;
-- Field Medic Penny: DamageModifier 7.5 -> 5 (melee, WotLK, 44 swings, k 4.957-4.998)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 32897;
-- Elementalist Avuun: DamageModifier 7.5 -> 5 (melee, WotLK, 171 swings, k 5.023-4.992)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 32900;
-- Tor Greycloud: DamageModifier 7.5 -> 5 (melee, WotLK, 61 swings, k 4.985-5.014)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 32941;
-- Veesha Blazeweaver: DamageModifier 7.5 -> 5 (melee, WotLK, 40 swings, k 5.003-4.996)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 32946;
-- Spiritwalker Yona: DamageModifier 7.5 -> 5 (melee, WotLK, 495 swings, k 4.994-5.000)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 32950;
-- Elementalist Mahfuun: DamageModifier 7.5 -> 5 (melee, WotLK, 36 swings, k 4.975-5.026)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 33328;
-- Battle-Priest Gina: DamageModifier 7.5 -> 5 (melee, WotLK, 169 swings, k 4.988-5.006)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 33330;
-- Amira Blazeweaver: DamageModifier 7.5 -> 5 (melee, WotLK, 59 swings, k 4.984-5.005)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 33331;
-- Spiritwalker Tara: DamageModifier 7.5 -> 5 (melee, WotLK, 322 swings, k 4.994-4.992)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 33332;
-- Chillmaw: DamageModifier 4.6 -> 8 (melee, WotLK, 320 swings, k 8.090-8.085)
UPDATE `creature_template` SET `DamageModifier` = 8 WHERE `entry` = 33687;
-- Cultist Bombardier: DamageModifier 7.5 -> 2 (melee, WotLK, 1051 swings, k 1.998-1.998)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 33695;
-- Mature Lasher: DamageModifier 1 -> 1.3 (melee, WotLK, 44 swings, k 1.289-1.307)
UPDATE `creature_template` SET `DamageModifier` = 1.3 WHERE `entry` = 34300;
-- Deathspeaker Kharos: DamageModifier 1 -> 0.4 (melee, WotLK, 74 swings, k 0.401-0.399)
UPDATE `creature_template` SET `DamageModifier` = 0.4 WHERE `entry` = 34808;
-- Kvaldir Harpooner: DamageModifier 1 -> 0.7 (melee, WotLK, 1193 swings, k 0.698-0.699)
UPDATE `creature_template` SET `DamageModifier` = 0.7 WHERE `entry` = 34907;
-- Firehawk Mariner: DamageModifier 1 -> 1.4 (melee, WotLK, 1283 swings, k 1.398-1.398)
UPDATE `creature_template` SET `DamageModifier` = 1.4 WHERE `entry` = 35070;
-- Captain Aerthas Firehawk: DamageModifier 1 -> 4 (melee, WotLK, 124 swings, k 3.986-3.996)
UPDATE `creature_template` SET `DamageModifier` = 4 WHERE `entry` = 35090;
-- Apothecary Frye: DamageModifier 7.5 -> 1 (melee, WotLK, 210 swings, k 1.010-1.008)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 36272;
-- Disturbed Glacial Revenant: DamageModifier 7.5 -> 25 (melee, WotLK, 50 swings, k 24.895-25.051)
UPDATE `creature_template` SET `DamageModifier` = 25 WHERE `entry` = 36874;
-- Spiritual Reflection: DamageModifier 7.5 -> 6 (melee, WotLK, 37 swings, k 5.969-5.957)
UPDATE `creature_template` SET `DamageModifier` = 6 WHERE `entry` = 37107;
-- Highlord Tirion Fordring: DamageModifier 35 -> 15.5 (melee, WotLK, 60 swings, k 15.611-15.291)
UPDATE `creature_template` SET `DamageModifier` = 15.5 WHERE `entry` = 37119;
-- Thalorien Dawnseeker: DamageModifier 1 -> 2 (melee, WotLK, 82 swings, k 2.004-2.003)
UPDATE `creature_template` SET `DamageModifier` = 2 WHERE `entry` = 37205;
-- Freed Alliance Slave: DamageModifier 7.5 -> 8 (melee, WotLK, 1675 swings, k 7.999-7.998)
UPDATE `creature_template` SET `DamageModifier` = 8 WHERE `entry` = 37572;
-- Freed Alliance Slave: DamageModifier 7.5 -> 8 (melee, WotLK, 86 swings, k 7.976-7.999)
UPDATE `creature_template` SET `DamageModifier` = 8 WHERE `entry` = 37575;
-- Freed Horde Slave: DamageModifier 7.5 -> 8 (melee, WotLK, 1159 swings, k 7.996-8.000)
UPDATE `creature_template` SET `DamageModifier` = 8 WHERE `entry` = 37577;
-- Freed Horde Slave: DamageModifier 7.5 -> 8 (melee, WotLK, 274 swings, k 8.001-8.001)
UPDATE `creature_template` SET `DamageModifier` = 8 WHERE `entry` = 37578;
-- Fury: DamageModifier 7.5 -> 1 (melee, WotLK, 30 swings, k 1.001-1.009)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 37586;
-- Warhawk: DamageModifier 13.4 -> 12 (melee, WotLK, 131 swings, k 12.013-12.005)
UPDATE `creature_template` SET `DamageModifier` = 12 WHERE `entry` = 38154;
-- Fallen Warrior: DamageModifier 7.5 -> 9 (melee, WotLK, 287 swings, k 8.995-9.001)
UPDATE `creature_template` SET `DamageModifier` = 9 WHERE `entry` = 38487;
-- Argent Crusader: DamageModifier 7.5 -> 3 (melee, WotLK, 15890 swings, k 3.009-3.011)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 38493;
-- Knight of the Ebon Blade: DamageModifier 7.5 -> 1 (melee, WotLK, 19373 swings, k 1.002-1.002)
UPDATE `creature_template` SET `DamageModifier` = 1 WHERE `entry` = 38505;
-- Terenas Menethil: DamageModifier 14.2 -> 30 (melee, WotLK, 216 swings, k 30.104-30.015)
UPDATE `creature_template` SET `DamageModifier` = 30 WHERE `entry` = 38579;
-- Highlord Tirion Fordring: DamageModifier 19 -> 15.5 (melee, WotLK, 302 swings, k 15.298-15.278)
UPDATE `creature_template` SET `DamageModifier` = 15.5 WHERE `entry` = 38995;
-- Restless Zombie: DamageModifier 1 -> 15 (melee, WotLK, 421 swings, k 15.006-15.006)
UPDATE `creature_template` SET `DamageModifier` = 15 WHERE `entry` = 39639;
-- Zalazane: DamageModifier 1 -> 30 (melee, WotLK, 39 swings, k 29.698-30.132)
UPDATE `creature_template` SET `DamageModifier` = 30 WHERE `entry` = 39647;
-- Irradiated Infantry: DamageModifier 1 -> 10 (melee, WotLK, 272 swings, k 9.989-10.007)
UPDATE `creature_template` SET `DamageModifier` = 10 WHERE `entry` = 39755;
-- Irradiated Mechano-Tank: DamageModifier 1 -> 10 (melee, WotLK, 154 swings, k 9.983-10.015)
UPDATE `creature_template` SET `DamageModifier` = 10 WHERE `entry` = 39819;
-- Irradiated Trogg: DamageModifier 1 -> 5 (melee, WotLK, 228 swings, k 4.994-5.002)
UPDATE `creature_template` SET `DamageModifier` = 5 WHERE `entry` = 39826;
-- Irradiated Cavalry: DamageModifier 1 -> 20 (melee, WotLK, 417 swings, k 19.983-19.964)
UPDATE `creature_template` SET `DamageModifier` = 20 WHERE `entry` = 39836;
-- Bwonsamdi: DamageModifier 1 -> 20.5 (melee, WotLK, 107 swings, k 20.451-20.361)
UPDATE `creature_template` SET `DamageModifier` = 20.5 WHERE `entry` = 40182;
-- Jun'do the Traitor: DamageModifier 1 -> 30 (melee, WotLK, 52 swings, k 29.919-30.105)
UPDATE `creature_template` SET `DamageModifier` = 30 WHERE `entry` = 40189;
-- Mindless Troll: DamageModifier 1 -> 15 (melee, WotLK, 70 swings, k 15.014-15.013)
UPDATE `creature_template` SET `DamageModifier` = 15 WHERE `entry` = 40195;
-- Hexed Dire Troll: DamageModifier 1 -> 20 (melee, WotLK, 236 swings, k 20.002-20.016)
UPDATE `creature_template` SET `DamageModifier` = 20 WHERE `entry` = 40225;
-- Hexed Troll: DamageModifier 1 -> 15 (melee, WotLK, 71 swings, k 15.118-15.056)
UPDATE `creature_template` SET `DamageModifier` = 15 WHERE `entry` = 40231;
-- Darkspear Warrior: DamageModifier 1 -> 3 (melee, WotLK, 191 swings, k 2.995-2.997)
UPDATE `creature_template` SET `DamageModifier` = 3 WHERE `entry` = 40241;
-- Crashin' Thrashin' Racer: ArmorModifier 1 -> 0.95 (armor, WotLK, 1 sheets, 1.0 of basearmor)
UPDATE `creature_template` SET `ArmorModifier` = 0.95 WHERE `entry` = 40281;
-- Voodoo Troll: DamageModifier 1 -> 15 (melee, WotLK, 98 swings, k 15.023-15.013)
UPDATE `creature_template` SET `DamageModifier` = 15 WHERE `entry` = 40425;
