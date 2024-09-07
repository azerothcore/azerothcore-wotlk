--
DROP TABLE IF EXISTS `vehicle_seat_addon`;
CREATE TABLE `vehicle_seat_addon` (
  `SeatEntry` INT(4) UNSIGNED NOT NULL COMMENT 'VehicleSeatEntry.dbc identifier',
  `SeatOrientation` FLOAT(6) DEFAULT 0 COMMENT 'Seat Orientation override value',
  `ExitParamX` FLOAT(10) DEFAULT 0,
  `ExitParamY` FLOAT(10) DEFAULT 0,
  `ExitParamZ` FLOAT(10) DEFAULT 0,
  `ExitParamO` FLOAT(10) DEFAULT 0,
  `ExitParamValue` TINYINT(1) DEFAULT 0,
  PRIMARY KEY (`SeatEntry`)
);

INSERT INTO vehicle_seat_addon
(SeatEntry, SeatOrientation, ExitParamX, ExitParamY, ExitParamZ, ExitParamO, ExitParamValue)
VALUES(861, 0.0, -2.0, 2.0, 0.0, 0.0, 1);
INSERT INTO vehicle_seat_addon
(SeatEntry, SeatOrientation, ExitParamX, ExitParamY, ExitParamZ, ExitParamO, ExitParamValue)
VALUES(862, 0.0, -2.0, 3.0, 0.0, 0.0, 1);
INSERT INTO vehicle_seat_addon
(SeatEntry, SeatOrientation, ExitParamX, ExitParamY, ExitParamZ, ExitParamO, ExitParamValue)
VALUES(2726, 0.0, 2803.32, 7051.41, 5.36291, 4.73481, 2);
INSERT INTO vehicle_seat_addon
(SeatEntry, SeatOrientation, ExitParamX, ExitParamY, ExitParamZ, ExitParamO, ExitParamValue)
VALUES(2727, 0.0, 2801.48, 7051.38, 5.36291, 4.73481, 2);
INSERT INTO vehicle_seat_addon
(SeatEntry, SeatOrientation, ExitParamX, ExitParamY, ExitParamZ, ExitParamO, ExitParamValue)
VALUES(2728, 0.0, 2801.17, 7046.47, 5.36201, 4.73481, 2);
INSERT INTO vehicle_seat_addon
(SeatEntry, SeatOrientation, ExitParamX, ExitParamY, ExitParamZ, ExitParamO, ExitParamValue)
VALUES(2729, 0.0, 2803.73, 7046.52, 5.36201, 4.73481, 2);
INSERT INTO vehicle_seat_addon
(SeatEntry, SeatOrientation, ExitParamX, ExitParamY, ExitParamZ, ExitParamO, ExitParamValue)
VALUES(2730, 0.0, 2807.86, 7038.57, 7.07581, 4.73481, 2);
INSERT INTO vehicle_seat_addon
(SeatEntry, SeatOrientation, ExitParamX, ExitParamY, ExitParamZ, ExitParamO, ExitParamValue)
VALUES(2764, 0.0, -2.0, 2.0, 0.0, 0.0, 1);
INSERT INTO vehicle_seat_addon
(SeatEntry, SeatOrientation, ExitParamX, ExitParamY, ExitParamZ, ExitParamO, ExitParamValue)
VALUES(2765, 0.0, -2.0, -2.0, 0.0, 0.0, 1);
INSERT INTO vehicle_seat_addon
(SeatEntry, SeatOrientation, ExitParamX, ExitParamY, ExitParamZ, ExitParamO, ExitParamValue)
VALUES(2767, 0.0, -2.0, 2.0, 0.0, 0.0, 1);
INSERT INTO vehicle_seat_addon
(SeatEntry, SeatOrientation, ExitParamX, ExitParamY, ExitParamZ, ExitParamO, ExitParamValue)
VALUES(2768, 0.0, -2.0, -2.0, 0.0, 0.0, 1);
INSERT INTO vehicle_seat_addon
(SeatEntry, SeatOrientation, ExitParamX, ExitParamY, ExitParamZ, ExitParamO, ExitParamValue)
VALUES(6446, 0.0, -1.0, 4.0, 3.0, 0.0, 1);
INSERT INTO vehicle_seat_addon
(SeatEntry, SeatOrientation, ExitParamX, ExitParamY, ExitParamZ, ExitParamO, ExitParamValue)
VALUES(6447, 0.0, 1.0, 4.0, 3.0, 0.0, 1);
INSERT INTO vehicle_seat_addon
(SeatEntry, SeatOrientation, ExitParamX, ExitParamY, ExitParamZ, ExitParamO, ExitParamValue)
VALUES(7326, 0.0, -1.0, 4.0, 3.0, 0.0, 1);
INSERT INTO vehicle_seat_addon
(SeatEntry, SeatOrientation, ExitParamX, ExitParamY, ExitParamZ, ExitParamO, ExitParamValue)
VALUES(7327, 0.0, 1.0, 4.0, 3.0, 0.0, 1);
INSERT INTO vehicle_seat_addon
(SeatEntry, SeatOrientation, ExitParamX, ExitParamY, ExitParamZ, ExitParamO, ExitParamValue)
VALUES(7328, 0.0, -1.0, 4.0, 3.0, 0.0, 1);
INSERT INTO vehicle_seat_addon
(SeatEntry, SeatOrientation, ExitParamX, ExitParamY, ExitParamZ, ExitParamO, ExitParamValue)
VALUES(7329, 0.0, 1.0, 4.0, 3.0, 0.0, 1);
