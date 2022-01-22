-- DB update 2018_06_11_00 -> 2018_06_12_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2018_06_11_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2018_06_11_00 2018_06_12_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1528731505867561398'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1528731505867561398');

DELETE FROM `creature_text` WHERE `entry` = 28948;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`BroadcastTextID`,`TextRange`,`comment`)
VALUES
(28948,0,0,'Ahh... there you are. The master told us you''d be arriving soon.',12,0,100,1,0,0,29127,0,'Malmortis text'),
(28948,1,0,'Please, follow me, $N. There is much for you to see...',12,0,100,1,0,0,29128,0,'Malmortis text'),
(28948,2,0,'You should feel honored. You are the first of the master''s prospects to be shown our operation.',12,0,100,1,0,0,29171,0,'Malmortis text'),
(28948,2,1,'Ever since his arrival from Drak''Tharon, the master has spoken of the time you would be joining him here.',12,0,100,1,0,0,29172,0,'Malmortis text'),
(28948,3,0,'The things I show you now must never be spoken of outside Voltarus. The world shall come to know our secret soon enough!',12,0,100,1,0,0,29173,0,'Malmortis text'),
(28948,4,0,'Here lie our stores of blight crystal, without which our project would be impossible.',12,0,100,1,0,0,29174,0,'Malmortis text'),
(28948,5,0,'I understand that you are to thank for the bulk of our supply.',12,0,100,1,0,0,29175,0,'Malmortis text'),
(28948,6,0,'These trolls are among those you exposed on the battlefield. Masterfully done, indeed....',12,0,100,1,0,0,29176,0,'Malmortis text'),
(28948,7,0,'We feel it best to position them here, where they might come in terms with their impending fate.',12,0,100,1,0,0,29433,0,'Malmortis text'),
(28948,8,0,'This is their destiny....',12,0,100,1,0,0,29434,0,'Malmortis text'),
(28948,9,0,'The blight slowly seeps into their bodies, gradually preparing them for their conversion.',12,0,100,1,0,0,29435,0,'Malmortis text'),
(28948,10,0,'This special preparation grants them unique powers far greater than they would otherwise know.',12,0,100,1,0,0,29436,0,'Malmortis text'),
(28948,11,0,'Soon, the master will grant them the dark gift, making them fit to server the Lich King for eternity!',12,0,100,1,0,0,29437,0,'Malmortis text'),
(28948,12,0,'Stay for as long as you like, $N. Glory in the fruits of your labor!',12,0,100,1,0,0,29438,0,'Malmortis text'),
(28948,13,0,'Your service has been invaluable in fulfilling the master''s plan. May you forever grow in power....',12,0,100,1,0,0,29439,0,'Malmortis text'),
(28948,14,0,'Farewell.',12,0,100,1,0,0,29440,0,'Malmortis text');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
