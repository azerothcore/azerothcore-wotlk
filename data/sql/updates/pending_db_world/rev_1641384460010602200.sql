INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641384460010602200');

-- Reputation level
SET @REVERED = 6;
SET @HONORED = 5;

-- NPCs
SET @CAULDRON_LORDS = 11075;
SET @ARAJ = 1852;
SET @GIBBERING_GHOUL = 8531;

-- Monsters in Western Plaguelands reward 10 reputation until <= Revered (6)
UPDATE `creature_onkill_reputation` SET `MaxStanding1` = @REVERED WHERE `creature_id` IN (8558, 1788, 11873, 1804, 12262, 12263, 8543, 8545);

-- Gibbering Ghoul rewards 10 reputation until <= Honored (5)
UPDATE `creature_onkill_reputation` SET `MaxStanding1` = @HONORED WHERE `creature_id` IN (@GIBBERING_GHOUL);

-- Cauldron Lords should reward 30 reputation <= Honored (5)
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = 30 WHERE `creature_id` IN (@CAULDRON_LORDS, @CAULDRON_LORDS + 1, @CAULDRON_LORDS + 2, @CAULDRON_LORDS + 3);

-- Araj the Summoner should reward 50 reputation <= Revered (6)
UPDATE `creature_onkill_reputation` SET `MaxStanding1` = @REVERED, `RewOnKillRepValue1` = 50 WHERE `creature_id` IN (@ARAJ);
