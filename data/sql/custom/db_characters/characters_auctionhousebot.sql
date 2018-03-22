DROP TABLE IF EXISTS `ahbot_history`;
DROP TABLE IF EXISTS `ahbot_category`;
DROP TABLE IF EXISTS `ahbot_price`;

CREATE TABLE `ahbot_history` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `buytime` int(20) NOT NULL,
  `item` int(20) NOT NULL,
  `bid` int(20) NOT NULL,
  `buyout` int(20) NOT NULL,
  `won` int(20) NOT NULL,
  `category` varchar(45) DEFAULT NULL,
  `auction_house` int(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `won` (`won`),
  KEY `category` (`category`),
  KEY `auction_house` (`auction_house`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ahbot_category` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `category` varchar(45) DEFAULT NULL,
  `multiplier` decimal(20, 2) NOT NULL,
  `max_auction_count` int(20) NOT NULL,
  `expire_time` int(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `helper` (`category`, `multiplier`, `expire_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ahbot_price` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `item` varchar(45) DEFAULT NULL,
  `price` decimal(20, 2) NOT NULL,
  `auction_house` int(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ahbot_price_item` (`item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
