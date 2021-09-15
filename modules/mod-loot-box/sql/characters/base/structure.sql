-- Put only sql structure in this file (create table if exists, delete table, alter table etc...).
-- If you don't use this database, then delete this file.

CREATE TABLE IF NOT EXISTS `lootbox` (
    `id` SERIAL PRIMARY KEY,
    `player` BIGINT,
    `item` BIGINT,
    `rarity` TINYINT,
    `banner` TINYINT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;