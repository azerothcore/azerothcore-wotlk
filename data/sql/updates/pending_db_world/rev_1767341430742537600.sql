-- correctly link brewfest building event in ironforge to brewfest
UPDATE `game_event` SET `holiday` = 372, `holidayStage` = 1 WHERE `eventEntry` = 70;

-- remove start end end times from automatically handled events
UPDATE `game_event` SET `start_time` = NULL, `end_time` = NULL WHERE `eventEntry` IN
(
    1,  -- Midsummer Fire Festival
    2,  -- Winter Veil
    7,  -- Lunar Festival
    8,  -- Love is in the Air
    9,  -- Noblegarden
    10, -- Children's Week
    11, -- Harvest Festival
    12, -- Hallow's End
    24, -- Brewfest
    26, -- Pilgrim's Bounty
    50, -- Pirates' Day
    51, -- Day of the Dead
    70, -- Brewfest Building (Iron Forge)
    72  -- Fireworks Spectacular
);
