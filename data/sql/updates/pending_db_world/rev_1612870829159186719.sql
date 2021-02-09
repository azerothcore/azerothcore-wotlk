INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612870829159186719');

-- Ras Frostwhisper movement

UPDATE `creature` SET `MovementType` = 2 WHERE `id` = 10508;

DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 10508);
UPDATE `creature_template_addon` SET `path_id` = 488500, `bytes2` = 4097 WHERE `entry` = 10508;
DELETE FROM `waypoint_data` WHERE `id` = 488500;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(488500,1,-22.732965,147.52971,83.90764,0,0,0,0,0,0),
(488500,2,-42.24653,147.56828,83.931465,0,0,0,0,0,0),
(488500,3,-42.204754,141.33911,83.93054,6.2831853072,90000,0,0,0,0),
(488500,4,-41.44412,134.91525,83.940956,0,0,0,0,0,0),
(488500,5,-22.852322,135.15367,83.90838,0,0,0,0,0,0),
(488500,6,-22.853083,141.41121,83.90816,0,0,0,0,0,0),
(488500,7,-25.107857,141.28365,83.91359,0.03490658476948738,75000,0,0,0,0);
