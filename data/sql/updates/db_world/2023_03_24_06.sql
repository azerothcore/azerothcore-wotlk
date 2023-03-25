-- DB update 2023_03_24_05 -> 2023_03_24_06
-- Violet Hold Guard, only the 2 right in front of VH should have emote 333.
UPDATE `creature_template_addon` SET `emote` = 0 WHERE `entry` = 30659;
