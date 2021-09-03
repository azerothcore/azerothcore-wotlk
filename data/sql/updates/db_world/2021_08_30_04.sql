-- DB update 2021_08_30_03 -> 2021_08_30_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_30_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_30_03 2021_08_30_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629818510750235317'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629818510750235317');

-- Removed Manual: Heavy Silk Bandage and Manual: Mageweave Bandage from Deneb Walker (2805)
DELETE FROM `npc_vendor` WHERE (`entry` = 2805) AND (`item` IN (16112, 16113));

-- Removed Manual: Heavy Silk Bandage and Manual: Mageweave Bandage from Balai Lok'Wein (13476)
DELETE FROM `npc_vendor` WHERE (`entry` = 13476) AND (`item` IN (16112, 16113));


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_30_04' WHERE sql_rev = '1629818510750235317';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
