--
UPDATE `creature_template`
SET `mingold` = 448, `maxgold` = 2520
WHERE `entry` IN (22241, 22242, 22243) AND `lootid` IN (22241, 22242, 22243);
