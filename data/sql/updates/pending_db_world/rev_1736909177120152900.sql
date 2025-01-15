--
DELETE FROM `acore_string` WHERE `entry` BETWEEN 35500 AND 35507;

INSERT INTO `acore_string` (`entry`, `content_default`) VALUES 
(35500, 'This teleport crystal cannot be used until the teleport crystal in Dalaran has been used at least once.'),
(35501, 'Purchase 1 Unstable Flask of the Beast for the cost of 10 Apexis Shards'),
(35502, 'Purchase 5 Unstable Flask of the Beast for the cost of 50 Apexis Shards'),
(35503, 'Use the fel crystalforge to make another purchase.'),
(35504, 'Purchase 1 Unstable Flask of the Sorcerer for the cost of 10 Apexis Shards'),
(35505, 'Purchase 5 Unstable Flask of the Sorcerer for the cost of 50 Apexis Shards'),
(35506, 'Use the bashir crystalforge to make another purchase.'),
(35507, 'Quest item Anderhol\'s Slider Cider not found.');
