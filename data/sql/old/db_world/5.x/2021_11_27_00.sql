-- DB update 2021_11_26_02 -> 2021_11_27_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_26_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_26_02 2021_11_27_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1637948987614040500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637948987614040500');

UPDATE `creature_template` SET `flags_extra` = `flags_extra` |128, `ScriptName` = '' WHERE `entry` = 12758;
UPDATE `creature_template` SET `ScriptName` = '' WHERE `entry` = 11262;

-- Remove taunt immunity
UPDATE `creature_template` SET `flags_extra` = `flags_extra` &~ 256 WHERE `entry` = 10184;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_27_00' WHERE sql_rev = '1637948987614040500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
