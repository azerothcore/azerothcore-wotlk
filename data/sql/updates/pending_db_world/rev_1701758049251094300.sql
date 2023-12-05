--
DELETE FROM `pool_template` WHERE `entry` = 137;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (137, 1, 'Tanaris - Inconspicuous Landmark Pool');

UPDATE `pool_gameobject` SET `pool_entry` = 137 WHERE `guid` IN (17231,17232,17233,17234,17235,17236);
