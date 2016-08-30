REVOKE ALL PRIVILEGES ON * . * FROM 'acore'@'localhost';

REVOKE ALL PRIVILEGES ON `world` . * FROM 'acore'@'localhost';

REVOKE GRANT OPTION ON `world` . * FROM 'acore'@'localhost';

REVOKE ALL PRIVILEGES ON `characters` . * FROM 'acore'@'localhost';

REVOKE GRANT OPTION ON `characters` . * FROM 'acore'@'localhost';

REVOKE ALL PRIVILEGES ON `auth` . * FROM 'acore'@'localhost';

REVOKE GRANT OPTION ON `auth` . * FROM 'acore'@'localhost';

DROP USER 'acore'@'localhost';

DROP DATABASE IF EXISTS `world`;

DROP DATABASE IF EXISTS `characters`;

DROP DATABASE IF EXISTS `auth`;
