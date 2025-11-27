-- Fixes https://github.com/azerothcore/azerothcore-wotlk/issues/23803
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24385;
