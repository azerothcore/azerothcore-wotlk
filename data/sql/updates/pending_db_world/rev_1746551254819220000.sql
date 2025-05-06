--
DELETE FROM `command` WHERE `name`='formation';
INSERT INTO `command` VALUES ('formation', 2, 'Syntax: .formation #leaderGUID #groupAI\r\n\r\nCreate a formation of selected target with #leaderGUID and #groupAI as flags.');

DELETE FROM `acore_string` WHERE `entry` IN (376,377);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(376, 'Formation created!'),
(377, 'Formation could not be created. Check your syntax or select a target.');
