CREATE TABLE IF NOT EXISTS `crossfaction_disable` (
  `id` INT(10) NOT NULL COMMENT 'could be Map, Zone, Area, depending on type field',
  `type` INT(10) NOT NULL COMMENT '1 = MAP - 2 = ZONE - 3 = AREA'
) ENGINE=INNODB DEFAULT CHARSET=utf8;

INSERT INTO `crossfaction_disable` VALUES 
(3557,2), -- The Exodar    
(1519,2), -- Stormwind City 
(1537,2), -- Ironforge
(1657,2), -- Darnassus
(1637,2), -- Orgrimmar
(1638,2), -- Thunder Bluff
(1497,2), -- Undercity
(3487,2); -- Silvermoon City
-- (3703,2), -- Shattrath
-- (4395,2); -- Dalaran
