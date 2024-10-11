-- DB update 2021_10_08_12 -> 2021_10_08_13
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_08_12';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_08_12 2021_10_08_13 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633308203494634065'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633308203494634065');

-- Remove Civilian flag from summoned Emerald Dragon Whelp
UPDATE `creature_template` SET `flags_extra`=`flags_extra`&~(2) WHERE `entry` = 8776;


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_08_13' WHERE sql_rev = '1633308203494634065';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
