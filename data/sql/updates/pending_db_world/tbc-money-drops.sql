UPDATE `creature_template` SET `mingold` = 2500000, `maxgold` = 2500000 WHERE `entry` IN (17767, 17808, 17842, 17888, 18805, 18831, 19044, 19514, 19516, 21213, 21214, 21215, 21216, 21217, 22841, 23420, 22871, 22887, 22898, 22947, 22948, 24882, 24892, 25038, 25840);
UPDATE `creature_template` SET `mingold` = 625000, `maxgold` = 625000 WHERE `entry` IN (22949, 22950, 22951, 22952);
UPDATE `creature_template` SET `mingold` = 3000000, `maxgold` = 3000000 WHERE `entry` IN (17968, 19622, 21212, 22917);
UPDATE `creature_template` SET `mingold` = 3500000, `maxgold` = 3500000 WHERE `entry` IN (25165, 25166);
UPDATE `creature_template` SET `mingold` = 5000000, `maxgold` = 5000000 WHERE `entry` = 25315;
-- Values below are entirely guessed, ±25g from Wowhead's ~500g average money drop.
UPDATE `creature_template` SET `mingold` = 4750000, `maxgold` = 5250000 WHERE `entry` IN (17257, 17711, 18728);
