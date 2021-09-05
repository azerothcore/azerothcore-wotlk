INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630488458384812200');

UPDATE `waypoint_data` SET `position_x`=-1388.755, `position_y`=-45.731, `position_z`=160.41 WHERE `id`=2083440 AND `point` IN (4,62);
UPDATE `waypoint_data` SET `position_x`=-1357.719, `position_y`=-10.463, `position_z`=142.40 WHERE `id`=2083440 AND `point` IN (5,61);
UPDATE `waypoint_data` SET `position_x`=-1331.005, `position_y`=18.9590, `position_z`=138.29 WHERE `id`=2083440 AND `point` IN (6,60);

UPDATE `creature_formations` SET `dist`=2 WHERE `leaderguid`=208344 AND `memberguid`=208349;
