-- Strings for ASH + AFH allerts
DELETE FROM `trinity_string` where `entry` IN (6617, 6618, 6619, 6620);
INSERT INTO `trinity_string` (`entry`, `content_default`) VALUES ('6617', 'AntiCheat: SpeedHack Detected for %s, normal distance for this time and speed = %f, distance from packet = %f');
INSERT INTO `trinity_string` (`entry`, `content_default`) VALUES ('6618', 'AntiCheat: FlyHack Detected for %s , player can not fly');
INSERT INTO `trinity_string` (`entry`, `content_default`) VALUES ('6619', 'AntiCheat: FlyHack Detected for %s, player has Swimming flag, but not in water');
INSERT INTO `trinity_string` (`entry`, `content_default`) VALUES ('6620', 'AntiCheat: FlyHack Detected for %s');