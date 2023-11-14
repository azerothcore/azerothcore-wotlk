-- SSC bosses aggro range
UPDATE `creature_template` SET `detection_range` = 45 WHERE `entry` = 21212; -- Lady Vashj
UPDATE `creature_template` SET `detection_range` = 35 WHERE `entry` = 21213; -- Morogrim Tidewalker 
UPDATE `creature_template` SET `detection_range` = 30 WHERE `entry` IN (21214,21215,21216); -- Karathress, Leotheras, Hydross
