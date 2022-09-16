-- DB update 2021_11_19_01 -> 2021_11_19_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_19_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_19_01 2021_11_19_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1635882858166720225'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635882858166720225');

DELETE FROM `gameobject_loot_template` WHERE (`Entry` = 11103) AND (`Item` IN (11751, 11752, 11753));
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11103, 11751, 0, 46, 0, 1, 0, 1, 2, 'Dark Coffer - Burning Essence'),
(11103, 11752, 0, 43, 0, 1, 0, 1, 2, 'Dark Coffer - Black Blood of the Tormented'),
(11103, 11753, 0, 39, 0, 1, 0, 1, 1, 'Dark Coffer - Eye of Kajal');


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_19_02' WHERE sql_rev = '1635882858166720225';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
