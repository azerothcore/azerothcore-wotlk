-- DB update 2023_06_16_02 -> 2023_06_17_00
--
DELETE FROM `game_event_gameobject` WHERE `eventEntry` = 1 AND `guid` = 28242;
INSERT INTO `game_event_gameobject` (`eventEntry`,`guid`) VALUES (1, 28242);
