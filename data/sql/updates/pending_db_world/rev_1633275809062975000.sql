INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633275809062975000');

-- baron adds 
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = 1 WHERE (`creature_id` = 11197);

-- scholo projections 
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = 1 WHERE (`creature_id` = 11263);