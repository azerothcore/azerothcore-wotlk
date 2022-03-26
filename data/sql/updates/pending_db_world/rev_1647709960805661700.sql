INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647709960805661700');

UPDATE `creature_template` SET `flags_extra`=`flags_extra`|128 WHERE `entry` IN (34146,34150,34151);

SET @CGUID := 2000059;
DELETE FROM `creature` WHERE `guid`=@CGUID AND `id1`=34150;
INSERT INTO `creature` VALUES
(@CGUID,34150,0,0,603,0,0,3,1,0,1873.25,-288.23,412.30,3.90,180,0,0,12600,0,0,0,0,0,'',12340);
