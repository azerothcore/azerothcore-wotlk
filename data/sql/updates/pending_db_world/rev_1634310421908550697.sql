INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634310421908550697');

-- Decreases the required mining skill level to learn Smelt Thorium to 230
UPDATE `npc_trainer` SET `ReqSkillRank` = 230 WHERE `ID` = 201033 AND `SpellID` = 16153;
