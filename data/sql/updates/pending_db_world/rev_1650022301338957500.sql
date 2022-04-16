INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1650022301338957500');

DELETE FROM `player_factionchange_quests` WHERE `alliance_id` = 7065 AND `horde_id` = 7064;
INSERT INTO `player_factionchange_quests` (`alliance_id`, `horde_id`) VALUES
(7065, 7064);
