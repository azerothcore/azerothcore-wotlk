-- DB update 2024_11_05_02 -> 2024_11_05_03
-- New Year Celebrations!
DELETE FROM `creature_queststarter` WHERE `quest` IN (8860,8861);
DELETE FROM `game_event_creature_quest` WHERE `quest` IN (8860,8861);
INSERT INTO `game_event_creature_quest` (`eventEntry`, `id`, `quest`) VALUES
(6, 15732, 8860),
(6, 15732, 8861);
