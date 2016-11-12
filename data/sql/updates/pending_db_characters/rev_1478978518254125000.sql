INSERT INTO version_db_characters (`sql_rev`) VALUES ('1478978518254125000');

ALTER TABLE `arena_team_member`
	CHANGE COLUMN `personalRating` `personalRating` SMALLINT(5) NOT NULL DEFAULT '0' AFTER `seasonWins`,
	DROP COLUMN `personal_rating`;
