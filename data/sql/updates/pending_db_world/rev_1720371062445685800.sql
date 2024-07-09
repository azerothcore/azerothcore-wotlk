--
DELETE FROM `creature_loot_template` WHERE (`Entry` IN (20031,20032,20033,20034,20035,20036,20037,20039,20040,20041,20042,20043,20044,20045,20046,20047,20048,20049,20050,20052)) AND (`Item` IN (30020,30024,30026,30028,30029,30030));
DELETE FROM `creature_loot_template` WHERE (`Entry` IN (20031,20032,20033,20034,20035,20036,20037,20039,20040,20041,20042,20043,20044,20045,20046,20047,20048,20049,20050,20052)) AND (`Reference` IN (55500));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(20031, 55500, 55500, 10, 0, 1, 0, 1, 1, 'Zone Loot - The Eye - Epic Gear'),
(20032, 55500, 55500, 10, 0, 1, 0, 1, 1, 'Zone Loot - The Eye - Epic Gear'),
(20033, 55500, 55500, 10, 0, 1, 0, 1, 1, 'Zone Loot - The Eye - Epic Gear'),
(20034, 55500, 55500, 10, 0, 1, 0, 1, 1, 'Zone Loot - The Eye - Epic Gear'),
(20035, 55500, 55500, 10, 0, 1, 0, 1, 1, 'Zone Loot - The Eye - Epic Gear'),
(20036, 55500, 55500, 10, 0, 1, 0, 1, 1, 'Zone Loot - The Eye - Epic Gear'),
(20037, 55500, 55500, 10, 0, 1, 0, 1, 1, 'Zone Loot - The Eye - Epic Gear'),
(20039, 55500, 55500, 10, 0, 1, 0, 1, 1, 'Zone Loot - The Eye - Epic Gear'),
(20040, 55500, 55500, 10, 0, 1, 0, 1, 1, 'Zone Loot - The Eye - Epic Gear'),
(20041, 55500, 55500, 10, 0, 1, 0, 1, 1, 'Zone Loot - The Eye - Epic Gear'),
(20042, 55500, 55500, 10, 0, 1, 0, 1, 1, 'Zone Loot - The Eye - Epic Gear'),
(20043, 55500, 55500, 10, 0, 1, 0, 1, 1, 'Zone Loot - The Eye - Epic Gear'),
(20044, 55500, 55500, 10, 0, 1, 0, 1, 1, 'Zone Loot - The Eye - Epic Gear'),
(20045, 55500, 55500, 10, 0, 1, 0, 1, 1, 'Zone Loot - The Eye - Epic Gear'),
(20046, 55500, 55500, 10, 0, 1, 0, 1, 1, 'Zone Loot - The Eye - Epic Gear'),
-- (20047, 55500, 55500, 10, 0, 1, 0, 1, 1, 'Zone Loot - The Eye - Epic Gear'), -- It shares lootid with another creature :<
(20048, 55500, 55500, 10, 0, 1, 0, 1, 1, 'Zone Loot - The Eye - Epic Gear'),
(20049, 55500, 55500, 10, 0, 1, 0, 1, 1, 'Zone Loot - The Eye - Epic Gear'),
(20050, 55500, 55500, 10, 0, 1, 0, 1, 1, 'Zone Loot - The Eye - Epic Gear'),
(20052, 55500, 55500, 10, 0, 1, 0, 1, 1, 'Zone Loot - The Eye - Epic Gear');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 55500);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(55500, 30020, 0, 0, 0, 1, 1, 1, 1, 'Fire-Cord of the Magus'),
(55500, 30024, 0, 0, 0, 1, 1, 1, 1, 'Mantle of the Elven Kings'),
(55500, 30026, 0, 0, 0, 1, 1, 1, 1, 'Bands of the Celestial Archer'),
(55500, 30028, 0, 0, 0, 1, 1, 1, 1, 'Seventh Ring of the Tirisfalen'),
(55500, 30029, 0, 0, 0, 1, 1, 1, 1, 'Bark-Gloves of Ancient Wisdom'),
(55500, 30030, 0, 0, 0, 1, 1, 1, 1, 'Girdle of Fallen Stars');
