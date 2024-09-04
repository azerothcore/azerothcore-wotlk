SET @STRING_ENTRY := 11120;
DELETE FROM `acore_string` WHERE `entry` IN  (@STRING_ENTRY+0,@STRING_ENTRY+1,@STRING_ENTRY+2);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(@STRING_ENTRY+0, 'Your experience rates were set to {}.'),
(@STRING_ENTRY+1, 'Wrong value specified. Please specify a value between 0 and {}'),
(@STRING_ENTRY+2, 'The rate being applied to you is {}.\nThe current weekendxp configuration is:\nAnnounce {}\nAlwaysEnabled {}\nQuestOnly {}\nMaxLevel {}\nxpAmount {}\nIndividualXPEnabled {}\nEnabled {}\nMaxAllowedRate {}');

DELETE FROM `command` WHERE `name` IN ('weekendxp rate');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('weekendxp rate', 0, 'Syntax: weekendxp rate $value \nSet your experience rate up to the allowed value.');

DELETE FROM `command` WHERE `name` IN ('weekendxp config');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('weekendxp config', 0, 'Syntax: weekendxp config\nDisplays the current configuration for the weekendxp mod.');
