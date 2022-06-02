-- DB update 2021_09_03_04 -> 2021_09_03_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_03_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_03_04 2021_09_03_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630437845134253537'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630437845134253537');

-- Set 5 rep until honored for Desert Rumbler, Dust Stormer, Greater Obsidian Elemental, Cyclone Warrior
UPDATE `creature_onkill_reputation` SET `MaxStanding1` = 4, `RewOnKillRepValue1` = 5 WHERE `creature_id` IN (11746, 11744, 7032, 11745);

-- Set 15 rep until revered for Lord Incendius
UPDATE `creature_onkill_reputation` SET `MaxStanding1` = 5, `RewOnKillRepValue1` = 15 WHERE (`creature_id` = 9017);

-- Set 25 rep until revered for Huricanian
UPDATE `creature_onkill_reputation` SET `MaxStanding1` = 5, `RewOnKillRepValue1` = 25 WHERE (`creature_id` = 14478);

-- Set 50 rep until revered for Pyroguard Emberseer
UPDATE `creature_onkill_reputation` SET `MaxStanding1` = 5, `RewOnKillRepValue1` = 50 WHERE (`creature_id` = 9816);

-- Set 20 rep until revered for Molten Giant, Ancient Core Hound, Lava Surger, Firelord
UPDATE `creature_onkill_reputation` SET `MaxStanding1` = 5, `RewOnKillRepValue1` = 20 WHERE `creature_id` IN (11658, 11673, 12101, 11668);

-- Set 40 rep until revered for Molten Destroyer, Lava Reaver, Lava Elemental, Flameguard, Firewalker
UPDATE `creature_onkill_reputation` SET `MaxStanding1` = 5, `RewOnKillRepValue1` = 40 WHERE `creature_id` IN (11659, 12100, 12076, 11667, 11666);
 
-- Set 100 rep until exalted for Lucifron, Magmadar, Gehennas, Garr, Baron Geddon, Shazzrah, Sulfuron Harbinger 
UPDATE `creature_onkill_reputation` SET `MaxStanding1` = 6, `RewOnKillRepValue1` = 100 WHERE `creature_id` IN (12118, 11982, 12259, 12057, 12056, 12264, 12098);

-- Set 150 rep until end exalted for Golemagg the incinerator
UPDATE `creature_onkill_reputation` SET `MaxStanding1` = 7, `RewOnKillRepValue1` = 150 WHERE (`creature_id` = 11988);

-- Set 200 rep until end exalted for Ragnaros
UPDATE `creature_onkill_reputation` SET `MaxStanding1` = 7, `RewOnKillRepValue1` = 200 WHERE (`creature_id` = 11502);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_03_05' WHERE sql_rev = '1630437845134253537';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
