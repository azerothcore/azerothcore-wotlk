-- DB update 2022_01_03_00 -> 2022_01_03_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_03_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_03_00 2022_01_03_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1640301341692176690'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640301341692176690');

-- Creature speed update for Eversong woods and Ghostlands.
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=20100;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=19456;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=16294;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=21970;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=16364;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=18954;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=15404;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=15921;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=16246;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=16204;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=16239;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=16291;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=16240;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=16358;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=16405;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=16331;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=16332;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=16404;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=16342;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=16237;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=16208;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=16248;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=16250;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=17832;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=16206;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=16329;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=16209;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=16247;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=16249;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=16340;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=16339;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=16344;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=16467;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=16469;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=17847;
UPDATE `creature_template` SET `speed_walk`=1 WHERE `entry`=16696;
UPDATE `creature_template` SET `speed_run`=0.85714 WHERE `entry`=15650;
UPDATE `creature_template` SET `speed_run`=0.85714 WHERE `entry`=15654;
UPDATE `creature_template` SET `speed_run`=0.85714 WHERE `entry`=15655;
UPDATE `creature_template` SET `speed_run`=0.85714 WHERE `entry`=15635;
UPDATE `creature_template` SET `speed_run`=0.85714 WHERE `entry`=15658;
UPDATE `creature_template` SET `speed_run`=0.85714 WHERE `entry`=15657;
UPDATE `creature_template` SET `speed_run`=0.85714 WHERE `entry`=15636;
UPDATE `creature_template` SET `speed_run`=0.85714 WHERE `entry`=16855;
UPDATE `creature_template` SET `speed_run`=0.85714 WHERE `entry`=15642;
UPDATE `creature_template` SET `speed_run`=0.85714 WHERE `entry`=15643;
UPDATE `creature_template` SET `speed_run`=0.85714 WHERE `entry`=14881;
UPDATE `creature_template` SET `speed_run`=0.85714 WHERE `entry`=15641;
UPDATE `creature_template` SET `speed_run`=0.85714 WHERE `entry`=15407;
UPDATE `creature_template` SET `speed_run`=0.85714 WHERE `entry`=4075;
UPDATE `creature_template` SET `speed_run`=0.85714 WHERE `entry`=16068;
UPDATE `creature_template` SET `speed_run`=0.85714 WHERE `entry`=16162;
UPDATE `creature_template` SET `speed_run`=0.85714 WHERE `entry`=15645;
UPDATE `creature_template` SET `speed_run`=0.85714 WHERE `entry`=15668;
UPDATE `creature_template` SET `speed_run`=0.85714 WHERE `entry`=15669;
UPDATE `creature_template` SET `speed_run`=0.85714 WHERE `entry`=15670;
UPDATE `creature_template` SET `speed_run`=0.85714 WHERE `entry`=15950;
UPDATE `creature_template` SET `speed_run`=0.85714 WHERE `entry`=15648;
UPDATE `creature_template` SET `speed_run`=0.85714 WHERE `entry`=15647;
UPDATE `creature_template` SET `speed_run`=0.85714 WHERE `entry`=15637;
UPDATE `creature_template` SET `speed_run`=0.85714 WHERE `entry`=15965;
UPDATE `creature_template` SET `speed_run`=2.28571 WHERE `entry`=17076;
UPDATE `creature_template` SET `speed_walk`=1, `speed_run`=0.85714 WHERE `entry`=15656;
UPDATE `creature_template` SET `speed_walk`=1, `speed_run`=0.85714 WHERE `entry`=16804;
UPDATE `creature_template` SET `speed_walk`=1, `speed_run`=0.85714 WHERE `entry`=16242;
UPDATE `creature_template` SET `speed_walk`=1, `speed_run`=0.85714 WHERE `entry`=17086;
UPDATE `creature_template` SET `speed_walk`=1, `speed_run`=0.99206 WHERE `entry`=20098;
UPDATE `creature_template` SET `speed_walk`=1, `speed_run`=0.99206 WHERE `entry`=20244;
UPDATE `creature_template` SET `speed_walk`=1, `speed_run`=1.14286 WHERE `entry`=15958;
UPDATE `creature_template` SET `speed_walk`=1, `speed_run`=1.28968 WHERE `entry`=16292;
UPDATE `creature_template` SET `speed_walk`=1, `speed_run`=1.38571 WHERE `entry`=16238;
UPDATE `creature_template` SET `speed_walk`=1, `speed_run`=1.42857 WHERE `entry`=17314;
UPDATE `creature_template` SET `speed_walk`=1, `speed_run`=1.42857 WHERE `entry`=17544;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_03_01' WHERE sql_rev = '1640301341692176690';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
