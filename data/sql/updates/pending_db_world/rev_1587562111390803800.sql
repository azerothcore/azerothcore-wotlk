INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1587562111390803800');

DELETE FROM `acore_string` WHERE entry IN (30081,30082);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(30081, 'You cannot share quests while in a Battleground'),
(30082, 'You cannot start a Ready Check while in a Battlground');
