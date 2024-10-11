-- DB update 2021_05_23_01 -> 2021_05_23_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_23_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_23_01 2021_05_23_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1621228822203725800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621228822203725800');

UPDATE `quest_template_locale` SET `Title` = '血腥的美食' , `Details` = '血齿狂鱼可以用来烹制一道佳肴，对治愈感染伤口有奇效。如果你有兴趣的话，我们能让它们能派上一些用场。\r\n\r\n就如同它们的名字所暗示的，血齿狂鱼会被鲜血的味道所吸引。据我所知，想要钓起这些小恶鱼就只有一种办法：弄出一片带血的池塘来。\r\n\r\n先把你自己弄得满身是血——只需要在北风苔原杀掉几头动物——然后跳进水里就行。如此一来，溶入了鲜血的池塘就成了绝佳的渔点。' , `Objectives` = '达拉然城中的玛西娅·切斯希望你为她带去5条血齿狂鱼。' WHERE `ID` = 13833 AND `locale` = 'zhCN';

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
