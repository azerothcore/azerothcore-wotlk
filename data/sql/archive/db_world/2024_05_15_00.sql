-- DB update 2024_05_14_02 -> 2024_05_15_00
-- clear all gameobjects in map 30 "Alterac Valley"
-- these will be spawned in the bg script
DELETE FROM `gameobject` WHERE `map` = 30;
