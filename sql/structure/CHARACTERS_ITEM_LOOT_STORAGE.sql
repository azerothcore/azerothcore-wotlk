
DROP TABLE IF EXISTS item_loot_items; -- TC SHIT
DROP TABLE IF EXISTS item_loot_money; -- TC SHIT
CREATE TABLE `item_loot_storage` (
  `containerGUID` int(10) unsigned NOT NULL,
  `itemid` int(10) unsigned NOT NULL,
  `count` int(10) unsigned NOT NULL,
  `randomPropertyId` int(10) NOT NULL,
  `randomSuffix` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

