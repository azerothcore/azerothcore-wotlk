
DELETE FROM `holiday_dates` WHERE `id` IN (404, 409, 372, 321, 398, 62, 341, 201, 181, 423, 327) AND `date_id` = 6;
INSERT INTO `holiday_dates` (`id`, `date_id`, `date_value`, `holiday_duration`) VALUES
(404, 6, 447037952, 167),  -- Pilgrim Bounty
(409, 6, 446693888, 48),   -- Day of the Dead
(372, 6, 444956928, 384),  -- Brewfest
(321, 6, 444924608, 168),  -- Harvest Festival
(398, 6, 444891904, 24),   -- Pirates Day
(62, 6, 442548992, 18),    -- Firework Spectacular
(341, 6, 441778944, 336),  -- Midsummer Fire Festivall
(201, 6, 439779712, 168),  -- Childrens Week
(181, 6, 439435968, 168),  -- Noblegarden
(423, 6, 437387968, 336),  -- Love is in the Air
(327, 6, 437502720, 336);  -- Lunar Festival
