-- DB update 2022_03_02_00 -> 2022_03_02_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_02_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_02_00 2022_03_02_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1645312955890170800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1645312955890170800');

/* Alliance Relations */
DELETE FROM `quest_details` WHERE `ID`=1431;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1431,1,1,0,0,0,0,0,0,0);

/* Alliance Relations */
DELETE FROM `quest_details` WHERE `ID`=1432;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1432,1,1,0,0,0,0,0,0,0);

/* Alliance Relations */
DELETE FROM `quest_details` WHERE `ID`=1433;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1433,1,0,0,0,0,0,0,0,0);

/* The Burning of Spirits */
DELETE FROM `quest_details` WHERE `ID`=1435;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1435,1,0,0,0,0,0,0,0,0);

/* Alliance Relations */
DELETE FROM `quest_details` WHERE `ID`=1436;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1436,1,1,0,0,0,0,0,0,0);

/* Catch of the Day */
DELETE FROM `quest_details` WHERE `ID`=5386;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (5386,1,0,0,0,0,0,0,0,0);

/* Befouled by Satyr */
DELETE FROM `quest_details` WHERE `ID`=1434;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1434,1,0,0,0,0,0,0,0,0);

/* Centaur Bounty */
DELETE FROM `quest_details` WHERE `ID`=1366;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1366,1,0,0,0,0,0,0,0,0);

/* The Corrupter */
DELETE FROM `quest_details` WHERE `ID`=1481;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1481,1,1,0,0,0,0,0,0,0);

/* The Corrupter */
DELETE FROM `quest_details` WHERE `ID`=1482;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1482,1,1,0,0,0,0,0,0,0);

/* The Corrupter */
DELETE FROM `quest_details` WHERE `ID`=1484;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1484,1,0,0,0,0,0,0,0,0);

/* The Corrupter */
DELETE FROM `quest_details` WHERE `ID`=1488;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1488,1,0,0,0,0,0,0,0,0);

/* Hunting in Stranglethorn */
DELETE FROM `quest_details` WHERE `ID`=5763;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (5763,1,0,0,0,0,0,0,0,0);

/* Hand of Iruxos */
DELETE FROM `quest_details` WHERE `ID`=5381;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (5381,1,0,0,0,0,0,0,0,0);

/* Portals of the Legion */
DELETE FROM `quest_details` WHERE `ID`=5581;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (5581,1,0,0,0,0,0,0,0,0);

/* Other Fish to Fry */
DELETE FROM `quest_details` WHERE `ID`=6143;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (6143,1,0,0,0,0,0,0,0,0);

/* Clam Bait */
DELETE FROM `quest_details` WHERE `ID`=6142;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (6142,1,0,0,0,0,0,0,0,0);

/* Sceptre of Light */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1 WHERE `ID`=5741;

/* Book of the Ancients */
DELETE FROM `quest_details` WHERE `ID`=6027;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (6027,1,0,0,0,0,0,0,0,0);

/* Book of the Ancients */
UPDATE `quest_request_items` SET `EmoteOnIncomplete`=1, `CompletionText`="Ah, $N! It's good to see you again. Do you have the Book of the Ancients?" WHERE `ID`=6027;

/* Twisted Evils */
UPDATE `quest_details` SET `Emote1`=1, `Emote2`=1 WHERE `ID`=7028;

/* Get Me Out of Here! */
DELETE FROM `quest_details` WHERE `ID`=6132;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (6132,5,0,0,0,0,0,0,0,0);

/* Vyletongue Corruption */
DELETE FROM `quest_details` WHERE `ID`=7029;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (7029,1,0,0,0,0,0,0,0,0);

/* The Sacred Flame */
DELETE FROM `quest_details` WHERE `ID`=1195;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1195,1,0,0,0,0,0,0,0,0);

/* The Sacred Flame */
DELETE FROM `quest_details` WHERE `ID`=1196;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1196,1,0,0,0,0,0,0,0,0);

/* The Sacred Flame */
DELETE FROM `quest_details` WHERE `ID`=1197;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1197,1,0,0,0,0,0,0,0,0);

/* Message to Freewind Post */
DELETE FROM `quest_details` WHERE `ID`=4542;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (4542,1,0,0,0,0,0,0,0,0);

/* Pacify the Centaur */
DELETE FROM `quest_details` WHERE `ID`=4841;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (4841,1,0,0,0,0,0,0,0,0);

/* Grimtotem Spying */
DELETE FROM `quest_details` WHERE `ID`=5064;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (5064,1,0,0,0,0,0,0,0,0);

/* Alien Egg */
DELETE FROM `quest_details` WHERE `ID`=4821;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (4821,2,1,0,0,0,0,0,0,0);

/* Serpent Wild */
DELETE FROM `quest_details` WHERE `ID`=4865;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (4865,1,5,0,0,0,0,0,0,0);

/* Sacred Fire */
DELETE FROM `quest_details` WHERE `ID`=5062;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (5062,1,1,0,0,0,0,0,0,0);

/* Arikara */
DELETE FROM `quest_details` WHERE `ID`=5088;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (5088,1,0,0,0,0,0,0,0,0);

/* Wind Rider */
DELETE FROM `quest_details` WHERE `ID`=4767;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (4767,1,1,0,0,0,0,0,0,0);

/* A Different Approach */
DELETE FROM `quest_details` WHERE `ID`=9431;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (9431,6,1,1,0,0,0,0,0,0);

/* A Dip in the Moonwell */
DELETE FROM `quest_details` WHERE `ID`=9433;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (9433,5,1,0,0,0,0,0,0,0);

/* Test of Faith */
DELETE FROM `quest_details` WHERE `ID`=1149;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1149,2,1,0,0,0,0,0,0,0);

/* Test of Endurance */
DELETE FROM `quest_details` WHERE `ID`=1150;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1150,1,0,0,0,0,0,0,0,0);

/* Test of Strength */
DELETE FROM `quest_details` WHERE `ID`=1151;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1151,1,0,0,0,0,0,0,0,0);

/* Test of Lore */
UPDATE `quest_details` SET `Emote1`=1 WHERE `ID`=1152;

/* Test of Lore */
DELETE FROM `quest_details` WHERE `ID`=1154;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1154,1,0,0,0,0,0,0,0,0);

/* Test of Lore */
DELETE FROM `quest_details` WHERE `ID`=6627;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (6627,1,0,0,0,0,0,0,0,0);

/* Test of Lore */
DELETE FROM `quest_details` WHERE `ID`=1159;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1159,1,0,0,0,0,0,0,0,0);

/* Test of Lore */
DELETE FROM `quest_details` WHERE `ID`=1160;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1160,1,0,0,0,0,0,0,0,0);

/* Test of Lore */
DELETE FROM `quest_details` WHERE `ID`=6628;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (6628,1,0,0,0,0,0,0,0,0);

/* Final Passage */
DELETE FROM `quest_details` WHERE `ID`=1394;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1394,1,0,0,0,0,0,0,0,0);

/* Homeward Bound */
UPDATE `quest_details` SET `Emote1`=20 WHERE `ID`=4770;

/* Free at Last */
DELETE FROM `quest_details` WHERE `ID`=4904;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (4904,1,0,0,0,0,0,0,0,0);

/* Protect Kanati Greycloud */
DELETE FROM `quest_details` WHERE `ID`=4966;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (4966,1,0,0,0,0,0,0,0,0);

/* Family Tree */
DELETE FROM `quest_details` WHERE `ID`=5361;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (5361,1,0,0,0,0,0,0,0,0);

/* A Bump in the Road */
DELETE FROM `quest_details` WHERE `ID`=1175;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1175,1,1,0,0,0,0,0,0,0);

/* Hardened Shells */
UPDATE `quest_offer_reward` SET `Emote1`=2, `Emote2`=5, `Emote3`=11, `RewardText`="You got them! Thanks, $N!$B$BWow, these shells are harder than I thought! When I work with them I'll probably need a whole box full of tools!" WHERE `ID`=1105;

/* Salt Flat Venom */
DELETE FROM `quest_details` WHERE `ID`=1104;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1104,5,1,0,0,0,0,0,0,0);

/* Wharfmaster Dizzywig */
DELETE FROM `quest_details` WHERE `ID`=1111;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1111,1,0,0,0,0,0,0,0,0);

/* Rocket Car Parts */
DELETE FROM `quest_details` WHERE `ID`=1110;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1110,1,0,0,0,0,0,0,0,0);

/* Hemet Nesingwary Jr. */
DELETE FROM `quest_details` WHERE `ID`=5762;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (5762,1,0,0,0,0,0,0,0,0);

/* Encrusted Tail Fins */
UPDATE `quest_details` SET `Emote1`=5, `Emote2`=1 WHERE `ID`=1107;

/* Martek the Exiled */
UPDATE `quest_details` SET `Emote1`=1 WHERE `ID`=1106;

/* Indurium */
DELETE FROM `quest_details` WHERE `ID`=1108;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1108,1,1,0,0,0,0,0,0,0);

/* News for Fizzle */
DELETE FROM `quest_details` WHERE `ID`=1137;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1137,5,1,0,0,0,0,0,0,0);

/* Parts of the Swarm */
DELETE FROM `quest_details` WHERE `ID`=1184;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1184,1,0,0,0,0,0,0,0,0);

/* The Brassbolts Brothers */
DELETE FROM `quest_details` WHERE `ID`=2769;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (2769,6,1,1,0,0,0,0,0,0);

/* Gahz'rilla */
DELETE FROM `quest_details` WHERE `ID`=2770;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (2770,1,1,5,0,0,0,0,0,0);

/* The Rumormonger */
DELETE FROM `quest_details` WHERE `ID`=1115;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1115,1,0,0,0,0,0,0,0,0);

/* Back to Booty Bay */
DELETE FROM `quest_details` WHERE `ID`=1118;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1118,1,0,0,0,0,0,0,0,0);

/* Report Back to Fizzlebub */
DELETE FROM `quest_details` WHERE `ID`=1122;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (1122,11,1,0,0,0,0,0,0,0);

/* Raptor Mastery */
DELETE FROM `quest_details` WHERE `ID`=194;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (194,6,0,0,0,0,0,0,0,0);

/* Raptor Mastery */
DELETE FROM `quest_details` WHERE `ID`=195;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (195,1,0,0,0,0,0,0,0,0);

/* Raptor Mastery */
DELETE FROM `quest_details` WHERE `ID`=196;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (196,1,0,0,0,0,0,0,0,0);

/* Raptor Mastery */
DELETE FROM `quest_details` WHERE `ID`=197;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (197,1,0,0,0,0,0,0,0,0);

/* Tiger Mastery */
DELETE FROM `quest_details` WHERE `ID`=186;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (186,1,0,0,0,0,0,0,0,0);

/* Tiger Mastery */
DELETE FROM `quest_details` WHERE `ID`=187;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (187,1,0,0,0,0,0,0,0,0);

/* Tiger Mastery */
DELETE FROM `quest_details` WHERE `ID`=188;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (188,1,0,0,0,0,0,0,0,0);

/* Panther Mastery */
DELETE FROM `quest_details` WHERE `ID`=191;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (191,1,0,0,0,0,0,0,0,0);

/* Panther Mastery */
DELETE FROM `quest_details` WHERE `ID`=192;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (192,1,0,0,0,0,0,0,0,0);

/* Panther Mastery */
DELETE FROM `quest_details` WHERE `ID`=193;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (193,1,0,0,0,0,0,0,0,0);

/* Big Game Hunter */
DELETE FROM `quest_details` WHERE `ID`=208;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (208,1,0,0,0,0,0,0,0,0);

/* Mok'thardin's Enchantment */
DELETE FROM `quest_details` WHERE `ID`=570;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (570,1,0,0,0,0,0,0,0,0);

/* Mok'thardin's Enchantment */
DELETE FROM `quest_details` WHERE `ID`=572;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (572,1,0,0,0,0,0,0,0,0);

/* Mok'thardin's Enchantment */
DELETE FROM `quest_details` WHERE `ID`=571;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (571,1,1,0,0,0,0,0,0,0);

/* Mok'thardin's Enchantment */
DELETE FROM `quest_details` WHERE `ID`=573;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (573,1,1,0,0,0,0,0,0,0);

/* The Defense of Grom'gol */
DELETE FROM `quest_details` WHERE `ID`=568;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (568,66,1,0,0,0,0,0,0,0);

/* The Defense of Grom'gol */
DELETE FROM `quest_details` WHERE `ID`=569;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (569,1,1,0,0,0,0,0,0,0);

/* Grim Message */
DELETE FROM `quest_details` WHERE `ID`=2932;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (2932,1,5,0,0,0,0,0,0,0);

/* The Vile Reef */
UPDATE `quest_offer_reward` SET `Emote1`=1, `Emote1`=2 WHERE `ID`=629;

/* The Bloodsail Buccaneers */
DELETE FROM `quest_details` WHERE `ID`=595;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (595,1,0,0,0,0,0,0,0,0);

/* The Bloodsail Buccaneers */
DELETE FROM `quest_details` WHERE `ID`=599;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (599,5,0,0,0,0,0,0,0,0);

/* The Bloodsail Buccaneers */
DELETE FROM `quest_details` WHERE `ID`=604;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (604,1,0,0,0,0,0,0,0,0);

/* The Bloodsail Buccaneers */
DELETE FROM `quest_details` WHERE `ID`=608;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (608,5,1,0,0,0,0,0,0,0);

/* Whiskey Slim's Lost Grog */
UPDATE `quest_details` SET `Emote1`=1 WHERE `ID`=580;

/* Stoley's Debt */
DELETE FROM `quest_details` WHERE `ID`=2872;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (2872,1,0,0,0,0,0,0,0,0);

/* Stoley's Shipment */
DELETE FROM `quest_details` WHERE `ID`=2873;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (2873,1,0,0,0,0,0,0,0,0);

/* Deliver to MacKinley */
DELETE FROM `quest_details` WHERE `ID`=2874;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (2874,1,0,0,0,0,0,0,0,0);

/* Keep An Eye Out */
DELETE FROM `quest_details` WHERE `ID`=576;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (576,6,0,0,0,0,0,0,0,0);

/* Message in a Bottle */
DELETE FROM `quest_details` WHERE `ID`=630;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (630,1,0,0,0,0,0,0,0,0);

/* The Captain's Chest */
DELETE FROM `quest_details` WHERE `ID`=614;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (614,1,5,0,0,0,2000,0,0,0);

/* The Captain's Cutlass */
DELETE FROM `quest_details` WHERE `ID`=8553;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (8553,1,1,0,0,0,0,0,0,0);

/* Facing Negolash */
DELETE FROM `quest_details` WHERE `ID`=8554;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (8554,1,1,0,0,0,0,0,0,0);

/* Cracking Maury's Foot */
DELETE FROM `quest_details` WHERE `ID`=613;
INSERT INTO `quest_details` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`VerifiedBuild`) VALUES (613,5,1,0,0,0,0,0,0,0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_02_01' WHERE sql_rev = '1645312955890170800';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
