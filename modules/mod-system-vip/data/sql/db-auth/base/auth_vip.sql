DROP TABLE IF EXISTS `account_vip`;

CREATE TABLE `account_vip` (
  `id` int(11) NOT NULL DEFAULT '0',
  `subscription_date` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `account_vip_teleport`;

CREATE TABLE `account_vip_teleport` (
  `id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `mapId` int(11) NOT NULL DEFAULT '0',
  `coord_x` float NOT NULL DEFAULT '0',
  `coord_y` float NOT NULL DEFAULT '0',
  `coord_z` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;