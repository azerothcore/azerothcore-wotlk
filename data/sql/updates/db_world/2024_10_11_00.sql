-- DB update 2024_10_10_00 -> 2024_10_11_00
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

DELETE FROM `vehicle_seat_addon` WHERE `SeatEntry` IN (2726, 2727, 2728, 2729, 2730, 1472, 1473, 1474, 1475, 1476, 2764, 2765, 2767, 2768, 6446, 6447, 7326, 7327, 7328, 7329, 861, 862, 1682, 2097, 2172, 2178, 2179, 2180, 3690, 3691, 3692, 3129, 2772, 2771);
INSERT INTO `vehicle_seat_addon` (`SeatEntry`, `SeatOrientation`, `ExitParamX`, `ExitParamY`, `ExitParamZ`, `ExitParamO`, `ExitParamValue`) VALUES
(2764, 0.0, -2.0, 2.0, 0.0, 0.0, 1), -- 312 Traveler's Tundra Mammoth
(2765, 0.0, -2.0, -2.0, 0.0, 0.0, 1), -- 312
(2767, 0.0, -2.0, 2.0, 0.0, 0.0, 1),  -- 313 Traveler's Tundra Mammoth
(2768, 0.0, -2.0, -2.0, 0.0, 0.0, 1),-- 313
(6446, 0.0, -1.0, 4.0, 3.0, 0.0, 1), -- 548 Stormwind Love Boat
(6447, 0.0, 1.0, 4.0, 3.0, 0.0, 1), -- 548
(7326, 0.0, -1.0, 4.0, 3.0, 0.0, 1), -- 615 Darnassus Love Boat
(7327, 0.0, 1.0, 4.0, 3.0, 0.0, 1), -- 615
(7328, 0.0, -1.0, 4.0, 3.0, 0.0, 1), -- 616 Undercity Love Boat
(7329, 0.0, 1.0, 4.0, 3.0, 0.0, 1), -- 616
(861, 0.0, -2.0, 2.0, 0.0, 0.0, 1), -- 51 Ducal's Horse
(862, 0.0, -2.0, 3.0, 0.0, 0.0, 1), -- 51
-- cmangos exclusive
(1682, 0.0, 6708.17, 5130.74, -19.388, 4.83608, 2), -- 118 Zeptek the Destroyer
(2097, 0.0, 12.0, 0.0, 4.0, 0.0, 1), -- 191 Gal'darah
(2172, 0.0, 40.0, 0.0, 0.0, 0.0, 1), -- 205 Gymer
(2178, 0.0, -3.3, 5.0, 0.0, 3.1326, 1), -- 209 Drakkari Rhino
(2179, 0.0, -5.9, -4.9, 0.0, 3.1326, 1), -- 209
(2180, 0.0, -7.9, 0.02, 0.0, 3.1326, 1), -- 209
-- acore exclusive
(3690, 0.0, 1776.0, -24.0, 448.75, 0.0, 2), -- 380 Kologarn right arm
(3691, 0.0, 1776.0, -24.0, 448.75, 0.0, 2), -- 380
(3692, 0.0, 1776.0, -24.0, 448.75, 0.0, 2), -- 380
(3129, 0.0, 0.0, -2.0, 0.0, 0.0, 1), -- 349 AT Mounts, dismount to the right
(2772, 0.0, -2.0, 2.0, 0.0, 0.0, 1), -- 315 Grand Ice Mammoth, Grand Black War Mammoth
(2771, 0.0, -2.0, -2.0, 0.0, 0.0, 1), -- 315
-- Helmsman's coords are different on acore
(1472, 0.0, 2802.18, 7054.91, -0.6, 4.67, 2), -- 91 The Helmsman's Ship
(1473, 0.0, 2802.18, 7054.91, -0.6, 4.67, 2), -- 91
(1474, 0.0, 2802.18, 7054.91, -0.6, 4.67, 2), -- 91
(1475, 0.0, 2802.18, 7054.91, -0.6, 4.67, 2), -- 91
(1476, 0.0, 2802.18, 7054.91, -0.6, 4.67, 2);
