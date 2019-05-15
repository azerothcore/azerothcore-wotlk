INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1557226918417685700');

ALTER TABLE `character_arena_stats`
MODIFY `guid` int(10) unsigned NOT NULL DEFAULT '0',
MODIFY `slot` tinyint(3) unsigned NOT NULL DEFAULT '0',
MODIFY `matchMakerRating` smallint(5) unsigned NOT NULL DEFAULT '0';
