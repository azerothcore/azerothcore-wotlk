-- Spawns npc's from 13:00 - 17:01 (keep npc's spawned 1 min longer to make sure riggle over announcement at 17:00 works)
UPDATE `game_event` SET `start_time`= '2016-10-30 13:00:00', `length` = 241,  `description`= 'Stranglethorn Fishing Extravaganza - The Crew' WHERE `eventEntry` = 62;

-- Quests can be turned in 14:00 - 17:00
DELETE FROM `game_event` WHERE `eventEntry` = 90;
INSERT INTO `game_event` (`eventEntry`, `start_time`, `end_time`, `occurence`, `length`, `holiday`, `holidayStage`, `description`, `world_event`, `announce`) VALUES
(90,'2016-10-30 14:00:00','2030-12-31 07:00:00',10080,180,0,0,'Stranglethorn Fishing Extravaganza - Turn-ins',0,2);
