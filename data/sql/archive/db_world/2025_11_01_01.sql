-- DB update 2025_11_01_00 -> 2025_11_01_01
-- GO_TRIBUNAL_ACCESS_DOOR
UPDATE `gameobject` SET `state` = 0 WHERE `id` = 191295 AND `map` = 599;
