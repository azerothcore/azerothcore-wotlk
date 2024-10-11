-- DB update 2021_06_18_14 -> 2021_06_18_15
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_18_14';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_18_14 2021_06_18_15 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1623675094427536149'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623675094427536149');

-- Enables fear, bleed, horror effects
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`&~(16|16384|8388608) WHERE `entry` = 4952;
-- Disables death grip
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`|32 WHERE `entry` = 4952;

-- Disables no_parry
UPDATE `creature_template` SET `flags_extra`=`flags_extra`&~(2) WHERE `entry` = 4952;
-- Disables weapon skill gains
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|262144 WHERE `entry` = 4952;

UPDATE `creature_template` SET `ScriptName` = 'npc_training_dummy' WHERE `entry` = 4952;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_18_15' WHERE sql_rev = '1623675094427536149';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
