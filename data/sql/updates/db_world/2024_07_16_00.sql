-- DB update 2024_07_15_00 -> 2024_07_16_00
--
DELETE FROM `acore_string` WHERE `entry` IN (2031,2032);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(2031, '|cff00ff00Response Appended|r:|cff00ccff [%s]|r'),
(2032, '|cff00ff00Response deleted by|r:|cff00ccff %s|r');

UPDATE `command` SET `help` = 'Add a response to a new line.\n\nSyntax: ticket response appendln $ticketId $response' WHERE `name` = 'ticket response appendln';
UPDATE `command` SET `help` = 'Add a response\n\nSyntax: ticket response append $ticketId $response' WHERE `name` = 'ticket response append';

DELETE FROM `command` WHERE `name` = 'ticket response delete';
DELETE FROM `command` WHERE `name` = 'ticket response show';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('ticket response delete', 2, 'Delete a ticket response\n\nSyntax: ticket response delete $ticketId'),
('ticket response show', 2, 'Show a ticket response\n\nSyntax: ticket response show $ticketId');
