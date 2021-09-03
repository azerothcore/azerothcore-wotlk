INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630682164924984301');

-- Removed one of the spawns of Razormaw Matriach's Nest because its on the same place as the guid 6245
DELETE FROM `gameobject` WHERE (`id` = 202083) AND (`guid` IN (14999));

-- Added the spawns to the same pool so only 1 can be spawned at the same time
DELETE FROM `pool_template` WHERE `entry` = 374;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`)  VALUES (374, 1, 'Razormaw Matriach''s Nest spawns');

DELETE FROM `pool_gameobject` WHERE `guid` IN (6245, 6246, 6247, 6248);
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES 
(6245, 374, 0, 'Razormaw Matriach''s Nest spawn 1'),
(6246, 374, 0, 'Razormaw Matriach''s Nest spawn 2'),
(6247, 374, 0, 'Razormaw Matriach''s Nest spawn 3'),
(6248, 374, 0, 'Razormaw Matriach''s Nest spawns 4');
