-- DB update 2022_03_01_09 -> 2022_03_02_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_01_09';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_01_09 2022_03_02_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1645306739640504900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1645306739640504900');

/* Blood Feeders */
DELETE FROM `quest_details` WHERE `ID`=6461;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6461,1,0,0,0,0,0,0,0,0);

/* Jin'Zil's Forest Magic */
DELETE FROM `quest_details` WHERE `ID`=1058;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1058,4,6,0,0,0,0,0,0,0);

/* Report to Kadrak */
DELETE FROM `quest_details` WHERE `ID`=6542;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6542,1,1,0,0,0,0,0,0,0);

/* Boulderslide Ravine */
DELETE FROM `quest_details` WHERE `ID`=6421;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6421,1,0,0,0,0,0,0,0,0);

/* Earthen Arise */
DELETE FROM `quest_details` WHERE `ID`=6481;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6481,1,0,0,0,0,0,0,0,0);

/* Cenarius' Legacy */
DELETE FROM `quest_details` WHERE `ID`=1087;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1087,1,1,0,0,0,0,0,0,0);

/* Ordanus */
DELETE FROM `quest_details` WHERE `ID`=1088;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1088,5,0,0,0,0,0,0,0,0);

/* The Den */
DELETE FROM `quest_details` WHERE `ID`=1089;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1089,1,0,0,0,0,0,0,0,0);

/* Cycle of Rebirth */
DELETE FROM `quest_details` WHERE `ID`=6301;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6301,1,0,0,0,0,0,0,0,0);

/* New Life */
DELETE FROM `quest_details` WHERE `ID`=6381;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6381,1,0,0,0,0,0,0,0,0);

/* Harpies Threaten */
DELETE FROM `quest_details` WHERE `ID`=6282;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6282,1,0,0,0,0,0,0,0,0);

/* Bloodfury Bloodline */
DELETE FROM `quest_details` WHERE `ID`=6283;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6283,1,0,0,0,0,0,0,0,0);

/* Calling in the Reserves */
DELETE FROM `quest_details` WHERE `ID`=5881;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5881,1,0,0,0,0,0,0,0,0);

/* Ashenvale Outrunners */
DELETE FROM `quest_details` WHERE `ID`=6503;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6503,5,0,0,0,0,0,0,0,0);

/* The Ashenvale Hunt */
DELETE FROM `quest_details` WHERE `ID`=6382;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6382,1,0,0,0,0,0,0,0,0);

/* The Ashenvale Hunt */
DELETE FROM `quest_details` WHERE `ID`=235;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (235,22,1,0,0,0,0,0,0,0);

/* The Ashenvale Hunt */
DELETE FROM `quest_details` WHERE `ID`=742;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (742,22,1,0,0,0,0,0,0,0);

/* Stonetalon Standstill */
DELETE FROM `quest_details` WHERE `ID`=25;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (25,6,1,0,0,0,0,0,0,0);

/* Je'neu of the Earthen Ring */
DELETE FROM `quest_details` WHERE `ID`=824;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (824,1,0,0,0,0,0,0,0,0);

/* Warsong Supplies */
DELETE FROM `quest_details` WHERE `ID`=6571;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6571,1,0,0,0,0,0,0,0,0);

/* Amongst the Ruins */
UPDATE `quest_details` SET `Emote1`=1 WHERE `ID`=6921;

/* The Essence of Aku'Mai */
UPDATE `quest_details` SET `Emote1`=1 WHERE `ID`=6563;

/* Allegiance to the Old Gods */
DELETE FROM `quest_details` WHERE `ID`=6565;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6565,1,0,0,0,0,0,0,0,0);

/* Destroy the Legion */
UPDATE `quest_details` SET `Emote1`=5 WHERE `ID`=9534;

/* Never Again! */
DELETE FROM `quest_details` WHERE `ID`=9536;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9536,25,1,0,0,0,0,0,0,0);

/* The Lost Pages */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1 WHERE `ID`=6504;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_02_00' WHERE sql_rev = '1645306739640504900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
