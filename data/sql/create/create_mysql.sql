GRANT USAGE ON * . * TO 'acore'@'localhost' IDENTIFIED BY 'acore' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 ;

CREATE DATABASE `acore_world` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE DATABASE `acore_characters` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE DATABASE `acore_auth` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

GRANT ALL PRIVILEGES ON `acore_world` . * TO 'acore'@'localhost' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON `acore_characters` . * TO 'acore'@'localhost' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON `acore_auth` . * TO 'acore'@'localhost' WITH GRANT OPTION;
