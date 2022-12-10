REVOKE ALL PRIVILEGES ON * . * FROM 'acore'@'localhost';

REVOKE ALL PRIVILEGES ON `acore_world` . * FROM 'acore'@'localhost';

REVOKE GRANT OPTION ON `acore_world` . * FROM 'acore'@'localhost';

REVOKE ALL PRIVILEGES ON `acore_characters` . * FROM 'acore'@'localhost';

REVOKE GRANT OPTION ON `acore_characters` . * FROM 'acore'@'localhost';

REVOKE ALL PRIVILEGES ON `acore_auth` . * FROM 'acore'@'localhost';

REVOKE GRANT OPTION ON `acore_auth` . * FROM 'acore'@'localhost';

DROP USER 'acore'@'localhost';

DROP DATABASE IF EXISTS `acore_world`;

DROP DATABASE IF EXISTS `acore_characters`;

DROP DATABASE IF EXISTS `acore_auth`;
