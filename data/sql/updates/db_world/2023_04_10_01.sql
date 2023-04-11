-- DB update En'kilah Hatchling unit_flags add 256 (Unable to fight or communicate with players)

DELETE FROM `creature_template` WHERE `entry` IN (25388,25390);

-- unit_flags 256- Cannot fight or communicate with players
UPDATE creature_template SET unit_flags = unit_flags | 256 WHERE entry IN (25388,25390);
