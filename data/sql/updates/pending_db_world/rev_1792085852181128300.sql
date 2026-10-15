--
-- Hungering Plaguehound (31556): unselectable friendly auxiliary spawns in Icecrown
DELETE FROM `creature` WHERE `id` = 31556 AND `guid` BETWEEN 121846 AND 121853;
