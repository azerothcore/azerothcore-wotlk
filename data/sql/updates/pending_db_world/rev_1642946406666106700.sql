INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642946406666106700');

DELETE FROM `command` WHERE `name` = 'guild rename';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('guild rename', 3, 'Syntax: .guild rename "$GuildName" "$NewGuildName" \n\n Rename a guild named $GuildName with $NewGuildName. Guild name and new guild name must in quotes.');
