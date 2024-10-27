-- miscelleanous cleanups of 'Hallow's End' gameobject spawns
-- remove duplicate unrelated 'Keg' spawn
DELETE FROM `gameobject` WHERE (`id` = 180570)
AND (`guid` IN (39927));
DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 12)
AND (`guid` IN (39927));

-- unlink unrelated 'Candle0x' spawns
DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 12)
AND (`guid` IN (77918, 77919));

-- cleanup double / stacked spawns in 'Brill' where just the z position differs
-- probably caused due to parsing errors
DELETE FROM `gameobject` WHERE (`id` IN (180405, 180406, 180407, 180411, 180426))
AND (`guid` IN (2588, 15827, 15828, 15830, 15832, 15834, 15836, 15838, 15840, 15842, 36326, 68350, 68351, 68354, 68656, 68658, 68659));

DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 12)
AND (`guid` IN (2588, 15827, 15828, 15830, 15832, 15834, 15836, 15838, 15840, 15842, 36326, 68350, 68351, 68354, 68656, 68658, 68659));
