DROP TABLE IF EXISTS `crossfaction_disable`;
CREATE TABLE `crossfaction_disable` (
  `id` int(10) NOT NULL COMMENT 'could be Map, Zone, Area, depending on type field',
  `type` int(10) NOT NULL COMMENT '1 = MAP - 2 = ZONE - 3 = AREA'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
