-- DB update En'kilah Hatchling faction (Unable to fight or communicate with players)
UPDATE `creature_template` SET `faction` = 634 WHERE `entry` IN (25388, 25389, 25390);
