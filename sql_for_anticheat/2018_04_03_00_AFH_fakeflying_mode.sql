-- Strings for Fake flying mode
DELETE FROM `trinity_string` where `entry` IN (6623);
INSERT INTO `trinity_string` (`entry`, `content_default`) VALUES ('6623', 'AntiCheat: FakeFlying mode Detected for %s');