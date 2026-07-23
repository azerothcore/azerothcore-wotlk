-- DB update 2026_07_23_00 -> 2026_07_23_01
--
DELETE FROM `vehicle_template_accessory` WHERE `entry` = 32930;
INSERT INTO `vehicle_template_accessory` (`entry`, `accessory_entry`, `seat_id`, `minion`, `description`, `summontype`, `summontimer`) VALUES
(32930, 32933, 0, 1, 'Kologarn', 8, 0),
(32930, 32934, 1, 1, 'Kologarn', 8, 0);
