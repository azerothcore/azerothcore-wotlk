-- DB update 2021_08_30_04 -> 2021_08_31_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_30_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_30_04 2021_08_31_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629326440508086998'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629326440508086998');
DELETE FROM `skinning_loot_template` WHERE `Entry` IN (684, 768, 1713, 10237) AND (`Item` IN (7428));

-- Adjust skinning drop rates for Shadowmaw Panther
UPDATE `skinning_loot_template` SET `Chance` = 73.4 WHERE `Entry` = 684 AND `Item` = 4234;
UPDATE `skinning_loot_template` SET `Chance` = 3.3 WHERE `Entry` = 684 AND `Item` = 4235;
UPDATE `skinning_loot_template` SET `Chance` = 23.3 WHERE `Entry` = 684 AND `Item` = 4304;

-- Adjust skinning drop rates for Shadow Panther
UPDATE `skinning_loot_template` SET `Chance` = 72.7 WHERE `Entry` = 768 AND `Item` = 4234;
UPDATE `skinning_loot_template` SET `Chance` = 4.2 WHERE `Entry` = 768 AND `Item` = 4235;
UPDATE `skinning_loot_template` SET `Chance` = 23.1 WHERE `Entry` = 768 AND `Item` = 4304;

-- Adjust skinning drop rates for Elder Shadowmaw Panther
UPDATE `skinning_loot_template` SET `Chance` = 72.8 WHERE `Entry` = 1713 AND `Item` = 4234;
UPDATE `skinning_loot_template` SET `Chance` = 3.3 WHERE `Entry` = 1713 AND `Item` = 4235;
UPDATE `skinning_loot_template` SET `Chance` = 23.9 WHERE `Entry` = 1713 AND `Item` = 4304;

UPDATE `creature_template` SET `skinloot` = 0 WHERE (`entry` = 10237);
DELETE FROM `skinning_loot_template` WHERE `Entry` = 10237;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_31_00' WHERE sql_rev = '1629326440508086998';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
