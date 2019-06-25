-- Strings for Fake flying mode
DELETE FROM `trinity_string` where `entry` IN (6624);
INSERT INTO `trinity_string` (`entry`, `content_default`) VALUES ('6624', 'AntiCheat: Wallclimb Detected for %s, diffZ = %f, distance = %f, angle = %f ');