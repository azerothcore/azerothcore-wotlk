-- DB update 2023_03_27_02 -> 2023_03_27_03
-- Verified in Build: 47213
UPDATE `creature_template` SET `faction` = 1860 WHERE `entry` IN (
21651, -- Time-Lost Skettis Reaver
21763, -- Time-Lost Skettis Worshipper
21787  -- Time-Lost Skettis High Priest
);
