GRANT USAGE ON * . * TO 'acore'@'localhost' IDENTIFIED BY 'acore' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 ;

CREATE DATABASE `acore_world` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE DATABASE `acore_worldcharacters` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE DATABASE `acore_worldauth` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

GRANT ALL PRIVILEGES ON `acore_worldworld` . * TO 'acore'@'localhost' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON `acore_worldcharacters` . * TO 'acore'@'localhost' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON `acore_worldauth` . * TO 'acore'@'localhost' WITH GRANT OPTION;
