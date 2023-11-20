-- DB update 2023_11_14_02 -> 2023_11_15_00
-- SSC bosses aggro range
UPDATE `creature_template` SET `detection_range` = 45 WHERE `entry` = 21212;
UPDATE `creature_template` SET `detection_range` = 35 WHERE `entry` = 21213;
UPDATE `creature_template` SET `detection_range` = 30 WHERE `entry` IN (21214,21215,21216);
