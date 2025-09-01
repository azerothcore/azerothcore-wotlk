-- DB update 2023_10_10_07 -> 2023_10_10_08
-- Plague Wagon Empty
DELETE FROM `gameobject` WHERE `guid`=242285;
DELETE FROM `game_event_gameobject` WHERE `guid`=242285;
