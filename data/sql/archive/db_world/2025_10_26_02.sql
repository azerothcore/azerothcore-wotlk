-- DB update 2025_10_26_01 -> 2025_10_26_02
-- `point`s had gaps causing core code needing to be extra complicated
UPDATE `waypoint_data` SET `point`=1 WHERE `id`=1336190 AND `point`=2 AND `action`=1336191;
UPDATE `waypoint_data` SET `point`=2 WHERE `id`=1336190 AND `point`=4 AND `action`=1336192;
UPDATE `waypoint_data` SET `point`=3 WHERE `id`=1336190 AND `point`=6 AND `action`=1336192;

UPDATE `waypoint_data` SET `point`=`point`-1 WHERE `id`=795240 AND `point`>4;

UPDATE `waypoint_data` SET `point`=`point`-1 WHERE `id`=497520 AND `point`>21;
UPDATE `waypoint_data` SET `point`=`point`-1 WHERE `id`=497520 AND `point`>33;

UPDATE `waypoint_data` SET `point`=`point`-15 WHERE `id`=1873101 AND `point`>0;
UPDATE `waypoint_data` SET `point`=`point`-1 WHERE `id`=1873101 AND `point`>5;

UPDATE `waypoint_data` SET `point`=`point`-1 WHERE `id`=1110490 AND `point`>187;
