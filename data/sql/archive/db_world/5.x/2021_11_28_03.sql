-- DB update 2021_11_28_02 -> 2021_11_28_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_28_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_28_02 2021_11_28_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1637254570424531000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637254570424531000');

DELETE FROM `creature_template_locale` WHERE `entry` in (8673, 9856, 8724) AND `locale` in ('esES', 'esMX');
INSERT INTO `creature_template_locale` (`entry`, `locale`, `name`, `Title`, `VerifiedBuild`) VALUES 
(8673, 'esES', 'Subastador Thathung', '', 18019),
(8673, 'esMX', 'Subastador Thathung', '', 18019),
(9856, 'esES', 'Subastador Grimful', '', 18019),
(9856, 'esMX', 'Subastador Grimful', '', 18019),
(8724, 'esES', 'Subastador Wabang', '', 18019),
(8724, 'esMX', 'Subastador Wabang', '', 18019);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_28_03' WHERE sql_rev = '1637254570424531000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
