-- DB update 2026_11_03_03 -> 2026_11_03_04
--
DELETE FROM `acore_string` WHERE `entry` IN (35483, 35484, 35485);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(35483, 'Recover id: {} | Item: {} ({}) | Count: {} | Sold for: {}'),
(35484, 'Recover id: {} | Item: {} ({}) | Count: {} | Disenchanted into: {}'),
(35485, 'Item {} is still in the player\'s vendor buyback list. Buy it back instead.');
