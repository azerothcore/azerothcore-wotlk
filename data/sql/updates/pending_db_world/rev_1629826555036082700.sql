INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629826555036082700');

SET @THORIUM_ORE := 10620; 
UPDATE `prospecting_loot_template` SET `GroupId`=1 WHERE `entry` = @THORIUM_ORE;
