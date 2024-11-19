-- DB update 2024_02_03_05 -> 2024_02_03_06
-- Midsummer - disable unrelated debris spawns in front of the Exodar
DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 1) AND (`guid` IN (SELECT `guid` from `gameobject` WHERE `id` IN (180698, 180699, 180700)));
