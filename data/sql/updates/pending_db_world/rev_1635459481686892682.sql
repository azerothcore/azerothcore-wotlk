INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635459481686892682');

-- Removed bad SAI from Snapjaw, Saltwater Snapjaw, Surf Glider, Ironback, Steeljaw Snapper, Cranky Benj
UPDATE `creature_template` SET `AIName`='' WHERE `entry` IN (2408,2505,5431,8213,14123,14223);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (2408,2505,5431,8213,14123,14223) AND `source_type`=0;
