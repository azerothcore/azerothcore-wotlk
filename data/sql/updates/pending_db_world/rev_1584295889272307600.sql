INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1584295889272307600');

-- =--------------------------------------------------------------------------------------------------------------------------------=
-- All normal/heroic DMG Values and additional changes listened below were gathered from the official 'World of Warcraft: Beastiary'
-- =--------------------------------------------------------------------------------------------------------------------------------=

-- Auchindoun: Auchenai Crypts (65-73)
-- -------------------------------------------------------------------------------------------------------------------
-- Shirrak the Dead Watcher
UPDATE `creature_template` SET `mindmg` = 1136, `maxdmg` = 1593, `DamageModifier` = 1 WHERE `entry` = 18371;
-- Exarch Maladaar
UPDATE `creature_template` SET `mindmg` = 2909, `maxdmg` = 4111, `DamageModifier` = 1 WHERE `entry` = 18373;
-- ===================================================================================================================


-- Auchindoun: Mana-Tombs (64 - 73)
-- -------------------------------------------------------------------------------------------------------------------
-- Pandemonius
UPDATE `creature_template` SET `mindmg` = 735, `maxdmg` = 1031, `DamageModifier` = 1 WHERE `entry` = 18341;
-- Tavarok
UPDATE `creature_template` SET `mindmg` = 735, `maxdmg` = 1031, `DamageModifier` = 1 WHERE `entry` = 18343;
-- Tavarok [Heroic]
UPDATE `creature_template` SET `mindmg` = 3920, `maxdmg` = 5544, `DamageModifier` = 1 WHERE `entry` = 20268;
-- Nexus-Prince Shaffar
UPDATE `creature_template` SET `mindmg` = 1136, `maxdmg` = 1593, `DamageModifier` = 1 WHERE `entry` = 18344;
-- Yor [Summoned in Heroic mode only]
UPDATE `creature_template` SET `mindmg` = 3787, `maxdmg` = 5355, `DamageModifier` = 1 WHERE `entry` = 22930;
-- ===================================================================================================================


-- Auchindoun: Sethekk Halls (67 - 73)
-- -------------------------------------------------------------------------------------------------------------------
-- Darkweaver Syth
UPDATE `creature_template` SET `mindmg` = 1203, `maxdmg` = 1694, `DamageModifier` = 1 WHERE `entry` = 18472;
-- Talon King Ikiss
UPDATE `creature_template` SET `mindmg` = 1755, `maxdmg` = 2471, `DamageModifier` = 1 WHERE `entry` = 18473;
-- Talon King Ikiss [Heroic]
UPDATE `creature_template` SET `mindmg` = 3252, `maxdmg` = 4718, `DamageModifier` = 1 WHERE `entry` = 20706;
-- Anzu [Summoned in Heroic mode only]
UPDATE `creature_template` SET `mindmg` = 4850, `maxdmg` = 6852, `DamageModifier` = 1 WHERE `entry` = 23035;
-- ===================================================================================================================


-- Auchindoun: Shadow Labyrinth (67 - 73)
-- -------------------------------------------------------------------------------------------------------------------
-- Ambassador Hellmaw
UPDATE `creature_template` SET `mindmg` = 2285, `maxdmg` = 3232, `DamageModifier` = 1 WHERE `entry` = 18731;
-- Blackheart the Inciter
UPDATE `creature_template` SET `mindmg` = 1852, `maxdmg` = 2619, `DamageModifier` = 1 WHERE `entry` = 18667;
-- Blackheart the Inciter [Heroic]
UPDATE `creature_template` SET `mindmg` = 3528, `maxdmg` = 4990, `DamageModifier` = 1 WHERE `entry` = 20637;
-- Grandmaster Vorpil
UPDATE `creature_template` SET `mindmg` = 1413, `maxdmg` = 1997, `DamageModifier` = 1 WHERE `entry` = 18732;
-- Murmur
UPDATE `creature_template` SET `mindmg` = 3257, `maxdmg` = 4606, `DamageModifier` = 1 WHERE `entry` = 18708;
-- ===================================================================================================================


-- Coilfang: The Slave Pens (62 - 73)
-- -------------------------------------------------------------------------------------------------------------------
-- Mennu the Betrayer
UPDATE `creature_template` SET `mindmg` = 619, `maxdmg` = 865, `DamageModifier` = 1 WHERE `entry` = 17941;
-- Rokmar the Crackler
UPDATE `creature_template` SET `mindmg` = 1240, `maxdmg` = 1733, `DamageModifier` = 1 WHERE `entry` = 17991;
-- Rokmar the Crackler [Heroic]
UPDATE `creature_template` SET `mindmg` = 4700, `maxdmg` = 6654, `DamageModifier` = 1 WHERE `entry` = 19895;
-- Quagmirran
UPDATE `creature_template` SET `mindmg` = 2289, `maxdmg` = 3200, `DamageModifier` = 1 WHERE `entry` = 17942;
-- Quagmirran [Heroic]
UPDATE `creature_template` SET `mindmg` = 6273, `maxdmg` = 8871, `DamageModifier` = 1 WHERE `entry` = 19894;
-- ===================================================================================================================


-- Coilfang: The Steamvault (67 - 73)
-- -------------------------------------------------------------------------------------------------------------------
-- Hydromancer Thespia
UPDATE `creature_template` SET `mindmg` = 1576, `maxdmg` = 2227, `DamageModifier` = 1 WHERE `entry` = 17797;
-- Mekgineer Steamrigger
UPDATE `creature_template` SET `mindmg` = 2091, `maxdmg` = 2957, `DamageModifier` = 1 WHERE `entry` = 17796;
-- Warlord Kalithresh
UPDATE `creature_template` SET `mindmg` = 1699, `maxdmg` = 2403, `DamageModifier` = 1 WHERE `entry` = 17798;
-- ===================================================================================================================


-- Coilfang: The Underbog (63 - 73)
-- -------------------------------------------------------------------------------------------------------------------
-- Hungarfen
UPDATE `creature_template` SET `mindmg` = 2005, `maxdmg` = 2809, `DamageModifier` = 1 WHERE `entry` = 17770;
-- Ghaz'an
UPDATE `creature_template` SET `mindmg` = 962, `maxdmg` = 1348, `DamageModifier` = 1 WHERE `entry` = 18105;
-- Ghaz'an [Heroic]
UPDATE `creature_template` SET `mindmg` = 4182, `maxdmg` = 5914, `DamageModifier` = 1 WHERE `entry` = 20168;
-- Swamplord Musel'ek
UPDATE `creature_template` SET `mindmg` = 1507, `maxdmg` = 2109, `DamageModifier` = 1 WHERE `entry` = 17826;
-- The Black Stalker
UPDATE `creature_template` SET `mindmg` = 1786, `maxdmg` = 2500, `DamageModifier` = 1 WHERE `entry` = 17882;
-- The Black Stalker [Heroic]
UPDATE `creature_template` SET `mindmg` = 2909, `maxdmg` = 4111, `DamageModifier` = 1 WHERE `entry` = 20184;
-- ===================================================================================================================


-- Hellfire Citadel: Ramparts (59 - 73)
-- -------------------------------------------------------------------------------------------------------------------
-- Watchkeeper Gargolmar
UPDATE `creature_template` SET `mindmg` = 603, `maxdmg` = 838, `DamageModifier` = 1 WHERE `entry` = 17306;
-- Omor the Unscarred
UPDATE `creature_template` SET `mindmg` = 1111, `maxdmg` = 1543, `DamageModifier` = 1 WHERE `entry` = 17308;
-- Omor the Unscarred [Heroic]
UPDATE `creature_template` SET `mindmg` = 1939, `maxdmg` = 2741, `DamageModifier` = 1 WHERE `entry` = 18433;
-- Nazan
UPDATE `creature_template` SET `mindmg` = 905, `maxdmg` = 1259, `DamageModifier` = 1 WHERE `entry` = 17536;
-- Vazruden
UPDATE `creature_template` SET `mindmg` = 1086, `maxdmg` = 1511, `DamageModifier` = 1 WHERE `entry` = 17537;
-- ===================================================================================================================


-- Hellfire Citadel: The Blood Furnace (61 - 73)
-- -------------------------------------------------------------------------------------------------------------------
-- The Maker
UPDATE `creature_template` SET `mindmg` = 1255, `maxdmg` = 1747, `DamageModifier` = 1 WHERE `entry` = 17381;
-- Broggok
UPDATE `creature_template` SET `mindmg` = 651, `maxdmg` = 937, `DamageModifier` = 1 WHERE `entry` = 17380;
-- Broggok [Heroic]
UPDATE `creature_template` SET `mindmg` = 2846, `maxdmg` = 4129, `DamageModifier` = 1 WHERE `entry` = 18601;
-- Keli'dan the Breaker
UPDATE `creature_template` SET `mindmg` = 2846, `maxdmg` = 4129, `DamageModifier` = 1 WHERE `entry` = 17377;
-- ===================================================================================================================

-- Hellfire Citadel: The Shattered Halls (67 - 73)
-- -------------------------------------------------------------------------------------------------------------------
-- Grand Warlock Nethekurse
UPDATE `creature_template` SET `mindmg` = 1406, `maxdmg` = 1986, `DamageModifier` = 1 WHERE `entry` = 16807;
-- Blood Guard Porung [Found in Heroic mode only]
UPDATE `creature_template` SET `mindmg` = 1960, `maxdmg` = 2772, `DamageModifier` = 1 WHERE `entry` = 20923;
UPDATE `creature_template` SET `mindmg` = 1960, `maxdmg` = 2772, `DamageModifier` = 1 WHERE `entry` = 20992;
UPDATE `creature_template` SET `mindmg` = 1960, `maxdmg` = 2772, `DamageModifier` = 1 WHERE `entry` = 20993;
-- Warbringer O'mrogg
UPDATE `creature_template` SET `mindmg` = 1610, `maxdmg` = 2277, `DamageModifier` = 1 WHERE `entry` = 16809;
-- Warchief Kargath Bladefist
UPDATE `creature_template` SET `mindmg` = 1388, `maxdmg` = 1963, `DamageModifier` = 1 WHERE `entry` = 16808;
-- ===================================================================================================================


-- Magister's Terrace (68 - 73)
-- -------------------------------------------------------------------------------------------------------------------
-- Kael'thas Sunstrider
UPDATE `creature_template` SET `mindmg` = 11083, `maxdmg` = 15653, `DamageModifier` = 1 WHERE `entry` = 24664;
-- ===================================================================================================================

-- Old Hillsbrad Foothills (66 - 73)
-- -------------------------------------------------------------------------------------------------------------------
-- Epoch Hunter
UPDATE `creature_template` SET `mindmg` = 1536, `maxdmg` = 2166, `DamageModifier` = 1 WHERE `entry` = 18096;
-- Epoch Hunter [Heroic]
UPDATE `creature_template` SET `mindmg` = 5227, `maxdmg` = 7393, `DamageModifier` = 1 WHERE `entry` = 20531;
-- ===================================================================================================================


-- Tempest Keep: The Arcatraz (68 - 73)
-- -------------------------------------------------------------------------------------------------------------------
-- Zereketh the Unbound
UPDATE `creature_template` SET `mindmg` = 1455, `maxdmg` = 2056, `DamageModifier` = 1 WHERE `entry` = 20870;
-- Dalliah the Doomsayer
UPDATE `creature_template` SET `mindmg` = 1777, `maxdmg` = 2514, `DamageModifier` = 1 WHERE `entry` = 20885;
-- Wrath-Scryer Soccothrates
UPDATE `creature_template` SET `mindmg` = 2091, `maxdmg` = 2957, `DamageModifier` = 1 WHERE `entry` = 20886;
-- Harbinger Skyriss
UPDATE `creature_template` SET `mindmg` = 969, `maxdmg` = 1370, `DamageModifier` = 1 WHERE `entry` = 20912;
-- ===================================================================================================================


-- Tempest Keep: The Botanica (67 - 73)
-- -------------------------------------------------------------------------------------------------------------------
-- Commander Sarannis
UPDATE `creature_template` SET `mindmg` = 1523, `maxdmg` = 2154, `DamageModifier` = 1 WHERE `entry` = 17976;
-- High Botanist Freywinn
UPDATE `creature_template` SET `mindmg` = 1413, `maxdmg` = 1997, `DamageModifier` = 1 WHERE `entry` = 17975;
-- Thorngrin the Tender
UPDATE `creature_template` SET `mindmg` = 2001, `maxdmg` = 2826, `DamageModifier` = 1 WHERE `entry` = 17978;
-- Thorngrin the Tender [Heroic]
UPDATE `creature_template` SET `mindmg` = 3394, `maxdmg` = 4796, `DamageModifier` = 1 WHERE `entry` = 21581;
-- Laj
UPDATE `creature_template` SET `mindmg` = 1960, `maxdmg` = 2772, `DamageModifier` = 1 WHERE `entry` = 17980;
UPDATE `creature_template` SET `resistance5` = 500 WHERE `entry` = 17980;
-- ===================================================================================================================

-- Tempest Keep: The Mechanar (67 - 73)
-- -------------------------------------------------------------------------------------------------------------------
-- Mechano-Lord Capacitus
UPDATE `creature_template` SET `mindmg` = 2091, `maxdmg` = 2957, `DamageModifier` = 1 WHERE `entry` = 19219;
-- Gatewatcher Gyro-Kill
UPDATE `creature_template` SET `mindmg` = 2091, `maxdmg` = 2957, `DamageModifier` = 1 WHERE `entry` = 19218;
-- Gatewatcher Iron-Hand
UPDATE `creature_template` SET `mindmg` = 2091, `maxdmg` = 2957, `DamageModifier` = 1 WHERE `entry` = 19710;
-- Nethermancer Sepethrea
UPDATE `creature_template` SET `mindmg` = 1576, `maxdmg` = 2227, `DamageModifier` = 1 WHERE `entry` = 19221;
-- Pathaleon the Calculator
UPDATE `creature_template` SET `mindmg` = 848, `maxdmg` = 1198, `DamageModifier` = 1 WHERE `entry` = 19220;
-- ===================================================================================================================

-- The Black Morass (68 - 73)
-- -------------------------------------------------------------------------------------------------------------------
-- Chrono Lord Deja
UPDATE `creature_template` SET `mindmg` = 1455, `maxdmg` = 2056, `DamageModifier` = 1 WHERE `entry` = 17879;
-- Temporus
UPDATE `creature_template` SET `mindmg` = 1829, `maxdmg` = 2587, `DamageModifier` = 1 WHERE `entry` = 17880;
-- Aeonus
UPDATE `creature_template` SET `mindmg` = 2353, `maxdmg` = 3327, `DamageModifier` = 1 WHERE `entry` = 17881;
-- ===================================================================================================================
