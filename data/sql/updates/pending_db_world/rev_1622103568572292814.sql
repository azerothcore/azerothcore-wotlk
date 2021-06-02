INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622103568572292814');

-- 118: Prowler
-- 3660: Athrikus Narassin
-- 8386: Horizon Scout Crewman
-- 10495: Diseased Ghoul
-- 11562: Drysnap Crawler
-- 11563: Drysnap Pincer
DELETE FROM `creature_loot_template` WHERE `reference` = 24060 AND `entry` IN (118, 3660, 8386, 10495, 11562, 11563);
