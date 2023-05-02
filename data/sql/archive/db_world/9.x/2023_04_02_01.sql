-- DB update 2023_04_02_00 -> 2023_04_02_01
-- Mote of Shadow
DELETE FROM `creature_loot_template` WHERE `Item` = 22577;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(16974, 22577, 0, 20, 0, 1, 0, 1, 1, 'Rogue Voidwalker - Mote of Shadow'),
(16975, 22577, 0, 20, 0, 1, 0, 1, 1, 'Uncontrolled Voidwalker - Mote of Shadow'),
(17014, 22577, 0, 20, 0, 1, 0, 1, 2, 'Collapsing Voidwalker - Mote of Shadow'),
(17981, 22577, 0, 18.6912, 0, 1, 0, 1, 2, 'Voidspawn - Mote of Shadow'),
(18683, 22577, 0, 25, 0, 1, 0, 1, 2, 'Voidhunter Yar - Mote of Shadow'),
(18869, 22577, 0, 1.0615, 0, 1, 0, 1, 2, 'Unstable Voidwraith - Mote of Shadow'),
(18870, 22577, 0, 1.0194, 0, 1, 0, 1, 2, 'Voidshrieker - Mote of Shadow'),
(19307, 22577, 0, 17.8397, 0, 1, 0, 1, 4, 'Nexus Terror - Mote of Shadow'),
(19527, 22577, 0, 20, 0, 1, 0, 1, 2, 'Vacillating Voidcaller - Mote of Shadow'),
(19554, 22577, 0, 60, 0, 1, 0, 2, 4, 'Dimensius the All-Devouring - Mote of Shadow'),
(20554, 22577, 0, 26.6608, 0, 1, 0, 1, 2, 'Arconus the Insatiable - Mote of Shadow'),
(20873, 22577, 0, 31.15, 0, 1, 0, 2, 4, 'Negaton Warp-Master - Mote of Shadow'),
(20875, 22577, 0, 30.59, 0, 1, 0, 2, 4, 'Negaton Screamer - Mote of Shadow'),
(22295, 22577, 0, 27.0833, 0, 1, 0, 2, 4, 'Deathforge Automaton - Mote of Shadow'),
(22301, 22577, 0, 37.8378, 0, 1, 0, 1, 2, 'Throne-Guard Sentinel - Mote of Shadow'),
-- Previously missing, from TrinityCore
(19299, 22577, 0, 42.4242, 0, 1, 0, 2, 4,'Deathwhisperer - Mote of Shadow'),
(20870, 22577, 0, 15, 0, 1, 0,  2, 4, 'Zereketh the Unbound - Mote of Shadow'),
(18341, 22577, 0, 15, 0, 1, 0, 2, 4, 'Pandemonius - Mote of Shadow'),
(19354, 22577, 0, 19.0751, 0, 1, 0, 2, 4, 'Arzeth the Merciless - Mote of Shadow');
