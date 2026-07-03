SET @MAX_LIMIT = 1;
SET @CHANCE = 0;
SET @RESPAWN = 3600;

SET @POOL_ME = 11665;
SET @POOL_BP = 11666;
SET @POOL_JL = 11667;
SET @POOL_FM = 11668;
SET @POOL_FE = 11669;

DELETE FROM `pool_template` WHERE `entry` IN (@POOL_ME, @POOL_BP, @POOL_JL, @POOL_FM, @POOL_FE);

DELETE FROM `pool_gameobject` WHERE `guid` IN (33616,26234,26978,85756,85879,85745,26916,26895,87390,85746,30950,85770,26865,85747,34032);

DELETE FROM `acore_characters`.`gameobject_respawn` WHERE `guid` IN (33616,26234,26978,85756,85879,85745,26916,26895,87390,85746,30950,85770,26865,85747,34032);

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOL_ME, @MAX_LIMIT, 'Battered Chests - Murloc Encampment near Goldshire'),
(@POOL_BP, @MAX_LIMIT, 'Battered Chests - Brackwell Pumpkin Patch'),
(@POOL_JL, @MAX_LIMIT, 'Battered Chests - Jerods Landing'),
(@POOL_FM, @MAX_LIMIT, 'Battered Chests - Fargodeep Mine Entrance'),
(@POOL_FE, @MAX_LIMIT, 'Battered Chests - Forests Edge');

INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(33616, @POOL_ME, @CHANCE, 'Battered Chest - Murloc Encampment, Node 1'),
(26234, @POOL_ME, @CHANCE, 'Battered Chest - Murloc Encampment, Node 2'),
(26978, @POOL_ME, @CHANCE, 'Battered Chest - Murloc Encampment, Node 3'),
(85756, @POOL_BP, @CHANCE, 'Battered Chest - Brackwell Pumpkin Patch, Node 1'),
(85879, @POOL_BP, @CHANCE, 'Battered Chest - Brackwell Pumpkin Patch, Node 2'),
(85745, @POOL_BP, @CHANCE, 'Battered Chest - Brackwell Pumpkin Patch, Node 3'),
(26916, @POOL_BP, @CHANCE, 'Battered Chest - Brackwell Pumpkin Patch, Node 4'),
(26895, @POOL_JL, @CHANCE, 'Battered Chest - Jerods Landing, Node 1'),
(87390, @POOL_JL, @CHANCE, 'Battered Chest - Jerods Landing, Node 2'),
(85746, @POOL_JL, @CHANCE, 'Battered Chest - Jerods Landing, Node 3'),
(30950, @POOL_FM, @CHANCE, 'Battered Chest - Fargodeep Mine, Node 1'),
(85770, @POOL_FM, @CHANCE, 'Battered Chest - Fargodeep Mine, Node 2'),
(26865, @POOL_FE, @CHANCE, 'Battered Chest - Forests Edge, Node 1'),
(85747, @POOL_FE, @CHANCE, 'Battered Chest - Forests Edge, Node 2'),
(34032, @POOL_FE, @CHANCE, 'Battered Chest - Forests Edge, Node 3');

UPDATE `gameobject` SET `spawntimesecs` = @RESPAWN WHERE `guid` IN (33616,26234,26978,85756,85879,85745,26916,26895,87390,85746,30950,85770,26865,85747,34032);
