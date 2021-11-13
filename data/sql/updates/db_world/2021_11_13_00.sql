-- DB update 2021_11_12_04 -> 2021_11_13_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_12_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_12_04 2021_11_13_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1636103884460644100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636103884460644100');

-- Correct drop chance for Westfall Deed
UPDATE `creature_loot_template` SET `Chance`=4 WHERE `Item`=1972 AND `Entry` IN (6866,6846);
UPDATE `creature_loot_template` SET `Chance`=3 WHERE `Item`=1972 AND `Entry` IN (116,474,880,6927);

-- Defias Ambusher and Surena Caledon should not drop Westfall Deed
DELETE FROM `creature_loot_template` WHERE `Item`=1972 AND `Entry` IN (583,881);
DELETE FROM `conditions` WHERE `SourceEntry`=1972 AND `SourceGroup` IN (583,881);

-- Correct drop chance for Gold Pickup Schedule
UPDATE `creature_loot_template` SET `Chance`=86 WHERE `Item`=1307 AND `Entry`=100;
UPDATE `creature_loot_template` SET `Chance`=3 WHERE `Item`=1307 AND `Entry` IN (478,97);
UPDATE `creature_loot_template` SET `Chance`=1.9 WHERE `Item`=1307 AND `Entry`=448;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_13_00' WHERE sql_rev = '1636103884460644100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
