-- DB update 2024_07_12_00 -> 2024_07_13_00
UPDATE `creature_template` SET `RangeAttackTime` = 1500 WHERE `entry` = 17968;
UPDATE `creature_template` SET `BaseAttackTime` = 2000 WHERE `entry` IN (17767, 17808, 17842, 17888);
