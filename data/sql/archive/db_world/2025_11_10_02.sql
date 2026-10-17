-- DB update 2025_11_10_01 -> 2025_11_10_02
--
DELETE FROM `game_event_gameobject` WHERE `eventEntry`=1 AND `guid`=5;
INSERT INTO `game_event_gameobject` (`eventEntry`, `guid`) VALUES(1, 5);
