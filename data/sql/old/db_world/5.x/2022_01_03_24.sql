-- DB update 2022_01_03_23 -> 2022_01_03_24
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_03_23';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_03_23 2022_01_03_24 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1641153687282510374'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641153687282510374');

-- Removes Ez-Thro Dynamite II  from mob. Item is not a Mod Drop Item per UDB verification.
DELETE FROM `creature_loot_template` WHERE  `Entry`=12178 AND `Item`=18588 AND `Reference`=0 AND `GroupId`=0;
DELETE FROM `creature_loot_template` WHERE  `Entry`=13136 AND `Item`=18588 AND `Reference`=0 AND `GroupId`=0;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_03_24' WHERE sql_rev = '1641153687282510374';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
