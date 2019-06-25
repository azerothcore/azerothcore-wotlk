-- Strings for AFH allerts
DELETE FROM `trinity_string` where `entry` IN (6621, 6622);
INSERT INTO `trinity_string` (`entry`, `content_default`) VALUES ('6621', 'AntiCheat: DoubleJump Detected for %s');
INSERT INTO `trinity_string` (`entry`, `content_default`) VALUES ('6622', 'AntiCheat: Fake Jumper Detected for %s');