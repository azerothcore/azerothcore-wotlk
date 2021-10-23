-- DB update 2021_06_20_01 -> 2021_06_20_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_20_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_20_01 2021_06_20_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1623852796811454700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623852796811454700');

/* Fix NPC's gossips for locales Europe Spanish and Latin America Spanish in all cities including Shattarth and Dalaran */
DELETE FROM `broadcast_text_locale` WHERE `ID` IN (80000, 80001, 80002, 80003, 80004, 80005, 80006, 80007) AND `locale` IN ('esES','esMX');
DELETE FROM `broadcast_text` WHERE `ID` IN (80000, 80001, 80002, 80003, 80004, 80005, 80006, 80007);

/* In order for the Core to read Locales, we must add entries here */
INSERT INTO `broadcast_text` (`ID`,`Language`,`MaleText`,`FemaleText`,`EmoteID0`,`EmoteID1`,`EmoteID2`,`EmoteDelay0`,
`EmoteDelay1`,`EmoteDelay2`,`SoundId`,`Unk1`,`Unk2`,`VerifiedBuild`) 
VALUES (80000, 0, 'The guild master', 'The guild master', 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019),
(80001, 0, 'The mailbox', 'The mailbox', 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019),
(80002, 0, 'The auction house', 'The auction house', 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019),
(80003, 0, 'The zeppelin master', 'The zeppelin master', 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019),
(80004, 0, 'The weapon master', 'The weapon master', 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019),
(80005, 0, "The officer's lounge", "The officer's lounge", 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019),
(80006, 0, 'The battlemaster', 'The battlemaster', 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019),
(80007, 0, "The Champions' Hall", "The Champions' Hall", 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019);

INSERT INTO `broadcast_text_locale` (`ID`,`locale`,`MaleText`,`FemaleText`,`VerifiedBuild`) 
VALUES (80000, 'esMX', 'El maestro de hermandad', 'El maestro de hermandad', 18019),
(80001, 'esMX', 'El buzón', 'El buzón', 18019),
(80002, 'esMX', 'La casa de subastas', 'La casa de subastas', 18019),
(80003, 'esMX', 'El maestro de zepelines', 'El maestro de zepelines', 18019),
(80004, 'esMX', 'El instructor de armas', 'El instructor de armas', 18019),
(80005, 'esMX', 'La sala de las leyendas', 'La sala de las leyendas', 18019),
(80006, 'esMX', 'El maestro de batalla', 'El maestro de batalla', 18019),
(80007, 'esMX', 'Sala de los campeones', 'Sala de los campeones', 18019),
(80000, 'esES', 'El maestro de hermandad', 'El maestro de hermandad', 18019),
(80001, 'esES', 'El buzón', 'El buzón', 18019),
(80002, 'esES', 'La casa de subastas', 'La casa de subastas', 18019),
(80003, 'esES', 'El maestro de zepelines', 'El maestro de zepelines', 18019),
(80004, 'esES', 'El instructor de armas', 'El instructor de armas', 18019),
(80005, 'esES', 'La sala de las leyendas', 'La sala de las leyendas', 18019),
(80006, 'esES', 'El maestro de batalla', 'El maestro de batalla', 18019),
(80007, 'esES', 'Sala de los campeones', 'Sala de los campeones', 18019);

UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80000 WHERE `MenuID` = 1951 AND `OptionID` = 2;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80000 WHERE `MenuID` = 7633 AND `OptionID` = 3;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80000 WHERE `MenuID` = 10769 AND `OptionID` = 5;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80000 WHERE `MenuID` = 721 AND `OptionID` = 2;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80000 WHERE `MenuID` = 2352 AND `OptionID` = 3;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80000 WHERE `MenuID` = 2121 AND `OptionID` = 4;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80000 WHERE `MenuID` = 435 AND `OptionID` = 6;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80000 WHERE `MenuID` = 7777 AND `OptionID` = 3;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80000 WHERE `MenuID` = 10043 AND `OptionID` = 7;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80001 WHERE `MenuID` = 1951 AND `OptionID` = 4;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80001 WHERE `MenuID` = 7633 AND `OptionID` = 5;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80001 WHERE `MenuID` = 10769 AND `OptionID` = 8;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80001 WHERE `MenuID` = 721 AND `OptionID` = 4;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80001 WHERE `MenuID` = 2352 AND `OptionID` = 5;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80001 WHERE `MenuID` = 2121 AND `OptionID` = 6;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80001 WHERE `MenuID` = 7777 AND `OptionID` = 5;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80001 WHERE `MenuID` = 10043 AND `OptionID` = 10;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80001 WHERE `MenuID` = 8282 AND `OptionID` = 4;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80002 WHERE `MenuID` = 1951 AND `OptionID` = 5;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80002 WHERE `MenuID` = 7633 AND `OptionID` = 0;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80002 WHERE `MenuID` = 10769 AND `OptionID` = 0;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80002 WHERE `MenuID` = 721 AND `OptionID` = 5;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80002 WHERE `MenuID` = 2352 AND `OptionID` = 0;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80002 WHERE `MenuID` = 2121 AND `OptionID` = 0;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80002 WHERE `MenuID` = 435 AND `OptionID` = 0;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80002 WHERE `MenuID` = 7777 AND `OptionID` = 0;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80002 WHERE `MenuID` = 10043 AND `OptionID` = 1;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80003 WHERE `MenuID` = 1951 AND `OptionID` = 6;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80003 WHERE `MenuID` = 10769 AND `OptionID` = 11;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80003 WHERE `MenuID` = 721 AND `OptionID` = 12;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80004 WHERE `MenuID` = 1951 AND `OptionID` = 7;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80004 WHERE `MenuID` = 7633 AND `OptionID` = 7;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80004 WHERE `MenuID` = 10769 AND `OptionID` = 10;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80004 WHERE `MenuID` = 721 AND `OptionID` = 6;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80004 WHERE `MenuID` = 7777 AND `OptionID` = 7;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80005 WHERE `MenuID` = 1951 AND `OptionID` = 9;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80006 WHERE `MenuID` = 1951 AND `OptionID` = 10;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80006 WHERE `MenuID` = 10769 AND `OptionID` = 4;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80006 WHERE `MenuID` = 721 AND `OptionID` = 8;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80006 WHERE `MenuID` = 2352 AND `OptionID` = 8;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80006 WHERE `MenuID` = 2121 AND `OptionID` = 9;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80006 WHERE `MenuID` = 435 AND `OptionID` = 11;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80006 WHERE `MenuID` = 8282 AND `OptionID` = 6;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID` = 80007 WHERE `MenuID` = 435 AND `OptionID` = 10;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_20_02' WHERE sql_rev = '1623852796811454700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
