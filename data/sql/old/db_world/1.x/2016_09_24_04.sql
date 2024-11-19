-- DB update 2016_09_24_03 -> 2016_09_24_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2016_09_24_03 2016_09_24_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1474716815295101300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world(`sql_rev`) VALUES ('1474716815295101300');

DELETE FROM waypoints WHERE entry = 33519;

UPDATE smart_scripts SET event_param1=44 WHERE entryorguid=33519 AND source_type=0 AND id=2;

INSERT INTO waypoints (entry, pointid, position_x, position_y, position_z, point_comment) VALUES
(33519, 1, 8526.23, 567.717, 552.608, 'Black Knight Gryphon WP1'),
(33519, 2, 8529.65, 561.457, 553.146, 'Black Knight Gryphon WP2'),
(33519, 3, 8560.83, 564.063, 560.969, 'Black Knight Gryphon WP3'),
(33519, 4, 8618.12, 597.455, 555.925, 'Black Knight Gryphon WP4'),
(33519, 5, 8656.04, 624.922, 552.328, 'Black Knight Gryphon WP5'),
(33519, 6, 8680.42, 660.062, 549.031, 'Black Knight Gryphon WP6'),
(33519, 7, 8698.54, 705.598, 548.933, 'Black Knight Gryphon WP7'),
(33519, 8, 8715.51, 748.276, 549.854, 'Black Knight Gryphon WP8'),
(33519, 9, 8740.09, 810.067, 549.854, 'Black Knight Gryphon WP9'),
(33519, 10, 8764.67, 871.858, 549.854, 'Black Knight Gryphon WP10'),
(33519, 11, 8796.18, 959.072, 518.157, 'Black Knight Gryphon WP11'),
(33519, 12, 8815.05, 1018.42, 468.263, 'Black Knight Gryphon WP12'),
(33519, 13, 8833.93, 1077.77, 418.369, 'Black Knight Gryphon WP13'),
(33519, 14, 8843.37, 1107.45, 393.422, 'Black Knight Gryphon WP14'),
(33519, 15, 8852.8, 1137.12, 368.474, 'Black Knight Gryphon WP15'),
(33519, 16, 8887.41, 1245.93, 277.002, 'Black Knight Gryphon WP16'),
(33519, 17, 8899.99, 1285.49, 243.739, 'Black Knight Gryphon WP17'),
(33519, 18, 8917.19, 1344.25, 206.989, 'Black Knight Gryphon WP18'),
(33519, 19, 8935.65, 1428.33, 171.939, 'Black Knight Gryphon WP19'),
(33519, 20, 8952.14, 1502.28, 152.627, 'Black Knight Gryphon WP20'),
(33519, 21, 8977.58, 1604.01, 134.608, 'Black Knight Gryphon WP21'),
(33519, 22, 8999.84, 1693.02, 118.842, 'Black Knight Gryphon WP22'),
(33519, 23, 9009.38, 1731.17, 112.085, 'Black Knight Gryphon WP23'),
(33519, 24, 9016.45, 1757.73, 107.355, 'Black Knight Gryphon WP24'),
(33519, 25, 9042.43, 1803.28, 98.3457, 'Black Knight Gryphon WP25'),
(33519, 26, 9068.41, 1848.82, 89.3364, 'Black Knight Gryphon WP26'),
(33519, 27, 9095.58, 1894.97, 73.9581, 'Black Knight Gryphon WP27'),
(33519, 28, 9113.08, 1951.09, 61.4356, 'Black Knight Gryphon WP28'),
(33519, 29, 9120.62, 1988.22, 68.3712, 'Black Knight Gryphon WP29'),
(33519, 30, 9126.46, 2030.88, 76.7076, 'Black Knight Gryphon WP30'),
(33519, 31, 9125.28, 2059.72, 71.875, 'Black Knight Gryphon WP31'),
(33519, 32, 9123.38, 2100.16, 76.8306, 'Black Knight Gryphon WP32'),
(33519, 33, 9121.33, 2132.18, 70.2638, 'Black Knight Gryphon WP33'),
(33519, 34, 9095.69, 2181.88, 58.6374, 'Black Knight Gryphon WP34'),
(33519, 35, 9076.85, 2189.14, 54.3544, 'Black Knight Gryphon WP35'),
(33519, 36, 9036.74, 2180.53, 57.0958, 'Black Knight Gryphon WP36'),
(33519, 37, 9031.46, 2161.92, 58.3603, 'Black Knight Gryphon WP37'),
(33519, 38, 9043.38, 2134.61, 60.2847, 'Black Knight Gryphon WP38'),
(33519, 39, 9058.39, 2101.61, 62.2349, 'Black Knight Gryphon WP39'),
(33519, 40, 9061.58, 2094.73, 64.1907, 'Black Knight Gryphon WP40'),
(33519, 41, 9061.58, 2094.73, 64.1907, 'Black Knight Gryphon WP41'),
(33519, 42, 9066.5, 2084.15, 66.2016, 'Black Knight Gryphon WP42'),
(33519, 43, 9068.36, 2080.14, 66.9176, 'Black Knight Gryphon WP43'),
(33519, 44, 9069.15, 2078.45, 66.99, 'Black Knight Gryphon WP44');
--
-- END UPDATING QUERIES
--
COMMIT;
END;
//
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
