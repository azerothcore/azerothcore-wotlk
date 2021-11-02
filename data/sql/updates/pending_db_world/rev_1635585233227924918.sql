INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635585233227924918');

-- Removes 25 incorrect items from Mithril Lockbox
DELETE FROM `item_loot_template` where `entry` = 5758 and `item` IN (785, 1645, 2319, 2449, 2450, 3356, 3357, 3858, 3927, 4234, 4338, 4339, 4419, 4426, 4607, 6149, 7912, 7974, 8932, 8950, 8953, 9030, 11914, 11948, 13446);

