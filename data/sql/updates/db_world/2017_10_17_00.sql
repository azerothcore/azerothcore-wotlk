-- DB update 2017_10_15_02 -> 2017_10_17_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_10_15_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_10_15_02 2017_10_17_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1508171605836767200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1508171605836767200');

-- Lord Thorval
SET @ENTRY := 28472;
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`, `BroadcastTextId`) VALUES
(@ENTRY, 0, 0, 'As disciples of blood, you strive to master the very lifeforce of your enemies.',                                       12, 0, 100, 1, 0, 0, 'Lord Thorval', 29867),
(@ENTRY, 1, 0, 'Be it by blade or incantation, blood feeds our attacks and weakens our foes.',                                          12, 0, 100, 1, 0, 0, 'Lord Thorval', 29868),
(@ENTRY, 2, 0, 'True masters learn to make blood serve more than just their strength in battle.',                                       12, 0, 100, 1, 0, 0, 'Lord Thorval', 29869),
(@ENTRY, 3, 0, 'Stripping energy from our foes, both fighting and fallen, allows us to persevere where lesser beigns falls exhausted.', 12, 0, 100, 1, 0, 0, 'Lord Thorval', 29870),
(@ENTRY, 4, 0, 'And every foe that falls, energy sapped and stolen, only further fuels our assault.',                                   12, 0, 100, 1, 0, 0, 'Lord Thorval', 29871),
(@ENTRY, 5, 0, 'As masters of blood, we know battle without end...',                                                                    12, 0, 100, 1, 0, 0, 'Lord Thorval', 29872),
(@ENTRY, 6, 0, 'We know hunger never to be quenched...',                                                                                12, 0, 100, 1, 0, 0, 'Lord Thorval', 29873),
(@ENTRY, 7, 0, 'We know power never to be overcome...',                                                                                 12, 0, 100, 1, 0, 0, 'Lord Thorval', 29874),
(@ENTRY, 8, 0, 'As masters of blood, we are masters of life and death itself. Agains us, even hope falls drained and lifeless.',        12, 0, 100, 1, 0, 0, 'Lord Thorval', 29875);
--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
