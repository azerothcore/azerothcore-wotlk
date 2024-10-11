-- DB update 2022_06_14_01 -> 2022_06_14_02
--
UPDATE `spell_target_position` SET `PositionX`=-11688.5, `PositionY`=-1737.74, `PositionZ`=8.409842 WHERE `id` IN (24325, 24593);
DELETE FROM `event_scripts` WHERE `id`=9104;

DELETE FROM `spell_script_names` WHERE `spell_id`=24325;
INSERT INTO `spell_script_names` VALUES
(24325, 'spell_pagles_point_cast');

DELETE FROM `waypoint_data` WHERE `id`=151140;
INSERT INTO `waypoint_data`  VALUES
(151140,1,-11697.263,-1759.001,10.364448,0,0,0,0,100,0),
(151140,2,-11689.899,-1776.087,12.593142,6.098,0,0,0,100,0);
