-- DB update 2023_07_16_00 -> 2023_07_16_01
--
DELETE FROM `item_loot_template` WHERE (`Entry` = 31800);
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(31800, 22829, 0, 97, 0, 1, 3, 1, 2, 'Outcast\'s Cache - Super Healing Potion'),
(31800, 27498, 0, 0, 0, 1, 1, 1, 1, 'Outcast\'s Cache - Scroll of Agility V'),
(31800, 27499, 0, 0, 0, 1, 1, 1, 1, 'Outcast\'s Cache - Scroll of Intellect V'),
(31800, 27500, 0, 0, 0, 1, 1, 1, 1, 'Outcast\'s Cache - Scroll of Protection V'),
(31800, 27501, 0, 0, 0, 1, 1, 1, 1, 'Outcast\'s Cache - Scroll of Spirit V'),
(31800, 27502, 0, 0, 0, 1, 1, 1, 1, 'Outcast\'s Cache - Scroll of Stamina V'),
(31800, 27503, 0, 0, 0, 1, 1, 1, 1, 'Outcast\'s Cache - Scroll of Strength V'),
(31800, 28491, 0, 3, 0, 1, 2, 1, 1, 'Outcast\'s Cache - Windwalker\'s Footwraps'),
(31800, 28492, 0, 2, 0, 1, 2, 1, 1, 'Outcast\'s Cache - Talonite\'s Boots'),
(31800, 28493, 0, 2, 0, 1, 2, 1, 1, 'Outcast\'s Cache - Dreadhawk\'s Schynbald'),
(31800, 28494, 0, 2, 0, 1, 2, 1, 1, 'Outcast\'s Cache - Ravenguard\'s Greaves'),
(31800, 28495, 0, 0, 0, 1, 2, 1, 1, 'Outcast\'s Cache - Windwalker\'s Sash'),
(31800, 28496, 0, 0, 0, 1, 2, 1, 1, 'Outcast\'s Cache - Talonite\'s Belt'),
(31800, 28497, 0, 0, 0, 1, 2, 1, 1, 'Outcast\'s Cache - Dreadhawk\'s Girdle'),
(31800, 28498, 0, 0, 0, 1, 2, 1, 1, 'Outcast\'s Cache - Ravenguard\'s Baldric'),
(31800, 33457, 0, 2, 0, 1, 1, 1, 1, 'Outcast\'s Cache - Scroll of Agility VI'),
(31800, 33458, 0, 2, 0, 1, 1, 1, 1, 'Outcast\'s Cache - Scroll of Intellect VI'),
(31800, 33459, 0, 2, 0, 1, 1, 1, 1, 'Outcast\'s Cache - Scroll of Protection VI'),
(31800, 33460, 0, 2, 0, 1, 1, 1, 1, 'Outcast\'s Cache - Scroll of Spirit VI'),
(31800, 33461, 0, 2, 0, 1, 1, 1, 1, 'Outcast\'s Cache - Scroll of Stamina VI'),
(31800, 33462, 0, 2, 0, 1, 1, 1, 1, 'Outcast\'s Cache - Scroll of Strenght VI');
