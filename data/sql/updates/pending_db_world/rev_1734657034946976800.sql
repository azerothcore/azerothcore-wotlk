--
DELETE FROM `acore_string` WHERE `entry` IN (35410, 35411);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(35410, 'Please move to the Dungeon: {}.'),
(35411, 'No dungeon name found!');
