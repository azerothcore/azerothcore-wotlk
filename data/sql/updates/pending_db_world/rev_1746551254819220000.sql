--
DELETE FROM `command` WHERE `name`IN('dev','dev formation','dev badge');
INSERT INTO `command` VALUES
('dev', 3, 'Syntax: .dev $subcommand\r\n\r\Type .dev to see the list of possible subcommands or .help dev $subcommand to see info on subcommands.'),
('dev formation', 3, 'Syntax: .dev formation #leaderGUID #groupAI\r\n\r\nCreate a formation of selected target with #leaderGUID and #groupAI as flags.'),
('dev badge', 3, 'Syntax: .dev badge [on/off]\r\n\r\nEnable or Disable in game Dev tag or show current state if on/off not provided.');

DELETE FROM `acore_string` WHERE `entry` IN (376,377);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(376, 'Formation created!'),
(377, 'Formation could not be created. Check your syntax or select a target.');
