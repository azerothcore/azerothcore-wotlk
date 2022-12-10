-- DB update 2022_03_03_04 -> 2022_03_05_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_03_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_03_04 2022_03_05_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1645313448111474600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1645313448111474600');

/* A Threat in Feralas */
DELETE FROM `quest_details` WHERE `ID`=2981;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2981,1,1,0,0,0,0,0,0,0);

/* The Ogres of Feralas */
DELETE FROM `quest_details` WHERE `ID`=2975;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2975,5,0,0,0,0,0,0,0,0);

/* The Ogres of Feralas */
DELETE FROM `quest_details` WHERE `ID`=2980;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2980,1,0,0,0,0,0,0,0,0);

/* Dark Ceremony */
DELETE FROM `quest_details` WHERE `ID`=2979;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2979,1,0,0,0,0,0,0,0,0);

/* The Gordunni Orb */
DELETE FROM `quest_details` WHERE `ID`=3002;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3002,1,0,0,0,0,0,0,0,0);

/* A New Cloak's Sheen */
DELETE FROM `quest_details` WHERE `ID`=2973;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2973,2,1,0,0,0,0,0,0,0);

/* A Grim Discovery */
DELETE FROM `quest_details` WHERE `ID`=2974;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2974,5,0,0,0,0,0,0,0,0);

/* A Grim Discovery */
DELETE FROM `quest_details` WHERE `ID`=2976;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2976,5,1,1,0,0,0,0,0,0);

/* A Strange Request */
DELETE FROM `quest_details` WHERE `ID`=3121;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3121,1,0,0,0,0,0,0,0,0);

/* Return to Witch Doctor Uzer'i */
DELETE FROM `quest_details` WHERE `ID`=3122;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3122,1,0,0,0,0,0,0,0,0);

/* Natural Materials */
DELETE FROM `quest_details` WHERE `ID`=3128;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3128,1,0,0,0,0,0,0,0,0);

/* War on the Woodpaw */
DELETE FROM `quest_details` WHERE `ID`=2862;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2862,1,0,0,0,0,0,0,0,0);

/* Alpha Strike */
DELETE FROM `quest_details` WHERE `ID`=2863;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2863,1,0,0,0,0,0,0,0,0);

/* Woodpaw Investigation */
DELETE FROM `quest_details` WHERE `ID`=2902;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2902,1,1,0,0,0,0,0,0,0);

/* Stinglasher */
DELETE FROM `quest_details` WHERE `ID`=7731;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7731,1,0,0,0,0,0,0,0,0);

/* Zukk'ash Infestation */
DELETE FROM `quest_details` WHERE `ID`=7730;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7730,1,0,0,0,0,0,0,0,0);

/* Zukk'ash Report */
DELETE FROM `quest_details` WHERE `ID`=7732;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7732,1,1,0,0,0,0,0,0,0);

/* The Mark of Quality */
DELETE FROM `quest_details` WHERE `ID`=2822;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2822,1,1,0,0,0,0,0,0,0);

/* Hippogryph Muisek */
DELETE FROM `quest_details` WHERE `ID`=3124;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3124,1,0,0,0,0,0,0,0,0);

/* Faerie Dragon Muisek */
DELETE FROM `quest_details` WHERE `ID`=3125;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3125,1,0,0,0,0,0,0,0,0);

/* Treant Muisek */
DELETE FROM `quest_details` WHERE `ID`=3126;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3126,1,0,0,0,0,0,0,0,0);

/* Mountain Giant Muisek */
DELETE FROM `quest_details` WHERE `ID`=3127;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3127,1,0,0,0,0,0,0,0,0);

/* Weapons of Spirit */
DELETE FROM `quest_details` WHERE `ID`=3129;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3129,1,0,0,0,0,0,0,0,0);

/* Dark Heart */
DELETE FROM `quest_details` WHERE `ID`=3062;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3062,1,0,0,0,0,0,0,0,0);

/* Vengeance on the Northspring */
DELETE FROM `quest_details` WHERE `ID`=3063;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3063,1,0,0,0,0,0,0,0,0);

/* The Strength of Corruption */
DELETE FROM `quest_details` WHERE `ID`=4120;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4120,1,0,0,0,0,0,0,0,0);

/* Improved Quality */
DELETE FROM `quest_details` WHERE `ID`=7734;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7734,1,0,0,0,0,0,0,0,0);

/* Again With the Zapped Giants */
DELETE FROM `quest_details` WHERE `ID`=7725;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7725,1,1,0,0,0,0,0,0,0);

/* Refuel for the Zapping */
DELETE FROM `quest_details` WHERE `ID`=7726;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7726,1,1,0,0,0,0,0,0,0);

/* Elven Legends */
DELETE FROM `quest_details` WHERE `ID`=7481;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7481,1,1,1,0,0,0,0,0,0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_05_00' WHERE sql_rev = '1645313448111474600';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
