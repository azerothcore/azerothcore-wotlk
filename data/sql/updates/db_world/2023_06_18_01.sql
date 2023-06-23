-- DB update 2023_06_18_00 -> 2023_06_18_01
--
UPDATE `creature_template` SET `minlevel` = 72, `maxlevel` = 72 WHERE  `entry` IN (
20738, -- Chrono Lord Deja (1)
20745, -- Temporus (1)
21558, -- High Botanist Freywinn (1)
21559, -- Laj (1)
21581, -- Thorngrin the Tender (1)
21582, -- Warp Splinter (1)
21712, -- Infinite Chrono-Lord (1)
22167  -- Infinite Timereaver (1)
);
