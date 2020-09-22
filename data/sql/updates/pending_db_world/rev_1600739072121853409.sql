INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1600739072121853409');

/* brewfest camp hostile mobs */
DELETE FROM `creature` WHERE `guid` IN (7370, 22181, 22188, 22473);

/* brewfest camp non-hostile mobs */
DELETE FROM `creature` WHERE `guid` IN (12369, 21020, 21022, 21026);

