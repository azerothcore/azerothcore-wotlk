ALTER TABLE world_db_version CHANGE COLUMN 2016_08_14_01 2016_08_14_02 bit;

DELETE FROM `trinity_string` WHERE `entry`IN (1334, 1335);
INSERT INTO `trinity_string` (`entry`, `content_default`) VALUES
(1334, 'Your ticket has been closed.'),
(1335, 'You received a ticket response.');
