INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1561816769087112416');

-- Only one game object "Saronite", pool entry is not needed
DELETE FROM `pool_gameobject` WHERE `pool_entry` = 5217;

-- Only one creature "Hematos" (8976), pool entry is not needed
DELETE FROM `pool_creature` WHERE `pool_entry` = 1047;

-- Add missing Saronite nodes to pool template
DELETE FROM `pool_template` WHERE `entry` IN (5450,5506,5608,5517);
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`)
VALUES
(5450,1,'Icecrown 189980, node 3'),
(5506,1,'Icecrown 189980, node 59'),
(5608,1,'Icecrown 189980, node 161'),
(5517,1,'Icecrown 189981, node 70');
