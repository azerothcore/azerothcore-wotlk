REVOKE ALL PRIVILEGES ON * . * FROM 'azerothcore'@'localhost';

REVOKE ALL PRIVILEGES ON `world` . * FROM 'azerothcore'@'localhost';

REVOKE GRANT OPTION ON `world` . * FROM 'azerothcore'@'localhost';

REVOKE ALL PRIVILEGES ON `characters` . * FROM 'azerothcore'@'localhost';

REVOKE GRANT OPTION ON `characters` . * FROM 'azerothcore'@'localhost';

REVOKE ALL PRIVILEGES ON `auth` . * FROM 'azerothcore'@'localhost';

REVOKE GRANT OPTION ON `auth` . * FROM 'azerothcore'@'localhost';

DROP USER 'azerothcore'@'localhost';

DROP DATABASE IF EXISTS `world`;

DROP DATABASE IF EXISTS `characters`;

DROP DATABASE IF EXISTS `auth`;
