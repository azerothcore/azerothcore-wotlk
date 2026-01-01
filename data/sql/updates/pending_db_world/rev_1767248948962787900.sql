DELETE FROM `holiday_dates` WHERE `id` IN (404, 409, 372, 321, 398, 62, 341, 201, 181, 423, 327) AND `date_id` = 26;
INSERT INTO `holiday_dates` (`id`, `date_id`, `date_value`, `holiday_duration`) VALUES
(404, 26, 447037952, 167),  -- Pilgrim Bounty
(409, 26, 446693888, 48),   -- Day of the Dead
(372, 26, 444956928, 384),  -- Brewfest
(321, 26, 444924608, 168),  -- Harvest Festival
(398, 26, 444891904, 24),   -- Pirates Day
(62, 26, 442548992, 18),    -- Firework Spectacular
(341, 26, 441778944, 336),  -- Midsummer Fire Festivall
(201, 26, 439779712, 168),  -- Childrens Week
(181, 26, 439435968, 168),  -- Noblegarden
(423, 26, 437387968, 336),  -- Love is in the Air
(327, 26, 437502720, 336);  -- Lunar Festival
