INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624657033501888850');

-- Flag all "Shredder Operating Manual - Page %" items for HORDE_ONLY
UPDATE `item_template` SET `FlagsExtra`=1 WHERE `entry` BETWEEN 16645 AND 16656;
