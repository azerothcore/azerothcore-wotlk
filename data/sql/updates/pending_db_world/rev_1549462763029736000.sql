INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1549462763029736000');

DELETE FROM `trinity_string` WHERE `entry` BETWEEN 5062 AND 5071;
DELETE FROM `command` WHERE `name` IN ('spy follow', 'spy unfollow', 'spy groupfollow', 'spy groupunfollow', 'spy clear', 'spy status');
