-- DB update 2021_10_16_04 -> 2021_10_16_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_16_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_16_04 2021_10_16_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633773844859273100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633773844859273100');

UPDATE `creature_template` SET `faction`=1998, `InhabitType`=3 WHERE `entry`=23543;
UPDATE `creature_template_addon` SET `Mount`=0 WHERE `entry`=23543;

DELETE FROM `creature_text` WHERE `CreatureID`=23543;
INSERT INTO `creature_text` VALUES
(23543,0,0,'Harken, cur! Tis you I spurn! Now feel... the burn!',12,0,100,0,0,0,22587,0,'Shade of Horseman Talk 0'),
(23543,1,0,'Prepare yourselves, the bells have tolled! Shelter your weak, your young and your old! Each of you shall pay the final sum! Cry for mercy; the reckoning has come!',14,0,100,0,0,11966,22022,0,'Shade of Horseman Talk 1'),
(23543,2,0,'The sky is dark. The fire burns. You strive in vain as Fate\'s wheel turns.',14,0,100,0,0,12570,22034,0,'Shade of Horseman Talk 2'),
(23543,3,0,'The town still burns. A cleansing fire! Time is short, I\'ll soon retire!',14,0,100,0,0,12571,22035,0,'Shade of Horseman Talk 3'),
(23543,4,0,'Fire consumes! You\'ve tried and failed. Let there be no doubt, justice prevailed!',14,0,100,0,0,11967,22026,0,'Shade of Horseman Talk 4'),
(23543,5,0,'My flames have died, left not a spark! I shall send you now to the lifeless dark!',14,0,100,0,0,11968,22027,0,'Shade of Horseman Talk 5'),
(23543,6,0,'So eager you are, for my blood to spill. Yet to vanquish me, \'tis my head you must kill!',14,0,100,0,0,11969,22757,0,'Shade of Horseman Talk 6');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_16_05' WHERE sql_rev = '1633773844859273100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
