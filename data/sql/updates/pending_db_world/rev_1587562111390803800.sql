INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1587562111390803800');

DELETE FROM `acore_string` WHERE entry IN (30083,30084);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(30083, 'You cannot share quests while in a Battleground.'),
(30084, 'You cannot start a Ready Check while in a Battlground.');
