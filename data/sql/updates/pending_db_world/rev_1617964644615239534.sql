INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617964644615239534');

SET @ENTRY := 11598;
DELETE FROM `creature_onkill_reputation` WHERE (`creature_id` = @ENTRY);
INSERT INTO `creature_onkill_reputation` (`creature_id`, `RewOnKillRepFaction1`, `RewOnKillRepFaction2`, `MaxStanding1`, `IsTeamAward1`, `RewOnKillRepValue1`, `MaxStanding2`, `IsTeamAward2`, `RewOnKillRepValue2`, `TeamDependent`) VALUES
(@ENTRY, 529, 0, 6, 0, 0, 0, 0, 0, 0);
