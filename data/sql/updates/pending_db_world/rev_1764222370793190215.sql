-- Fix Quest 12521 "Where in the World is Hemet Nesingwary?" flying machine issues
-- https://github.com/azerothcore/azerothcore-wotlk/issues/21494

-- Increase flight speed from 1.0 to 3.0 (flying creatures use speed_run for flight)
UPDATE `creature_template` SET `speed_run` = 3, `speed_walk` = 2 WHERE `entry` = 28192;
