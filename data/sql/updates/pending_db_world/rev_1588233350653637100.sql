INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588233350653637100');

ALTER TABLE `broadcast_text`
	CHANGE `unk1` `EmotesID` MEDIUMINT,
	CHANGE `unk2` `Flags` MEDIUMINT,
	CHANGE `EmoteID2` `EmoteID3` MEDIUMINT,
	CHANGE `EmoteID1` `EmoteID2` MEDIUMINT,
	CHANGE `EmoteID0` `EmoteID1` MEDIUMINT,
	CHANGE `EmoteDelay2` `EmoteDelay3` MEDIUMINT,
	CHANGE `EmoteDelay1` `EmoteDelay2` MEDIUMINT,
	CHANGE `EmoteDelay0` `EmoteDelay1` MEDIUMINT;
