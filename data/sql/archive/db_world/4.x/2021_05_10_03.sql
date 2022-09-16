-- DB update 2021_05_10_02 -> 2021_05_10_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_10_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_10_02 2021_05_10_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1620498329028793558'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620498329028793558');

-- Missing Reference Tables in STV
UPDATE `creature_loot_template` SET `Reference` = 24723, `Comment` = 'Ana''thek the Cruel - (ReferenceTable)' WHERE `Entry`= 1059 AND `Item` = 24723;
UPDATE `creature_loot_template` SET `Reference` = 24722, `Comment` = 'Gan''zulah - (ReferenceTable)' WHERE `Entry`= 1061 AND `Item` = 24722;
UPDATE `creature_loot_template` SET `Reference` = 24723, `Comment` = 'Nezzliok the Dire - (ReferenceTable)' WHERE `Entry`= 1062 AND `Item` = 24723;
UPDATE `creature_loot_template` SET `Reference` = 24736, `Comment` = 'Nezzliok the Dire - (ReferenceTable)' WHERE `Entry`= 1062 AND `Item` = 24736;


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
