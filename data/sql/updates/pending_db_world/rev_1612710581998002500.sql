INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612710581998002500');

UPDATE `game_event` SET `start_time` = '2016-10-29 01:00:00', `end_time` = '2030-12-31 07:00:00', `description` = 'Stranglethorn Fishing Extravaganza Announce' WHERE `evententry` = 14;
UPDATE `game_event` SET `start_time` = '2016-10-30 15:00:00', `end_time` = '2030-12-31 07:00:00', `holiday` = 301, `description` = 'Stranglethorn Fishing Extravaganza Fishing Pools' WHERE `evententry` = 15;
UPDATE `game_event` SET `start_time` = '2016-10-30 15:00:00', `end_time` = '2030-12-31 07:00:00', `holiday` = 0, `holidayStage` = 0, `description` = 'Stranglethorn Fishing Extravaganza Turn-ins' WHERE `evententry` = 62;

UPDATE `game_event_creature` SET `EventEntry` = 62 WHERE `EventEntry` = 15 AND `guid` IN (54687,54688,203521);
