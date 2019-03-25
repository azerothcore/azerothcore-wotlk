INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1552751401332509400');

-- Delete old
DELETE FROM `trinity_string` WHERE `entry` IN (11002, 11003, 11004, 11005, 11006, 11007, 11017, 11018);

-- Add rus and replace eng
INSERT INTO `trinity_string`(`entry`, `content_default`, `content_loc8`) VALUES
(11002, 'Server: %s has kicked %s, reason: %s', 'Server: %s кикнул %s, причина: %s'),
(11003, 'Server: %s has muted %s for %u minutes, reason: %s', 'Server: %s замутил %s на %u минут, причина: %s'),
(11004, 'Server: %s has banned character %s for %s, reason: %s', 'Server: %s забанил персонажа %s на %s, причина: %s'),
(11005, 'Server: %s has banned character %s permanetly, reason: %s', 'Server: %s забанил персонажа %s permanetly, reason: %s'),
(11006, 'Server: %s has banned account %s for %s, reason: %s', 'Server: %s забанил аккаунт %s на %s, причина: %s'),
(11007, 'Server: %s has banned account %s permanetly, reason: %s', 'Server: %s забанил аккаунт %s навсегда, причина: %s'),
(11017, 'Server: %s has banned ip %s for %s, reason: %s', 'Server: %s забанил айпи %s на %s, причина: %s'),
(11018, 'Server: %s has banned ip %s permanetly, reason: %s', 'Server: %s забанил айпи %s навсегда, причина: %s');
