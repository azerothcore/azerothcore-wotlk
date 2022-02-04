INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643662892603722900');

UPDATE `creature_template` SET `RegenHealth` = 0 WHERE `RegenHealth` >= 2;
UPDATE `creature_onkill_reputation` SET `IsTeamAward1` = 0 WHERE `IsTeamAward1` >= 2;
UPDATE `creature_onkill_reputation` SET `IsTeamAward2` = 0 WHERE `IsTeamAward2` >= 2;
