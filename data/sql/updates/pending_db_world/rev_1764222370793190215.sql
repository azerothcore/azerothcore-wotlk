-- Fix Quest 12521 "Where in the World is Hemet Nesingwary?" flying machine issues
-- https://github.com/azerothcore/azerothcore-wotlk/issues/21494

-- Increase flight speed from 1.0 to 3.0 (flying creatures use speed_run for flight)
UPDATE `creature_template` SET `speed_run` = 3, `speed_walk` = 2 WHERE `entry` = 28192;

-- Fix orientation so the flying machine faces INTO the portal instead of away from it
UPDATE `smart_scripts` SET `target_o` = -1.5984 WHERE `entryorguid` = 2819200 AND `source_type` = 9 AND `id` = 2;
