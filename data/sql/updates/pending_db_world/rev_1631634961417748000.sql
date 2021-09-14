INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631634961417748000');
-- sets for all, generic 20/100 and maxrep
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = 20, `MaxStanding1` = 5, `MaxStanding2` = 7, `RewOnKillRepValue2` = -100 WHERE (`RewOnKillRepFaction1` = 92 AND `RewOnKillRepFaction2` = 93);
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = 20, `MaxStanding1` = 5, `MaxStanding2` = 7, `RewOnKillRepValue2` = -100 WHERE (`RewOnKillRepFaction1` = 93 AND `RewOnKillRepFaction2` = 92);


-- Warug bodyguard
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = 5, `RewOnKillRepValue2` = -25 WHERE (`creature_id` = 6068);



-- khan shaka doesn't exist in current DB
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` = 5602);
DELETE FROM `creature_onkill_reputation` WHERE (`creature_id` = 5602);
INSERT INTO `creature_onkill_reputation` (`creature_id`, `RewOnKillRepFaction1`, `RewOnKillRepFaction2`, `MaxStanding1`, `IsTeamAward1`, `RewOnKillRepValue1`, `MaxStanding2`, `IsTeamAward2`, `RewOnKillRepValue2`, `TeamDependent`) VALUES
(5602, 93, 92, 5, 0, 25, 7, 0, -125, 0);

-- khan jehn
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = 25, `RewOnKillRepValue2` = -125 WHERE (`creature_id` = 5601);