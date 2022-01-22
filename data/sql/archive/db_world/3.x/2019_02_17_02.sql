-- DB update 2019_02_17_01 -> 2019_02_17_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_02_17_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_02_17_01 2019_02_17_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1550318643525669100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1550318643525669100');

-- Scattered Crate drop Lost Supplies should have 100 drop chance
UPDATE `gameobject_loot_template` SET `Chance`='100' WHERE `Entry`=3597 AND `Item`=6172;

-- Creature "Flanis Swiftwing" should be dead.
UPDATE `creature_template_addon` SET `emote`=65 WHERE  `entry`=21727;
UPDATE `creature_template` SET `flags_extra`=2 WHERE  `entry`=21727;
UPDATE `creature_template` SET `unit_flags`=536904450 WHERE  `entry`=21727;
UPDATE `creature_template` SET `dynamicflags`=32 WHERE  `entry`=21727;

-- Duplicate creature Commander Jordan
DELETE FROM `creature` WHERE `guid`=105029;
DELETE FROM `creature_addon` WHERE `guid`=105029;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
