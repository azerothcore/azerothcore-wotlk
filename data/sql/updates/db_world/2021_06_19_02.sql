-- DB update 2021_06_19_01 -> 2021_06_19_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_19_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_19_01 2021_06_19_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1623568768400505753'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623568768400505753');

-- Deletes RLT 24054 from lvl 12 Gamon, ID 6466 (96 items/25 level gap)
DELETE FROM `creature_loot_template` WHERE `Entry` = 6466 AND `Reference` = 24054;

-- Deletes RLT 24042 from lvl 24 Galak Packhound, ID 4250 (12 items/21 level gap)
DELETE FROM `creature_loot_template` WHERE `Entry` = 4250 AND `Reference` = 24042;

-- Deletes RLT 24056 from lvl 21 Syndicate Rogue, ID 2260 (92 items/17 level gap)
DELETE FROM `creature_loot_template` WHERE `Entry` = 2260 AND `Reference` = 24056;

-- Deletes RLT 24025 from lvl 37 Rigglefuzz, ID 2817 (108 items/14 level gap)
DELETE FROM `creature_loot_template` WHERE `Entry` = 2817 AND `Reference` = 24025;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_19_02' WHERE sql_rev = '1623568768400505753';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
