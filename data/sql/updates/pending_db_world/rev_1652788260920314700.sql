-- Name: Blackrock Drake
-- Entry: 8964

-- Not sniffed waypoint_data, temp fix
DELETE FROM `waypoint_data` WHERE `id` IN (33430, 33440);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `move_type`) VALUES 
(33430, 1, -7551.270020, -1197.180664, 303.952026, 0.654515, 2),
(33430, 2, -7508.760254, -1148.814209, 304.232971, 0.862646, 2),
(33430, 3, -7510.151855, -1095.706421, 304.882050, 1.596993, 2),
(33430, 4, -7543.525391, -1034.990845, 304.181732, 2.421662, 2),
(33430, 5, -7599.916016, -1024.026489, 301.400848, 3.446607, 2),
(33430, 6, -7652.217773, -1048.178467, 279.493805, 3.902138, 2),
(33430, 7, -7683.442871, -1098.987427, 274.503876, 4.259488, 2),
(33430, 8, -7672.438965, -1141.654419, 290.900818, 5.143041, 2),
(33430, 9, -7607.541016, -1206.215820, 290.179840, 5.779202, 2),
(33440, 1, -7599.916016, -1024.026489, 301.400848, 3.446607, 2),
(33440, 2, -7652.217773, -1048.178467, 279.493805, 3.902138, 2),
(33440, 3, -7683.442871, -1098.987427, 274.503876, 4.259488, 2),
(33440, 4, -7672.438965, -1141.654419, 290.900818, 5.143041, 2),
(33440, 5, -7607.541016, -1206.215820, 290.179840, 5.779202, 2),
(33440, 6, -7551.270020, -1197.180664, 303.952026, 0.654515, 2),
(33440, 7, -7508.760254, -1148.814209, 304.232971, 0.862646, 2),
(33440, 8, -7510.151855, -1095.706421, 304.882050, 1.596993, 2),
(33440, 9, -7543.525391, -1034.990845, 304.181732, 2.421662, 2);

UPDATE `creature_template` SET `MovementType` = 2, `speed_walk` = 1, `speed_run` = 2.85714, `speed_flight` = 2.85714 WHERE `entry` = 8964;

-- Update their zone and area ids
UPDATE `creature` SET `zoneId` = 25, `areaId` = 25 WHERE `guid` IN(3343, 3344);

-- Update their visibility to avoid them lapping on bad directions
UPDATE `creature_addon` SET `visibilityDistanceType` = 1 WHERE `guid` IN (3343, 3344);

-- Change spawn place to cycle them on oposite directions
UPDATE `creature` SET `position_x`= -7599.916016, `position_y`= -1024.026489, `position_z`= 301.400848, `orientation`= 3.446607 WHERE `guid`= 3344;

DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 8964);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(8964, 0, 0, 2, 0, 0, 0, 0);
