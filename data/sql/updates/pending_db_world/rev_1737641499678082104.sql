-- Update gold drop rate with min 437 and max 3869 like picture
-- I suspect realistically ~200 ~4000
UPDATE `creature_template` SET `mingold` = 437, `maxgold` = 3869 WHERE `entry` IN (18853, 19453, 18852, 18857, 19779, 18855, 19643);
