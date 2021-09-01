INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630484852047598500');

SET @THORIUM_ORE := 10620; 
UPDATE `prospecting_loot_template` SET `GroupId`=1 WHERE `entry` = @THORIUM_ORE;
UPDATE `prospecting_loot_template` SET `Reference`=-13001 WHERE `entry` = @THORIUM_ORE AND `item`=1;
