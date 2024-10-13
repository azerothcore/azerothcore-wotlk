--
DELETE FROM `game_event_creature_quest` WHERE `quest` IN (13931, 13932);
DELETE FROM `creature_queststarter` WHERE `quest`=13932 AND `id`=24468;
DELETE FROM `creature_queststarter` WHERE `quest`=13931 AND `id`=24510;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(24468, 13932),
(24510, 13931);

