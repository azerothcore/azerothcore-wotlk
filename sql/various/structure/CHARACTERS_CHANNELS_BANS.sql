CREATE TABLE `channels_bans` (
  `channelId` int(10) unsigned NOT NULL,
  `playerGUID` int(10) unsigned NOT NULL,
  `banTime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`channelId`,`playerGUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
