INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628001727322964286');

-- Caliph Scorpidsting - Gadgetzan kill rep to 15
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = 15, `MaxStanding1` = 4 WHERE `creature_id` = 7847;

-- Wastewander Assassin, Bandit, Rogue, Scofflaw, Shadow Mage, Thief - Gadgetzan kill rep to 5
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = 5 WHERE `creature_id` IN (5623, 5618, 5615, 7805, 5617, 5616);

