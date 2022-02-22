-- DB update 2022_02_22_01 -> 2022_02_22_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_22_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_22_01 2022_02_22_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1645326770688077000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1645326770688077000');

ALTER TABLE `quest_request_items` CHANGE `VerifiedBuild` `VerifiedBuild` INT DEFAULT 0 NOT NULL;
ALTER TABLE `quest_details` CHANGE `VerifiedBuild` `VerifiedBuild` INT DEFAULT 0 NOT NULL;
ALTER TABLE `quest_offer_reward` CHANGE `VerifiedBuild` `VerifiedBuild` INT DEFAULT 0 NOT NULL;

/* Sample for Helbrim */
DELETE FROM `quest_details` WHERE `ID`=1358;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1358,1,0,0,0,0,0,0,0,0);

/* A Husband's Revenge */
DELETE FROM `quest_details` WHERE `ID`=530;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (530,1,0,0,0,0,0,0,0,0);

/* Arugal's Folly */
DELETE FROM `quest_details` WHERE `ID`=422;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (422,1,1,0,0,0,0,0,0,0);

/* Arugal's Folly */
DELETE FROM `quest_details` WHERE `ID`=424;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (424,1,1,0,0,0,0,0,0,0);

/* Arugal's Folly */
DELETE FROM `quest_details` WHERE `ID`=99;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (99,1,1,0,0,0,0,0,0,0);

/* A Recipe For Death */
DELETE FROM `quest_details` WHERE `ID`=450;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (450,1,1,0,0,0,0,0,0,0);

/* A Recipe For Death */
DELETE FROM `quest_details` WHERE `ID`=451;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (451,1,0,0,0,0,0,0,0,0);

/* Arugal Must Die */
DELETE FROM `quest_details` WHERE `ID`=1014;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1014,1,1,5,0,0,0,0,0,0);

/* Time To Strike */
DELETE FROM `quest_details` WHERE `ID`=494;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (494,5,1,0,0,0,0,0,0,0);

/* Helcular's Revenge */
DELETE FROM `quest_details` WHERE `ID`=552;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (552,1,0,0,0,0,0,0,0,0);

/* Helcular's Revenge */
DELETE FROM `quest_details` WHERE `ID`=553;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (553,1,0,0,0,0,0,0,0,0);

/* Battle of Hillsbrad */
DELETE FROM `quest_details` WHERE `ID`=527;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (527,25,1,1,0,0,0,0,0,0);

/* Battle of Hillsbrad */
DELETE FROM `quest_details` WHERE `ID`=528;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (528,1,1,1,0,0,0,0,0,0);

/* Battle of Hillsbrad */
DELETE FROM `quest_details` WHERE `ID`=529;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (529,1,1,0,0,0,0,0,0,0);

/* Battle of Hillsbrad */
DELETE FROM `quest_details` WHERE `ID`=532;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (532,1,1,0,0,0,0,0,0,0);

/* Battle of Hillsbrad */
DELETE FROM `quest_details` WHERE `ID`=539;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (539,1,1,1,0,0,0,0,0,0);

/* Battle of Hillsbrad */
DELETE FROM `quest_details` WHERE `ID`=541;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (541,6,5,1,0,0,0,0,0,0);

/* Battle of Hillsbrad */
DELETE FROM `quest_details` WHERE `ID`=14351;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (14351,1,66,0,0,0,0,0,0,0);

/* The Rescue */
DELETE FROM `quest_details` WHERE `ID`=498;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (498,1,1,1,0,0,0,0,0,0);

/* Infiltration */
DELETE FROM `quest_details` WHERE `ID`=533;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (533,1,0,0,0,0,0,0,0,0);

/* Gol'dir */
DELETE FROM `quest_details` WHERE `ID`=503;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (503,1,0,0,0,0,0,0,0,0);

/* Blackmoore's Legacy */
DELETE FROM `quest_details` WHERE `ID`=506;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (506,1,1,1,0,0,0,0,0,0);

/* Lord Aliden Perenolde */
DELETE FROM `quest_details` WHERE `ID`=507;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (507,1,0,0,0,0,0,0,0,0);

/* Souvenirs of Death */
DELETE FROM `quest_details` WHERE `ID`=546;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (546,1,1,6,0,0,0,0,0,0);

/* Humbert's Sword */
DELETE FROM `quest_details` WHERE `ID`=547;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (547,1,0,0,0,0,0,0,0,0);

/* Soothing Turtle Bisque */
DELETE FROM `quest_details` WHERE `ID`=7321;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7321,6,1,1,0,0,0,0,0,0);

/* Elixir of Suffering */
DELETE FROM `quest_details` WHERE `ID`=496;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (496,1,1,0,0,0,0,0,0,0);

/* Elixir of Suffering */
DELETE FROM `quest_details` WHERE `ID`=499;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (499,1,11,0,0,0,0,0,0,0);

/* Elixir of Pain */
DELETE FROM `quest_details` WHERE `ID`=501;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (501,1,5,0,0,0,0,0,0,0);

/* Elixir of Pain */
DELETE FROM `quest_details` WHERE `ID`=502;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (502,5,1,11,0,0,0,0,0,0);

/* Elixir of Agony */
DELETE FROM `quest_details` WHERE `ID`=509;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (509,1,1,0,0,0,0,0,0,0);

/* Elixir of Agony */
DELETE FROM `quest_details` WHERE `ID`=513;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (513,1,0,0,0,0,0,0,0,0);

/* Elixir of Agony */
DELETE FROM `quest_details` WHERE `ID`=517;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (517,1,1,11,0,0,0,0,0,0);

/* Elixir of Agony */
DELETE FROM `quest_details` WHERE `ID`=524;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (524,1,1,11,0,0,0,0,0,0);

/* Bathran's Hair */
DELETE FROM `quest_details` WHERE `ID`=1010;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1010,1,1,6,0,0,0,0,0,0);

/* The Ruins of Stardust */
DELETE FROM `quest_details` WHERE `ID`=1034;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1034,1,1,0,0,0,0,0,0,0);

/* Fallen Sky Lake */
DELETE FROM `quest_details` WHERE `ID`=1035;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1035,1,1,1,0,0,0,0,0,0);

/* Journey to Stonetalon Peak */
DELETE FROM `quest_details` WHERE `ID`=1056;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1056,1,1,0,0,0,0,0,0,0);

/* Raene's Cleansing */
DELETE FROM `quest_details` WHERE `ID`=991;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (991,1,1,20,0,0,0,0,0,0);

/* Raene's Cleansing */
DELETE FROM `quest_details` WHERE `ID`=1024;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1024,1,1,0,0,0,0,0,0,0);

/* Raene's Cleansing */
DELETE FROM `quest_details` WHERE `ID`=1030;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1030,6,1,1,0,0,0,0,0,0);

/* Raene's Cleansing */
DELETE FROM `quest_details` WHERE `ID`=1045;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1045,1,0,0,0,0,0,0,0,0);

/* Raene's Cleansing */
DELETE FROM `quest_details` WHERE `ID`=1046;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1046,1,0,0,0,0,0,0,0,0);

/* Culling the Threat */
DELETE FROM `quest_details` WHERE `ID`=1054;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1054,1,1,2,0,0,0,0,0,0);

/* Elemental Bracers */
DELETE FROM `quest_details` WHERE `ID`=1016;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1016,66,1,0,0,0,0,0,0,0);

/* Mage Summoner */
DELETE FROM `quest_details` WHERE `ID`=1017;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1017,1,1,5,0,0,0,0,0,0);

/* An Aggressive Defense */
DELETE FROM `quest_details` WHERE `ID`=1025;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1025,1,1,5,0,0,0,0,0,0);

/* Kayneth Stillwind */
DELETE FROM `quest_details` WHERE `ID`=4581;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4581,1,0,0,0,0,0,0,0,0);

/* Forsaken Diseases */
DELETE FROM `quest_details` WHERE `ID`=1011;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1011,1,5,0,0,0,0,0,0,0);

/* Insane Druids */
DELETE FROM `quest_details` WHERE `ID`=1012;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1012,1,0,0,0,0,0,0,0,0);

/* The Howling Vale */
DELETE FROM `quest_details` WHERE `ID`=1022;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1022,1,1,0,0,0,0,0,0,0);

/* Velinde Starsong */
DELETE FROM `quest_details` WHERE `ID`=1037;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1037,1,1,0,0,0,0,0,0,0);

/* Velinde's Effects */
DELETE FROM `quest_details` WHERE `ID`=1038;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1038,6,1,0,0,0,0,0,0,0);

/* The Barrens Port */
DELETE FROM `quest_details` WHERE `ID`=1039;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1039,1,1,0,0,0,0,0,0,0);

/* The Caravan Road */
DELETE FROM `quest_details` WHERE `ID`=1041;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1041,1,0,0,0,0,0,0,0,0);

/* The Carevin Family */
DELETE FROM `quest_details` WHERE `ID`=1042;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1042,274,1,0,0,0,0,0,0,0);

/* The Scythe of Elune */
DELETE FROM `quest_details` WHERE `ID`=1043;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1043,1,1,1,0,0,0,0,0,0);

/* Answered Questions */
DELETE FROM `quest_details` WHERE `ID`=1044;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1044,1,1,0,0,0,0,0,0,0);

/* A Helping Hand */
DELETE FROM `quest_details` WHERE `ID`=9533;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9533,1,274,1,0,0,0,0,0,0);

/* A Shameful Waste */
DELETE FROM `quest_details` WHERE `ID`=9517;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9517,1,0,0,0,0,0,0,0,0);

/* The Lost Chalice */
DELETE FROM `quest_details` WHERE `ID`=9519;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9519,1,0,0,0,0,0,0,0,0);

/* Destroy the Legion */
DELETE FROM `quest_details` WHERE `ID`=9516;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9516,5,1,25,0,0,0,0,0,0);

/* Never Again! */
DELETE FROM `quest_details` WHERE `ID`=9522;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9522,1,1,1,0,0,0,0,0,0);

/* Agents of Destruction */
DELETE FROM `quest_details` WHERE `ID`=9518;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9518,1,5,25,0,0,0,0,0,0);

/* Report from the Northern Front */
DELETE FROM `quest_details` WHERE `ID`=9521;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9521,1,0,0,0,0,0,0,0,0);

/* In Search of Thaelrid */
DELETE FROM `quest_details` WHERE `ID`=1198;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1198,1,1,0,0,0,0,0,0,0);

/* Twilight Falls */
DELETE FROM `quest_details` WHERE `ID`=1199;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1199,1,0,0,0,0,0,0,0,0);

/* The Tower of Althalaxx */
UPDATE `quest_details` SET `Emote2`=1 WHERE `ID`=966;

/* The Tower of Althalaxx */
UPDATE `quest_details` SET `Emote2`=1 WHERE `ID`=967;

/* The Tower of Althalaxx */
UPDATE `quest_details` SET `Emote2`=1, `Emote3`=1 WHERE `ID`=1140;

/* The Tower of Althalaxx */
DELETE FROM `quest_details` WHERE `ID`=1167;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1167,1,0,0,0,0,0,0,0,0);

/* The Tower of Althalaxx */
UPDATE `quest_details` SET `Emote2`=1 WHERE `ID`=1143;

/* The Tower of Althalaxx */
DELETE FROM `quest_details` WHERE `ID`=981;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (981,1,0,0,0,0,0,0,0,0);

/* The Corruption Abroad */
DELETE FROM `quest_details` WHERE `ID`=3765;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3765,1,1,0,0,0,0,0,0,0);

/* On Guard in Stonetalon */
DELETE FROM `quest_details` WHERE `ID`=1070;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1070,3,6,0,0,0,0,0,0,0);

/* On Guard in Stonetalon */
DELETE FROM `quest_details` WHERE `ID`=1085;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1085,1,1,0,0,0,0,0,0,0);

/* A Gnome's Respite */
DELETE FROM `quest_details` WHERE `ID`=1071;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1071,1,0,0,0,0,0,0,0,0);

/* A Scroll from Mauren */
DELETE FROM `quest_details` WHERE `ID`=1075;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1075,1,0,0,0,0,0,0,0,0);

/* Devils in Westfall */
DELETE FROM `quest_details` WHERE `ID`=1076;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1076,1,0,0,0,0,0,0,0,0);

/* Special Delivery for Gaxim */
DELETE FROM `quest_details` WHERE `ID`=1077;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1077,1,0,0,0,0,0,0,0,0);

/* An Old Colleague */
DELETE FROM `quest_details` WHERE `ID`=1072;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1072,1,0,0,0,0,0,0,0,0);

/* Ineptitude + Chemicals = Fun */
DELETE FROM `quest_details` WHERE `ID`=1073;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1073,11,1,1,0,0,0,0,0,0);

/* Ineptitude + Chemicals = Fun */
DELETE FROM `quest_details` WHERE `ID`=1074;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1074,1,11,0,0,0,0,0,0,0);

/* Covert Ops - Alpha */
DELETE FROM `quest_details` WHERE `ID`=1079;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1079,1,0,0,0,0,0,0,0,0);

/* Covert Ops - Beta */
DELETE FROM `quest_details` WHERE `ID`=1080;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1080,1,0,0,0,0,0,0,0,0);

/* Kaela's Update */
DELETE FROM `quest_details` WHERE `ID`=1091;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1091,1,0,0,0,0,0,0,0,0);

/* Enraged Spirits */
DELETE FROM `quest_details` WHERE `ID`=1083;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1083,1,1,1,0,0,0,0,0,0);

/* Wounded Ancients */
DELETE FROM `quest_details` WHERE `ID`=1084;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1084,1,1,0,0,0,0,0,0,0);

/* Update for Sentinel Thenysil */
DELETE FROM `quest_details` WHERE `ID`=1082;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1082,1,0,0,0,0,0,0,0,0);

/* Reception from Tyrande */
DELETE FROM `quest_details` WHERE `ID`=1081;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1081,1,1,0,0,0,0,0,0,0);

/* Castpipe's Task */
DELETE FROM `quest_details` WHERE `ID`=2931;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2931,5,1,1,0,0,0,0,0,0);

/* Data Rescue */
DELETE FROM `quest_details` WHERE `ID`=2930;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2930,5,1,1,6,0,0,0,0,0);

/* A Call to Arms: The Plaguelands! */
DELETE FROM `quest_details` WHERE `ID` IN (5094,5066,5090,5091,10373,5093,10374,5095);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5094,5,0,0,0,0,0,0,0,0);

/* A Call to Arms: The Plaguelands! */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5066,5,0,0,0,0,0,0,0,0);

/* A Call to Arms: The Plaguelands! */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5090,5,0,0,0,0,0,0,0,0);

/* A Call to Arms: The Plaguelands! */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5091,5,0,0,0,0,0,0,0,0);

/* A Call to Arms: The Plaguelands! */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10373,5,0,0,0,0,0,0,0,0);

/* A Call to Arms: The Plaguelands! */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5093,5,0,0,0,0,0,0,0,0);

/* A Call to Arms: The Plaguelands! */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10374,5,0,0,0,0,0,0,0,0);

/* A Call to Arms: The Plaguelands! */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5095,5,0,0,0,0,0,0,0,0);

/* Scarlet Diversions */
DELETE FROM `quest_details` WHERE `ID`=5096;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5096,1,0,0,0,0,0,0,0,0);

/* The Scourge Cauldrons */
DELETE FROM `quest_details` WHERE `ID`=5228;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5228,1,0,0,0,0,0,0,0,0);

/* Target: Felstone Field */
DELETE FROM `quest_details` WHERE `ID`=5229;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5229,1,0,0,0,0,0,0,0,0);

/* Target: Dalson's Tears */
DELETE FROM `quest_details` WHERE `ID`=5231;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5231,1,0,0,0,0,0,0,0,0);

/* Target: Writhing Haunt */
DELETE FROM `quest_details` WHERE `ID`=5233;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5233,1,0,0,0,0,0,0,0,0);

/* Target: Gahrron's Withering */
DELETE FROM `quest_details` WHERE `ID`=5235;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5235,1,0,0,0,0,0,0,0,0);

/* All Along the Watchtowers */
DELETE FROM `quest_details` WHERE `ID`=5098;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5098,1,0,0,0,0,0,0,0,0);

/* All Along the Watchtowers */
UPDATE `quest_offer_reward` SET `Emote1`=5, `RewardText`="My warlocks are reporting that our beacon trackers are picking up extremely strong signals on all four towers!  You've executed my orders with the skill and precision of a seasoned veteran.  Your service to the Horde is duly noted once more, $N!$B$BWith the towers marked, our preparations for the attack are now in place.  The time has come to take the fight to the Scourge!" WHERE `ID`=5098;

/* Alas, Andorhal */
DELETE FROM `quest_details` WHERE `ID`=105;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (105,5,1,1,5,0,0,0,0,0);

/* Scholomance */
DELETE FROM `quest_details` WHERE `ID`=838;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (838,1,0,0,0,0,0,0,0,0);

/* Skeletal Fragments */
DELETE FROM `quest_details` WHERE `ID`=964;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (964,1,0,0,0,0,0,0,0,0);

/* Fire Plume Forged */
DELETE FROM `quest_details` WHERE `ID`=5802;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5802,1,0,0,0,0,0,0,0,0);

/* Araj's Scarab */
DELETE FROM `quest_details` WHERE `ID`=5804;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5804,1,0,0,0,0,0,0,0,0);

/* A Plague Upon Thee */
DELETE FROM `quest_details` WHERE `ID`=5901;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5901,1,1,0,0,0,0,0,0,0);

/* A Plague Upon Thee */
DELETE FROM `quest_details` WHERE `ID`=5902;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5902,1,1,0,0,0,0,0,0,0);

/* The Last Barov */
DELETE FROM `quest_details` WHERE `ID`=5342;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5342,1,1,0,0,3500,0,0,0,0);

/* The Jeremiah Blues */
DELETE FROM `quest_details` WHERE `ID`=5049;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5049,1,0,0,0,0,0,0,0,0);

/* Good Natured Emma */
DELETE FROM `quest_details` WHERE `ID`=5048;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5048,1,0,0,0,0,0,0,0,0);

/* Good Luck Charm */
DELETE FROM `quest_details` WHERE `ID`=5050;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5050,2,0,0,0,0,0,0,0,0);

/* Unfinished Business */
DELETE FROM `quest_details` WHERE `ID`=6004;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6004,1,1,0,0,0,0,0,0,0);

/* Unfinished Business */
DELETE FROM `quest_details` WHERE `ID`=6023;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6023,1,1,0,0,0,0,0,0,0);

/* Unfinished Business */
DELETE FROM `quest_details` WHERE `ID`=6025;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6025,1,1,0,0,0,0,0,0,0);

/* The So-Called Mark of the Lightbringer */
UPDATE `quest_template` SET `RewardNextQuest`=0 WHERE `ID`=9443;

/* Defiling Uther's Tomb */
DELETE FROM `quest_details` WHERE `ID`=9444;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9444,1,1,1,0,0,0,0,0,0);

/* To The Bulwark */
DELETE FROM `quest_details` WHERE `ID`=9601;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9601,1,0,0,0,0,0,0,0,0);

/* Prove Your Hatred */
DELETE FROM `quest_details` WHERE `ID`=10590;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10590,1,1,1,0,0,0,0,0,0);

/* Wisdom of the Banshee Queen */
DELETE FROM `quest_details` WHERE `ID`=10592;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10592,1,1,0,0,0,2000,0,0,0);

/* Ancient Evil */
DELETE FROM `quest_details` WHERE `ID`=10593;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10593,1,1,1,0,0,0,0,0,0);

/* Clear the Way */
DELETE FROM `quest_details` WHERE `ID`=5092;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5092,1,0,0,0,0,0,0,0,0);

/* All Along the Watchtowers */
DELETE FROM `quest_details` WHERE `ID`=5097;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5097,1,0,0,0,0,0,0,0,0);

/* The Scourge Cauldrons */
DELETE FROM `quest_details` WHERE `ID`=5215;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5215,1,0,0,0,0,0,0,0,0);

/* Target: Felstone Field */
DELETE FROM `quest_details` WHERE `ID`=5216;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5216,1,0,0,0,0,0,0,0,0);

/* Target: Dalson's Tears */
DELETE FROM `quest_details` WHERE `ID`=5219;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5219,1,0,0,0,0,0,0,0,0);

/* Target: Writhing Haunt */
DELETE FROM `quest_details` WHERE `ID`=5222;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5222,1,0,0,0,0,0,0,0,0);

/* Target: Gahrron's Withering */
DELETE FROM `quest_details` WHERE `ID`=5225;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5225,1,0,0,0,0,0,0,0,0);

/* Barov Family Fortune */
DELETE FROM `quest_details` WHERE `ID`=5343;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5343,1,1,1,5,0,0,0,0,0);

/* The Last Barov */
DELETE FROM `quest_details` WHERE `ID`=5344;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5344,1,1,0,0,3500,0,0,0,0);

/* Scholomance */
DELETE FROM `quest_details` WHERE `ID`=5533;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5533,1,0,0,0,0,0,0,0,0);

/* Skeletal Fragments */
DELETE FROM `quest_details` WHERE `ID`=5537;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5537,1,0,0,0,0,0,0,0,0);

/* Mold Rhymes With... */
DELETE FROM `quest_details` WHERE `ID`=5538;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5538,1,1,0,0,0,0,0,0,0);

/* Mold Rhymes With... */
UPDATE `quest_offer_reward` SET `Emote1`=5, `RewardText`="Arbington said you'd deliver the goods, and deliver you have! A deal is a deal; let me pack the fragments into the mold for you.$b$bDid Arbington imbue them already? Excellent... otherwise, it would have been a long trip back to the Chillwind Camp for you." WHERE `ID`=5538;

/* Fire Plume Forged */
DELETE FROM `quest_details` WHERE `ID`=5801;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5801,1,0,0,0,0,0,0,0,0);

/* Araj's Scarab */
DELETE FROM `quest_details` WHERE `ID`=5803;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5803,1,0,0,0,0,0,0,0,0);

/* Alas, Andorhal */
DELETE FROM `quest_details` WHERE `ID`=211;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (211,5,1,1,0,0,0,0,0,0);

/* A Plague Upon Thee */
DELETE FROM `quest_details` WHERE `ID`=5903;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5903,1,1,0,0,0,0,0,0,0);

/* A Plague Upon Thee */
DELETE FROM `quest_details` WHERE `ID`=5904;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5904,1,1,0,0,0,0,0,0,0);

/* The Eastern Plagues */
DELETE FROM `quest_details` WHERE `ID`=6185;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6185,1,1,1,1,0,0,1000,2000,0);

/* Order Must Be Restored */
DELETE FROM `quest_details` WHERE `ID`=6187;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6187,1,1,1,25,1000,2000,3000,3500,0);

/* Chillwind Camp */
DELETE FROM `quest_details` WHERE `ID`=8415;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8415,1,0,0,0,0,0,0,0,0);

/* Dispelling Evil */
DELETE FROM `quest_details` WHERE `ID`=8414;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8414,1,0,0,0,0,0,0,0,0);

/* Inert Scourgestones */
DELETE FROM `quest_details` WHERE `ID`=8416;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8416,1,0,0,0,0,0,0,0,0);

/* Forging the Mightstone */
DELETE FROM `quest_details` WHERE `ID`=8418;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8418,1,0,0,0,0,0,0,0,0);

/* Doctor Theolen Krastinov, the Butcher */
DELETE FROM `quest_details` WHERE `ID`=5382;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5382,1,1,1,1,0,0,0,0,0);

/* Kirtonos the Herald */
DELETE FROM `quest_details` WHERE `ID`=5384;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5384,5,1,1,1,0,0,0,0,0);

/* The Human, Ras Frostwhisper */
DELETE FROM `quest_details` WHERE `ID`=5461;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5461,1,1,1,1,0,0,0,0,0);

/* The Dying, Ras Frostwhisper */
DELETE FROM `quest_details` WHERE `ID`=5462;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5462,1,1,1,25,0,0,0,0,0);

/* Menethil's Gift */
DELETE FROM `quest_details` WHERE `ID`=5463;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5463,1,1,51,25,0,0,0,0,0);

/* Soulbound Keepsake */
DELETE FROM `quest_details` WHERE `ID`=5465;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5465,1,0,0,0,0,0,0,0,0);

/* The Lich, Ras Frostwhisper */
DELETE FROM `quest_details` WHERE `ID`=5466;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5466,1,1,0,0,0,0,0,0,0);

/* A Matter of Time */
DELETE FROM `quest_details` WHERE `ID`=4971;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4971,1,0,0,0,0,0,0,0,0);

/* Counting Out Time */
DELETE FROM `quest_details` WHERE `ID`=4972;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4972,1,0,0,0,0,0,0,0,0);

/* Counting Out Time */
DELETE FROM `quest_details` WHERE `ID`=4973;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4973,1,0,0,0,0,0,0,0,0);

/* Counting Out Time */
UPDATE `quest_offer_reward` SET `Emote1`=2, `RewardText`="Again, I thank you for your assistance.  Please accept this gift.  While you still may not know when to use such an item, perhaps in the future the path of time will reveal its true intentions to you.  You could say that I've seen as such happening to you, $N."  WHERE `ID`=4973;

/* The Everlook Report */
DELETE FROM `quest_details` WHERE `ID`=6029;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6029,1,0,0,0,0,0,0,0,0);

/* Demon Dogs */
DELETE FROM `quest_details` WHERE `ID`=5542;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5542,1,1,1,0,0,0,0,0,0);

/* Blood Tinged Skies */
DELETE FROM `quest_details` WHERE `ID`=5543;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5543,1,1,1,1,0,0,0,0,0);

/* Carrion Grubbage */
DELETE FROM `quest_details` WHERE `ID`=5544;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5544,1,6,1,5,0,0,0,0,0);

/* Of Forgotten Memories */
DELETE FROM `quest_details` WHERE `ID`=5781;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5781,1,1,1,1,0,0,0,0,0);

/* Of Lost Honor */
DELETE FROM `quest_details` WHERE `ID`=5845;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5845,1,1,1,1,0,0,0,0,0);

/* Of Love and Family */
DELETE FROM `quest_details` WHERE `ID`=5846;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5846,1,1,1,1,0,0,0,0,0);

/* Of Love and Family */
DELETE FROM `quest_details` WHERE `ID`=5848;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5848,1,1,1,1,0,0,0,0,0);

/* Find Myranda */
DELETE FROM `quest_details` WHERE `ID`=5861;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5861,1,1,1,1,0,0,0,0,0);

/* Scarlet Subterfuge */
DELETE FROM `quest_details` WHERE `ID`=5862;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5862,1,1,1,1,0,0,0,0,0);

/* In Dreams */
DELETE FROM `quest_details` WHERE `ID`=5944;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5944,1,6,1,1,0,0,0,0,0);

/* The Restless Souls */
DELETE FROM `quest_details` WHERE `ID`=5281;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5281,1,1,1,1,0,0,0,0,0);

/* The Restless Souls */
DELETE FROM `quest_details` WHERE `ID`=5282;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5282,1,1,1,1,0,0,0,0,0);

/* Zaeldarr the Outcast */
DELETE FROM `quest_details` WHERE `ID`=6021;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6021,5,0,0,0,0,0,0,0,0);

/* Duke Nicholas Zverenhoff */
DELETE FROM `quest_details` WHERE `ID`=6030;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6030,1,0,0,0,0,0,0,0,0);

/* The Archivist */
DELETE FROM `quest_details` WHERE `ID`=5251;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5251,1,6,5,1,0,0,0,0,0);

/* Augustus' Receipt Book */
DELETE FROM `quest_details` WHERE `ID`=6164;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6164,1,6,1,5,0,0,0,0,0);

/* Sister Pamela */
DELETE FROM `quest_details` WHERE `ID`=5601;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5601,5,18,20,0,0,1000,2000,0,0);

/* Little Pamela */
DELETE FROM `quest_details` WHERE `ID`=5142;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5142,1,20,0,0,0,0,0,0,0);

/* A Strange Historian */
DELETE FROM `quest_details` WHERE `ID`=5153;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5153,1,0,0,0,0,0,0,0,0);

/* The Annals of Darrowshire */
DELETE FROM `quest_details` WHERE `ID`=5154;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5154,1,0,0,0,0,0,0,0,0);

/* Brother Carlin */
DELETE FROM `quest_details` WHERE `ID`=5210;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5210,1,0,0,0,0,0,0,0,0);

/* Defenders of Darrowshire */
DELETE FROM `quest_details` WHERE `ID`=5211;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5211,5,1,0,0,0,0,0,0,0);

/* The Champion of the Banshee Queen */
DELETE FROM `quest_details` WHERE `ID`=5961;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5961,1,25,1,1,0,0,0,0,0);

/* To Kill With Purpose */
DELETE FROM `quest_details` WHERE `ID`=6022;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6022,1,1,1,1,0,0,0,0,0);

/* Un-Life's Little Annoyances */
DELETE FROM `quest_details` WHERE `ID`=6042;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6042,1,1,6,5,0,0,0,0,0);

/* The Ranger Lord's Behest */
DELETE FROM `quest_details` WHERE `ID`=6133;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6133,1,1,25,1,0,0,0,0,0);

/* Duskwing, Oh How I Hate Thee... */
UPDATE `quest_offer_reward` SET `Emote1`=273, `RewardText`="Excellent work, imbecile. I shall fashion this fur into something you can use." WHERE `ID`=6135;

/* Ramstein */
DELETE FROM `quest_details` WHERE `ID`=6163;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6163,1,1,1,1,0,0,0,0,0);

/* The Call to Command */
DELETE FROM `quest_details` WHERE `ID`=6144;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6144,1,1,25,5,0,0,0,0,0);

/* The Crimson Courier */
DELETE FROM `quest_details` WHERE `ID`=14350;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (14350,1,1,1,5,0,0,0,0,0);

/* Nathanos' Ruse */
DELETE FROM `quest_details` WHERE `ID`=6146;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6146,1,1,1,1,0,0,0,0,0);

/* Return to Nathanos */
DELETE FROM `quest_details` WHERE `ID`=6147;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6147,1,1,0,0,0,0,0,0,0);

/* The Scarlet Oracle, Demetria */
DELETE FROM `quest_details` WHERE `ID`=6148;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6148,1,1,1,25,0,0,0,0,0);

/* Heroes of Darrowshire */
DELETE FROM `quest_details` WHERE `ID`=5168;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5168,1,0,0,0,0,0,0,0,0);

/* Villains of Darrowshire */
DELETE FROM `quest_details` WHERE `ID`=5181;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5181,1,0,0,0,0,0,0,0,0);

/* Marauders of Darrowshire */
DELETE FROM `quest_details` WHERE `ID`=5206;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5206,1,0,0,0,0,0,0,0,0);

/* Return to Chromie */
DELETE FROM `quest_details` WHERE `ID`=5941;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5941,1,0,0,0,0,0,0,0,0);

/* The Battle of Darrowshire */
DELETE FROM `quest_details` WHERE `ID`=5721;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5721,1,0,0,0,0,0,0,0,0);

/* Savage Flora */
DELETE FROM `quest_details` WHERE `ID`=9136;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9136,1,1,1,1,0,0,0,0,0);

/* Houses of the Holy */
DELETE FROM `quest_details` WHERE `ID`=5243;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5243,1,1,1,25,0,0,0,0,0);

/* Houses of the Holy */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1, `CompletionText`="Be wary, not all supply crates will have survived the destruction of the city. The Scourge dare not touch the water but surely the holy water will not prevent vermin infestations." WHERE `ID`=5243;

/* Houses of the Holy */
UPDATE `quest_offer_reward` SET `Emote1`=1, `Emote2`=1, `RewardText`="Well done, $R. You have proven that while you are tolerant of others, you will stop at nothing to destroy the minions of Kel'Thuzad." WHERE `ID`=5243;

/* Bonescythe Digs */
DELETE FROM `quest_details` WHERE `ID`=9126;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9126,1,1,1,6,0,0,0,0,0);

/* Cryptstalker Armor Doesn't Make Itself... */
DELETE FROM `quest_details` WHERE `ID`=9124;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9124,6,1,1,0,0,1000,0,0,0);

/* The Elemental Equation */
DELETE FROM `quest_details` WHERE `ID`=9128;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9128,2,6,1,1,0,0,0,0,0);

/* Binding the Dreadnaught */
DELETE FROM `quest_details` WHERE `ID`=9131;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9131,6,1,1,25,0,0,0,0,0);

/* The Great Fras Siabi */
DELETE FROM `quest_details` WHERE `ID`=5214;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5214,1,1,5,20,0,0,0,0,0);

/* When Smokey Sings, I Get Violent */
DELETE FROM `quest_details` WHERE `ID`=6041;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6041,1,1,1,5,0,0,0,0,0);

/* They Call Me "The Rooster" */
DELETE FROM `quest_details` WHERE `ID`=9141;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9141,6,1,1,1,0,0,0,0,0);

/* Glacial Wrists */
DELETE FROM `quest_details` WHERE `ID`=9238;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9238,1,1,0,0,0,0,0,0,0);

/* Glacial Gloves */
DELETE FROM `quest_details` WHERE `ID`=9239;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9239,1,1,0,0,0,0,0,0,0);

/* The Flesh Does Not Lie */
DELETE FROM `quest_details` WHERE `ID`=5212;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5212,1,1,5,1,0,0,0,0,0);

/* The Active Agent */
DELETE FROM `quest_details` WHERE `ID`=5213;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5213,1,1,1,0,0,0,0,0,0);

/* Plagued Hatchlings */
DELETE FROM `quest_details` WHERE `ID`=5529;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5529,5,1,0,0,0,0,0,0,0);

/* Superior Armaments of Battle - Friend of the Dawn */
DELETE FROM `quest_details` WHERE `ID`=9221;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9221,1,6,1,1,0,0,0,0,0);

/* Epic Armaments of Battle - Friend of the Dawn */
DELETE FROM `quest_details` WHERE `ID`=9222;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9222,1,6,1,1,0,0,0,0,0);

/* Superior Armaments of Battle - Revered Amongst the Dawn */
DELETE FROM `quest_details` WHERE `ID`=9226;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9226,1,6,1,1,0,0,0,0,0);

/* Epic Armaments of Battle - Revered Amongst the Dawn */
DELETE FROM `quest_details` WHERE `ID`=9225;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9225,1,6,1,1,0,0,0,0,0);

/* Epic Armaments of Battle - Exalted Amongst the Dawn */
DELETE FROM `quest_details` WHERE `ID`=9228;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9228,1,6,1,1,0,0,0,0,0);

/* Superior Armaments of Battle - Exalted Amongst the Dawn */
DELETE FROM `quest_details` WHERE `ID`=9227;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9227,1,6,1,1,0,0,0,0,0);

/* Above and Beyond */
DELETE FROM `quest_details` WHERE `ID`=5263;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5263,1,1,1,0,0,0,0,0,0);

/* Lord Maxwell Tyrosus */
DELETE FROM `quest_details` WHERE `ID`=5264;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5264,1,1,5,0,0,0,0,0,0);

/* The Argent Hold */
DELETE FROM `quest_details` WHERE `ID`=5265;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5265,1,1,2,0,0,0,0,0,0);

/* The Balance of Light and Shadow */
DELETE FROM `quest_details` WHERE `ID`=7622;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7622,1,1,1,2,0,0,0,0,0);

/* Bolstering Our Defenses */
DELETE FROM `quest_details` WHERE `ID`=9665;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9665,66,1,1,0,0,0,0,0,0);

/* Establishing New Outposts */
DELETE FROM `quest_details` WHERE `ID`=9664;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9664,66,1,1,0,0,0,0,0,0);

/* Forces of Jaedenar */
DELETE FROM `quest_details` WHERE `ID`=5155;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5155,1,1,0,0,0,0,0,0,0);

/* Collection of the Corrupt Water */
DELETE FROM `quest_details` WHERE `ID`=5157;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5157,1,1,0,0,0,0,0,0,0);

/* Seeking Spiritual Aid */
DELETE FROM `quest_details` WHERE `ID`=5158;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5158,1,0,0,0,0,0,0,0,0);

/* Cleansed Water Returns to Felwood */
DELETE FROM `quest_details` WHERE `ID`=5159;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5159,1,1,0,0,0,0,0,0,0);

/* Dousing the Flames of Protection */
DELETE FROM `quest_details` WHERE `ID`=5165;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5165,1,1,0,0,0,0,0,0,0);

/* A Final Blow */
DELETE FROM `quest_details` WHERE `ID`=5242;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5242,1,1,0,0,0,0,0,0,0);

/* Verifying the Corruption */
DELETE FROM `quest_details` WHERE `ID`=5156;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5156,1,1,1,0,0,0,0,0,0);

/* Cleansing Felwood */
DELETE FROM `quest_details` WHERE `ID` IN (4101,4102);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4101,1,0,0,0,0,0,0,0,0);

/* Cleansing Felwood */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4102,1,0,0,0,0,0,0,0,0);

/* A Strange One */
DELETE FROM `quest_details` WHERE `ID`=6605;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6605,1,0,0,0,0,0,0,0,0);

/* Well of Corruption */
DELETE FROM `quest_details` WHERE `ID`=4505;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4505,1,1,1,0,0,0,0,0,0);

/* Corrupted Sabers */
DELETE FROM `quest_details` WHERE `ID`=4506;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4506,1,11,0,0,0,0,0,0,0);

/* A Husband's Last Battle */
DELETE FROM `quest_details` WHERE `ID`=6162;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6162,1,1,5,0,0,0,0,0,0);

/* Timbermaw Ally */
DELETE FROM `quest_details` WHERE `ID`=8460;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8460,1,1,0,0,0,0,0,0,0);

/* Speak to Nafien */
DELETE FROM `quest_details` WHERE `ID`=8462;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8462,1,0,0,0,0,0,0,0,0);

/* Wild Guardians */
DELETE FROM `quest_details` WHERE `ID`=4521;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4521,1,0,0,0,0,0,0,0,0);

/* Wild Guardians */
DELETE FROM `quest_details` WHERE `ID`=4741;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4741,1,0,0,0,0,0,0,0,0);

/* Wild Guardians */
DELETE FROM `quest_details` WHERE `ID`=4721;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4721,1,0,0,0,0,0,0,0,0);

/* The Corruption of the Jadefire */
DELETE FROM `quest_details` WHERE `ID`=4421;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4421,1,2,1,0,0,0,0,0,0);

/* Further Corruption */
DELETE FROM `quest_details` WHERE `ID`=4906;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4906,1,1,0,0,0,0,0,0,0);

/* Felbound Ancients */
DELETE FROM `quest_details` WHERE `ID`=4441;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4441,1,1,0,0,0,0,0,0,0);

/* Purified! */
DELETE FROM `quest_details` WHERE `ID`=4442;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4442,1,0,0,0,0,0,0,0,0);

/* Ancient Spirit */
UPDATE `quest_offer_reward` SET `Emote1`=2, `RewardText`="Yes, $N. Felwood has been through much hardship. Thank you for what you have done.$B$BOne day, we may be able to reclaim Felwood from the corruption; every kind deed helps." WHERE `ID`=4261;

/* Rescue From Jaedenar */
DELETE FROM `quest_details` WHERE `ID`=5203;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5203,1,0,0,0,0,0,0,0,0);

/* Retribution of the Light */
DELETE FROM `quest_details` WHERE `ID`=5204;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5204,1,1,1,0,0,0,0,0,0);

/* An Imp's Request */
DELETE FROM `quest_details` WHERE `ID`=8419;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8419,1,0,0,0,0,0,0,0,0);

/* What Niby Commands */
DELETE FROM `quest_details` WHERE `ID`=7601;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7601,1,1,1,1,0,0,0,0,0);

/* The Root of All Evil */
DELETE FROM `quest_details` WHERE `ID`=8481;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8481,1,1,0,0,0,0,0,0,0);

/* The Brokering of Peace */
DELETE FROM `quest_details` WHERE `ID` IN (8484,8485);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8484,1,1,0,0,0,0,0,0,0);

/* The Brokering of Peace */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8485,1,1,0,0,0,0,0,0,0);

/* Brotherhood of Thieves */
DELETE FROM `quest_details` WHERE `ID`=18;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (18,1,0,0,0,0,0,0,0,0);

/* Garments of the Light */
DELETE FROM `quest_details` WHERE `ID`=5624;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5624,1,0,0,0,0,0,0,0,0);

/* Report to Gryan Stoutmantle */
DELETE FROM `quest_details` WHERE `ID`=109;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (109,1,25,0,0,0,0,0,0,0);

/* A Watchful Eye */
DELETE FROM `quest_details` WHERE `ID`=94;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (94,1,0,0,0,0,0,0,0,0);

/* Tome of Divinity */
DELETE FROM `quest_details` WHERE `ID`=2998;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2998,1,1,0,0,0,0,0,0,0);

/* The Tome of Divinity */
DELETE FROM `quest_details` WHERE `ID`=1643;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1643,2,1,1,0,0,0,0,0,0);

/* The Tome of Divinity */
DELETE FROM `quest_details` WHERE `ID`=1644;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1644,1,1,1,16,0,0,0,0,0);

/* The Tome of Divinity */
DELETE FROM `quest_details` WHERE `ID`=1780;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1780,1,1,3,0,0,0,0,0,0);

/* The Tome of Divinity */
DELETE FROM `quest_details` WHERE `ID`=1781;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1781,1,1,1,0,0,0,0,0,0);

/* The Tome of Divinity */
DELETE FROM `quest_details` WHERE `ID`=1786;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1786,1,1,1,1,0,0,0,0,0);

/* The Tome of Divinity */
DELETE FROM `quest_details` WHERE `ID`=1787;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1787,1,1,6,1,0,0,0,0,0);

/* The Tome of Divinity */
DELETE FROM `quest_details` WHERE `ID`=1788;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1788,1,1,2,0,0,0,0,0,0);

/* Wine Shop Advert */
DELETE FROM `quest_details` WHERE `ID`=332;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (332,1,0,0,0,0,0,0,0,0);

/* Retrieval for Mauren */
DELETE FROM `quest_details` WHERE `ID`=1078;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1078,1,1,1,0,0,0,0,0,0);

/* The Color of Blood */
DELETE FROM `quest_details` WHERE `ID`=388;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (388,1,5,0,0,0,0,0,0,0);

/* Quell The Uprising */
DELETE FROM `quest_details` WHERE `ID`=387;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (387,5,0,0,0,0,0,0,0,0);

/* Mazen's Behest */
DELETE FROM `quest_details` WHERE `ID`=1363;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1363,1,6,1,6,0,0,0,0,0);

/* The Corruption Abroad */
DELETE FROM `quest_details` WHERE `ID`=3765;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3765,2,1,1,0,0,0,0,0,0);

/* Speaking of Fortitude */
DELETE FROM `quest_details` WHERE `ID`=343;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (343,1,1,2,0,0,0,0,0,0);

/* Brother Paxton */
DELETE FROM `quest_details` WHERE `ID`=344;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (344,1,1,1,0,0,0,0,0,0);

/* Ink Supplies */
DELETE FROM `quest_details` WHERE `ID`=345;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (345,1,1,1,0,0,0,0,0,0);

/* Rethban Ore */
DELETE FROM `quest_details` WHERE `ID`=347;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (347,1,1,0,0,0,0,0,0,0);

/* Return to Kristoff */
DELETE FROM `quest_details` WHERE `ID`=346;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (346,1,0,0,0,0,0,0,0,0);

/* Humble Beginnings */
DELETE FROM `quest_details` WHERE `ID`=399;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (399,1,0,0,0,0,0,0,0,0);

/* Bring the Light */
DELETE FROM `quest_details` WHERE `ID`=3636;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3636,1,0,0,0,0,0,0,0,0);

/* Underground Assault */
DELETE FROM `quest_details` WHERE `ID`=2040;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2040,1,0,0,0,0,0,0,0,0);

/* Gyrodrillmatic Excavationators */
DELETE FROM `quest_details` WHERE `ID`=2928;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2928,1,0,0,0,0,0,0,0,0);

/* Collecting Memories */
DELETE FROM `quest_details` WHERE `ID`=168;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (168,1,1,1,0,0,0,0,0,0);

/* Oh Brother. . . */
DELETE FROM `quest_details` WHERE `ID`=167;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (167,1,1,1,0,0,0,0,0,0);

/* The Forgotten Heirloom */
DELETE FROM `quest_details` WHERE `ID`=64;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (64,5,1,0,0,0,0,0,0,0);

/* Poor Old Blanchy */
DELETE FROM `quest_details` WHERE `ID`=151;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (151,5,1,0,0,0,0,0,0,0);

/* Westfall Stew */
DELETE FROM `quest_details` WHERE `ID`=36;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (36,1,6,0,0,0,0,0,0,0);

/* Westfall Stew */
DELETE FROM `quest_details` WHERE `ID`=38;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (38,1,0,0,0,0,0,0,0,0);

/* Goretusk Liver Pie */
DELETE FROM `quest_details` WHERE `ID`=22;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (22,1,0,0,0,0,0,0,0,0);

/* The Killing Fields */
DELETE FROM `quest_details` WHERE `ID`=9;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9,5,0,0,0,0,0,0,0,0);

/* The People's Militia */
DELETE FROM `quest_details` WHERE `ID`=12;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (12,1,0,0,0,0,0,0,0,0);

/* The People's Militia */
DELETE FROM `quest_details` WHERE `ID`=13;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (13,1,0,0,0,0,0,0,0,0);

/* The People's Militia */
DELETE FROM `quest_details` WHERE `ID`=14;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (14,1,0,0,0,0,0,0,0,0);

/* Patrolling Westfall */
DELETE FROM `quest_details` WHERE `ID`=102;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (102,1,1,0,0,0,0,0,0,0);

/* A Swift Message */
DELETE FROM `quest_details` WHERE `ID`=6181;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6181,1,0,0,0,0,0,0,0,0);

/* Continue to Stormwind */
DELETE FROM `quest_details` WHERE `ID`=6281;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6281,1,0,0,0,0,0,0,0,0);

/* Dungar Longdrink */
DELETE FROM `quest_details` WHERE `ID`=6261;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6261,1,0,0,0,0,0,0,0,0);

/* Return to Lewis */
DELETE FROM `quest_details` WHERE `ID`=6285;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6285,1,0,0,0,0,0,0,0,0);

/* Red Leather Bandanas */
DELETE FROM `quest_details` WHERE `ID`=153;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (153,1,0,0,0,0,0,0,0,0);

/* Thunderbrew Lager */
DELETE FROM `quest_details` WHERE `ID`=117;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (117,94,0,0,0,0,0,0,0,0);

/* Sweet Amber */
DELETE FROM `quest_details` WHERE `ID`=48;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (48,94,0,0,0,0,0,0,0,0);

/* Sweet Amber */
DELETE FROM `quest_details` WHERE `ID`=49;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (49,94,0,0,0,0,0,0,0,0);

/* Sweet Amber */
DELETE FROM `quest_details` WHERE `ID`=50;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (50,94,0,0,0,0,0,0,0,0);

/* Sweet Amber */
DELETE FROM `quest_details` WHERE `ID`=51;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (51,94,0,0,0,0,0,0,0,0);

/* Sweet Amber */
DELETE FROM `quest_details` WHERE `ID`=53;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (53,94,0,0,0,0,0,0,0,0);

/* The Defias Brotherhood */
DELETE FROM `quest_details` WHERE `ID`=65;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (65,1,25,0,0,0,0,0,0,0);

/* The Defias Brotherhood */
DELETE FROM `quest_details` WHERE `ID`=132;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (132,1,0,0,0,0,0,0,0,0);

/* The Defias Brotherhood */
DELETE FROM `quest_details` WHERE `ID`=135;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (135,6,1,0,0,0,0,0,0,0);

/* The Defias Brotherhood */
DELETE FROM `quest_details` WHERE `ID`=141;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (141,1,1,0,0,0,0,0,0,0);

/* The Defias Brotherhood */
DELETE FROM `quest_details` WHERE `ID`=142;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (142,1,1,0,0,0,0,0,0,0);

/* The Defias Brotherhood */
DELETE FROM `quest_details` WHERE `ID`=155;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (155,6,0,0,0,0,0,0,0,0);

/* The Defias Brotherhood */
DELETE FROM `quest_details` WHERE `ID`=166;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (166,1,0,0,0,0,0,0,0,0);

/* Red Silk Bandanas */
DELETE FROM `quest_details` WHERE `ID`=214;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (214,1,0,0,0,0,0,0,0,0);

/* Brother Anton */
DELETE FROM `quest_details` WHERE `ID`=6141;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6141,1,0,0,0,0,0,0,0,0);

/* Lord Grayson Shadowbreaker */
DELETE FROM `quest_details` WHERE `ID` IN (7638,7670);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7638,1,1,0,0,0,0,0,0,0);

/* Lord Grayson Shadowbreaker */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7670,1,1,0,0,0,0,0,0,0);

/* Emphasis on Sacrifice */
DELETE FROM `quest_details` WHERE `ID`=7637;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7637,1,1,0,0,0,0,0,0,0);

/* To Show Due Judgment */
DELETE FROM `quest_details` WHERE `ID`=7639;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7639,1,0,0,0,0,0,0,0,0);

/* Exorcising Terrordale */
DELETE FROM `quest_details` WHERE `ID`=7640;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7640,1,1,0,0,0,0,0,0,0);

/* The Work of Grimand Elmore */
DELETE FROM `quest_details` WHERE `ID`=7641;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7641,1,1,0,0,0,0,0,0,0);

/* Collection of Goods */
DELETE FROM `quest_details` WHERE `ID`=7642;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7642,1,1,0,0,0,0,0,0,0);

/* Grimand's Finest Work */
DELETE FROM `quest_details` WHERE `ID`=7648;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7648,1,1,0,0,0,0,0,0,0);

/* Ancient Equine Spirit */
UPDATE `quest_template_addon` SET `PrevQuestID`=7648 WHERE `ID`=7643;

/* Ancient Equine Spirit */
DELETE FROM `quest_details` WHERE `ID`=7643;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7643,1,1,0,0,0,0,0,0,0);

/* Manna-Enriched Horse Feed */
DELETE FROM `quest_details` WHERE `ID`=7645;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7645,1,1,25,0,0,0,0,0,0);

/* The Divination Scryer */
DELETE FROM `quest_details` WHERE `ID`=7646;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7646,1,1,0,0,0,0,0,0,0);

/* Judgment and Redemption */
DELETE FROM `quest_details` WHERE `ID`=7647;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7647,1,1,2,0,0,0,0,0,0);

/* The Tome of Valor */
DELETE FROM `quest_details` WHERE `ID`=1650;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1650,21,1,1,1,0,0,0,0,0);

/* The Tome of Valor */
DELETE FROM `quest_details` WHERE `ID`=1651;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1651,1,1,1,5,0,0,0,0,0);

/* The Tome of Valor */
DELETE FROM `quest_details` WHERE `ID`=1652;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1652,1,1,0,0,0,0,0,0,0);

/* The Test of Righteousness */
DELETE FROM `quest_details` WHERE `ID`=1653;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1653,1,1,1,0,0,0,0,0,0);

/* The Test of Righteousness */
DELETE FROM `quest_details` WHERE `ID`=1654;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1654,6,2,1,6,0,0,0,0,0);

/* The Test of Righteousness */
DELETE FROM `quest_details` WHERE `ID`=1806;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1806,6,1,0,0,0,0,0,0,0);

/* A Warrior's Training */
DELETE FROM `quest_details` WHERE `ID`=1638;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1638,1,1,0,0,0,0,0,0,0);

/* Bartleby the Drunk */
DELETE FROM `quest_details` WHERE `ID`=1639;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1639,1,6,11,0,0,0,0,0,0);

/* Beat Bartleby */
DELETE FROM `quest_details` WHERE `ID`=1640;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1640,5,0,0,0,0,0,0,0,0);

/* Bartleby's Mug */
DELETE FROM `quest_details` WHERE `ID`=1665;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1665,1,0,0,0,0,0,0,0,0);

/* Marshal Haggard */
DELETE FROM `quest_details` WHERE `ID`=1666;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1666,1,1,0,0,0,0,0,0,0);

/* Dead-tooth Jack */
DELETE FROM `quest_details` WHERE `ID`=1667;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1667,6,1,1,0,0,0,0,0,0);

/* Speak with Jennea */
DELETE FROM `quest_details` WHERE `ID`=1860;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1860,1,1,0,0,0,0,0,0,0);

/* Mirror Lake */
DELETE FROM `quest_details` WHERE `ID`=1861;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1861,1,1,0,0,0,0,0,0,0);

/* Report to Jennea */
DELETE FROM `quest_details` WHERE `ID`=1919;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1919,1,6,1,0,0,0,0,0,0);

/* Investigate the Blue Recluse */
DELETE FROM `quest_details` WHERE `ID`=1920;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1920,1,1,1,0,0,0,0,0,0);

/* Gathering Materials */
DELETE FROM `quest_details` WHERE `ID`=1921;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1921,1,1,0,0,0,0,0,0,0);

/* High Sorcerer Andromath */
DELETE FROM `quest_details` WHERE `ID`=1939;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1939,1,1,0,0,0,0,0,0,0);

/* Ur's Treatise on Shadow Magic */
DELETE FROM `quest_details` WHERE `ID`=1938;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1938,1,1,1,0,0,0,0,0,0);

/* Pristine Spider Silk */
DELETE FROM `quest_details` WHERE `ID`=1940;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1940,1,1,0,0,0,0,0,0,0);

/* Vital Supplies */
DELETE FROM `quest_details` WHERE `ID`=1477;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1477,1,1,0,0,0,0,0,0,0);

/* Supplies for Nethergarde */
DELETE FROM `quest_details` WHERE `ID`=1395;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1395,1,1,1,0,0,0,0,0,0);

/* Journey to the Marsh */
DELETE FROM `quest_details` WHERE `ID`=1947;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1947,1,1,0,0,0,0,0,0,0);

/* Items of Power */
UPDATE `quest_template_addon` SET `PrevQuestID`=1947 WHERE `ID`=1948;

/* Items of Power */
DELETE FROM `quest_details` WHERE `ID`=1948;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1948,1,1,0,0,0,0,0,0,0);

/* Hidden Secrets */
DELETE FROM `quest_details` WHERE `ID`=1949;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1949,1,1,0,0,0,0,0,0,0);

/* Get the Scoop */
DELETE FROM `quest_details` WHERE `ID`=1950;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1950,1,1,5,0,0,0,0,0,0);

/* Rituals of Power */
DELETE FROM `quest_details` WHERE `ID`=1951;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1951,6,1,1,0,0,0,0,0,0);

/* Mage's Wand */
DELETE FROM `quest_details` WHERE `ID`=1952;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1952,1,0,0,0,0,0,0,0,0);

/* Return to the Marsh */
DELETE FROM `quest_details` WHERE `ID`=1953;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1953,1,1,0,0,0,0,0,0,0);

/* The Infernal Orb */
DELETE FROM `quest_details` WHERE `ID`=1954;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1954,1,1,0,0,0,0,0,0,0);

/* The Exorcism */
DELETE FROM `quest_details` WHERE `ID`=1955;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1955,1,25,0,0,0,0,0,0,0);

/* Power in Uldaman */
DELETE FROM `quest_details` WHERE `ID`=1956;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1956,1,1,0,0,0,0,0,0,0);

/* Mana Surges */
DELETE FROM `quest_details` WHERE `ID`=1957;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1957,1,1,0,0,0,0,0,0,0);

/* Tabetha's Task */
DELETE FROM `quest_details` WHERE `ID`=2861;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2861,1,0,0,0,0,0,0,0,0);

/* Tiara of the Deep */
DELETE FROM `quest_details` WHERE `ID`=2846;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2846,1,0,0,0,0,0,0,0,0);

/* Magecraft */
DELETE FROM `quest_details` WHERE `ID`=8250;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8250,1,0,0,0,0,0,0,0,0);

/* A Meal Served Cold */
DELETE FROM `quest_details` WHERE `ID`=212;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (212,1,1,0,0,0,0,0,0,0);

/* James Hyal */
DELETE FROM `quest_details` WHERE `ID`=1301;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1301,1,0,0,0,0,0,0,0,0);

/* James Hyal */
DELETE FROM `quest_details` WHERE `ID`=1302;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1302,1,1,0,0,0,0,0,0,0);

/* Morgan Stern */
DELETE FROM `quest_details` WHERE `ID`=1260;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1260,1,0,0,0,0,0,0,0,0);

/* Mayara Brightwing */
DELETE FROM `quest_details` WHERE `ID`=4766;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4766,1,0,0,0,0,0,0,0,0);

/* Tinkmaster Overspark */
DELETE FROM `quest_details` WHERE `ID`=2923;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2923,1,0,0,0,0,0,0,0,0);

/* Save Techbot's Brain! */
DELETE FROM `quest_details` WHERE `ID`=2922;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2922,1,5,1,0,0,0,0,0,0);

/* Seek out SI: 7 */
DELETE FROM `quest_details` WHERE `ID`=2205;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2205,6,1,0,0,0,0,0,0,0);

/* Snatch and Grab */
DELETE FROM `quest_details` WHERE `ID`=2206;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2206,1,1,0,0,0,0,0,0,0);

/* Mathias and the Defias */
DELETE FROM `quest_details` WHERE `ID`=2360;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2360,1,1,1,25,0,0,0,0,0);

/* Klaven's Tower */
DELETE FROM `quest_details` WHERE `ID`=2359;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2359,1,1,1,0,0,0,0,0,0);

/* The Touch of Zanzil */
DELETE FROM `quest_details` WHERE `ID`=2607;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2607,1,6,0,0,0,0,0,0,0);

/* The Touch of Zanzil */
DELETE FROM `quest_details` WHERE `ID`=2608;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2608,1,11,0,0,0,0,0,0,0);

/* The Touch of Zanzil */
DELETE FROM `quest_details` WHERE `ID`=2609;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2609,1,1,0,0,0,0,0,0,0);

/* A Simple Request */
DELETE FROM `quest_details` WHERE `ID`=8233;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8233,1,0,0,0,0,0,0,0,0);

/* Sealed Azure Bag */
DELETE FROM `quest_details` WHERE `ID`=8234;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8234,1,1,1,0,0,0,0,0,0);

/* Encoded Fragments */
DELETE FROM `quest_details` WHERE `ID`=8235;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8235,1,1,0,0,0,0,0,0,0);

/* The Azure Key */
DELETE FROM `quest_details` WHERE `ID`=8236;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8236,1,1,1,0,0,0,0,0,0);

/* The Azure Key */
UPDATE `quest_offer_reward` SET `Emote1`=4, `Emote1`=1 WHERE `ID`=8236;

/* SI:7 */
DELETE FROM `quest_details` WHERE `ID`=2300;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2300,1,0,0,0,0,0,0,0,0);

/* Alther's Mill */
UPDATE `quest_template_addon` SET `PrevQuestID`=2281 WHERE `ID`=2282;

/* Alther's Mill */
DELETE FROM `quest_details` WHERE `ID`=2282;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2282,5,1,1,0,0,0,0,0,0);

/* Alther's Mill */
UPDATE `quest_offer_reward` SET `Emote1`=21, `Emote1`=25 WHERE `ID`=2282;

/* Cenarion Aid */
DELETE FROM `quest_details` WHERE `ID`=8254;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8254,1,0,0,0,0,0,0,0,0);

/* Gakin's Summons */
DELETE FROM `quest_details` WHERE `ID` IN (1685,1717);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1685,1,1,0,0,0,0,0,0,0);

/* Gakin's Summons */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1717,1,0,0,0,0,0,0,0,0);

/* The Slaughtered Lamb */
DELETE FROM `quest_details` WHERE `ID`=1715;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1715,1,5,0,0,0,0,0,0,0);

/* Surena Caledon */
DELETE FROM `quest_details` WHERE `ID`=1688;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1688,1,1,0,0,0,0,0,0,0);

/* The Binding */
DELETE FROM `quest_details` WHERE `ID`=1689;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1689,1,1,0,0,0,0,0,0,0);

/* A Noble Brew */
DELETE FROM `quest_details` WHERE `ID`=335;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (335,1,1,0,0,0,0,0,0,0);

/* A Noble Brew */
DELETE FROM `quest_details` WHERE `ID`=336;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (336,1,0,0,0,0,0,0,0,0);

/* You Have Served Us Well */
DELETE FROM `quest_details` WHERE `ID`=397;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (397,11,1,0,0,0,0,0,0,0);

/* Knowledge of the Orb of Orahil */
DELETE FROM `quest_details` WHERE `ID` IN (4965,4967,4968,4969);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4965,21,1,0,0,0,0,0,0,0);

/* Knowledge of the Orb of Orahil */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4967,1,25,0,0,0,0,0,0,0);

/* Knowledge of the Orb of Orahil */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4968,21,1,0,0,0,0,0,0,0);

/* Knowledge of the Orb of Orahil */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4969,11,1,0,0,0,0,0,0,0);

/* Fragments of the Orb of Orahil */
DELETE FROM `quest_details` WHERE `ID`=1799;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1799,1,1,1,0,0,0,0,0,0);

/* Shard of an Infernal */
DELETE FROM `quest_details` WHERE `ID`=4963;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4963,1,0,0,0,0,0,0,0,0);

/* Shard of a Felhound */
DELETE FROM `quest_details` WHERE `ID`=4962;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4962,1,0,0,0,0,0,0,0,0);

/* Cleansing of the Orb of Orahil */
DELETE FROM `quest_details` WHERE `ID`=4961;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4961,1,1,1,0,0,0,0,0,0);

/* Returning the Cleansed Orb */
DELETE FROM `quest_details` WHERE `ID`=4976;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4976,1,1,0,0,0,0,0,0,0);

/* The Completed Orb of Noh'Orahil */
DELETE FROM `quest_details` WHERE `ID`=4975;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4975,1,1,0,0,0,0,0,0,0);

/* The Completed Orb of Dar'Orahil */
DELETE FROM `quest_details` WHERE `ID`=4964;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4964,1,1,0,0,0,0,0,0,0);

/* In Search of Menara Voidrender */
DELETE FROM `quest_details` WHERE `ID` IN (4736,4737,4738,4739);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4736,3,1,0,0,0,0,0,0,0);

/* In Search of Menara Voidrender */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4737,1,25,0,0,0,0,0,0,0);

/* In Search of Menara Voidrender */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4738,1,1,0,0,0,0,0,0,0);

/* In Search of Menara Voidrender */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4739,25,1,0,0,500,0,0,0,0);

/* Components for the Enchanted Gold Bloodrobe */
DELETE FROM `quest_details` WHERE `ID`=1796;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1796,1,1,0,0,0,0,0,0,0);

/* Components for the Enchanted Gold Bloodrobe */
DELETE FROM `quest_details` WHERE `ID`=4781;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4781,1,1,0,0,0,0,0,0,0);

/* Components for the Enchanted Gold Bloodrobe */
DELETE FROM `quest_details` WHERE `ID`=4782;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4782,1,1,0,0,0,0,0,0,0);

/* Components for the Enchanted Gold Bloodrobe */
DELETE FROM `quest_details` WHERE `ID`=4783;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4783,1,1,0,0,0,0,0,0,0);

/* Components for the Enchanted Gold Bloodrobe */
DELETE FROM `quest_details` WHERE `ID`=4784;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4784,1,1,1,0,0,0,0,0,0);

/* The Completed Robe */
DELETE FROM `quest_details` WHERE `ID`=4786;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4786,1,0,0,0,0,0,0,0,0);

/* Devourer of Souls */
DELETE FROM `quest_details` WHERE `ID`=1716;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1716,1,1,1,0,0,0,0,0,0);

/* The Binding */
DELETE FROM `quest_details` WHERE `ID`=1739;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1739,1,1,0,0,0,0,0,0,0);

/* The Missing Diplomat */
DELETE FROM `quest_details` WHERE `ID`=1274;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1274,1,1,2,0,0,0,0,0,0);

/* The Missing Diplomat */
DELETE FROM `quest_details` WHERE `ID`=1241;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1241,2,1,1,0,0,0,0,0,0);

/* The Missing Diplomat */
DELETE FROM `quest_details` WHERE `ID`=1242;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1242,1,1,0,0,0,0,0,0,0);

/* The Missing Diplomat */
DELETE FROM `quest_details` WHERE `ID`=1243;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1243,1,6,1,0,0,0,0,0,0);

/* The Missing Diplomat */
DELETE FROM `quest_details` WHERE `ID`=1244;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1244,6,1,1,1,0,0,0,0,0);

/* The Missing Diplomat */
DELETE FROM `quest_details` WHERE `ID`=1245;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1245,5,1,1,1,0,0,0,0,0);

/* The Missing Diplomat */
DELETE FROM `quest_details` WHERE `ID`=1246;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1246,1,1,1,0,0,0,0,0,0);

/* The Missing Diplomat */
DELETE FROM `quest_details` WHERE `ID`=1447;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1447,14,6,0,0,0,0,0,0,0);

/* The Missing Diplomat */
DELETE FROM `quest_details` WHERE `ID`=1247;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1247,11,1,1,0,0,0,0,0,0);

/* The Missing Diplomat */
DELETE FROM `quest_details` WHERE `ID`=1248;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1248,1,1,1,0,0,0,0,0,0);

/* The Missing Diplomat */
DELETE FROM `quest_details` WHERE `ID`=1249;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1249,6,1,1,0,0,0,0,0,0);

/* The Missing Diplomat */
DELETE FROM `quest_details` WHERE `ID`=1250;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1250,18,1,1,5,0,0,0,0,0);

/* The Missing Diplomat */
DELETE FROM `quest_details` WHERE `ID`=1264;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1264,1,1,1,0,0,0,0,0,0);

/* The Missing Diplomat */
DELETE FROM `quest_details` WHERE `ID`=1265;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1265,6,1,1,0,0,0,0,0,0);

/* The Missing Diplomat */
DELETE FROM `quest_details` WHERE `ID`=1266;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1266,1,1,1,0,0,0,0,0,0);

/* The Missing Diplomat */
UPDATE `quest_offer_reward` SET `Emote1`=2, `Emote2`=1, `Emote3`=1, `Emote4`=1 WHERE `ID`=1266;

/* Yorus Barleybrew */
DELETE FROM `quest_details` WHERE `ID` IN (1698,10371);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1698,1,0,0,0,0,0,0,0,0);

/* Yorus Barleybrew */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10371,1,0,0,0,0,0,0,0,0);

/* The Rethban Gauntlet */
DELETE FROM `quest_details` WHERE `ID`=1699;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1699,1,25,1,6,0,0,0,0,0);

/* The Shieldsmith */
DELETE FROM `quest_details` WHERE `ID`=1702;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1702,1,0,0,0,0,0,0,0,0);

/* Fire Hardened Mail */
DELETE FROM `quest_details` WHERE `ID`=1701;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1701,1,1,6,0,0,0,0,0,0);

/* Mathiel */
DELETE FROM `quest_details` WHERE `ID`=1703;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1703,1,0,0,0,0,0,0,0,0);

/* Sunscorched Shells */
DELETE FROM `quest_details` WHERE `ID`=1710;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1710,1,6,1,0,0,0,0,0,0);

/* Grimand Elmore */
DELETE FROM `quest_details` WHERE `ID`=1700;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1700,1,0,0,0,0,0,0,0,0);

/* Burning Blood */
DELETE FROM `quest_details` WHERE `ID`=1705;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1705,1,1,0,0,0,0,0,0,0);

/* Klockmort Spannerspan */
DELETE FROM `quest_details` WHERE `ID`=1704;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1704,1,0,0,0,0,0,0,0,0);

/* Iron Coral */
DELETE FROM `quest_details` WHERE `ID`=1708;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1708,1,1,5,0,0,0,0,0,0);

/* The Islander */
DELETE FROM `quest_details` WHERE `ID`=1718;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1718,1,1,1,0,0,0,0,0,0);

/* The Affray */
DELETE FROM `quest_details` WHERE `ID`=1719;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1719,1,1,0,0,0,0,0,0,0);

/* The Windwatcher */
DELETE FROM `quest_details` WHERE `ID`=1791;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1791,1,1,1,0,0,0,0,0,0);

/* Cyclonian */
DELETE FROM `quest_details` WHERE `ID`=1712;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1712,1,25,1,0,0,0,0,0,0);

/* The Summoning */
DELETE FROM `quest_details` WHERE `ID`=1713;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1713,1,6,0,0,0,0,0,0,0);

/* A Troubled Spirit */
DELETE FROM `quest_details` WHERE `ID`=8417;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8417,1,0,0,0,0,0,0,0,0);

/* Warrior Kinship */
DELETE FROM `quest_details` WHERE `ID`=8423;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8423,25,1,0,0,500,0,0,0,0);

/* War on the Shadowsworn */
DELETE FROM `quest_details` WHERE `ID`=8424;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8424,1,0,0,0,0,0,0,0,0);

/* Voodoo Feathers */
DELETE FROM `quest_details` WHERE `ID`=8425;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8425,1,1,0,0,0,0,0,0,0);

/* Malin's Request */
DELETE FROM `quest_details` WHERE `ID`=690;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (690,2,1,6,0,0,0,0,0,0);

/* Bazil Thredd */
DELETE FROM `quest_details` WHERE `ID`=389;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (389,1,1,1,0,0,0,0,0,0);

/* The Stockade Riots */
DELETE FROM `quest_details` WHERE `ID`=391;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (391,1,1,1,1,0,0,0,0,0);

/* The Curious Visitor */
DELETE FROM `quest_details` WHERE `ID`=392;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (392,1,1,1,0,0,0,0,0,0);

/* Shadow of the Past */
DELETE FROM `quest_details` WHERE `ID`=393;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (393,1,1,1,0,0,0,0,0,0);

/* Look to an Old Friend */
DELETE FROM `quest_details` WHERE `ID`=350;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (350,1,1,1,0,0,0,0,0,0);

/* Infiltrating the Castle */
DELETE FROM `quest_details` WHERE `ID`=2745;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2745,1,1,6,1,0,0,0,0,0);

/* Items of Some Consequence */
DELETE FROM `quest_details` WHERE `ID`=2746;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2746,1,1,1,0,0,0,0,0,0);

/* The Attack! */
DELETE FROM `quest_details` WHERE `ID`=434;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (434,1,1,6,0,0,0,0,0,0);

/* The Head of the Beast */
DELETE FROM `quest_details` WHERE `ID`=394;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (394,1,1,1,0,0,0,0,0,0);

/* Brotherhood's End */
DELETE FROM `quest_details` WHERE `ID`=395;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (395,1,1,1,0,0,0,0,0,0);

/* An Audience with the King */
DELETE FROM `quest_details` WHERE `ID`=396;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (396,1,1,1,0,0,0,0,0,0);

/* Travel to Darkshire */
DELETE FROM `quest_details` WHERE `ID`=9429;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9429,1,1,0,0,0,0,0,0,0);

/* Southshore */
DELETE FROM `quest_details` WHERE `ID`=538;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (538,1,1,1,0,0,0,0,0,0);

/* Preserving Knowledge */
DELETE FROM `quest_details` WHERE `ID`=540;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (540,1,1,1,0,0,0,0,0,0);

/* Return to Milton */
DELETE FROM `quest_details` WHERE `ID`=542;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (542,1,1,0,0,0,0,0,0,0);

/* Goblin Engineering */
DELETE FROM `quest_details` WHERE `ID` IN (3526,3629,3633,4181);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3526,1,1,0,0,0,0,0,0,0);

/* Goblin Engineering */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3629,1,1,0,0,0,0,0,0,0);

/* Goblin Engineering */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3633,1,1,0,0,0,0,0,0,0);

/* Goblin Engineering */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4181,1,1,0,0,0,0,0,0,0);

/* The Pledge of Secrecy */
DELETE FROM `quest_details` WHERE `ID` IN (3638,3640,3642);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3638,1,0,0,0,0,0,0,0,0);

/* The Pledge of Secrecy */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3640,1,0,0,0,0,0,0,0,0);

/* The Pledge of Secrecy */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3642,1,0,0,0,0,0,0,0,0);

/* The Pledge of Secrecy */
UPDATE `quest_offer_reward` SET `Emote1`=4, `Emote2`=1 WHERE `ID` IN (3638,3640,3642);

/* Show Your Work */
DELETE FROM `quest_details` WHERE `ID` IN (3639,3641,3643);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3639,1,1,25,0,0,0,0,0,0);

/* Show Your Work */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3641,1,1,25,0,0,0,0,0,0);

/* Show Your Work */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3643,1,1,25,0,0,0,0,0,0);

/* Gnome Engineering */
DELETE FROM `quest_details` WHERE `ID` IN (3630,3632,3634,3635,3637);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3630,1,1,0,0,0,0,0,0,0);

/* Gnome Engineering */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3632,1,1,0,0,0,0,0,0,0);

/* Gnome Engineering */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3634,1,1,0,0,0,0,0,0,0);

/* Gnome Engineering */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3635,1,1,0,0,0,0,0,0,0);

/* Gnome Engineering */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3637,1,1,0,0,0,0,0,0,0);

/* The Origins of Smithing */
DELETE FROM `quest_details` WHERE `ID`=2758;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2758,1,1,0,0,0,0,0,0,0);

/* The Old Ways */
DELETE FROM `quest_details` WHERE `ID`=2756;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2756,1,1,5,0,0,0,0,0,0);

/* Booty Bay or Bust! */
DELETE FROM `quest_details` WHERE `ID` IN (2757,2759);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2757,25,1,0,0,0,0,0,0,0);

/* In Search of Galvan */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2759,1,1,0,0,0,0,0,0,0);

/* The Mithril Order */
DELETE FROM `quest_details` WHERE `ID`=2760;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2760,1,1,0,0,0,0,0,0,0);

/* Smelt On, Smelt Off */
DELETE FROM `quest_details` WHERE `ID`=2761;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2761,1,6,1,0,0,0,0,0,0);

/* The Great Silver Deceiver */
DELETE FROM `quest_details` WHERE `ID`=2762;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2762,1,1,2,0,0,0,0,0,0);

/* The Art of the Imbue */
DELETE FROM `quest_details` WHERE `ID`=2763;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2763,1,1,0,0,0,0,0,0,0);

/* Galvan's Finest Pupil */
DELETE FROM `quest_details` WHERE `ID`=2764;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2764,1,0,0,0,0,0,0,0,0);

/* Expert Blacksmith! */
DELETE FROM `quest_details` WHERE `ID`=2765;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2765,1,1,2,0,0,0,0,0,0);

/* In Search of The Temple */
DELETE FROM `quest_details` WHERE `ID`=1448;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1448,1,1,1,0,0,0,0,0,0);

/* To The Hinterlands */
DELETE FROM `quest_details` WHERE `ID`=1449;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1449,1,1,1,0,0,0,0,0,0);

/* Gryphon Master Talonaxe */
DELETE FROM `quest_details` WHERE `ID`=1450;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1450,1,25,6,5,0,0,0,0,0);

/* Rhapsody Shindigger */
DELETE FROM `quest_details` WHERE `ID`=1451;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1451,1,1,1,1,0,0,0,0,0);

/* Rhapsody's Kalimdor Kocktail */
DELETE FROM `quest_details` WHERE `ID`=1452;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1452,33,6,1,1,0,0,0,0,0);

/* Rhapsody's Tale */
DELETE FROM `quest_details` WHERE `ID`=1469;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1469,1,33,5,1,0,0,0,0,0);

/* Into The Temple of Atal'Hakkar */
DELETE FROM `quest_details` WHERE `ID`=1475;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1475,1,1,1,1,0,0,0,0,0);

/* Assisting Arch Druid Runetotem */
DELETE FROM `quest_details` WHERE `ID`=936;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (936,1,0,0,0,0,0,0,0,0);

/* Assisting Arch Druid Runetotem */
DELETE FROM `quest_details` WHERE `ID`=3762;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3762,1,0,0,0,0,0,0,0,0);

/* Assisting Arch Druid Runetotem */
DELETE FROM `quest_details` WHERE `ID`=3784;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3784,1,0,0,0,0,0,0,0,0);

/* Un'Goro Soil */
DELETE FROM `quest_details` WHERE `ID`=3761;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3761,1,0,0,0,0,0,0,0,0);

/* Morrowgrain Research */
DELETE FROM `quest_details` WHERE `ID`=3782;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3782,1,0,0,0,0,0,0,0,0);

/* Morrowgrain Research */
DELETE FROM `quest_details` WHERE `ID`=3786;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3786,1,0,0,0,0,0,0,0,0);

/* Assisting Arch Druid Staghelm */
DELETE FROM `quest_details` WHERE `ID` IN (3763,3789,3790,10520);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3763,1,0,0,0,0,0,0,0,0);

/* Assisting Arch Druid Staghelm */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3789,1,0,0,0,0,0,0,0,0);

/* Assisting Arch Druid Staghelm */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3790,1,0,0,0,0,0,0,0,0);

/* Assisting Arch Druid Staghelm */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10520,1,0,0,0,0,0,0,0,0);

/* Un'Goro Soil */
DELETE FROM `quest_details` WHERE `ID`=3764;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3764,1,0,0,0,0,0,0,0,0);

/* Morrowgrain Research */
DELETE FROM `quest_details` WHERE `ID`=3781;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3781,1,0,0,0,0,0,0,0,0);

/* Morrowgrain Research */
DELETE FROM `quest_details` WHERE `ID`=3785;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3785,1,0,0,0,0,0,0,0,0);

/* Bungle in the Jungle */
DELETE FROM `quest_details` WHERE `ID`=4496;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4496,1,0,0,0,0,0,0,0,0);

/* Bungle in the Jungle */
UPDATE `quest_request_items` SET `EmoteOnComplete`=0 WHERE `ID`=4496;

/* Volcanic Activity */
DELETE FROM `quest_details` WHERE `ID`=4502;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4502,1,1,0,0,0,0,0,0,0);

/* The Apes of Un'Goro */
DELETE FROM `quest_details` WHERE `ID`=4289;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4289,1,1,0,0,0,0,0,0,0);

/* The Fare of Lar'korwi */
DELETE FROM `quest_details` WHERE `ID`=4290;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4290,1,1,1,0,0,0,0,0,0);

/* The Scent of Lar'korwi */
DELETE FROM `quest_details` WHERE `ID`=4291;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4291,1,1,1,0,0,0,0,0,0);

/* The Bait for Lar'korwi */
DELETE FROM `quest_details` WHERE `ID`=4292;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4292,1,1,1,0,0,0,0,0,0);

/* Chasing A-Me 01 */
DELETE FROM `quest_details` WHERE `ID`=4243;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4243,18,1,1,0,4000,0,0,0,0);

/* Roll the Bones */
DELETE FROM `quest_details` WHERE `ID`=3882;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3882,1,0,0,0,0,0,0,0,0);

/* Alien Ecology */
DELETE FROM `quest_details` WHERE `ID`=3883;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3883,5,0,0,0,0,0,0,0,0);

/* Expedition Salvation */
DELETE FROM `quest_details` WHERE `ID`=3881;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3881,1,0,0,0,0,0,0,0,0);

/* A Visit to Gregan */
DELETE FROM `quest_details` WHERE `ID`=4142;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4142,6,1,0,0,0,0,0,0,0);

/* Haze of Evil */
DELETE FROM `quest_details` WHERE `ID`=4143;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4143,1,0,0,0,0,0,0,0,0);

/* Larion and Muigin */
DELETE FROM `quest_details` WHERE `ID`=4145;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4145,5,1,6,0,0,0,0,0,0);

/* Marvon's Workshop */
DELETE FROM `quest_details` WHERE `ID`=4147;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4147,1,5,0,0,0,0,0,0,0);

/* Zapper Fuel */
DELETE FROM `quest_details` WHERE `ID`=4146;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4146,1,0,0,0,0,0,0,0,0);

/* Finding the Source */
DELETE FROM `quest_details` WHERE `ID`=974;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (974,6,4,0,0,0,0,0,0,0);

/* The New Springs */
DELETE FROM `quest_details` WHERE `ID`=980;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (980,1,0,0,0,0,0,0,0,0);

/* Strange Sources */
DELETE FROM `quest_details` WHERE `ID`=4842;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4842,1,0,0,0,0,0,0,0,0);

/* Shizzle's Flyer */
DELETE FROM `quest_details` WHERE `ID`=4503;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4503,4,1,0,0,0,0,0,0,0);

/* Crystals of Power */
DELETE FROM `quest_details` WHERE `ID`=4284;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4284,1,5,0,0,0,0,0,0,0);

/* It's a Secret to Everybody */
DELETE FROM `quest_details` WHERE `ID`=3908;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3908,1,1,1,0,0,0,0,0,0);

/* The Videre Elixir */
DELETE FROM `quest_details` WHERE `ID`=3909;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3909,5,1,0,0,0,0,0,0,0);

/* Meet at the Grave */
DELETE FROM `quest_details` WHERE `ID`=3912;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3912,1,1,0,0,0,0,0,0,0);

/* A Grave Situation */
DELETE FROM `quest_details` WHERE `ID`=3913;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3913,1,1,0,0,0,0,0,0,0);

/* A Gnome's Assistance */
DELETE FROM `quest_details` WHERE `ID`=3941;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3941,1,1,1,0,0,0,0,0,0);

/* Linken's Memory */
DELETE FROM `quest_details` WHERE `ID`=3942;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3942,6,1,1,0,0,0,0,0,0);

/* Silver Heart */
DELETE FROM `quest_details` WHERE `ID`=4084;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4084,274,1,1,1,0,0,0,0,0);

/* Aquementas */
DELETE FROM `quest_details` WHERE `ID`=4005;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4005,1,1,1,1,0,0,0,0,0);

/* Linken's Adventure */
DELETE FROM `quest_details` WHERE `ID`=3961;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3961,1,1,0,0,0,0,0,0,0);

/* It's Dangerous to Go Alone */
DELETE FROM `quest_details` WHERE `ID`=3962;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3962,273,1,1,0,0,0,0,0,0);

/* Torwa Pathfinder */
DELETE FROM `quest_details` WHERE `ID`=9063;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9063,1,0,0,0,0,0,0,0,0);

/* Bloodpetal Poison */
DELETE FROM `quest_details` WHERE `ID`=9052;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9052,1,1,0,0,0,0,0,0,0);

/* Toxic Test */
DELETE FROM `quest_details` WHERE `ID`=9051;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9051,1,1,0,0,0,0,0,0,0);

/* A Better Ingredient */
DELETE FROM `quest_details` WHERE `ID`=9053;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9053,1,1,0,0,0,0,0,0,0);

/* The Orebor Harborage */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1 WHERE `ID`=9776;

/* Fulgor Spores */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1, `Emote3`=1 WHERE `ID`=9777;

/* Umbrafen Eel Filets */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1, `Emote3`=1 WHERE `ID`=9780;

/* Too Many Mouths to Feed */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1, `Emote3`=1 WHERE `ID`=9781;

/* The Dead Mire */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1, `Emote3`=1 WHERE `ID`=9782;

/* An Unnatural Drought */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1, `Emote3`=1 WHERE `ID`=9783;

/* The Boha'mu Ruins */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1, `Emote3`=1 WHERE `ID`=9786;

/* Idols of the Feralfen */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1, `Emote3`=1 WHERE `ID`=9787;

/* Diaphanous Wings */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1, `Emote3`=1 WHERE `ID`=9790;

/* Menacing Marshfangs */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1 WHERE `ID`=9791;

/* A Message to Telaar */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1, `Emote3`=1 WHERE `ID`=9792;

/* The Fate of Tuurem */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1, `Emote3`=1 WHERE `ID`=9793;

/* No Time for Curiosity */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1, `Emote3`=1 WHERE `ID`=9794;

/* Gathering the Reagents */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1, `Emote3`=1 WHERE `ID`=9801;

/* Messenger to the Feralfen */
DELETE FROM `quest_details` WHERE `ID`=9803;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9803,1,1,1,0,0,0,0,0,0);

/* Stinger Venom */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1, `Emote3`=1 WHERE `ID`=9830;

/* Lines of Communication */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1, `Emote3`=1 WHERE `ID`=9833;

/* Natural Armor */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1, `Emote3`=1 WHERE `ID`=9834;

/* Ango'rosh Encroachment */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1, `Emote3`=1 WHERE `ID`=9835;

/* Overlord Gorefist */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1, `Emote3`=1 WHERE `ID`=9839;

/* Secrets of the Daggerfen */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1, `Emote3`=1 WHERE `ID`=9848;

/* Safeguarding the Watchers */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1 WHERE `ID`=9894;

/* Blacksting's Bane */
UPDATE `quest_details` SET `Emote1`=5, `Emote2`=1, `Emote3`=1 WHERE `ID`=9896;

/* Unfinished Business */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1 WHERE `ID`=9901;

/* The Terror of Marshlight Lake */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1, `Emote3`=1 WHERE `ID`=9902;

/* Maktu's Revenge */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1, `Emote3`=1 WHERE `ID`=9905;

/* What's Wrong at Cenarion Thicket? */
DELETE FROM `quest_details` WHERE `ID`=9961;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9961,1,1,0,0,0,0,0,0,0);

/* Stymying the Arakkoa */
DELETE FROM `quest_details` WHERE `ID`=9986;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9986,5,1,1,0,0,0,0,0,0);

/* Olemba Seeds */
DELETE FROM `quest_details` WHERE `ID`=9992;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9992,1,1,0,0,0,0,0,0,0);

/* What Are These Things? */
DELETE FROM `quest_details` WHERE `ID` IN (9994,9995);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9994,1,1,0,0,0,0,0,0,0);

/* What Are These Things? */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9995,1,1,0,0,0,0,0,0,0);

/* Attack on Firewing Point */
DELETE FROM `quest_details` WHERE `ID`=9996;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9996,1,1,1,0,0,0,0,0,0);

/* Unruly Neighbors */
DELETE FROM `quest_details` WHERE `ID`=9998;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9998,1,1,1,0,0,0,0,0,0);

/* The Firewing Liaison */
DELETE FROM `quest_details` WHERE `ID`=10002;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10002,1,1,1,0,0,0,0,0,0);

/* Thinning the Ranks */
DELETE FROM `quest_details` WHERE `ID`=10007;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10007,274,1,1,0,0,0,0,0,0);

/* Timber Worg Tails */
DELETE FROM `quest_details` WHERE `ID`=10016;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10016,1,1,1,0,0,0,0,0,0);

/* The Elusive Ironjaw */
DELETE FROM `quest_details` WHERE `ID`=10022;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10022,1,1,1,0,0,0,0,0,0);

/* Magical Disturbances */
UPDATE `quest_details` SET `Emote1`=24, `Emote2`=1, `Emote3`=1 WHERE `ID`=10026;

/* Vessels of Power */
DELETE FROM `quest_details` WHERE `ID`=10028;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10028,1,1,1,0,0,0,0,0,0);

/* Torgos! */
DELETE FROM `quest_details` WHERE `ID`=10035;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10035,1,1,0,0,0,0,0,0,0);

/* Speak with Private Weeks */
DELETE FROM `quest_details` WHERE `ID`=10038;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10038,1,25,1,0,0,0,0,0,0);

/* Who Are They? */
DELETE FROM `quest_details` WHERE `ID`=10040;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10040,6,1,1,0,0,0,0,0,0);

/* Kill the Shadow Council! */
DELETE FROM `quest_details` WHERE `ID`=10042;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10042,5,1,1,0,0,0,0,0,0);

/* Escape from Firewing Point! */
DELETE FROM `quest_details` WHERE `ID` IN (10051,10052);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10051,1,1,1,0,0,0,0,0,0);

/* Escape from Firewing Point! */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10052,1,1,1,0,0,0,0,0,0);

/* Daggerfen Deviance */
DELETE FROM `quest_details` WHERE `ID`=10115;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10115,1,1,1,0,0,0,0,0,0);

/* Withered Flesh */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1, `Emote3`=1 WHERE `ID`=10355;

/* Report to the Allerian Post */
DELETE FROM `quest_details` WHERE `ID`=10444;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10444,5,1,1,1,0,0,0,0,0);

/* The Final Code */
DELETE FROM `quest_details` WHERE `ID`=10446;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10446,5,1,1,0,0,0,0,0,0);

/* Before Darkness Falls */
UPDATE `quest_details` SET `Emote1`=0 WHERE `ID`=10878;

/* The Infested Protectors */
UPDATE `quest_details` SET `Emote1`=0 WHERE `ID`=10896;

/* Blackrock Bounty */
DELETE FROM `quest_details` WHERE `ID`=128;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (128,1,0,0,0,0,0,0,0,0);

/* The Lost Tools */
DELETE FROM `quest_details` WHERE `ID`=125;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (125,1,1,0,0,0,0,0,0,0);

/* The Everstill Bridge */
DELETE FROM `quest_details` WHERE `ID`=89;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (89,1,1,25,0,0,0,0,0,0);

/* Hilary's Necklace */
DELETE FROM `quest_details` WHERE `ID`=3741;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3741,5,1,6,0,0,0,0,0,0);

/* Solomon's Law */
DELETE FROM `quest_details` WHERE `ID`=91;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (91,1,0,0,0,0,0,0,0,0);

/* Messenger to Stormwind */
DELETE FROM `quest_details` WHERE `ID`=120;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (120,1,0,0,0,0,0,0,0,0);

/* Messenger to Stormwind */
DELETE FROM `quest_details` WHERE `ID`=121;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (121,25,0,0,0,0,0,0,0,0);

/* Messenger to Westfall */
DELETE FROM `quest_details` WHERE `ID`=143;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (143,1,0,0,0,0,0,0,0,0);

/* Messenger to Westfall */
DELETE FROM `quest_details` WHERE `ID`=144;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (144,1,25,0,0,0,0,0,0,0);

/* Messenger to Darkshire */
DELETE FROM `quest_details` WHERE `ID`=145;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (145,1,0,0,0,0,0,0,0,0);

/* Messenger to Darkshire */
DELETE FROM `quest_details` WHERE `ID`=146;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (146,1,1,29,0,0,0,0,0,0);

/* What Comes Around... */
DELETE FROM `quest_details` WHERE `ID`=386;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (386,1,1,0,0,0,0,0,0,0);

/* Dry Times */
DELETE FROM `quest_details` WHERE `ID`=116;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (116,1,5,0,0,0,0,0,0,0);

/* An Unwelcome Guest */
DELETE FROM `quest_details` WHERE `ID`=34;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (34,1,5,0,0,0,0,0,0,0);

/* Redridge Goulash */
DELETE FROM `quest_details` WHERE `ID`=92;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (92,1,0,0,0,0,0,0,0,0);

/* Missing In Action */
DELETE FROM `quest_details` WHERE `ID`=219;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (219,5,1,20,0,0,0,0,0,0);

/* Horns of Nez'ra */
DELETE FROM `quest_details` WHERE `ID`=2358;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2358,1,1,0,0,0,0,0,0,0);

/* Recover the Bones */
DELETE FROM `quest_details` WHERE `ID`=10030;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10030,1,1,0,0,0,0,0,0,0);

/* Helping the Lost Find Their Way */
DELETE FROM `quest_details` WHERE `ID`=10031;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10031,1,1,6,0,0,0,0,0,0);

/* Rather Be Fishin' */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1, `Emote3`=1 WHERE `ID`=10037;

/* Brother Against Brother */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1 WHERE `ID`=10097;

/* Terokk's Legacy */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1 WHERE `ID`=10098;

/* Trouble at Auchindoun */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1, `Emote3`=1 WHERE `ID`=10177;

/* Can't Stay Away */
DELETE FROM `quest_details` WHERE `ID`=10180;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10180,1,1,1,0,0,0,0,0,0);

/* The Tomb of Lights */
DELETE FROM `quest_details` WHERE `ID`=10840;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10840,1,0,0,0,0,0,0,0,0);

/* Vengeful Souls */
DELETE FROM `quest_details` WHERE `ID`=10842;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10842,1,0,0,0,0,0,0,0,0);

/* The Eyes of Skettis */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1, `Emote3`=1 WHERE `ID`=10847;

/* Veil Rhaze: Unliving Evil */
DELETE FROM `quest_details` WHERE `ID`=10848;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10848,1,1,1,0,0,0,0,0,0);

/* Seek Out Kirrik */
DELETE FROM `quest_details` WHERE `ID`=10849;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10849,1,1,1,0,0,0,0,0,0);

/* Veil Lithic: Preemptive Strike */
DELETE FROM `quest_details` WHERE `ID`=10861;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10861,1,1,1,0,0,0,0,0,0);

/* The Skettis Offensive */
DELETE FROM `quest_details` WHERE `ID`=10879;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10879,1,1,1,0,0,0,0,0,0);

/* Return to Shattrath */
DELETE FROM `quest_details` WHERE `ID`=10889;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10889,1,1,1,0,0,0,0,0,0);

/* The Fallen Exarch */
DELETE FROM `quest_details` WHERE `ID`=10915;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10915,1,1,1,5,0,0,0,0,0);

/* The Fallen Exarch */
UPDATE `quest_offer_reward` SET `Emote1`=1, `Emote2`=1, `Emote3`=1 WHERE `ID`=10915;

/* The Outcast's Plight */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1, `Emote3`=1 WHERE `ID`=10917;

/* Fumping */
DELETE FROM `quest_details` WHERE `ID`=10929;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10929,1,1,1,1,0,0,0,0,0);

/* The Big Bone Worm */
DELETE FROM `quest_details` WHERE `ID`=10930;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10930,5,1,5,0,0,0,0,0,0);

/* Mog'dorg the Wizened */
DELETE FROM `quest_details` WHERE `ID`=10983;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10983,1,1,0,0,0,0,0,0,0);

/* Mog'dorg the Wizened */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID`=10983;

/* Zorus the Judicator */
UPDATE `quest_details` SET `Emote1`=5, `Emote2`=1, `Emote3`=1 WHERE `ID`=11045;

/* Look To The Stars */
DELETE FROM `quest_details` WHERE `ID`=174;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (174,1,0,0,0,0,0,0,0,0);

/* Look To The Stars */
DELETE FROM `quest_details` WHERE `ID`=175;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (175,1,0,0,0,0,0,0,0,0);

/* Look To The Stars */
DELETE FROM `quest_details` WHERE `ID`=181;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (181,1,1,0,0,0,0,0,0,0);

/* The Totem of Infliction */
DELETE FROM `quest_details` WHERE `ID`=101;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (101,1,0,0,0,0,0,0,0,0);

/* The Legend of Stalvan */
DELETE FROM `quest_details` WHERE `ID`=66;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (66,5,1,1,25,0,0,0,0,0);

/* The Legend of Stalvan */
DELETE FROM `quest_details` WHERE `ID`=67;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (67,6,1,5,1,0,0,0,0,0);

/* The Legend of Stalvan */
DELETE FROM `quest_details` WHERE `ID`=69;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (69,5,1,0,0,0,0,0,0,0);

/* The Legend of Stalvan */
DELETE FROM `quest_details` WHERE `ID`=70;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (70,1,1,25,0,0,0,0,0,0);

/* The Legend of Stalvan */
DELETE FROM `quest_details` WHERE `ID`=72;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (72,1,1,0,0,0,0,0,0,0);

/* The Legend of Stalvan */
DELETE FROM `quest_details` WHERE `ID`=75;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (75,1,1,0,0,0,0,0,0,0);

/* The Legend of Stalvan */
DELETE FROM `quest_details` WHERE `ID`=78;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (78,1,25,0,0,0,0,0,0,0);

/* The Legend of Stalvan */
DELETE FROM `quest_details` WHERE `ID`=79;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (79,1,1,0,0,0,0,0,0,0);

/* The Legend of Stalvan */
DELETE FROM `quest_details` WHERE `ID`=80;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (80,1,1,1,0,0,0,0,0,0);

/* The Legend of Stalvan */
DELETE FROM `quest_details` WHERE `ID`=97;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (97,25,0,0,0,0,0,0,0,0);

/* The Legend of Stalvan */
DELETE FROM `quest_details` WHERE `ID`=98;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (98,1,1,25,0,0,0,0,0,0);

/* Seasoned Wolf Kabobs */
DELETE FROM `quest_details` WHERE `ID`=90;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (90,1,1,0,0,0,0,0,0,0);

/* The Night Watch */
DELETE FROM `quest_details` WHERE `ID`=56;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (56,1,5,0,0,0,0,0,0,0);

/* The Night Watch */
DELETE FROM `quest_details` WHERE `ID`=57;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (57,5,25,0,0,0,0,0,0,0);

/* The Night Watch */
DELETE FROM `quest_details` WHERE `ID`=58;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (58,5,0,0,0,0,0,0,0,0);

/* Crime and Punishment */
DELETE FROM `quest_details` WHERE `ID`=377;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (377,1,1,0,0,0,0,0,0,0);

/* Worgen in the Woods */
DELETE FROM `quest_details` WHERE `ID`=223;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (223,66,0,0,0,0,0,0,0,0);

/* The Hermit */
DELETE FROM `quest_details` WHERE `ID`=165;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (165,1,0,0,0,0,0,0,0,0);

/* Ghost Hair Thread */
DELETE FROM `quest_details` WHERE `ID`=149;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (149,1,1,0,0,0,0,0,0,0);

/* Deliver the Thread */
DELETE FROM `quest_details` WHERE `ID`=157;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (157,1,0,0,0,0,0,0,0,0);

/* Gather Rot Blossoms */
DELETE FROM `quest_details` WHERE `ID`=156;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (156,1,0,0,0,0,0,0,0,0);

/* Juice Delivery */
DELETE FROM `quest_details` WHERE `ID`=159;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (159,1,5,0,0,0,0,0,0,0);

/* Note to the Mayor */
DELETE FROM `quest_details` WHERE `ID`=160;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (160,11,0,0,0,0,0,0,0,0);

/* Translation to Ello */
DELETE FROM `quest_details` WHERE `ID`=252;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (252,5,0,0,0,0,0,0,0,0);

/* Bride of the Embalmer */
DELETE FROM `quest_details` WHERE `ID`=253;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (253,1,0,0,0,0,0,0,0,0);

/* Wolves at Our Heels */
DELETE FROM `quest_details` WHERE `ID`=226;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (226,1,0,0,0,0,0,0,0,0);

/* Deliveries to Sven */
DELETE FROM `quest_details` WHERE `ID`=164;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (164,6,1,0,0,0,0,0,0,0);

/* Sven's Revenge */
DELETE FROM `quest_details` WHERE `ID`=95;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (95,1,1,0,0,0,0,0,0,0);

/* The Shadowy Figure */
DELETE FROM `quest_details` WHERE `ID`=262;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (262,1,20,0,0,0,0,0,0,0);

/* The Shadowy Search Continues */
DELETE FROM `quest_details` WHERE `ID`=265;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (265,1,0,0,0,0,0,0,0,0);

/* Inquire at the Inn */
DELETE FROM `quest_details` WHERE `ID`=266;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (266,1,0,0,0,0,0,0,0,0);

/* Finding the Shadowy Figure */
DELETE FROM `quest_details` WHERE `ID`=453;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (453,1,0,0,0,0,0,0,0,0);

/* Return to Sven */
DELETE FROM `quest_details` WHERE `ID`=268;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (268,1,1,0,0,0,0,0,0,0);

/* Proving Your Worth */
DELETE FROM `quest_details` WHERE `ID`=323;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (323,1,1,1,0,0,0,0,0,0);

/* Seeking Wisdom */
DELETE FROM `quest_details` WHERE `ID`=269;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (269,1,1,0,0,0,0,0,0,0);

/* The Doomed Fleet */
DELETE FROM `quest_details` WHERE `ID`=270;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (270,1,1,1,0,0,0,0,0,0);

/* Lightforge Iron */
DELETE FROM `quest_details` WHERE `ID`=321;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (321,1,1,0,0,0,0,0,0,0);

/* Blessed Arm */
DELETE FROM `quest_details` WHERE `ID`=322;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (322,1,1,0,0,0,0,0,0,0);

/* Armed and Ready */
DELETE FROM `quest_details` WHERE `ID`=325;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (325,1,0,0,0,0,0,0,0,0);

/* Morbent Fel */
DELETE FROM `quest_details` WHERE `ID`=55;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (55,1,1,5,0,0,0,0,0,0);

/* Mor'Ladim */
DELETE FROM `quest_details` WHERE `ID`=228;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (228,1,1,0,0,0,0,0,0,0);

/* The Daughter Who Lived */
DELETE FROM `quest_details` WHERE `ID`=229;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (229,1,1,0,0,0,0,0,0,0);

/* A Daughter's Love */
DELETE FROM `quest_details` WHERE `ID`=231;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (231,1,2,0,0,0,1000,0,0,0);

/* Raven Hill */
DELETE FROM `quest_details` WHERE `ID`=163;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (163,1,0,0,0,0,0,0,0,0);

/* Jitters' Growling Gut */
DELETE FROM `quest_details` WHERE `ID`=5;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5,5,1,0,0,0,0,0,0,0);

/* Dusky Crab Cakes */
DELETE FROM `quest_details` WHERE `ID`=93;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (93,1,1,0,0,0,0,0,0,0);

/* Return to Jitters */
DELETE FROM `quest_details` WHERE `ID`=240;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (240,4,0,0,0,0,0,0,0,0);

/* Feathermoon Stronghold */
DELETE FROM `quest_details` WHERE `ID`=7494;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7494,5,0,0,0,0,0,0,0,0);

/* Lethtendris's Web */
DELETE FROM `quest_details` WHERE `ID`=7488;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7488,1,1,1,0,0,0,0,0,0);

/* The Ruins of Solarsal */
DELETE FROM `quest_details` WHERE `ID`=2866;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2866,1,1,0,0,0,0,0,0,0);

/* Against the Hatecrest */
DELETE FROM `quest_details` WHERE `ID`=3130;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3130,1,1,66,0,0,0,0,0,0);

/* Against the Hatecrest */
DELETE FROM `quest_details` WHERE `ID`=2869;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2869,1,1,1,0,0,0,0,0,0);

/* Against Lord Shalzaru */
DELETE FROM `quest_details` WHERE `ID`=2870;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2870,1,1,1,0,0,0,0,0,0);

/* Delivering the Relic */
DELETE FROM `quest_details` WHERE `ID`=2871;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2871,1,1,0,0,0,0,0,0,0);

/* The Mark of Quality */
DELETE FROM `quest_details` WHERE `ID`=2821;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2821,1,1,1,0,0,0,0,0,0);

/* Improved Quality */
DELETE FROM `quest_details` WHERE `ID`=7733;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7733,1,1,0,0,0,0,0,0,0);

/* Elven Legends */
DELETE FROM `quest_details` WHERE `ID`=7482;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7482,1,1,1,0,0,0,0,0,0);

/* Jonespyre's Request */
DELETE FROM `quest_details` WHERE `ID` IN (3787,3788);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3787,1,0,0,0,0,0,0,0,0);

/* Jonespyre's Request */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3788,1,0,0,0,0,0,0,0,0);

/* The Mystery of Morrowgrain */
DELETE FROM `quest_details` WHERE `ID`=3791;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3791,1,1,0,0,0,0,0,0,0);

/* In Search of Knowledge */
DELETE FROM `quest_details` WHERE `ID`=2939;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2939,1,0,0,0,0,0,0,0,0);

/* The Borrower */
DELETE FROM `quest_details` WHERE `ID`=2941;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2941,1,1,0,0,0,0,0,0,0);

/* The Super Snapper FX */
DELETE FROM `quest_details` WHERE `ID`=2944;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2944,1,1,0,0,0,0,0,0,0);

/* Return to Troyas */
DELETE FROM `quest_details` WHERE `ID`=2943;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2943,1,0,0,0,0,0,0,0,0);

/* The Stave of Equinex */
DELETE FROM `quest_details` WHERE `ID`=2879;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2879,5,1,1,0,0,0,0,0,0);

/* The High Wilderness */
DELETE FROM `quest_details` WHERE `ID`=2982;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2982,1,1,0,0,0,0,0,0,0);

/* Wild Leather Armor */
DELETE FROM `quest_details` WHERE `ID`=2847;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2847,21,1,1,0,0,0,0,0,0);

/* Wild Leather Shoulders */
DELETE FROM `quest_details` WHERE `ID`=2848;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2848,1,1,0,0,0,0,0,0,0);

/* Wild Leather Shoulders */
UPDATE `quest_offer_reward` SET `Emote1`=1, `Emote2`=1, `RewardText`="These armor kits are of solid quality, $N. If there is one thing I demand in not only my work, but the work of those in my employ, it is quality.$B$BYou've done well to earn this pattern; I hope it brings you the rewards it has brought me." WHERE `ID`=2848;

/* Wild Leather Vest */
DELETE FROM `quest_details` WHERE `ID`=2849;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2849,1,1,0,0,0,0,0,0,0);

/* Wild Leather Helmet */
DELETE FROM `quest_details` WHERE `ID`=2850;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2850,1,1,0,0,0,0,0,0,0);

/* Wild Leather Boots */
DELETE FROM `quest_details` WHERE `ID`=2851;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2851,1,1,1,0,0,0,0,0,0);

/* Wild Leather Leggings */
DELETE FROM `quest_details` WHERE `ID`=2852;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2852,1,1,0,0,0,0,0,0,0);

/* Master of the Wild Leather */
DELETE FROM `quest_details` WHERE `ID`=2853;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2853,1,1,0,0,0,0,0,0,0);

/* Moonglow Vest */
DELETE FROM `quest_details` WHERE `ID`=1582;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1582,1,1,0,0,0,0,0,0,0);

/* The Missing Courier */
DELETE FROM `quest_details` WHERE `ID`=4124;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4124,1,1,0,0,0,0,0,0,0);

/* The Missing Courier */
DELETE FROM `quest_details` WHERE `ID`=4125;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4125,1,1,1,0,0,0,0,0,0);

/* The Knife Revealed */
DELETE FROM `quest_details` WHERE `ID`=4129;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4129,1,1,0,0,0,0,0,0,0);

/* Psychometric Reading */
DELETE FROM `quest_details` WHERE `ID`=4130;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4130,1,1,0,0,0,0,0,0,0);

/* The Woodpaw Gnolls */
DELETE FROM `quest_details` WHERE `ID`=4131;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4131,1,1,1,0,0,0,0,0,0);

/* A Hero's Welcome */
DELETE FROM `quest_details` WHERE `ID`=4266;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4266,1,1,0,0,0,0,0,0,0);

/* Rise of the Silithid */
DELETE FROM `quest_details` WHERE `ID`=4267;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4267,1,1,66,0,0,0,0,0,0);

/* Tribal Leatherworking */
DELETE FROM `quest_details` WHERE `ID`=5143;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5143,1,1,0,0,0,0,0,0,0);

/* The Crone of the Kraul */
DELETE FROM `quest_details` WHERE `ID`=1101;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1101,18,1,1,0,0,0,0,0,0);

/* Freedom for All Creatures */
DELETE FROM `quest_details` WHERE `ID`=2969;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2969,5,1,0,0,0,0,0,0,0);

/* Doling Justice */
DELETE FROM `quest_details` WHERE `ID`=2970;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2970,1,1,0,0,0,0,0,0,0);

/* Doling Justice */
DELETE FROM `quest_details` WHERE `ID`=2972;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2972,1,1,2,0,0,0,0,0,0);

/* An Orphan Looking For a Home */
DELETE FROM `quest_details` WHERE `ID`=3841;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3841,1,1,6,0,0,0,0,0,0);

/* A Short Incubation */
DELETE FROM `quest_details` WHERE `ID`=3842;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3842,1,1,1,0,0,0,0,0,0);

/* The Newest Member of the Family */
DELETE FROM `quest_details` WHERE `ID`=3843;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3843,1,1,0,0,0,0,0,0,0);

/* Food for Baby */
DELETE FROM `quest_details` WHERE `ID`=4297;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4297,1,1,6,0,0,0,0,0,0);

/* Becoming a Parent */
DELETE FROM `quest_details` WHERE `ID`=4298;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4298,1,0,0,0,0,0,0,0,0);

/* Wandering Shay */
DELETE FROM `quest_details` WHERE `ID`=2845;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2845,6,1,0,0,0,0,0,0,0);

/* Rise of the Silithid */
UPDATE `quest_template_addon` SET `NextQuestID`=4493 WHERE `ID` IN (162,4267);

/* March of the Silithid */
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `ID`=4493;

/* Trouble in Winterspring! */
DELETE FROM `quest_details` WHERE `ID`=6603;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6603,5,0,0,0,0,0,0,0,0);

/* Threat of the Winterfall */
DELETE FROM `quest_details` WHERE `ID`=5082;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5082,1,1,0,0,0,0,0,0,0);

/* Toxic Horrors */
DELETE FROM `quest_details` WHERE `ID`=5086;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5086,1,1,0,0,0,0,0,0,0);

/* Winterfall Runners */
DELETE FROM `quest_details` WHERE `ID`=5087;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5087,1,0,0,0,0,0,0,0,0);

/* Are We There, Yeti? */
DELETE FROM `quest_details` WHERE `ID`=3783;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3783,1,5,0,0,0,0,0,0,0);

/* Are We There, Yeti? */
DELETE FROM `quest_details` WHERE `ID`=977;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (977,1,0,0,0,0,0,0,0,0);

/* Are We There, Yeti? */
DELETE FROM `quest_details` WHERE `ID`=5163;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5163,4,1,25,0,0,0,0,0,0);

/* Ursius of the Shardtooth */
DELETE FROM `quest_details` WHERE `ID`=5054;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5054,1,2,0,0,0,0,0,0,0);

/* Brumeran of the Chillwind */
DELETE FROM `quest_details` WHERE `ID`=5055;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5055,1,2,0,0,0,0,0,0,0);

/* Shy-Rotam */
DELETE FROM `quest_details` WHERE `ID`=5056;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5056,1,2,0,0,0,0,0,0,0);

/* Past Endeavors */
UPDATE `quest_offer_reward` SET `Emote1`=1, `Emote2`=1, `Emote3`=1, `RewardText`="We learn from our life experiences, $N. I am sure that you have only become stronger and wiser as a result of yours. You have grown much since we first spoke.$b$bTake this in remembrance of the difficult tasks you have accomplished as a $R $C, and know that you will always have my respect and admiration." WHERE `ID`=5057;

/* Luck Be With You */
DELETE FROM `quest_details` WHERE `ID`=969;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (969,1,0,0,0,0,0,0,0,0);

/* Cache of Mau'ari */
DELETE FROM `quest_details` WHERE `ID`=975;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (975,1,0,0,0,0,0,0,0,0);

/* Guarding Secrets */
DELETE FROM `quest_details` WHERE `ID`=4883;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4883,1,0,0,0,0,0,0,0,0);

/* To Winterspring! */
DELETE FROM `quest_details` WHERE `ID`=5249;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5249,1,0,0,0,0,0,0,0,0);

/* Starfall */
DELETE FROM `quest_details` WHERE `ID`=5250;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5250,1,0,0,0,0,0,0,0,0);

/* The Ruins of Kel'Theril */
DELETE FROM `quest_details` WHERE `ID`=5244;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5244,1,0,0,0,0,0,0,0,0);

/* Fragments of the Past */
DELETE FROM `quest_details` WHERE `ID`=5246;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5246,2,0,0,0,0,0,0,0,0);

/* Fragments of the Past */
DELETE FROM `quest_details` WHERE `ID`=5247;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5247,1,0,0,0,0,0,0,0,0);

/* Tormented By the Past */
DELETE FROM `quest_details` WHERE `ID`=5248;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5248,1,1,2,0,0,0,0,0,0);

/* The Crystal of Zin-Malor */
DELETE FROM `quest_details` WHERE `ID`=5253;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5253,1,1,1,0,0,0,0,0,0);

/* Snakestone of the Shadow Huntress */
DELETE FROM `quest_details` WHERE `ID`=5306;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5306,1,1,1,0,0,0,0,0,0);

/* Sweet Serenity */
DELETE FROM `quest_details` WHERE `ID`=5305;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5305,1,1,0,0,0,0,0,0,0);

/* Corruption */
DELETE FROM `quest_details` WHERE `ID`=5307;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5307,1,1,1,0,0,0,0,0,0);

/* Favored of Elune? */
DELETE FROM `quest_details` WHERE `ID`=3661;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3661,1,0,0,0,0,0,0,0,0);

/* Moontouched Wildkin */
DELETE FROM `quest_details` WHERE `ID`=978;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (978,1,6,0,0,0,0,0,0,0);

/* Find Ranshalla */
DELETE FROM `quest_details` WHERE `ID`=979;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (979,1,0,0,0,0,0,0,0,0);

/* Guardians of the Altar */
DELETE FROM `quest_details` WHERE `ID`=4901;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4901,1,0,0,0,0,0,0,0,0);

/* Wildkin of Elune */
DELETE FROM `quest_details` WHERE `ID`=4902;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4902,5,0,0,0,0,0,0,0,0);

/* Enraged Wildkin */
DELETE FROM `quest_details` WHERE `ID`=6604;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6604,6,1,0,0,0,0,0,0,0);

/* Enraged Wildkin */
DELETE FROM `quest_details` WHERE `ID`=4861;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4861,3,1,0,0,0,0,0,0,0);

/* The Everlook Report */
DELETE FROM `quest_details` WHERE `ID`=6028;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6028,1,0,0,0,0,0,0,0,0);

/* High Chief Winterfall */
DELETE FROM `quest_details` WHERE `ID`=5121;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5121,1,1,0,0,0,0,0,0,0);

/* Words of the High Chief */
DELETE FROM `quest_details` WHERE `ID`=5128;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5128,1,2,0,0,0,0,0,0,0);

/* Finkle Einhorn, At Your Service! */
DELETE FROM `quest_details` WHERE `ID`=5047;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5047,1,25,1,5,0,0,0,0,0);

/* Frostsaber Provisions */
DELETE FROM `quest_details` WHERE `ID`=4970;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4970,1,0,0,0,0,0,0,0,0);

/* Winterfall Intrusion */
DELETE FROM `quest_details` WHERE `ID`=5201;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5201,1,0,0,0,0,0,0,0,0);

/* Rampaging Giants */
DELETE FROM `quest_details` WHERE `ID`=5981;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5981,1,0,0,0,0,0,0,0,0);

/* Vahlarriel's Search */
DELETE FROM `quest_details` WHERE `ID`=1437;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1437,2,1,1,0,0,0,0,0,0);

/* Vahlarriel's Search */
DELETE FROM `quest_details` WHERE `ID`=1438;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1438,1,1,1,0,0,0,0,0,0);

/* Search for Tyranis */
DELETE FROM `quest_details` WHERE `ID`=1439;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1439,1,5,1,274,0,0,0,0,0);

/* Return to Vahlarriel */
DELETE FROM `quest_details` WHERE `ID`=1440;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1440,1,1,0,0,0,0,0,0,0);

/* Vyletongue Corruption */
DELETE FROM `quest_details` WHERE `ID`=7041;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7041,1,0,0,0,0,0,0,0,0);

/* Down the Scarlet Path */
DELETE FROM `quest_details` WHERE `ID`=261;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (261,1,1,25,0,0,0,0,0,0);

/* Down the Scarlet Path */
DELETE FROM `quest_details` WHERE `ID`=1052;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1052,1,1,0,0,0,0,0,0,0);

/* Centaur Bounty */
DELETE FROM `quest_details` WHERE `ID`=1387;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1387,1,0,0,0,0,0,0,0,0);

/* Sceptre of Light */
UPDATE `quest_offer_reward` SET `RewardText`="The elusive Sceptre of Light! Your acquisition of it has removed a grave threat to the world. Well done, $C, well done." WHERE `ID`=5741;

/* Book of the Ancients */
UPDATE `quest_offer_reward` SET `RewardText`="The long lost Book of the Ancients! I will ensure this book is passed on to the high council. You've done well today, and for that you are to be thanked... as a hero should be thanked!" WHERE `ID`=6027;

/* Reclaimers' Business in Desolace */
DELETE FROM `quest_details` WHERE `ID`=1453;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1453,1,1,0,0,0,0,0,0,40443); -- Reclaimers' Business in Desolace

/* Reagents for Reclaimers Inc. */
DELETE FROM `quest_details` WHERE `ID`=1458;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1458,1,1,0,0,0,0,0,0,0);

/* Reagents for Reclaimers Inc. */
DELETE FROM `quest_details` WHERE `ID`=1459;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1459,1,1,0,0,0,0,0,0,0);

/* Reagents for Reclaimers Inc. */
DELETE FROM `quest_details` WHERE `ID`=1466;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1466,1,1,0,0,0,0,0,0,0);

/* Reagents for Reclaimers Inc. */
DELETE FROM `quest_details` WHERE `ID`=1467;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1467,1,1,0,0,0,0,0,0,0);

/* The Karnitol Shipwreck */
DELETE FROM `quest_details` WHERE `ID` IN (1456,1455,1454);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1456,1,1,0,0,0,0,0,0,40443);

/* The Karnitol Shipwreck */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1455,0,0,0,0,0,0,0,0,40443);

/* The Karnitol Shipwreck */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1454,0,0,0,0,0,0,0,0,40443);

/* The Karnitol Shipwreck */
DELETE FROM `quest_details` WHERE `ID`=1457;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1457,1,11,1,0,0,0,0,0,0);

/* In Nightmares */
DELETE FROM `quest_details` WHERE `ID` IN (3370,3369);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3370,1,1,1,0,0,0,0,0,0);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3369,1,1,1,0,0,0,0,0,0);

/* Rat Catching */
DELETE FROM `quest_details` WHERE `ID`=416;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (416,1,5,0,0,0,0,0,0,0);

/* Mercenaries */
DELETE FROM `quest_details` WHERE `ID`=255;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (255,1,0,0,0,0,0,0,0,0);

/* Bailor's Ore Shipment */
DELETE FROM `quest_details` WHERE `ID`=1655;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1655,5,6,1,1,0,0,0,0,0);

/* Badlands Reagent Run */
DELETE FROM `quest_details` WHERE `ID`=2500;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2500,1,1,1,0,0,0,0,0,0);

/* Uldaman Reagent Run */
DELETE FROM `quest_details` WHERE `ID`=17;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (17,1,1,1,0,0,0,0,0,0);

/* Badlands Reagent Run II */
DELETE FROM `quest_details` WHERE `ID`=2501;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2501,1,1,1,0,0,0,0,0,0);

/* Thelsamar Blood Sausages */
DELETE FROM `quest_details` WHERE `ID`=418;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (418,1,0,0,0,0,0,0,0,0);

/* Stonegear's Search */
DELETE FROM `quest_details` WHERE `ID`=467;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (467,1,0,0,0,0,0,0,0,0);

/* Search for Incendicite */
DELETE FROM `quest_details` WHERE `ID`=466;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (466,1,0,0,0,0,0,0,0,0);

/* Mountaineer Stormpike's Task */
DELETE FROM `quest_details` WHERE `ID`=1339;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1339,1,0,0,0,0,0,0,0,0);

/* Stormpike's Order */
DELETE FROM `quest_details` WHERE `ID`=1338;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1338,1,0,0,0,0,0,0,0,0);

/* The Trogg Threat */
DELETE FROM `quest_details` WHERE `ID`=267;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (267,1,1,0,0,0,0,0,0,0);

/* In Defense of the King's Lands */
DELETE FROM `quest_details` WHERE `ID`=224;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (224,5,1,1,0,0,0,0,0,0);

/* In Defense of the King's Lands */
DELETE FROM `quest_details` WHERE `ID`=237;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (237,1,1,0,0,0,0,0,0,0);

/* In Defense of the King's Lands */
DELETE FROM `quest_details` WHERE `ID`=263;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (263,1,1,0,0,0,0,0,0,0);

/* In Defense of the King's Lands */
DELETE FROM `quest_details` WHERE `ID`=217;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (217,1,1,0,0,0,0,0,0,0);

/* Proof of Deed */
DELETE FROM `quest_details` WHERE `ID`=3182;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3182,6,1,0,0,0,0,0,0,0);

/* Proof of Deed */
UPDATE `quest_request_items` SET `EmoteOnComplete`=0 WHERE `ID`=3182;

/* Crocolisk Hunting */
DELETE FROM `quest_details` WHERE `ID`=385;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (385,1,0,0,0,0,0,0,0,0);

/* A Hunter's Boast */
DELETE FROM `quest_details` WHERE `ID`=257;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (257,6,1,1,0,0,0,0,0,0);

/* A Hunter's Challenge */
DELETE FROM `quest_details` WHERE `ID`=258;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (258,1,1,1,0,0,0,0,0,0);

/* Vyrin's Revenge */
DELETE FROM `quest_details` WHERE `ID`=271;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (271,1,1,1,0,0,0,0,0,0);

/* Vyrin's Revenge */
DELETE FROM `quest_details` WHERE `ID`=531;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (531,5,0,0,0,0,0,0,0,0);

/* Report to Mountaineer Rockgar */
DELETE FROM `quest_details` WHERE `ID`=468;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (468,1,0,0,0,0,0,0,0,0);

/* Ironband's Excavation */
DELETE FROM `quest_details` WHERE `ID`=436;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (436,1,1,1,0,0,0,0,0,0);

/* Gathering Idols */
DELETE FROM `quest_details` WHERE `ID`=297;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (297,1,0,0,0,0,0,0,0,0);

/* Excavation Progress Report */
DELETE FROM `quest_details` WHERE `ID`=298;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (298,1,0,0,0,0,0,0,0,0);

/* Report to Ironforge */
DELETE FROM `quest_details` WHERE `ID`=301;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (301,1,1,1,0,0,0,0,0,0);

/* Powder to Ironband */
DELETE FROM `quest_details` WHERE `ID`=302;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (302,1,1,25,0,0,0,0,0,0);

/* Resupplying the Excavation */
DELETE FROM `quest_details` WHERE `ID`=273;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (273,1,1,0,0,0,0,0,0,0);

/* After the Ambush */
DELETE FROM `quest_details` WHERE `ID`=454;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (454,1,0,0,0,0,0,0,0,0);

/* Protecting the Shipment */
DELETE FROM `quest_details` WHERE `ID`=309;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (309,6,1,0,0,0,0,0,0,0);

/* Find Bingles */
DELETE FROM `quest_details` WHERE `ID`=2039;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2039,1,0,0,0,0,0,0,0,0);

/* Bingles' Missing Supplies */
DELETE FROM `quest_details` WHERE `ID`=2038;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2038,1,0,0,0,0,0,0,0,0);

/* Honor Students */
DELETE FROM `quest_details` WHERE `ID`=6387;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6387,1,0,0,0,0,0,0,0,40593);

/* Honor Students */
UPDATE `quest_request_items` SET `EmoteOnComplete`=0 WHERE `ID`=6387;

/* Honor Students */
UPDATE `quest_offer_reward` SET `Emote1`=1, `VerifiedBuild`=40593 WHERE `ID`=6387;

/* Ride to Ironforge */
DELETE FROM `quest_details` WHERE `ID`=6391;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6391,1,0,0,0,0,0,0,0,40593);

/* Ride to Ironforge */
UPDATE `quest_offer_reward` SET `Emote1`=1, `VerifiedBuild`=40593 WHERE `ID`=6391;

/* Gryth Thurden */
DELETE FROM `quest_details` WHERE `ID`=6388;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6388,1,0,0,0,0,0,0,0,40593);

/* Gryth Thurden */
UPDATE `quest_request_items` SET `EmoteOnComplete`=0 WHERE `ID`=6388;

/* Gryth Thurden */
UPDATE `quest_offer_reward` SET `Emote1`=1, `VerifiedBuild`=40593 WHERE `ID`=6388;

/* Return to Brock */
DELETE FROM `quest_details` WHERE `ID`=6392;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6392,1,0,0,0,0,0,0,0,40593);

/* Return to Brock */
UPDATE `quest_request_items` SET `EmoteOnComplete`=6, `CompletionText`='Ah, $n.  Have you returned from Ironforge?' WHERE `ID`=6392;

/* Return to Brock */
UPDATE `quest_offer_reward` SET `Emote1`=1, `RewardText`='You brought the cleavers.  Great!  I\'ll get these to my students.  I\'m sure they\'re eager to use them on some fresh boar meat.$B$BThank you for your help, $n.  I am in your debt, but I hope this money will at least cover your travel costs.', `VerifiedBuild`=40593 WHERE `ID`=6392;

/* Filthy Paws */
DELETE FROM `quest_details` WHERE `ID`=307;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (307,1,0,0,0,0,0,0,0,0);

/* A Dark Threat Looms */
DELETE FROM `quest_details` WHERE `ID`=250;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (250,5,1,25,0,0,0,0,0,0);

/* A Dark Threat Looms */
DELETE FROM `quest_details` WHERE `ID`=161;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (161,1,1,5,0,0,0,0,0,0);

/* A Dark Threat Looms */
DELETE FROM `quest_details` WHERE `ID`=274;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (274,1,1,1,0,0,0,0,0,0);

/* A Dark Threat Looms */
DELETE FROM `quest_details` WHERE `ID`=278;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (278,1,1,5,0,0,0,0,0,0);

/* A Dark Threat Looms */
DELETE FROM `quest_details` WHERE `ID`=280;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (280,1,5,0,0,0,0,0,0,0);

/* Ironband Wants You! */
DELETE FROM `quest_details` WHERE `ID`=707;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (707,1,1,0,0,0,0,0,0,0);

/* Find Agmond */
DELETE FROM `quest_details` WHERE `ID`=738;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (738,1,1,1,0,0,0,0,0,0);

/* Agmond's Fate */
DELETE FROM `quest_details` WHERE `ID`=704;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (704,1,1,25,0,0,0,0,0,0);

/* Scalding Mornbrew Delivery */
DELETE FROM `quest_details` WHERE `ID`=3364;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3364,5,0,0,0,0,0,0,0,0);

/* Speak with Bink */
DELETE FROM `quest_details` WHERE `ID`=1879;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1879,5,1,0,0,0,0,0,0,0);

/* Mage-tastic Gizmonitor */
DELETE FROM `quest_details` WHERE `ID`=1880;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1880,1,1,20,0,0,0,0,0,0);

/* Stocking Jetsteam */
DELETE FROM `quest_details` WHERE `ID`=317;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (317,1,0,0,0,0,0,0,0,0);

/* Evershine */
DELETE FROM `quest_details` WHERE `ID`=318;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (318,1,0,0,0,0,0,0,0,0);

/* A Favor for Evershine */
DELETE FROM `quest_details` WHERE `ID`=319;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (319,1,0,0,0,0,0,0,0,0);

/* Ammo for Rumbleshot */
DELETE FROM `quest_details` WHERE `ID`=5541;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5541,1,5,0,0,0,0,0,0,0);

/* Tundra MacGrann's Stolen Stash */
DELETE FROM `quest_details` WHERE `ID`=312;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (312,1,6,0,0,0,0,0,0,0);

/* Stout to Kadrell */
DELETE FROM `quest_details` WHERE `ID`=414;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (414,1,0,0,0,0,0,0,0,0);

/* The New Frontier */
DELETE FROM `quest_details` WHERE `ID` IN (1000,1004,1015,1018,1019,1047);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1000,15,5,1,0,0,0,0,0,0);

/* The New Frontier */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1004,15,5,1,0,0,0,0,0,0);

/* The New Frontier */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1015,15,5,1,0,0,0,0,0,0);

/* The New Frontier */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1018,15,5,1,0,0,0,0,0,0);

/* The New Frontier */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1019,15,5,1,0,0,0,0,0,0);

/* The New Frontier */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1047,15,5,1,0,0,0,0,0,0);

/* The New Frontier */
UPDATE `quest_template_addon` SET `NextQuestID`=6761 WHERE `ID` IN (1015,1019,1047);

/* The New Frontier */
UPDATE `quest_template_addon` SET `NextQuestID`=1123 WHERE `ID` IN (1000,1004,1018);

/* The New Frontier */
DELETE FROM `quest_details` WHERE `ID`=6761;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6761,1,1,5,25,0,0,0,0,0);

/* Rabine Saturna */
DELETE FROM `quest_details` WHERE `ID` IN (6762,1123);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6762,1,1,1,0,0,0,0,0,0);

/* Rabine Saturna */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1123,1,1,1,0,0,0,0,0,0);

/* Wasteland */
DELETE FROM `quest_details` WHERE `ID`=1124;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1124,1,6,1,0,0,0,0,0,0);

/* The Spirits of Southwind */
DELETE FROM `quest_details` WHERE `ID`=1125;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1125,1,1,1,0,0,0,0,0,0);

/* Hive in the Tower */
DELETE FROM `quest_details` WHERE `ID`=1126;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1126,1,1,25,0,0,0,0,0,0);

/* Umber, Archivist */
DELETE FROM `quest_details` WHERE `ID`=6844;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6844,1,1,1,0,0,0,0,0,0);

/* Uncovering Past Secrets */
DELETE FROM `quest_details` WHERE `ID`=6845;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6845,1,1,6,0,0,0,0,0,0);

/* The Brassbolts Brothers */
DELETE FROM `quest_details` WHERE `ID`=1179;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1179,6,1,1,0,0,0,0,0,0);

/* The Smoldering Ruins of Thaurissan */
DELETE FROM `quest_details` WHERE `ID`=3702;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3702,6,0,0,0,0,0,0,0,0);

/* The Smoldering Ruins of Thaurissan */
DELETE FROM `quest_details` WHERE `ID`=3701;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3701,1,1,1,0,0,0,0,0,0);

/* Kharan Mighthammer */
DELETE FROM `quest_details` WHERE `ID`=4341;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4341,6,5,18,5,0,0,0,3000,0);

/* Kharan Mighthammer */
UPDATE `quest_offer_reward` SET `Emote1`=20 WHERE `ID`=4341;

/* Kharan Mighthammer */
DELETE FROM `quest_details` WHERE `ID`=4341;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4341,6,5,18,5,0,0,0,3000,0);

/* Kharan's Tale */
DELETE FROM `quest_details` WHERE `ID`=4342;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4342,20,0,0,0,0,0,0,0,0);

/* The Bearer of Bad News */
DELETE FROM `quest_details` WHERE `ID`=4361;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4361,5,0,0,0,0,0,0,0,0);

/* The Fate of the Kingdom */
DELETE FROM `quest_details` WHERE `ID`=4362;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4362,1,1,5,0,0,0,0,0,0);

/* The Princess's Surprise */
DELETE FROM `quest_details` WHERE `ID`=4363;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4363,5,25,0,0,0,0,0,0,0);

/* Mythology of the Titans */
DELETE FROM `quest_details` WHERE `ID`=1050;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1050,1,1,1,1,0,0,0,0,0);

/* Powder to Ironband */
UPDATE `quest_details` SET `Emote1`=5 WHERE `ID`=302;

/* The Lost Dwarves */
DELETE FROM `quest_details` WHERE `ID`=2398;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2398,1,0,0,0,0,0,0,0,0);

/* The Hidden Chamber */
DELETE FROM `quest_details` WHERE `ID`=2240;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2240,1,5,0,0,0,0,0,0,0);

/* Reclaimed Treasures */
DELETE FROM `quest_details` WHERE `ID`=1360;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1360,1,1,0,0,0,0,0,0,0);

/* Knowledge in the Deeps */
DELETE FROM `quest_details` WHERE `ID`=971;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (971,1,1,0,0,0,0,0,0,0);

/* Passing the Burden */
DELETE FROM `quest_details` WHERE `ID`=3448;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3448,6,1,0,0,0,0,0,0,0);

/* Arcane Runes */
DELETE FROM `quest_details` WHERE `ID`=3449;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3449,1,1,1,0,0,0,0,0,0);

/* An Easy Pickup */
DELETE FROM `quest_details` WHERE `ID`=3450;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3450,1,1,0,0,0,0,0,0,0);

/* Signal for Pickup */
DELETE FROM `quest_details` WHERE `ID`=3451;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3451,6,1,1,0,0,0,0,0,0);

/* Return to Tymor */
DELETE FROM `quest_details` WHERE `ID`=3461;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3461,1,1,6,0,0,0,0,0,0);

/* Klockmort's Essentials */
DELETE FROM `quest_details` WHERE `ID`=2925;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2925,1,0,0,0,0,0,0,0,0);

/* Essential Artificials */
DELETE FROM `quest_details` WHERE `ID`=2924;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2924,1,1,0,0,0,0,0,0,0);

/* The Grand Betrayal */
DELETE FROM `quest_details` WHERE `ID`=2929;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2929,5,0,0,0,0,0,0,0,0);

/* The Day After */
DELETE FROM `quest_details` WHERE `ID`=2927;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2927,6,1,5,0,0,0,0,0,0);

/* Gnogaine */
DELETE FROM `quest_details` WHERE `ID`=2926;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2926,1,1,1,0,0,0,0,0,0);

/* The Only Cure is More Green Glow */
DELETE FROM `quest_details` WHERE `ID`=2962;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2962,1,1,1,0,0,0,0,0,0);

/* Speak with Shoni */
DELETE FROM `quest_details` WHERE `ID`=2041;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2041,1,0,0,0,0,0,0,0,0);

/* Sara Balloo's Plea */
DELETE FROM `quest_details` WHERE `ID`=683;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (683,1,1,0,0,0,0,0,0,0);

/* A King's Tribute */
DELETE FROM `quest_details` WHERE `ID`=686;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (686,1,1,1,0,0,0,0,0,0);

/* A King's Tribute */
DELETE FROM `quest_details` WHERE `ID`=689;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (689,6,6,1,0,0,0,0,0,0);

/* A King's Tribute */
DELETE FROM `quest_details` WHERE `ID`=700;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (700,1,1,0,0,0,0,0,0,0);

/* Imperial Plate Armor */
DELETE FROM `quest_details` WHERE `ID` IN (10891,10892);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10891,1,0,0,0,0,0,0,0,0);

/* Imperial Plate Armor */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10892,1,0,0,0,0,0,0,0,0);

/* Imperial Plate Belt */
UPDATE `quest_offer_reward` SET `Emote1`=1, `RewardText`="A pleasure doin' business with ya.$B$BAnd $N, wipe that look of disgust off yer face." WHERE `ID`=7653;

/* Imperial Plate Chest */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1, `CompletionText`="For the chest piece plans, I'll be needin' 30 thorium bars.$B$BOh boy, there you go again. Are you gonna be runnin' to yer blue Gods, askin' why they have forsaken you?!? Toughen up, Nancy! Nobody ever said life's fair." WHERE `ID`=7656;

/* The Platinum Discs */
DELETE FROM `quest_details` WHERE `ID`=2439;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2439,4,0,0,0,0,0,0,0,0);

/* Portents of Uldum */
DELETE FROM `quest_details` WHERE `ID`=2963;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2963,2,1,5,0,0,0,0,0,0);

/* Seeing What Happens */
DELETE FROM `quest_details` WHERE `ID`=2946;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2946,1,1,1,0,0,0,0,0,0);

/* A Future Task */
DELETE FROM `quest_details` WHERE `ID`=2964;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2964,1,1,0,0,0,0,0,0,0);

/* Road to Salvation */
DELETE FROM `quest_details` WHERE `ID`=2218;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2218,1,1,0,0,0,0,0,0,0);

/* Simple Subterfugin' */
DELETE FROM `quest_details` WHERE `ID`=2238;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2238,1,1,1,0,0,0,0,0,0);

/* Onin's Report */
DELETE FROM `quest_details` WHERE `ID`=2239;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2239,1,0,0,0,0,0,0,0,0);

/* To Hulfdan! */
DELETE FROM `quest_details` WHERE `ID`=2299;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2299,6,5,0,0,0,0,0,0,0);

/* Kingly Shakedown */
DELETE FROM `quest_details` WHERE `ID`=2298;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2298,1,5,0,0,0,0,0,0,0);

/* Tome of Divinity */
DELETE FROM `quest_details` WHERE `ID`=2997;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2997,1,1,0,0,0,0,0,0,0);

/* Tome of Divinity */
DELETE FROM `quest_details` WHERE `ID`=3000;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3000,1,1,0,0,0,0,0,0,0);

/* Tome of Divinity */
DELETE FROM `quest_details` WHERE `ID`=2999;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2999,1,1,0,0,0,0,0,0,0);

/* The Tome of Divinity */
DELETE FROM `quest_details` WHERE `ID`=1647;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1647,1,1,1,0,0,0,0,0,0);

/* The Tome of Divinity */
DELETE FROM `quest_details` WHERE `ID`=1648;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1648,1,1,1,0,0,0,0,0,0);

/* The Tome of Divinity */
DELETE FROM `quest_details` WHERE `ID`=1778;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1778,1,3,0,0,0,0,0,0,0);

/* The Tome of Divinity */
DELETE FROM `quest_details` WHERE `ID`=1779;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1779,1,1,1,0,0,0,0,0,0);

/* The Tome of Divinity */
DELETE FROM `quest_details` WHERE `ID`=1783;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1783,1,1,1,6,0,0,0,0,0);

/* The Tome of Divinity */
DELETE FROM `quest_details` WHERE `ID`=1784;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1784,1,1,1,1,0,0,0,0,0);

/* The Tome of Divinity */
DELETE FROM `quest_details` WHERE `ID`=1785;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1785,1,1,2,0,0,0,0,0,0);

/* Taming the Beast */
DELETE FROM `quest_details` WHERE `ID` IN (6064,6084,6085,6086);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6064,1,0,0,0,0,0,0,0,0);

/* Taming the Beast */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6084,1,0,0,0,0,0,0,0,0);

/* Taming the Beast */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6085,1,0,0,0,0,0,0,0,0);

/* Training the Beast */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6086,1,0,0,0,0,0,0,0,0);

/* Lore for a Price */
DELETE FROM `quest_details` WHERE `ID`=2199;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2199,1,0,0,0,0,0,0,0,0);

/* Back to Uldaman */
DELETE FROM `quest_details` WHERE `ID`=2200;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2200,1,0,0,0,0,0,0,0,0);

/* Replacement Phial */
DELETE FROM `quest_details` WHERE `ID`=3375;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3375,6,5,0,0,0,0,0,0,0);

/* Restoring the Necklace */
DELETE FROM `quest_details` WHERE `ID`=2204;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2204,1,0,0,0,0,0,0,0,0);

/* An Earnest Proposition */
DELETE FROM `quest_details` WHERE `ID` IN (8905,8906,8907,8908,8909,8910,8911,8912,10492,8913,8914,8915,8916,8917,8918,8919,8920,10493);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8905,2,1,1,0,0,0,0,0,0);

/* An Earnest Proposition */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8906,2,1,1,0,0,0,0,0,0);

/* An Earnest Proposition */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8907,2,1,1,0,0,0,0,0,0);

/* An Earnest Proposition */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8908,2,1,1,0,0,0,0,0,0);

/* An Earnest Proposition */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8909,2,1,1,0,0,0,0,0,0);

/* An Earnest Proposition */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8910,2,1,1,0,0,0,0,0,0);

/* An Earnest Proposition */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8911,2,1,1,0,0,0,0,0,0);

/* An Earnest Proposition */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8912,2,1,1,0,0,0,0,0,0);

/* An Earnest Proposition */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10492,2,1,1,0,0,0,0,0,0);

/* An Earnest Proposition */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8913,2,1,1,0,0,0,0,0,0);

/* An Earnest Proposition */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8914,2,1,1,0,0,0,0,0,0);

/* An Earnest Proposition */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8915,2,1,1,0,0,0,0,0,0);

/* An Earnest Proposition */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8916,2,1,1,0,0,0,0,0,0);

/* An Earnest Proposition */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8917,2,1,1,0,0,0,0,0,0);

/* An Earnest Proposition */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8918,2,1,1,0,0,0,0,0,0);

/* An Earnest Proposition */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8919,2,1,1,0,0,0,0,0,0);

/* An Earnest Proposition */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8920,2,1,1,0,0,0,0,0,0);

/* An Earnest Proposition */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10493,2,1,1,0,0,0,0,0,0);

/* A Supernatural Device */
DELETE FROM `quest_details` WHERE `ID` IN (8922,8923);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8922,1,1,0,0,0,0,0,0,0);

/* A Supernatural Device */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8923,1,1,0,0,0,0,0,0,0);

/* The Ectoplasmic Distiller */
DELETE FROM `quest_details` WHERE `ID`=8921;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8921,5,6,0,0,0,0,0,0,0);

/* Hunting for Ectoplasm */
DELETE FROM `quest_details` WHERE `ID`=8924;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8924,5,1,1,0,0,0,0,0,0);

/* A Portable Power Source */
DELETE FROM `quest_details` WHERE `ID`=8925;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8925,1,1,0,0,0,0,0,0,0);

/* A Shifty Merchant */
DELETE FROM `quest_details` WHERE `ID`=8928;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8928,1,1,25,0,0,0,0,0,0);

/* Return to Deliana */
DELETE FROM `quest_details` WHERE `ID`=8977;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8977,2,1,0,0,0,0,0,0,0);

/* Return to Mokvar */
DELETE FROM `quest_details` WHERE `ID`=8978;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8978,2,1,0,0,0,0,0,0,0);

/* Just Compensation */
DELETE FROM `quest_details` WHERE `ID` IN (8926,8931,8932,8933,8934,8935,8936,8937,10494,8927,8938,8939,8940,8941,8942,8943,8944,10495);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8926,1,1,0,0,0,0,0,0,0);

/* Just Compensation */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8931,1,1,0,0,0,0,0,0,0);

/* Just Compensation */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8932,1,1,0,0,0,0,0,0,0);

/* Just Compensation */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8933,1,1,0,0,0,0,0,0,0);

/* Just Compensation */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8934,1,1,0,0,0,0,0,0,0);

/* Just Compensation */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8935,1,1,0,0,0,0,0,0,0);

/* Just Compensation */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8936,1,1,0,0,0,0,0,0,0);

/* Just Compensation */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8937,1,1,0,0,0,0,0,0,0);

/* Just Compensation */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10494,1,1,0,0,0,0,0,0,0);

/* Just Compensation */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8927,1,1,0,0,0,0,0,0,0);

/* Just Compensation */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8938,1,1,0,0,0,0,0,0,0);

/* Just Compensation */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8939,1,1,0,0,0,0,0,0,0);

/* Just Compensation */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8940,1,1,0,0,0,0,0,0,0);

/* Just Compensation */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8941,1,1,0,0,0,0,0,0,0);

/* Just Compensation */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8942,1,1,0,0,0,0,0,0,0);

/* Just Compensation */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8943,1,1,0,0,0,0,0,0,0);

/* Just Compensation */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8944,1,1,0,0,0,0,0,0,0);

/* Just Compensation */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10495,1,1,0,0,0,0,0,0,0);

/* In Search of Anthion */
DELETE FROM `quest_details` WHERE `ID` IN (8929,8930);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8929,1,1,0,0,0,0,0,0,0);

/* In Search of Anthion */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8930,1,1,0,0,0,0,0,0,0);

/* Dead Man's Plea */
DELETE FROM `quest_details` WHERE `ID`=8945;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8945,1,5,1,0,0,0,0,0,0);

/* Proof of Life */
DELETE FROM `quest_details` WHERE `ID`=8946;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8946,1,1,2,0,0,0,0,0,0);

/* Anthion's Strange Request */
DELETE FROM `quest_details` WHERE `ID`=8947;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8947,1,1,1,0,0,0,0,0,0);

/* Anthion's Old Friend */
DELETE FROM `quest_details` WHERE `ID`=8948;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8948,1,1,1,0,0,0,0,0,0);

/* Falrin's Vendetta */
DELETE FROM `quest_details` WHERE `ID`=8949;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8949,1,1,5,0,0,0,0,0,0);

/* The Instigator's Enchantment */
DELETE FROM `quest_details` WHERE `ID`=8950;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8950,1,1,0,0,0,0,0,0,0);

/* The Challenge */
DELETE FROM `quest_details` WHERE `ID`=9015;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9015,1,1,1,0,0,0,0,0,0);

/* Bodley's Unfortunate Fate */
DELETE FROM `quest_details` WHERE `ID` IN (8960,9032);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8960,6,1,1,0,0,0,0,0,0);

/* Bodley's Unfortunate Fate */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9032,5,1,1,0,0,0,0,0,0);

/* Three Kings of Flame */
DELETE FROM `quest_details` WHERE `ID`=8961;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8961,1,1,1,0,0,0,0,0,0);

/* Components of Importance */
DELETE FROM `quest_details` WHERE `ID` IN (8962,8963,8964,8965);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8962,1,1,1,0,0,0,0,0,0);

/* Components of Importance */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8963,1,1,1,0,0,0,0,0,0);

/* Components of Importance */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8964,1,1,1,0,0,0,0,0,0);

/* Components of Importance */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8965,1,1,1,0,0,0,0,0,0);

/* The Left Piece of Lord Valthalak's Amulet */
DELETE FROM `quest_details` WHERE `ID` IN (8966,8967,8968,8969);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8966,1,1,1,0,0,0,0,0,0);

/* The Left Piece of Lord Valthalak's Amulet */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8967,1,1,1,0,0,0,0,0,0);

/* The Left Piece of Lord Valthalak's Amulet */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8968,1,1,1,0,0,0,0,0,0);

/* The Left Piece of Lord Valthalak's Amulet */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8969,1,1,1,0,0,0,0,0,0);

/* I See Alcaz Island In Your Future... */
DELETE FROM `quest_details` WHERE `ID`=8970;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8970,1,1,1,0,0,0,0,0,0);

/* More Components of Importance */
DELETE FROM `quest_details` WHERE `ID` IN (8985,8986,8987,8988);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8985,1,1,1,0,0,0,0,0,0);

/* More Components of Importance */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8986,1,1,1,0,0,0,0,0,0);

/* More Components of Importance */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8987,1,1,1,0,0,0,0,0,0);

/* More Components of Importance */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8988,1,1,1,0,0,0,0,0,0);

/* The Right Piece of Lord Valthalak's Amulet */
DELETE FROM `quest_details` WHERE `ID` IN (8989,8990,8991,8992);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8989,1,1,1,0,0,0,0,0,0);

/* The Right Piece of Lord Valthalak's Amulet */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8990,1,1,1,0,0,0,0,0,0);

/* The Right Piece of Lord Valthalak's Amulet */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8991,1,1,1,0,0,0,0,0,0);

/* The Right Piece of Lord Valthalak's Amulet */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8992,1,1,1,0,0,0,0,0,0);

/* Final Preparations */
DELETE FROM `quest_details` WHERE `ID`=8994;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8994,1,1,1,0,0,0,0,0,0);

/* Mea Culpa, Lord Valthalak */
DELETE FROM `quest_details` WHERE `ID`=8995;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8995,1,1,1,1,0,0,0,0,0);

/* Back to the Beginning */
DELETE FROM `quest_details` WHERE `ID` IN (8997,8998);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8997,1,1,0,0,0,0,0,0,0);

/* Back to the Beginning */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8998,1,1,0,0,0,0,0,0,0);

/* The Art of the Armorsmith */
DELETE FROM `quest_details` WHERE `ID`=5283;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5283,1,1,1,6,0,0,0,0,0);

/* The Art of the Armorsmith */
DELETE FROM `quest_details` WHERE `ID`=5301;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5301,1,1,1,6,0,0,0,0,0);

/* The Way of the Weaponsmith */
DELETE FROM `quest_details` WHERE `ID`=5284;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5284,1,1,1,25,0,0,0,0,0);

/* The Way of the Weaponsmith */
DELETE FROM `quest_details` WHERE `ID`=5302;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5302,1,1,1,0,0,0,0,0,0);

/* The Greenwarden */
DELETE FROM `quest_details` WHERE `ID`=463;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (463,1,0,0,0,0,0,0,0,0);

/* Daily Delivery */
DELETE FROM `quest_details` WHERE `ID`=469;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (469,3,1,0,0,0,0,0,0,0);

/* In Search of The Excavation Team */
DELETE FROM `quest_details` WHERE `ID`=305;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (305,5,1,5,0,0,0,0,0,0);

/* In Search of The Excavation Team */
DELETE FROM `quest_details` WHERE `ID`=306;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (306,5,1,0,0,0,0,0,0,0);

/* Uncovering the Past */
DELETE FROM `quest_details` WHERE `ID`=299;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (299,1,1,5,0,0,0,0,0,0);

/* Ormer's Revenge */
DELETE FROM `quest_details` WHERE `ID`=294;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (294,1,1,0,0,0,0,0,0,0);

/* Ormer's Revenge */
DELETE FROM `quest_details` WHERE `ID`=295;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (295,1,0,0,0,0,0,0,0,0);

/* Ormer's Revenge */
DELETE FROM `quest_details` WHERE `ID`=296;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (296,1,5,0,0,0,0,0,0,0);

/* Ormer's Revenge */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6, `EmoteOnComplete`=6 WHERE `ID`=296;

/* The Third Fleet */
DELETE FROM `quest_details` WHERE `ID`=288;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (288,1,0,0,0,0,0,0,0,0);

/* The Cursed Crew */
DELETE FROM `quest_details` WHERE `ID`=289;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (289,1,0,0,0,0,0,0,0,0);

/* Lifting the Curse */
DELETE FROM `quest_details` WHERE `ID`=290;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (290,1,1,0,0,0,0,0,0,0);

/* Cleansing the Eye */
DELETE FROM `quest_details` WHERE `ID`=293;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (293,1,0,0,0,0,0,0,0,0);

/* Young Crocolisk Skins */
DELETE FROM `quest_details` WHERE `ID`=484;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (484,2,0,0,0,0,0,0,0,0);

/* Apprentice's Duties */
DELETE FROM `quest_details` WHERE `ID`=471;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (471,1,0,0,0,0,0,0,0,0);

/* A Grim Task */
DELETE FROM `quest_details` WHERE `ID`=304;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (304,1,0,0,0,0,0,0,0,0);

/* The Dark Iron War */
DELETE FROM `quest_details` WHERE `ID`=303;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (303,1,1,5,0,0,0,0,0,0);

/* The Fury Runs Deep */
DELETE FROM `quest_details` WHERE `ID`=378;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (378,1,1,0,0,0,0,0,0,0);

/* The Thandol Span */
DELETE FROM `quest_details` WHERE `ID`=631;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (631,5,1,6,0,0,0,0,0,0);

/* The Thandol Span */
DELETE FROM `quest_details` WHERE `ID`=633;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (633,5,1,5,0,0,0,0,0,0);

/* Plea To The Alliance */
DELETE FROM `quest_details` WHERE `ID`=634;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (634,1,0,0,0,0,0,0,0,0);

/* The Hammer May Fall */
DELETE FROM `quest_details` WHERE `ID`=676;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (676,5,1,0,0,0,0,0,0,0);

/* Call to Arms */
DELETE FROM `quest_details` WHERE `ID`=677;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (677,1,1,0,0,0,0,0,0,0);

/* Call to Arms */
DELETE FROM `quest_details` WHERE `ID`=679;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (679,1,1,0,0,0,0,0,0,0);

/* Sigil of Strom */
DELETE FROM `quest_details` WHERE `ID`=639;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (639,1,0,0,0,0,0,0,0,0);

/* The Broken Sigil */
DELETE FROM `quest_details` WHERE `ID`=640;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (640,1,0,0,0,0,0,0,0,0);

/* Sigil of Arathor */
DELETE FROM `quest_details` WHERE `ID`=643;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (643,1,0,0,0,0,0,0,0,0);

/* Sigil of Trollbane */
DELETE FROM `quest_details` WHERE `ID`=644;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (644,1,0,0,0,0,0,0,0,0);

/* Trol'kalar */
DELETE FROM `quest_details` WHERE `ID`=645;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (645,6,1,0,0,0,0,0,0,0);

/* Raising Spirits */
DELETE FROM `quest_details` WHERE `ID`=675;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (675,61,0,0,0,0,0,0,0,0);

/* Guile of the Raptor */
DELETE FROM `quest_details` WHERE `ID`=847;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (847,23,0,0,0,0,0,0,0,0);

/* Foul Magics */
UPDATE `quest_request_items` SET `EmoteOnComplete`=0 WHERE `ID` IN (671, 672, 673, 674, 701, 702);

/* Theldurin the Lost */
DELETE FROM `quest_details` WHERE `ID`=687;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (687,1,1,0,0,0,0,0,0,0);

/* The Lost Fragments */
DELETE FROM `quest_details` WHERE `ID`=692;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (692,6,5,1,5,0,0,0,0,0);

/* Summoning the Princess */
DELETE FROM `quest_details` WHERE `ID`=656;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (656,1,5,6,1,0,0,0,0,0);

/* Elemental Leatherworking */
DELETE FROM `quest_details` WHERE `ID`=5146;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5146,1,25,0,0,0,0,0,0,0);

/* The Battle for Arathi Basin! */
DELETE FROM `quest_details` WHERE `ID` IN (8120,8169,8170,8171,8105,8166,8167,8168);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8120,1,0,0,0,0,0,0,0,0);

/* The Battle for Arathi Basin! */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8169,1,0,0,0,0,0,0,0,0);

/* The Battle for Arathi Basin! */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8170,1,0,0,0,0,0,0,0,0);

/* The Battle for Arathi Basin! */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8171,1,0,0,0,0,0,0,0,0);

/* The Battle for Arathi Basin! */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8105,1,0,0,0,0,0,0,0,0);

/* The Battle for Arathi Basin! */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8166,1,0,0,0,0,0,0,0,0);

/* The Battle for Arathi Basin! */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8167,1,0,0,0,0,0,0,0,0);

/* The Battle for Arathi Basin! */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8168,1,0,0,0,0,0,0,0,0);

/* Take Four Bases */
DELETE FROM `quest_details` WHERE `ID` IN (8121,8122);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8121,1,0,0,0,0,0,0,0,0);

/* Take Five Bases */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8122,1,0,0,0,0,0,0,0,0);

/* Control Four Bases */
DELETE FROM `quest_details` WHERE `ID` IN (8114,8115);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8114,1,0,0,0,0,0,0,0,0);

/* Control Five Bases */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8115,1,0,0,0,0,0,0,0,0);

/* Arathi Basin Resources! */
DELETE FROM `quest_details` WHERE `ID` IN (8080,8154,8155,8156,8297);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8080,1,0,0,0,0,0,0,0,0);

/* Arathi Basin Resources! */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8154,1,0,0,0,0,0,0,0,0);

/* Arathi Basin Resources! */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8155,1,0,0,0,0,0,0,0,0);

/* Arathi Basin Resources! */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8156,1,0,0,0,0,0,0,0,0);

/* Arathi Basin Resources! */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8297,1,0,0,0,0,0,0,0,0);

/* Wand over Fist */
DELETE FROM `quest_details` WHERE `ID`=693;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (693,1,1,0,0,0,0,0,0,0);

/* Trelane's Defenses */
DELETE FROM `quest_details` WHERE `ID`=694;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (694,6,1,0,0,0,0,0,0,0);

/* Attack on the Tower */
DELETE FROM `quest_details` WHERE `ID`=696;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (696,1,1,1,0,0,0,0,0,0);

/* Malin's Request */
DELETE FROM `quest_details` WHERE `ID`=697;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (697,1,2,0,0,0,0,0,0,0);

/* Sunken Treasure */
DELETE FROM `quest_details` WHERE `ID`=665;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (665,1,0,0,0,0,0,0,0,0);

/* Sunken Treasure */
DELETE FROM `quest_details` WHERE `ID`=666;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (666,1,0,0,0,0,0,0,0,0);

/* Sunken Treasure */
DELETE FROM `quest_details` WHERE `ID`=668;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (668,1,0,0,0,0,0,0,0,0);

/* Sunken Treasure */
DELETE FROM `quest_details` WHERE `ID`=669;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (669,1,0,0,0,0,0,0,0,0);

/* Sunken Treasure */
DELETE FROM `quest_details` WHERE `ID`=670;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (670,1,0,0,0,0,0,0,0,0);

/* Drowned Sorrows */
DELETE FROM `quest_details` WHERE `ID`=664;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (664,1,1,0,0,0,0,0,0,0);

/* Death From Below */
DELETE FROM `quest_details` WHERE `ID`=667;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (667,5,0,0,0,0,0,0,0,0);

/* Missing Crystals */
DELETE FROM `quest_details` WHERE `ID`=9435;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9435,1,0,0,0,0,0,0,0,0);

/* Down the Coast */
DELETE FROM `quest_details` WHERE `ID`=536;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (536,7,0,0,0,0,0,0,0,0);

/* Farren's Proof */
DELETE FROM `quest_details` WHERE `ID`=559;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (559,6,0,0,0,0,0,0,0,0);

/* Farren's Proof */
DELETE FROM `quest_details` WHERE `ID`=560;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (560,6,0,0,0,0,0,0,0,0);

/* Stormwind Ho! */
DELETE FROM `quest_details` WHERE `ID`=562;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (562,1,0,0,0,0,0,0,0,0);

/* Reassignment */
DELETE FROM `quest_details` WHERE `ID`=563;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (563,1,0,0,0,0,0,0,0,0);

/* Costly Menace */
DELETE FROM `quest_details` WHERE `ID`=564;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (564,1,1,5,0,0,0,0,0,0);

/* Soothing Turtle Bisque */
DELETE FROM `quest_details` WHERE `ID`=555;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (555,1,1,0,0,0,0,0,0,0);

/* Letter to Stormpike */
DELETE FROM `quest_details` WHERE `ID`=514;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (514,1,0,0,0,0,0,0,0,0);

/* Further Mysteries */
DELETE FROM `quest_details` WHERE `ID`=525;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (525,1,6,0,0,0,0,0,0,0);

/* MacKreel's Moonshine */
DELETE FROM `quest_details` WHERE `ID`=647;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (647,5,1,5,0,0,0,0,0,0);

/* Hints of a New Plague? */
DELETE FROM `quest_details` WHERE `ID`=659;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (659,1,1,6,0,0,0,0,0,0);

/* Hints of a New Plague? */
DELETE FROM `quest_details` WHERE `ID`=658;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (658,6,1,1,0,0,0,0,0,0);

/* Hints of a New Plague? */
DELETE FROM `quest_details` WHERE `ID`=657;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (657,1,1,1,0,0,0,0,0,0);

/* Hints of a New Plague? */
DELETE FROM `quest_details` WHERE `ID`=660;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (660,1,0,0,0,0,0,0,0,0);

/* Hints of a New Plague? */
DELETE FROM `quest_details` WHERE `ID`=661;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (661,11,1,6,0,0,0,0,0,0);

/* Bartolo's Yeti Fur Cloak */
DELETE FROM `quest_details` WHERE `ID`=565;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (565,94,0,0,0,0,0,0,0,0);

/* Stormpike's Deciphering */
DELETE FROM `quest_details` WHERE `ID`=554;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (554,1,1,0,0,0,0,0,0,0);

/* Rise and Be Recognized */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1, `EmoteOnComplete`=1, `CompletionText`="Most do not live long enough to rise above their own mediocrity. You have proven yourself to be an exemplary soldier, $c. The time has come.$B$BPresent your insignia." WHERE `ID`=7168;

/* Honored Amongst the Guard */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=5, `EmoteOnComplete`=5, `CompletionText`="The base buzzes with news of your exploits in the Field of Strife! You have struck mighty blows against our enemy - crushing their morale! For this, you have earned a rank of honor among the Stormpike.$B$BPresent your insignia." WHERE `ID`=7169;

/* Earned Reverence */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6, `EmoteOnComplete`=6, `CompletionText`="I must know, $n. When you look directly into the eyes of the enemy, do you see fear? Do they now cower in your presence? They must realize that they are defeated!$B$BYou have earned reverence among the Guard. Present your insignia!" WHERE `ID`=7170;

/* Legendary Heroes */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=66, `EmoteOnComplete`=66, `CompletionText`="Before me stands an exalted hero of the Alliance.$B$B<Lieutenant Haggerdin salutes.>$B$BFew have earned such a rank among the Stormpike. I have watched the enemy fall before you. I have seen their resolve crumble in your presence. When you enter the fray, you become the beacon of hope for our forces!$B$BPresent your insignia." WHERE `ID`=7171;

/* The Eye of Command */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=5, `EmoteOnComplete`=5, `CompletionText`="Let them hear your voice, commander $n! Let them know fear. Show them what power the Stormpike holds in their rank!$B$BPresent your insignia." WHERE `ID`=7172;

/* The Eye of Command */
UPDATE `quest_offer_reward` SET `Emote1`=66, `RewardText`="It is you who must lead our troops to victory, Commander! The soldiers are under your command. They will follow your direct orders. Lead them... Crush the Frostwolf." WHERE `ID`=7172;

/* This Old Lighthouse */
DELETE FROM `quest_details` WHERE `ID`=11191;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (11191,1,1,0,0,0,0,0,0,0);

/* Challenge Overlord Mok'Morokk */
DELETE FROM `quest_details` WHERE `ID`=1173;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1173,11,15,0,0,0,0,0,0,0);

/* The Witch's Bane */
DELETE FROM `quest_details` WHERE `ID`=11181;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (11181,1,1,0,0,0,0,0,0,0);

/* Cleansing Witch Hill */
DELETE FROM `quest_details` WHERE `ID`=11183;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (11183,1,1,0,0,0,0,0,0,0);

/* The Troll Witchdoctor */
DELETE FROM `quest_details` WHERE `ID`=1240;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1240,1,0,0,0,0,0,0,0,0);

/* Jarl Needs Eyes */
DELETE FROM `quest_details` WHERE `ID`=1206;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1206,1,6,0,0,0,0,0,0,0);

/* Jarl Needs a Blade */
DELETE FROM `quest_details` WHERE `ID`=1203;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1203,1,0,0,0,0,0,0,0,0);

/* Bloodfen Feathers */
UPDATE `quest_details` SET `Emote3`=1 WHERE `ID` IN (11158,11160,11159,11162,11201,11203);

/* Raze Direhorn Post! */
UPDATE `quest_details` SET `Emote2`=5 WHERE `ID`=11205;

/* They Call Him Smiling Jim */
DELETE FROM `quest_details` WHERE `ID`=1282;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1282,1,1,0,0,0,0,0,0,0);

/* Inspecting the Ruins */
DELETE FROM `quest_details` WHERE `ID`=11123;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (11123,1,1,1,0,0,0,0,0,0);

/* Traitors Among Us */
UPDATE `quest_details` SET `Emote2`=1 WHERE `ID` IN (11126,11128,11194,11133,11134,11177,11214,11136,11209,11210,11137,11146,11147,11145,11212,/*11138,*/11139,11140,11142,11149,11150,11151,11152);

/* Lieutenant Paval Reethe */
DELETE FROM `quest_details` WHERE `ID`=1259;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1259,1,0,0,0,0,0,0,0,0);

/* Daelin's Men */
DELETE FROM `quest_details` WHERE `ID`=1285;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1285,1,0,0,0,0,0,0,0,0);

/* The Deserters */
DELETE FROM `quest_details` WHERE `ID`=1286;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1286,1,0,0,0,0,0,0,0,0);

/* The Black Shield */
DELETE FROM `quest_details` WHERE `ID`=1319;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1319,1,0,0,0,0,0,0,0,0);

/* The Black Shield */
DELETE FROM `quest_details` WHERE `ID`=1320;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1320,1,3,0,0,0,0,0,0,0);

/* Jaina Must Know */
UPDATE `quest_details` SET `Emote1`=5, `Emote2`=1 WHERE `ID`=11141;

/* The Deserters */
DELETE FROM `quest_details` WHERE `ID`=1287;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1287,1,0,0,0,0,0,0,0,0);

/* A Grim Connection */
DELETE FROM `quest_details` WHERE `ID`=11143;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (11143,1,1,1,0,0,0,0,0,0);

/* Confirming the Suspicion */
DELETE FROM `quest_details` WHERE `ID`=11144;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (11144,1,1,0,0,0,0,0,0,0);

/* Arms of the Grimtotems */
DELETE FROM `quest_details` WHERE `ID`=11148;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (11148,1,1,0,0,0,0,0,0,0);

/* Corrosion Prevention */
DELETE FROM `quest_details` WHERE `ID`=11174;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (11174,5,1,0,0,0,0,0,0,0);

/* Shadowshard Fragments */
DELETE FROM `quest_details` WHERE `ID`=7070;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7070,1,1,0,0,0,0,0,0,0);

/* Ripple Recovery */
DELETE FROM `quest_details` WHERE `ID`=649;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (649,25,0,0,0,0,0,0,0,0);

/* Ripple Recovery */
DELETE FROM `quest_details` WHERE `ID`=650;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (650,1,0,0,0,0,0,0,0,0);

/* Ripple Delivery */
DELETE FROM `quest_details` WHERE `ID`=81;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (81,1,0,0,0,0,0,0,0,0);

/* Vilebranch Hooligans */
DELETE FROM `quest_details` WHERE `ID`=7839;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7839,1,0,0,0,0,0,0,0,0);

/* Message to the Wildhammer */
DELETE FROM `quest_details` WHERE `ID`=7841;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7841,1,1,0,0,0,0,0,0,0);

/* The Final Message to the Wildhammer */
DELETE FROM `quest_details` WHERE `ID`=7843;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7843,25,5,0,0,0,0,0,0,0);

/* Hunt the Savages */
DELETE FROM `quest_details` WHERE `ID`=7829;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7829,1,1,0,0,0,0,0,0,0);

/* Avenging the Fallen */
DELETE FROM `quest_details` WHERE `ID`=7830;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7830,1,1,0,0,0,0,0,0,0);

/* The Spider God */
DELETE FROM `quest_details` WHERE `ID`=2936;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2936,1,0,0,0,0,0,0,0,0);

/* Summoning Shadra */
DELETE FROM `quest_details` WHERE `ID`=2937;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2937,1,0,0,0,0,0,0,0,0);

/* Venom to the Undercity */
DELETE FROM `quest_details` WHERE `ID`=2938;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2938,5,1,0,0,0,0,0,0,0);

/* Snapjaws, Mon! */
DELETE FROM `quest_details` WHERE `ID`=7815;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7815,1,0,0,0,0,0,0,0,0);

/* Gammerita, Mon! */
DELETE FROM `quest_details` WHERE `ID`=7816;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7816,1,0,0,0,0,0,0,0,0);

/* Saving Sharpbeak */
DELETE FROM `quest_details` WHERE `ID`=2994;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2994,5,0,0,0,0,0,0,0,0);

/* Gadgetzan Water Survey */
UPDATE `quest_details` SET `Emote1`=1 WHERE `ID`=992;

/* Wastewander Justice */
DELETE FROM `quest_details` WHERE `ID`=1690;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1690,25,5,0,0,0,0,0,0,0);

/* More Wastewander Justice */
DELETE FROM `quest_details` WHERE `ID`=1691;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1691,1,0,0,0,0,0,0,0,0);

/* Water Pouch Bounty */
DELETE FROM `quest_details` WHERE `ID`=1707;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1707,1,0,0,0,0,0,0,0,0);

/* Screecher Spirits */
DELETE FROM `quest_details` WHERE `ID`=3520;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3520,1,1,0,0,0,0,0,0,0);

/* The Ancient Egg */
DELETE FROM `quest_details` WHERE `ID`=4787;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4787,1,0,0,0,0,0,0,0,0);

/* The God Hakkar */
DELETE FROM `quest_details` WHERE `ID`=3528;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3528,1,1,0,0,0,0,0,0,0);

/* Southsea Shakedown */
DELETE FROM `quest_details` WHERE `ID`=8366;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8366,5,1,0,0,0,0,0,0,0);

/* Pirate Hats Ahoy! */
DELETE FROM `quest_details` WHERE `ID`=8365;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8365,1,0,0,0,0,0,0,0,0);

/* Divino-matic Rod */
DELETE FROM `quest_details` WHERE `ID`=2768;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2768,5,0,0,0,0,0,0,0,0);

/* Into the Field */
DELETE FROM `quest_details` WHERE `ID`=243;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (243,1,1,0,0,0,0,0,0,0);

/* Slake That Thirst */
DELETE FROM `quest_details` WHERE `ID`=379;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (379,25,0,0,0,0,0,0,0,0);

/* The Thirsty Goblin */
DELETE FROM `quest_details` WHERE `ID`=2605;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2605,5,1,0,0,0,0,0,0,0);

/* In Good Taste */
DELETE FROM `quest_details` WHERE `ID`=2606;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2606,7,5,0,0,0,0,0,0,0);

/* Sprinkle's Secret Ingredient */
DELETE FROM `quest_details` WHERE `ID`=2641;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2641,1,11,0,0,0,0,0,0,0);

/* Thistleshrub Valley */
DELETE FROM `quest_details` WHERE `ID`=3362;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3362,6,5,0,0,0,0,0,0,0);

/* Scarab Shells */
DELETE FROM `quest_details` WHERE `ID`=2865;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2865,1,0,0,0,0,0,0,0,0);

/* Gahz'ridian */
DELETE FROM `quest_details` WHERE `ID`=3161;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3161,1,0,0,0,0,0,0,0,0);

/* The Scrimshank Redemption */
DELETE FROM `quest_details` WHERE `ID`=10;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (10,5,0,0,0,0,0,0,0,0);

/* March of the Silithid */
DELETE FROM `quest_details` WHERE `ID` IN (4493,4494);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4493,1,0,0,0,0,0,0,0,0);

/* March of the Silithid */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4494,1,0,0,0,0,0,0,0,0);

/* Delivery for Marin */
DELETE FROM `quest_details` WHERE `ID`=2661;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2661,1,0,0,0,0,0,0,0,0);

/* Noggenfogger Elixir */
DELETE FROM `quest_details` WHERE `ID`=2662;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2662,5,0,0,0,0,0,0,0,0);

/* Handle With Care */
DELETE FROM `quest_details` WHERE `ID`=3022;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3022,4,0,0,0,0,0,0,0,0);

/* Troll Temper */
DELETE FROM `quest_details` WHERE `ID`=3042;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3042,1,0,0,0,0,0,0,0,0);

/* A Bad Egg */
UPDATE `quest_offer_reward` SET `Emote1`=274, `Emote1`=1 WHERE `ID`=2750;

/* An Ordinary Egg */
UPDATE `quest_offer_reward` SET `Emote1`=6, `Emote1`=1 WHERE `ID`=2749;

/* A Fine Egg */
UPDATE `quest_offer_reward` SET `Emote1`=273, `Emote1`=1 WHERE `ID`=2748;

/* An Extraordinary Egg */
UPDATE `quest_offer_reward` SET `Emote1`=4, `Emote1`=1 WHERE `ID`=2747;

/* Pawn Captures Queen */
DELETE FROM `quest_details` WHERE `ID`=4507;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4507,1,0,0,0,0,0,0,0,0);

/* Calm Before the Storm */
DELETE FROM `quest_details` WHERE `ID` IN (4508,4509);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4508,1,0,0,0,0,0,0,0,0);

/* Calm Before the Storm */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4509,1,0,0,0,0,0,0,0,0);

/* Calm Before the Storm */
DELETE FROM `quest_details` WHERE `ID` IN (4510,4511);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4510,1,0,0,0,0,0,0,0,0);

/* Calm Before the Storm */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4511,1,0,0,0,0,0,0,0,0);

/* The Lost Tablets of Mosh'aru */
DELETE FROM `quest_details` WHERE `ID`=5065;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5065,274,1,0,0,0,0,0,0,0);

/* The Final Tablets */
DELETE FROM `quest_details` WHERE `ID`=4788;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4788,1,1,0,0,0,0,0,0,0);

/* Confront Yeh'kinya */
DELETE FROM `quest_details` WHERE `ID`=8181;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8181,1,5,0,0,0,0,0,0,0);

/* The Hand of Rastakhan */
DELETE FROM `quest_details` WHERE `ID`=8182;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (8182,1,1,0,0,0,0,0,0,0);

/* Divine Retribution */
DELETE FROM `quest_details` WHERE `ID`=3441;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3441,1,0,0,0,1000,0,0,0,0);

/* The Flawless Flame */
DELETE FROM `quest_details` WHERE `ID`=3442;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3442,1,1,0,0,2000,1000,0,0,0);

/* Forging the Shaft */
DELETE FROM `quest_details` WHERE `ID`=3443;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3443,1,1,0,0,500,500,0,0,0);

/* The Torch of Retribution */
DELETE FROM `quest_details` WHERE `ID`=3453;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3453,1,0,0,0,0,0,0,0,0);

/* Squire Maltrake */
DELETE FROM `quest_details` WHERE `ID`=3462;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3462,1,0,0,0,0,0,0,0,0);

/* Set Them Ablaze! */
DELETE FROM `quest_details` WHERE `ID`=3463;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3463,1,1,1,0,0,0,0,0,0);

/* Curse These Fat Fingers */
DELETE FROM `quest_details` WHERE `ID`=7723;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7723,1,1,1,25,0,0,0,0,0);

/* Incendosaurs? Whateverosaur is More Like It */
DELETE FROM `quest_details` WHERE `ID`=7727;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7727,1,6,0,0,0,0,0,0,0);

/* Fiery Menace! */
DELETE FROM `quest_details` WHERE `ID`=7724;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7724,1,1,1,0,0,0,0,0,0);

/* What the Flux? */
DELETE FROM `quest_details` WHERE `ID`=7722;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7722,1,1,1,0,0,0,0,0,0);

/* Shadoweaver */
DELETE FROM `quest_details` WHERE `ID`=3379;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3379,1,1,1,0,0,0,0,0,0);

/* The Undermarket */
DELETE FROM `quest_details` WHERE `ID`=3385;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3385,1,1,25,0,0,0,0,0,0);

/* The Undermarket */
DELETE FROM `quest_details` WHERE `ID`=3402;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3402,1,0,0,0,0,0,0,0,0);

/* The Undermarket */
UPDATE `quest_offer_reward` SET `Emote1`=4, `Emote2`=4, `Emote3`=5, `RewardText`="Kovic slain??! This is a glorious day, $N! For years that scoundrel has been running shady undermarket trades, undercutting honest, hard working traders all over the world.$b$bYou deserve a fine reward for this accomplishment! And a fine reward you shall have!" WHERE `ID`=3402;

/* Dreadmaul Rock */
DELETE FROM `quest_details` WHERE `ID`=3821;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3821,1,1,6,0,0,0,0,0,0);

/* Krom'Grul */
DELETE FROM `quest_details` WHERE `ID`=3822;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3822,1,1,1,0,0,0,0,0,0);

/* Disharmony of Flame */
DELETE FROM `quest_details` WHERE `ID`=3906;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3906,1,1,1,0,0,0,0,0,0);

/* Disharmony of Fire */
DELETE FROM `quest_details` WHERE `ID`=3907;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3907,1,1,1,0,0,0,0,0,0);

/* Disharmony of Fire */
UPDATE `quest_request_items` SET `EmoteOnComplete`=5, `EmoteOnIncomplete`=5, `CompletionText`="The flames will soon overtake these lands. Make haste, $N!" WHERE `ID`=3907;

/* Disharmony of Fire */
UPDATE `quest_offer_reward` SET `RewardText`="<Thunderheart clutches the Tablet of Kurniya.>$b$bRagnaros... here...$b$bThe elders were right to fear the corruption emanating from Blackrock Mountain. A general of the Old Gods! IN OUR WORLD! We must reassess our position here in Kargath. We must decide on whether we stay and fight or run for fear of a new sundering.$b$bBe weary of any further exploration in Blackrock Mountain, $N. A far greater evil than anything that exists in this world resides in those fiery depths." WHERE `ID`=3907;

/* The Rise of the Machines */
DELETE FROM `quest_details` WHERE `ID`=4061;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4061,1,1,1,0,0,0,0,0,0);

/* The Rise of the Machines */
DELETE FROM `quest_details` WHERE `ID`=4062;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4062,1,1,1,0,0,0,0,0,0);

/* The Rise of the Machines */
DELETE FROM `quest_details` WHERE `ID`=4063;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4063,6,1,1,1,0,0,0,0,0);

/* The Last Element */
DELETE FROM `quest_details` WHERE `ID`=7201;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7201,1,1,5,0,0,0,0,0,0);

/* Badlands Reagent Run */
DELETE FROM `quest_details` WHERE `ID`=2258;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2258,2,1,0,0,0,0,0,0,0);

/* Uldaman Reagent Run */
DELETE FROM `quest_details` WHERE `ID`=2202;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2202,25,0,0,0,0,0,0,0,0);

/* Badlands Reagent Run II */
DELETE FROM `quest_details` WHERE `ID`=2203;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2203,1,1,0,0,0,0,0,0,0);

/* Solution to Doom */
DELETE FROM `quest_details` WHERE `ID`=709;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (709,5,274,1,1,0,0,0,0,0);

/* To Ironforge for Yagyin's Digest */
DELETE FROM `quest_details` WHERE `ID`=727;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (727,1,1,1,0,0,0,0,0,0);

/* To the Undercity for Yagyin's Digest */
DELETE FROM `quest_details` WHERE `ID`=728;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (728,1,1,1,0,0,0,0,0,0);

/* The Star, the Hand and the Heart */
DELETE FROM `quest_details` WHERE `ID` IN (735,736);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (735,6,1,1,0,0,0,0,0,0);

/* The Star, the Hand and the Heart */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (736,6,1,1,0,0,0,0,0,0);

/* Forbidden Knowledge */
DELETE FROM `quest_details` WHERE `ID`=737;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (737,1,1,0,0,0,0,0,0,0);

/* Dragonscale Leatherworking */
DELETE FROM `quest_details` WHERE `ID`=5145;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5145,1,25,0,0,0,0,0,0,0);

/* Necklace Recovery */
DELETE FROM `quest_details` WHERE `ID`=2283;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2283,1,0,0,0,0,0,0,0,0);

/* Necklace Recovery, Take 2 */
DELETE FROM `quest_details` WHERE `ID`=2284;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2284,1,0,0,0,0,0,0,0,0);

/* Translating the Journal */
DELETE FROM `quest_details` WHERE `ID`=2338;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2338,1,0,0,0,0,0,0,0,0);

/* Find the Gems and Power Source */
DELETE FROM `quest_details` WHERE `ID`=2339;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2339,1,0,0,0,0,0,0,0,0);

/* Deliver the Gems */
DELETE FROM `quest_details` WHERE `ID`=2340;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2340,1,0,0,0,0,0,0,0,0);

/* Study of the Elements: Rock */
DELETE FROM `quest_details` WHERE `ID`=710;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (710,1,1,0,0,0,0,0,0,0);

/* Study of the Elements: Rock */
DELETE FROM `quest_details` WHERE `ID`=711;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (711,1,1,0,0,0,0,0,0,0);

/* Study of the Elements: Rock */
DELETE FROM `quest_details` WHERE `ID`=712;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (712,1,1,0,0,0,0,0,0,0);

/* Gyro... What? */
DELETE FROM `quest_details` WHERE `ID`=714;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (714,1,0,0,0,0,0,0,0,0);

/* Gyro... What? */
UPDATE `quest_request_items` SET `EmoteOnComplete`=0, `CompletionText`="Yes, yes, yes. Just a moment." WHERE `ID`=714;

/* This Is Going to Be Hard */
DELETE FROM `quest_details` WHERE `ID`=734;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (734,4,1,0,0,0,0,0,0,0);

/* This Is Going to Be Hard */
DELETE FROM `quest_details` WHERE `ID`=777;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (777,1,0,0,0,0,0,0,0,0);

/* This Is Going to Be Hard */
DELETE FROM `quest_details` WHERE `ID`=778;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (778,4,1,0,0,0,0,0,0,0);

/* Stone Is Better than Cloth */
DELETE FROM `quest_details` WHERE `ID`=716;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (716,1,1,0,0,0,0,0,0,0);

/* Liquid Stone */
DELETE FROM `quest_details` WHERE `ID`=715;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (715,1,1,0,0,0,0,0,0,0);

/* Vivian Lagrave */
DELETE FROM `quest_details` WHERE `ID`=4133;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4133,1,0,0,0,0,0,0,0,0);

/* Tinkee Steamboil */
DELETE FROM `quest_details` WHERE `ID`=4907;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4907,3,6,0,0,0,0,0,0,0);

/* Egg Freezing */
DELETE FROM `quest_details` WHERE `ID`=4734;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4734,1,0,0,0,0,0,0,0,0);

/* Betina Bigglezink */
DELETE FROM `quest_details` WHERE `ID`=5531;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5531,1,1,1,0,0,0,0,0,0);

/* Dawn's Gambit */
DELETE FROM `quest_details` WHERE `ID`=4771;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4771,1,1,1,1,0,0,0,0,0);

/* Dawn's Gambit */
UPDATE `quest_offer_reward` SET `Emote1`=4, `Emote2`=1, `Emote3`=2, `RewardText`="You did it! Vectus is defeated! And Dawn's Gambit... did it work?$B$BHm... maybe my device wasn't the success I had hoped, but I'm glad you were able to handle things anyway. Well done, $n!$B$BThe Argent Dawn, and the good people of Azeroth, are in your debt." WHERE `ID`=4771;

/* Eitrigg's Wisdom */
DELETE FROM `quest_details` WHERE `ID`=4941;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4941,6,5,1,1,0,0,0,0,0);

/* For The Horde! */
DELETE FROM `quest_details` WHERE `ID`=4974;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4974,1,1,25,0,0,0,0,0,0);

/* What the Wind Carries */
DELETE FROM `quest_details` WHERE `ID`=6566;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6566,1,0,0,0,0,0,0,0,0);

/* The Champion of the Horde */
DELETE FROM `quest_details` WHERE `ID`=6567;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6567,1,1,0,0,0,0,0,0,0);

/* Mistress of Deception */
DELETE FROM `quest_details` WHERE `ID`=6568;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6568,1,1,1,0,0,0,0,0,0);

/* Emberstrife */
DELETE FROM `quest_details` WHERE `ID`=6570;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6570,1,1,1,0,0,0,0,0,0);

/* The Test of Skulls, Scryer */
DELETE FROM `quest_details` WHERE `ID`=6582;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6582,1,5,0,0,0,0,0,0,0);

/* The Test of Skulls, Chronalis */
DELETE FROM `quest_details` WHERE `ID`=6584;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6584,1,1,0,0,0,0,0,0,0);

/* The Test of Skulls, Somnus */
DELETE FROM `quest_details` WHERE `ID`=6583;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6583,1,1,0,0,0,0,0,0,0);

/* The Test of Skulls, Axtroz */
DELETE FROM `quest_details` WHERE `ID`=6585;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6585,1,1,0,0,0,0,0,0,0);

/* Blood of the Black Dragon Champion */
DELETE FROM `quest_details` WHERE `ID`=6602;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6602,6,1,1,25,0,0,0,0,0);

/* Operative Bijou */
DELETE FROM `quest_details` WHERE `ID`=4981;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4981,1,1,25,1,0,0,0,0,0);

/* Bijou's Belongings */
DELETE FROM `quest_details` WHERE `ID`=4982;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4982,1,1,5,0,0,0,0,0,0);

/* Bijou's Reconnaissance Report */
DELETE FROM `quest_details` WHERE `ID`=4983;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4983,1,6,25,0,0,0,0,0,0);

/* Grark Lorkrub */
DELETE FROM `quest_details` WHERE `ID`=4122;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4122,1,1,1,0,0,0,0,0,0);

/* Precarious Predicament */
DELETE FROM `quest_details` WHERE `ID`=4121;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4121,6,6,5,0,0,0,0,0,0);

/* Commander Gor'shak */
DELETE FROM `quest_details` WHERE `ID`=3981;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3981,1,1,1,6,0,0,0,0,0);

/* What Is Going On? */
DELETE FROM `quest_details` WHERE `ID`=3982;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3982,6,1,11,5,0,0,0,0,0);

/* What Is Going On? */
DELETE FROM `quest_details` WHERE `ID`=4001;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4001,1,1,1,1,0,0,0,0,0);

/* The Eastern Kingdoms */
DELETE FROM `quest_details` WHERE `ID`=4002;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4002,1,1,1,0,0,0,0,0,0);

/* The Royal Rescue */
DELETE FROM `quest_details` WHERE `ID`=4003;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4003,1,1,5,0,0,0,0,0,0);

/* The Princess Saved? */
DELETE FROM `quest_details` WHERE `ID`=4004;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4004,5,25,1,5,0,0,0,0,0);

/* A Dwarf and His Tools */
DELETE FROM `quest_details` WHERE `ID`=719;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (719,3,1,1,6,0,0,0,0,0);

/* Fiery Blaze Enchantments */
DELETE FROM `quest_details` WHERE `ID`=706;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (706,1,1,6,1,0,0,0,0,0);

/* Mirages */
DELETE FROM `quest_details` WHERE `ID`=718;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (718,1,1,1,0,0,0,0,0,0);

/* Scrounging */
DELETE FROM `quest_details` WHERE `ID`=733;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (733,1,6,1,1,0,0,0,0,0);

/* Tremors of the Earth */
DELETE FROM `quest_details` WHERE `ID`=732;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (732,2,1,274,1,0,0,0,0,0);

/* Tremors of the Earth */
DELETE FROM `quest_details` WHERE `ID`=717;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (717,1,1,1,25,0,0,0,0,0);

/* A Sign of Hope */
DELETE FROM `quest_details` WHERE `ID`=721;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (721,6,1,1,5,0,0,0,0,0);

/* Amulet of Secrets */
DELETE FROM `quest_details` WHERE `ID`=722;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (722,33,1,1,0,0,0,0,0,0);

/* Prospect of Faith */
DELETE FROM `quest_details` WHERE `ID`=723;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (723,1,33,0,0,1500,0,0,0,0);

/* Prospect of Faith */
DELETE FROM `quest_details` WHERE `ID`=724;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (724,6,5,1,1,0,0,0,0,0);

/* Prospect of Faith */
UPDATE `quest_request_items` SET `CompletionText`="Ah, yes. Another traveler seeking something from the dwarves.$B$B$G Sir : Ma'am;, I'm truly sorry, but I've no time to answer meaningless questions right now." WHERE `ID`=724;

/* Passing Word of a Threat */
DELETE FROM `quest_details` WHERE `ID`=725;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (725,1,1,1,0,0,0,0,0,0);

/* Passing Word of a Threat */
DELETE FROM `quest_details` WHERE `ID`=726;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (726,5,25,1,0,1500,0,0,0,0);

/* An Ambassador of Evil */
DELETE FROM `quest_details` WHERE `ID`=762;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (762,1,1,1,1,0,0,0,0,0);

/* The Lost Tablets of Will */
DELETE FROM `quest_details` WHERE `ID`=1139;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1139,1,1,1,1,0,0,0,0,0);

/* Dwarven Justice */
DELETE FROM `quest_details` WHERE `ID`=3371;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3371,1,1,0,0,0,0,0,0,0);

/* At Last! */
DELETE FROM `quest_details` WHERE `ID`=3201;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3201,6,1,0,0,0,0,0,0,0);

/* En-Ay-Es-Tee-Why */
DELETE FROM `quest_details` WHERE `ID`=4862;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4862,25,1,0,0,0,0,0,0,0);

/* Kibler's Exotic Pets */
DELETE FROM `quest_details` WHERE `ID`=4729;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4729,6,1,0,0,0,0,0,0,0);

/* Libram of Tenacity */
UPDATE `quest_offer_reward` SET `Emote1`=1, `Emote2`=6, `Emote2`=25 WHERE `ID`=4482;

/* Mor'zul Bloodbringer */
DELETE FROM `quest_details` WHERE `ID`=7562;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7562,1,1,25,0,0,0,0,0,0);

/* Rage of Blood */
DELETE FROM `quest_details` WHERE `ID`=7563;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7563,1,1,1,0,0,0,0,0,0);

/* Wildeyes */
DELETE FROM `quest_details` WHERE `ID`=7564;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7564,1,0,0,0,0,0,0,0,0);

/* Lord Banehollow */
DELETE FROM `quest_details` WHERE `ID`=7623;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7623,1,0,0,0,0,0,0,0,0);

/* Ulathek the Traitor */
DELETE FROM `quest_details` WHERE `ID`=7624;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7624,1,1,0,0,0,0,0,0,0);

/* Xorothian Stardust */
DELETE FROM `quest_details` WHERE `ID`=7625;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7625,1,1,0,0,0,0,0,0,0);

/* Bell of Dethmoora */
DELETE FROM `quest_details` WHERE `ID`=7626;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7626,1,1,1,0,0,0,0,0,0);

/* Wheel of the Black March */
DELETE FROM `quest_details` WHERE `ID`=7627;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7627,1,1,0,0,0,0,0,0,0);

/* Doomsday Candle */
DELETE FROM `quest_details` WHERE `ID`=7628;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7628,1,1,1,0,0,0,0,0,0);

/* Arcanite */
DELETE FROM `quest_details` WHERE `ID`=7630;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7630,1,1,0,0,0,0,0,0,0);

/* Imp Delivery */
DELETE FROM `quest_details` WHERE `ID`=7629;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7629,1,1,0,0,0,0,0,0,0);

/* Dreadsteed of Xoroth */
DELETE FROM `quest_details` WHERE `ID`=7631;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7631,1,1,1,2,0,0,0,0,0);

/* Put Her Down */
DELETE FROM `quest_details` WHERE `ID`=4701;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4701,1,1,1,2,0,0,0,0,0);

/* Overmaster Pyron */
DELETE FROM `quest_details` WHERE `ID`=4262;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4262,1,1,5,0,0,0,0,0,0);

/* Incendius! */
DELETE FROM `quest_details` WHERE `ID`=4263;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4263,6,1,5,0,0,0,0,0,0);

/* Doomrigger's Clasp */
DELETE FROM `quest_details` WHERE `ID`=4764;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4764,1,0,0,0,0,0,0,0,0);

/* Delivery to Ridgewell */
DELETE FROM `quest_details` WHERE `ID`=4765;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4765,1,0,0,0,0,0,0,0,0);

/* Extinguish the Firegut */
DELETE FROM `quest_details` WHERE `ID`=3823;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3823,5,1,1,51,0,0,0,0,0);

/* Gor'tesh the Brute Lord */
DELETE FROM `quest_details` WHERE `ID`=3824;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3824,5,1,1,1,0,0,0,0,0);

/* Ogre Head On A Stick = Party */
DELETE FROM `quest_details` WHERE `ID`=3825;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3825,1,1,1,0,0,0,0,0,0);

/* Wrath of the Blue Flight */
DELETE FROM `quest_details` WHERE `ID`=5161;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5161,1,1,1,1,0,0,0,0,0);

/* Wrath of the Blue Flight */
DELETE FROM `quest_details` WHERE `ID`=5162;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5162,1,1,1,0,0,0,0,0,0);

/* Catalogue of the Wayward */
DELETE FROM `quest_details` WHERE `ID`=5164;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5164,1,1,0,0,0,0,0,0,0);

/* FIFTY! YEP! */
DELETE FROM `quest_details` WHERE `ID`=4283;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4283,1,5,5,51,0,0,0,0,0);

/* The Good Stuff */
DELETE FROM `quest_details` WHERE `ID`=4286;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4286,1,22,6,5,0,0,0,0,0);

/* Bijou's Belongings */
DELETE FROM `quest_details` WHERE `ID`=5001;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5001,1,1,0,0,0,0,0,0,0);

/* Message to Maxwell */
DELETE FROM `quest_details` WHERE `ID`=5002;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5002,1,5,0,0,0,0,0,0,0);

/* Maxwell's Mission */
DELETE FROM `quest_details` WHERE `ID`=5081;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5081,1,1,1,1,0,0,0,0,0);

/* General Drakkisath's Demise */
DELETE FROM `quest_details` WHERE `ID`=5102;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5102,1,1,1,5,0,0,0,0,0);

/* Nothing But The Truth */
DELETE FROM `quest_details` WHERE `ID`=1372;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1372,1,0,0,0,0,0,0,0,0);

/* Nothing But The Truth */
DELETE FROM `quest_details` WHERE `ID`=1383;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1383,1,0,0,0,0,0,0,0,0);

/* Nothing But The Truth */
DELETE FROM `quest_details` WHERE `ID`=1388;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1388,1,11,0,0,0,0,0,0,0);

/* Nothing But The Truth */
DELETE FROM `quest_details` WHERE `ID`=1391;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1391,1,0,0,0,0,0,0,0,0);

/* Draenethyst Crystals */
DELETE FROM `quest_details` WHERE `ID`=1389;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1389,1,0,0,0,0,0,0,0,0);

/* Pool of Tears */
DELETE FROM `quest_details` WHERE `ID`=1424;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1424,1,0,0,0,0,0,0,0,0);

/* The Atal'ai Exile */
DELETE FROM `quest_details` WHERE `ID`=1429;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1429,1,1,0,0,0,0,0,0,0);

/* Return to Fel'Zerul */
DELETE FROM `quest_details` WHERE `ID`=1444;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1444,1,1,1,0,0,0,0,0,0);

/* The Temple of Atal'Hakkar */
DELETE FROM `quest_details` WHERE `ID`=1445;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1445,6,1,1,0,0,0,0,0,0);

/* Lack of Surplus */
DELETE FROM `quest_details` WHERE `ID`=699;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (699,1,0,0,0,0,0,0,0,0);

/* Threat From the Sea */
DELETE FROM `quest_details` WHERE `ID`=1422;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1422,1,0,0,0,0,0,0,0,0);

/* Threat From the Sea */
DELETE FROM `quest_details` WHERE `ID`=1427;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1427,1,0,0,0,0,0,0,0,0);

/* Neeka Bloodscar */
DELETE FROM `quest_details` WHERE `ID`=1418;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1418,1,0,0,0,0,0,0,0,0);

/* The Sunken Temple */
DELETE FROM `quest_details` WHERE `ID`=3380;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3380,1,0,0,0,0,0,0,0,0);

/* The Sunken Temple */
DELETE FROM `quest_details` WHERE `ID`=3445;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3445,1,0,0,0,0,0,0,0,0);

/* The Missing Orders */
DELETE FROM `quest_details` WHERE `ID`=2622;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2622,6,5,0,0,0,0,0,0,0);

/* Little Morsels */
DELETE FROM `quest_details` WHERE `ID`=9440;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9440,1,0,0,0,0,0,0,0,0);

/* In Eranikus' Own Words */
DELETE FROM `quest_details` WHERE `ID`=3512;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3512,1,0,0,0,0,0,0,0,0);

/* Pool of Tears */
DELETE FROM `quest_details` WHERE `ID`=9610;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9610,1,1,1,0,0,1000,1000,0,0);

/* Mercy for the Cursed */
DELETE FROM `quest_details` WHERE `ID`=9448;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9448,5,1,1,0,0,1000,1000,0,0);

/* Help Watcher Biggs */
DELETE FROM `quest_details` WHERE `ID`=9609;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9609,1,0,0,0,0,0,0,0,0);

/* Encroaching Wildlife */
DELETE FROM `quest_details` WHERE `ID`=1396;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1396,1,0,0,0,0,0,0,0,0);

/* The Lost Caravan */
DELETE FROM `quest_details` WHERE `ID`=1421;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1421,1,0,0,0,0,0,0,0,0);

/* Driftwood */
DELETE FROM `quest_details` WHERE `ID`=1398;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1398,1,0,0,0,0,0,0,0,0);

/* Deliver the Shipment */
DELETE FROM `quest_details` WHERE `ID`=1425;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1425,1,0,0,0,0,0,0,0,0);

/* Return the Comb */
DELETE FROM `quest_details` WHERE `ID`=154;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (154,34,0,0,0,0,0,0,0,0);

/* Petty Squabbles */
DELETE FROM `quest_details` WHERE `ID`=2783;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2783,1,6,0,0,0,0,0,0,0);

/* Heroes of Old */
DELETE FROM `quest_details` WHERE `ID`=2702;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2702,2,0,0,0,0,0,0,0,0);

/* Kirith */
DELETE FROM `quest_details` WHERE `ID`=2721;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2721,1,0,0,0,0,0,0,0,0);

/* The Cover of Darkness */
DELETE FROM `quest_details` WHERE `ID`=2743;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2743,274,1,0,0,0,0,0,0,0);

/* The Demon Hunter */
DELETE FROM `quest_details` WHERE `ID`=2744;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2744,1,0,0,0,0,0,0,0,0);

/* Breaking the Ward */
DELETE FROM `quest_details` WHERE `ID`=3508;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3508,21,0,0,0,0,0,0,0,0);

/* The Name of the Beast */
DELETE FROM `quest_details` WHERE `ID`=3509;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3509,1,0,0,0,0,0,0,0,0);

/* The Name of the Beast */
UPDATE `quest_offer_reward` SET `RewardText`="Finally, one worthy of the wisdom of Arkkoroc!" WHERE `ID`=3510;

/* The Name of the Beast */
UPDATE `quest_request_items` SET `EmoteOnComplete`=6, `EmoteOnIncomplete`=6, `CompletionText`="You return! Astounding, $R. Did you discover the true name?" WHERE `ID`=3511;

/* Enchanted Azsharite Fel Weaponry */
DELETE FROM `quest_details` WHERE `ID`=3625;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3625,1,0,0,0,0,0,0,0,0);

/* Return to the Blasted Lands */
DELETE FROM `quest_details` WHERE `ID`=3626;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3626,1,0,0,0,0,0,0,0,0);

/* Ragnar Thunderbrew */
DELETE FROM `quest_details` WHERE `ID`=4128;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4128,3,1,0,0,0,0,0,0,0);

/* Hurley Blackbreath */
DELETE FROM `quest_details` WHERE `ID`=4126;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (4126,1,1,1,5,0,0,0,0,0);

/* Everything Counts In Large Amounts */
UPDATE `quest_offer_reward` SET `RewardText`="You truly disgust me, $r. A grown $g man : woman; drooling over a pile of junk? Pitiful! Take your reward and get out of my sight." WHERE `ID`=3501;

/* One Draenei's Junk... */
UPDATE `quest_offer_reward` SET `RewardText`="You truly disgust me, $r. A grown $g man : woman; drooling over a pile of junk? Pitiful! Take your reward and get out of my sight.$B$BSounds familiar? It should, because I say it a thousand times per day.$B$BOh how I loathe this world." WHERE `ID`=3502;

/* Through the Dark Portal */
DELETE FROM `quest_details` WHERE `ID`=9407;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (9407,1,1,1,25,0,0,0,0,0);

/* The Basilisk's Bite */
DELETE FROM `quest_details` WHERE `ID`=2601;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2601,1,1,0,0,0,0,0,0,0);

/* Vulture's Vigor */
DELETE FROM `quest_details` WHERE `ID`=2603;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2603,1,1,0,0,0,0,0,0,0);

/* The Decisive Striker */
DELETE FROM `quest_details` WHERE `ID`=2585;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2585,6,1,0,0,0,0,0,0,0);

/* The Decisive Striker */
UPDATE `quest_request_items` SET `EmoteOnComplete`=5, `EmoteOnIncomplete`=5, `CompletionText`="Where are the organs, $N!?" WHERE `ID`=2585;

/* A Boar's Vitality */
DELETE FROM `quest_details` WHERE `ID`=2583;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2583,1,1,0,0,0,0,0,0,0);

/* Snickerfang Jowls */
DELETE FROM `quest_details` WHERE `ID`=2581;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2581,1,1,0,0,0,0,0,0,0);

/* Rage of Ages */
DELETE FROM `quest_details` WHERE `ID`=2582;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2582,2,1,0,0,0,0,0,0,0);

/* Spirit of the Boar */
DELETE FROM `quest_details` WHERE `ID`=2584;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2584,1,1,0,0,0,0,0,0,0);

/* Salt of the Scorpok */
DELETE FROM `quest_details` WHERE `ID`=2586;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2586,5,1,0,0,0,0,0,0,0);

/* Infallible Mind */
DELETE FROM `quest_details` WHERE `ID`=2602;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2602,6,1,0,0,0,0,0,0,0);

/* Spiritual Domination */
DELETE FROM `quest_details` WHERE `ID`=2604;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2604,1,6,0,0,0,0,0,0,0);

/* The Prison's Bindings */
DELETE FROM `quest_details` WHERE `ID`=7581;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7581,1,1,0,0,0,0,0,0,0);

/* The Prison's Casing */
DELETE FROM `quest_details` WHERE `ID`=7582;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7582,1,1,1,0,0,0,0,0,0);

/* Suppression */
DELETE FROM `quest_details` WHERE `ID`=7583;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (7583,1,1,1,1,0,0,0,0,0);

/* The Path of the Righteous */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1, `EmoteOnComplete`=1, `CompletionText`="There is much history rooted in their distrust of the mortal races; but alas, such is a tale better left for the Brood to tell when the time is right." WHERE `ID`=8301;

/* The Path of the Righteous */
UPDATE `quest_offer_reward` SET `Emote1`=1, `RewardText`="You are not alone, hero. I will now grant you the ability to deputize others to help you in your quest. If you are to be the champion of your people, you will need assistance in your tasks and duties." WHERE `ID`=8301;

/* Kris of Unspoken Names */
UPDATE `quest_offer_reward` SET `Emote1`=1, `Emote2`=2 WHERE `ID`=8710;

/* A Humble Offering */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6, `EmoteOnComplete`=6, `CompletionText`="Fandu-dath-belore? Oh, pardon me, $N. I did not recognize you. Have you the scepter?" WHERE `ID`=9248;

/* Field Duty Papers */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6, `EmoteOnComplete`=6 WHERE `ID` IN (8508, 8732);

/* Field Duty Papers */
UPDATE `quest_offer_reward` SET `Emote1`=1, `Emote2`=25 WHERE `ID` IN (8508, 8732);

/* Uniform Supplies */
UPDATE `quest_request_items` SET `CompletionText`="You have something for me, $n?", `EmoteOnComplete`=0 WHERE `ID` IN (8782,8808,8496,8810,8783,8809,8829);

/* Desert Survival Kits */
UPDATE `quest_request_items` SET `CompletionText`="You have something for me, $n?", `EmoteOnComplete`=0 WHERE `ID` IN (8497,8804);

/* Boots for the Guard */
UPDATE `quest_request_items` SET `CompletionText`="You have something for me, $n?", `EmoteOnComplete`=0 WHERE `ID` IN (8540,8805,8541,8806,8786,8781,8780,8787);

/* The Hunt Begins */
DELETE FROM `quest_details` WHERE `ID`=747;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (747,3,0,0,0,0,0,0,0,0);

/* The Hunt Begins */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1, `EmoteOnComplete`=1 WHERE `ID`=747;

/* The Hunt Begins */
UPDATE `quest_offer_reward` SET `Emote1`=2 WHERE `ID`=747;

/* The Hunt Continues */
DELETE FROM `quest_details` WHERE `ID`=750;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (750,1,1,0,0,0,0,0,0,0);

/* The Hunt Continues */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1, `EmoteOnComplete`=1 WHERE `ID`=750;

/* The Hunt Continues */
UPDATE `quest_offer_reward` SET `Emote1`=2 WHERE `ID`=750;

/* The Battleboars */
DELETE FROM `quest_details` WHERE `ID`=780;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (780,5,0,0,0,0,0,0,0,0);

/* The Battleboars */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=0, `EmoteOnComplete`=0 WHERE `ID`=780;

/* The Battleboars */
UPDATE `quest_offer_reward` SET `Emote1`=4 WHERE `ID`=780;

/* Simple Note */
DELETE FROM `quest_details` WHERE `ID` IN (3091,3092,3093,3094);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3091,1,0,0,0,0,0,0,0,0);

/* Etched Note */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3092,1,0,0,0,0,0,0,0,0);

/* Rune-Inscribed Note */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3093,1,0,0,0,0,0,0,0,0);

/* Verdant Note */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3094,1,0,0,0,0,0,0,0,0);

/* Simple Note */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=2, `EmoteOnComplete`=2 WHERE `ID` IN (3091,3092,3093,3094);

/* Simple Note */
UPDATE `quest_offer_reward` SET `Emote1`=1, `Emote2`=1 WHERE `ID` IN (3091,3092,3093,3094);

/* A Humble Task */
DELETE FROM `quest_details` WHERE `ID`=752;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (752,1,6,0,0,0,0,0,0,0);

/* A Humble Task */
UPDATE `quest_offer_reward` SET `Emote1`=24 WHERE `ID`=752;

/* A Humble Task */
DELETE FROM `quest_details` WHERE `ID`=753;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (753,1,1,0,0,0,0,0,0,0);

/* A Humble Task */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6, `EmoteOnComplete`=6 WHERE `ID`=753;

/* A Humble Task */
UPDATE `quest_offer_reward` SET `Emote1`=6, `Emote2`=1 WHERE `ID`=753;

/* Rites of the Earthmother */
DELETE FROM `quest_details` WHERE `ID`=755;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (755,1,1,0,0,0,0,0,0,0);

/* Rites of the Earthmother */
UPDATE `quest_offer_reward` SET `Emote1`=6 WHERE `ID`=755;

/* Rite of Strength */
DELETE FROM `quest_details` WHERE `ID`=757;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (757,1,1,0,0,0,0,0,0,0);

/* Rite of Strength */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6, `EmoteOnComplete`=6 WHERE `ID`=757;

/* Rite of Strength */
UPDATE `quest_offer_reward` SET `Emote1`=21 WHERE `ID`=757;

/* Break Sharptusk! */
DELETE FROM `quest_details` WHERE `ID`=3376;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (3376,1,0,0,0,0,0,0,0,0);

/* Break Sharptusk! */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1, `EmoteOnComplete`=1 WHERE `ID`=3376;

/* Attack on Camp Narache */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6, `EmoteOnComplete`=6 WHERE `ID` IN (781,24857);

/* Rites of the Earthmother */
DELETE FROM `quest_details` WHERE `ID`=763;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (763,25,0,0,0,0,0,0,0,0);

/* Rites of the Earthmother */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6, `EmoteOnComplete`=6 WHERE `ID`=763;

/* Rites of the Earthmother */
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=763;

/* A Task Unfinished */
DELETE FROM `quest_details` WHERE `ID`=1656;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1656,1,1,1,0,0,0,0,0,0);

/* A Task Unfinished */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6, `EmoteOnComplete`=6 WHERE `ID`=1656;

/* A Task Unfinished */
UPDATE `quest_offer_reward` SET `Emote1`=1, `Emote2`=1, `Emote3`=1 WHERE `ID`=1656;

/* Poison Water */
DELETE FROM `quest_details` WHERE `ID`=748;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (748,5,1,0,0,0,0,0,0,0);

/* Poison Water */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6, `EmoteOnComplete`=6 WHERE `ID`=748;

/* Poison Water */
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=748;

/* Mazzranache */
DELETE FROM `quest_details` WHERE `ID`=766;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (766,1,1,0,0,0,0,0,0,0);

/* Mazzranache */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1, `EmoteOnComplete`=1 WHERE `ID`=766;

/* Mazzranache */
UPDATE `quest_offer_reward` SET `Emote1`=2, `Emote2`=1 WHERE `ID`=766;

/* Rite of Vision */
DELETE FROM `quest_details` WHERE `ID`=767;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (767,1,0,0,0,0,0,0,0,0);

/* Rite of Vision */
DELETE FROM `quest_details` WHERE `ID`=771;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (771,1,1,0,0,0,0,0,0,0);

/* Rite of Vision */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1, `EmoteOnComplete`=1 WHERE `ID`=771;

/* Rite of Vision */
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=771;

/* Rite of Vision */
DELETE FROM `quest_details` WHERE `ID`=772;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (772,1,0,0,0,0,0,0,0,0);

/* Rite of Vision */
UPDATE `quest_offer_reward` SET `Emote1`=2 WHERE `ID`=772;

/* Dwarven Digging */
DELETE FROM `quest_details` WHERE `ID`=746;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (746,1,0,0,0,0,0,0,0,0);

/* Dwarven Digging */
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=746;

/* Winterhoof Cleansing */
DELETE FROM `quest_details` WHERE `ID`=754;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (754,1,1,0,0,0,0,0,0,0);

/* Winterhoof Cleansing */
UPDATE `quest_offer_reward` SET `Emote1`=2 WHERE `ID`=754;

/* Thunderhorn Totem */
DELETE FROM `quest_details` WHERE `ID`=756;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (756,1,1,0,0,0,0,0,0,0);

/* Thunderhorn Totem */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=0, `EmoteOnComplete`=0 WHERE `ID`=756;

/* Thunderhorn Totem */
UPDATE `quest_offer_reward` SET `Emote1`=2 WHERE `ID`=756;

/* Thunderhorn Cleansing */
DELETE FROM `quest_details` WHERE `ID`=758;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (758,1,1,0,0,0,0,0,0,0);

/* Thunderhorn Cleansing */
UPDATE `quest_offer_reward` SET `Emote1`=2 WHERE `ID`=758;

/* Wildmane Totem */
DELETE FROM `quest_details` WHERE `ID`=759;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (759,1,1,0,0,0,0,0,0,0);

/* Wildmane Totem */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=0, `EmoteOnComplete`=0 WHERE `ID`=759;

/* Wildmane Totem */
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=759;

/* Wildmane Cleansing */
DELETE FROM `quest_details` WHERE `ID`=760;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (760,1,1,0,0,0,0,0,0,0);

/* Wildmane Cleansing */
UPDATE `quest_offer_reward` SET `Emote1`=2 WHERE `ID`=760;

/* Sharing the Land */
DELETE FROM `quest_details` WHERE `ID`=745;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (745,1,0,0,0,0,0,0,0,0);

/* Sharing the Land */
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=745;

/* Supervisor Fizsprocket */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=0, `EmoteOnComplete`=0 WHERE `ID` = 765;

/* The Hunter's Way */
DELETE FROM `quest_details` WHERE `ID`=861;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (861,1,0,0,0,0,0,0,0,0);

/* The Hunter's Way */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=3, `EmoteOnComplete`=3 WHERE `ID`=861;

/* The Hunter's Way */
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=861;

/* Journey into Thunder Bluff */
DELETE FROM `quest_details` WHERE `ID`=775;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (775,1,0,0,0,0,0,0,0,0);

/* Journey into Thunder Bluff */
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=775;

/* Rites of the Earthmother */
DELETE FROM `quest_details` WHERE `ID`=776;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (776,1,0,0,0,0,0,0,0,0);

/* Rites of the Earthmother */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6, `EmoteOnComplete`=6 WHERE `ID`=776;

/* Rites of the Earthmother */
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=776;

/* The Demon Scarred Cloak */
UPDATE `quest_offer_reward` SET `Emote1`=5, `Emote2`=2 WHERE `ID`=770;

/* Taming the Beast */
DELETE FROM `quest_details` WHERE `ID` IN (6061,6087,6088,6089);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6061,1,0,0,0,0,0,0,0,0);

/* Taming the Beast */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6087,1,0,0,0,0,0,0,0,0);

/* Taming the Beast */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6088,1,0,0,0,0,0,0,0,0);

/* Training the Beast */
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (6089,1,0,0,0,0,0,0,0,0);

/* Taming the Beast */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1 WHERE `ID` IN (6061,6088);

/* Taming the Beast */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6, `EmoteOnComplete`=6 WHERE `ID`=6087;

/* Taming the Beast */
UPDATE `quest_offer_reward` SET `Emote1`=21 WHERE `ID`=6061;

/* Taming the Beast */
UPDATE `quest_offer_reward` SET `Emote1`=273 WHERE `ID`=6087;

/* Taming the Beast */
UPDATE `quest_offer_reward` SET `Emote1`=2 WHERE `ID`=6088;

/* A Vengeful Fate */
DELETE FROM `quest_details` WHERE `ID`=1102;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1102,1,5,0,0,0,0,0,0,0);

/* A Vengeful Fate */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6, `EmoteOnComplete`=6 WHERE `ID`=1102;

/* A Vengeful Fate */
UPDATE `quest_offer_reward` SET `Emote1`=1, `Emote2`=1 WHERE `ID`=1102;

/* Compendium of the Fallen */
DELETE FROM `quest_details` WHERE `ID`=1049;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (1049,1,6,0,0,0,0,0,0,0);

/* Compendium of the Fallen */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1, `EmoteOnComplete`=1 WHERE `ID`=1049;

/* Compendium of the Fallen */
UPDATE `quest_offer_reward` SET `Emote1`=5, `Emote2`=2 WHERE `ID`=1049;

/* The Platinum Discs */
DELETE FROM `quest_details` WHERE `ID`=2440;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2440,1,1,0,0,0,0,0,0,0);

/* The Platinum Discs */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=3, `EmoteOnComplete`=3 WHERE `ID`=2440;

/* The Platinum Discs */
UPDATE `quest_offer_reward` SET `Emote1`=6, `Emote2`=1 WHERE `ID`=2440;

/* Portents of Uldum */
DELETE FROM `quest_details` WHERE `ID`=2965;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2965,1,1,0,0,0,0,0,0,0);

/* Portents of Uldum */
UPDATE `quest_offer_reward` SET `Emote1`=1, `Emote2`=1 WHERE `ID`=2965;

/* Seeing What Happens */
DELETE FROM `quest_details` WHERE `ID`=2966;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2966,1,1,1,0,0,0,0,0,0);

/* Return to Thunder Bluff */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6, `EmoteOnComplete`=6 WHERE `ID`=2967;

/* Return to Thunder Bluff */
UPDATE `quest_offer_reward` SET `Emote1`=6, `Emote2`=1, `Emote3`=1 WHERE `ID`=2967;

/* A Future Task */
DELETE FROM `quest_details` WHERE `ID`=2968;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (2968,1,1,0,0,0,0,0,0,0);

/* A Future Task */
UPDATE `quest_offer_reward` SET `Emote1`=1, `Emote2`=1, `Emote3`=1 WHERE `ID`=2968;

/* Serpentbloom */
DELETE FROM `quest_details` WHERE `ID`=962;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (962,1,0,0,0,0,0,0,0,0);

/* Serpentbloom */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1, `EmoteOnComplete`=1 WHERE `ID`=962;

/* Serpentbloom */
UPDATE `quest_offer_reward` SET `Emote1`=4 WHERE `ID`=962;

/* Searching for the Lost Satchel */
DELETE FROM `quest_details` WHERE `ID`=5722;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5722,1,0,0,0,0,0,0,0,0);

/* Returning the Lost Satchel */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6, `EmoteOnComplete`=6 WHERE `ID`=5724;

/* Returning the Lost Satchel */
UPDATE `quest_offer_reward` SET `Emote1`=1 WHERE `ID`=5724;

/* Testing an Enemy's Strength */
DELETE FROM `quest_details` WHERE `ID`=5723;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES (5723,1,1,0,0,0,0,0,0,0);

/* Testing an Enemy's Strength */
UPDATE `quest_offer_reward` SET `Emote1`=2, `Emote2`=1 WHERE `ID`=5723;

/* Wanted: Thaelis the Hungerer */
UPDATE `quest_offer_reward` SET `Emote1`=4 WHERE `ID`=8468;

/* The Ring of Mmmrrrggglll */
UPDATE `quest_offer_reward` SET `Emote1`=15, `Emote2`=66 WHERE `ID`=8885;

/* Quest "Anthion's Parting Words" */
DELETE FROM `quest_details` WHERE `ID` IN (8951,8952,8953,8954,8955,8956,8957,8958,8959,9016,9017,9018,9019,9020,9021,9022,10496,10497);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES
(8951,1,1,1,2,0,0,0,0,0),
(8952,1,1,1,2,0,0,0,0,0),
(8953,1,1,1,2,0,0,0,0,0),
(8954,1,1,1,2,0,0,0,0,0),
(8955,1,1,1,2,0,0,0,0,0),
(8956,1,1,1,2,0,0,0,0,0),
(8957,1,1,1,2,0,0,0,0,0),
(8958,1,1,1,2,0,0,0,0,0),
(8959,1,1,1,2,0,0,0,0,0),
(9016,1,1,1,2,0,0,0,0,0),
(9017,1,1,1,2,0,0,0,0,0),
(9018,1,1,1,2,0,0,0,0,0),
(9019,1,1,1,2,0,0,0,0,0),
(9020,1,1,1,2,0,0,0,0,0),
(9021,1,1,1,2,0,0,0,0,0),
(9022,1,1,1,2,0,0,0,0,0),
(10496,1,1,1,2,0,0,0,0,0),
(10497,1,1,1,2,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1, `EmoteOnComplete`=1 WHERE `ID` IN (8951,8952,8953,8954,8955,8956,8957,8958,8959,9016,9017,9018,9019,9020,9021,9022);
UPDATE `quest_offer_reward` SET `Emote1`=5, `Emote2`=1 WHERE `ID` IN (8951,8952,8953,8954,8955,8956,8958,8959);
UPDATE `quest_offer_reward` SET `Emote1`=6, `Emote2`=1 WHERE `ID` IN (9016,9017,9018,9019,9020,9021,9022);
UPDATE `quest_offer_reward` SET `Emote1`=6, `Emote2`=1, `RewardText`="This curse was bestowed upon us but for a mere medallion. Lord Valthalak certainly knows how to hold a grudge.$B$BWe'll endeavor to find the remaining pieces - hopefully before I meet an untimely demise. But before that, let us see about your reward." WHERE `ID`=8957;
DELETE FROM `quest_request_items` WHERE `ID` IN (10496,10497);
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`, `VerifiedBuild`) VALUES
(10496,1,1,"You're back, $N. You must tell me all about what you've found out. But first let us arrange for your reward.",0),
(10497,1,1,"You've returned and I see in your eyes that you've much to tell me, $N. Let us take care of your reward first.",0);
DELETE FROM `quest_offer_reward` WHERE `ID` IN (10496,10497);
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(10496,5,1,0,0,0,0,0,0,"I can't believe our lives are all but forfeit all because of a stupid medallion! And you're sure Anthion mentioned Bodley?$B$BWell, you've done your job so let's get your reward out of the way.",0),
(10497,6,1,0,0,0,0,0,0,"This curse was bestowed upon us but for a mere medallion. Lord Valthalak certainly knows how to hold a grudge.$B$BWe'll endeavor to find the remaining pieces - hopefully before I meet an untimely demise. But before that, let us see about your reward.",0);


/* Quest "Redemption" */
DELETE FROM `quest_details` WHERE `ID`=5742;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES
(5742,1,0,0,0,0,0,0,0,0);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `ID`=5742;
UPDATE `quest_template_addon` SET `NextQuestID`=5742 WHERE `ExclusiveGroup`=-5542;

/* Quest "Mazen's Behest (Part 2)" */
DELETE FROM `quest_template_addon` WHERE `ID`=1364;
INSERT INTO `quest_template_addon` (`ID`, `MaxLevel`, `AllowableClasses`, `SourceSpellID`, `PrevQuestID`, `NextQuestID`, `ExclusiveGroup`, `RewardMailTemplateID`, `RewardMailDelay`, `RequiredSkillID`, `RequiredSkillPoints`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepValue`, `ProvidedItemCount`, `SpecialFlags`) VALUES
(1364,0,0,0,1363,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `quest_details` WHERE `ID`=1364;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES
(1364,1,1,5,6,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6, `EmoteOnComplete`=6 WHERE `ID`=1364;

/* Fix "Wild Leather Armor" quest chain */
UPDATE `quest_template_addon` SET `ExclusiveGroup`=-2851 WHERE `ID` IN (2851,2852);
UPDATE `quest_template_addon` SET `NextQuestID`=2851 WHERE `ID` IN (2848,2849);
UPDATE `quest_template_addon` SET `NextQuestID`=2852 WHERE `ID`=2850;

UPDATE `creature_template` SET `ScriptName`="" WHERE `entry`=6806; -- Tannok Frosthammer is not an innkeeper

/* Quest "Tome of Divinity" */
UPDATE `quest_offer_reward` SET `Emote1`=2, `Emote2`=1, `Emote3`=1 WHERE `ID`=1645;

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=19 AND `SourceEntry`=1645;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19,0,1645,0,0,14,0,2997,0,0,0,0,0,"","Quest 'Tome of Divinity (1645)' can only be taken if quest 'Tome of Divinity (2997)' is not taken"),
(19,0,1645,0,0,14,0,3000,0,0,0,0,0,"","Quest 'Tome of Divinity (1645)' can only be taken if quest 'Tome of Divinity (3000)' is not taken"),
(19,0,1645,0,0,14,0,2999,0,0,0,0,0,"","Quest 'Tome of Divinity (1645)' can only be taken if quest 'Tome of Divinity (2999)' is not taken");

/* Quest "Garments of the Light" */
DELETE FROM `quest_details` WHERE `ID`=5625;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES
(5625,1,1,0,0,0,0,0,0,0);
UPDATE `quest_offer_reward` SET `Emote1`=2, `Emote2`=1, `Emote3`=1, `RewardText`="Well done, $n. You got the Light inside you, that's for sure.$B$BHere, take this robe. It'll denote your role in the church and help people recognize you as a $c--wear it if you want.$B$BLater, there will be more tests that you'll have to go through. Do what you can to learn about your abilities and what you're capable of. Try your hand at a fight or two alone, and then again with other travelers.$B$BBut don't fret none... you're as powerful as they come." WHERE `ID`=5625;

/* Quest "Saving the Best for Last" */
DELETE FROM `quest_details` WHERE `ID` IN (8999,9000,9001,9002,9003,9004,9005,9006,9007,9008,9009,9010,9011,9012,9013,9014,10498,10499);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES
(8999,1,1,0,0,0,0,0,0,0),
(9000,1,1,0,0,0,0,0,0,0),
(9001,1,1,0,0,0,0,0,0,0),
(9002,1,1,0,0,0,0,0,0,0),
(9003,1,1,0,0,0,0,0,0,0),
(9004,1,1,0,0,0,0,0,0,0),
(9005,1,1,0,0,0,0,0,0,0),
(9006,1,1,0,0,0,0,0,0,0),
(9007,1,1,0,0,0,0,0,0,0),
(9008,1,1,0,0,0,0,0,0,0),
(9009,1,1,0,0,0,0,0,0,0),
(9010,1,1,0,0,0,0,0,0,0),
(9011,1,1,0,0,0,0,0,0,0),
(9012,1,1,0,0,0,0,0,0,0),
(9013,1,1,0,0,0,0,0,0,0),
(9014,1,1,0,0,0,0,0,0,0),
(10498,1,1,0,0,0,0,0,0,0),
(10499,1,1,0,0,0,0,0,0,0);
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=6, `EmoteOnComplete`=6 WHERE `ID` IN (8999,9000,9001,9002,9003,9004,9005,9006,9007,9008,9009,9010,9011,9012,9013,9014);
UPDATE `quest_offer_reward` SET `Emote1`=1, `Emote2`=2 WHERE `ID` IN (8999,9000,9001,9002,9003,9004,9005,9006,9007,9008,9009,9010,9011,9012,9013,9014);
DELETE FROM `quest_request_items` WHERE `ID` IN (10498,10499);
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`, `VerifiedBuild`) VALUES
(10498,6,6,"As per our deal, are you ready to hand over your Wildheart pieces in exchange for your new Feralheart Cowl and Vest?",0),
(10499,6,6,"As per our deal, are you ready to hand over your Magister's pieces in exchange for your new Sorcerer's Crown and Robes?",0);
DELETE FROM `quest_offer_reward` WHERE `ID` IN (10498,10499);
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(10498,1,2,0,0,0,0,0,0,"I'm going to miss you, $N. I owe you such a debt of gratitude; I think I'll never be able to repay it.$B$BI hope that you enjoy your new head and chest armor, and that it protects you for a long time to come.",0),
(10499,1,2,0,0,0,0,0,0,"I will truly miss you, $N. There is a debt that I owe you, which I may never be able to repay.$B$BEnjoy your new head and chest armor. May it protect you for a long time to come, and help you to achieve even greater honor!",0);

/* Quest "Scrying Materials" */
UPDATE `quest_request_items` SET `CompletionText`="You have something for me, $n?", `EmoteOnComplete`=0 WHERE `ID` IN (8779,8807);
UPDATE `quest_offer_reward` SET `Emote1`=2 WHERE `ID` = 8779;
DELETE FROM `quest_offer_reward` WHERE `ID`=8807;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(8807,2,0,0,0,0,0,0,0,"Why, yes... these will be of tremendous aid!  These materials are awfully hard to come by in the desert, $n.  Thank you.",0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_22_02' WHERE sql_rev = '1645326770688077000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
