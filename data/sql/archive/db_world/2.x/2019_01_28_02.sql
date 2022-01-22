-- DB update 2019_01_28_01 -> 2019_01_28_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_01_28_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_01_28_01 2019_01_28_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1548606393549139336'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1548606393549139336');


DROP TABLE IF EXISTS `gameobject_template_addon`;
CREATE TABLE `gameobject_template_addon`(
    `entry` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
    `faction` smallint(5) unsigned NOT NULL DEFAULT '0',
    `flags` int(10) unsigned NOT NULL DEFAULT '0',
    `mingold` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
    `maxgold` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
    PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `gameobject_template_addon` (`entry`, `faction`, `flags`)
SELECT `entry`, `faction`, `flags` FROM `gameobject_template`;

ALTER TABLE `gameobject_template`
DROP COLUMN `faction`,
DROP COLUMN `flags`,
CHANGE COLUMN `VerifiedBuild` `VerifiedBuild` smallint(5) DEFAULT '0';

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
