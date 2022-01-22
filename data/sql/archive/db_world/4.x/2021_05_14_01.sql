-- DB update 2021_05_14_00 -> 2021_05_14_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_14_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_14_00 2021_05_14_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1620435208642994700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620435208642994700');

-- es.classic.wowhead.com/npc=6910/revelosh
UPDATE `creature_loot_template` SET `Chance`=41 WHERE `Entry`=6910 AND `Item`=7741;
UPDATE `creature_loot_template` SET `Chance`=23 WHERE `Entry`=6910 AND `Item` IN (9387,9389);
UPDATE `creature_loot_template` SET `Chance`=21 WHERE `Entry`=6910 AND `Item` IN (9390,9388);
UPDATE `creature_loot_template` SET `Chance`=13 WHERE `Entry`=6910 AND `Item`=4306;
UPDATE `creature_loot_template` SET `Chance`=2 WHERE `Entry`=6910 AND `Item`=3771;


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
