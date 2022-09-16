-- DB update 2021_06_25_03 -> 2021_06_25_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_25_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_25_03 2021_06_25_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1624022594966979301'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624022594966979301');

SET @POOL1 = 60005,
    @POOL2 = 60006,
    @POOL3 = 60007,
    @POOL4 = 60008,
    @POOL5 = 60009,
    @WATERBARREL1 = 29275,
    @WATERBARREL2 = 32313,
    @WATERBARREL3 = 30677,
    @WATERBARREL4 = 29276,
    @WATERBARREL5 = 29609,
    @FOODCRATE1 = 30758,
    @FOODCRATE2 = 32754,
    @FOODCRATE3 = 30839,
    @FOODCRATE4 = 30687,
    @FOODCRATE5 = 29306;

DELETE FROM `pool_template` WHERE `entry` IN (@POOL1, @POOL2, @POOL3, @POOL4, @POOL5);
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOL1, 1, 'Water Barrel (29275) / Food Crate (30758) - Westbrook Garrison'),
(@POOL2, 1, 'Water Barrel (32313) / Food Crate (32754) - Goldshire'),
(@POOL3, 1, 'Water Barrel (30677) / Food Crate (30839) - Lions Pride Inn'),
(@POOL4, 1, 'Water Barrel (29276) / Food Crate (30687) - Elwynn Forest'),
(@POOL5, 1, 'Water Barrel (29609) / Food Crate (29306) - Steelgrills Depot');

DELETE FROM `pool_gameobject`
WHERE `guid` IN (
    @WATERBARREL1, @WATERBARREL2, @WATERBARREL3, @WATERBARREL4, @WATERBARREL5,
    @FOODCRATE1, @FOODCRATE2, @FOODCRATE3, @FOODCRATE4, @FOODCRATE5
)
AND `pool_entry` IN (@POOL1, @POOL2, @POOL3, @POOL4, @POOL5);
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@WATERBARREL1, @POOL1, 0, 'Water Barrel (29275) - Westbrook Garrison'),
(@WATERBARREL2, @POOL2, 0, 'Water Barrel (32313) - Goldshire'),
(@WATERBARREL3, @POOL3, 0, 'Water Barrel (30677) - Lions Pride Inn'),
(@WATERBARREL4, @POOL4, 0, 'Water Barrel (29276) - Elwynn Forest'),
(@WATERBARREL5, @POOL5, 0, 'Water Barrel (29609) - Steelgrills Depot'),
(@FOODCRATE1, @POOL1, 0, 'Food Crate (30758) - Westbrook Garrison'),
(@FOODCRATE2, @POOL2, 0, 'Food Crate (32754) - Goldshire'),
(@FOODCRATE3, @POOL3, 0, 'Food Crate (30839) - Lions Pride Inn'),
(@FOODCRATE4, @POOL4, 0, 'Food Crate (30687) - Elwynn Forest'),
(@FOODCRATE5, @POOL5, 0, 'Food Crate (29306) - Steelgrills Depot');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_25_04' WHERE sql_rev = '1624022594966979301';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
