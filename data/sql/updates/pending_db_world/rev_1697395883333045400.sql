-- Add 3 missing Midsummer Music Doodad
DELETE FROM `gameobject` WHERE `guid` IN (50554, 50553, 50552);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES 
(50554, 188174, 0, -8836.6, 866.36, 98.7168, 2.09439, 0.866025, 0.500001, 180, 100, 1),
(50553, 188174, 530, 9794.82, -7248.74, 26.0974, 3.68265, 0.96363, -0.267241, 180, 100, 1),
(50552, 188174, 530, -3798.69, -11509, -134.821, 5.06146, 0.573576, -0.819152, 180, 100, 1);

DELETE FROM `game_event_gameobject` WHERE `eventEntry` = 1 AND `guid` IN (50552, 50553, 50554);
INSERT INTO `game_event_gameobject` (`eventEntry`,`guid`) VALUES
(1, 50552),
(1, 50553),
(1, 50554);
