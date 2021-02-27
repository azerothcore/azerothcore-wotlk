INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1614328114555323168');

-- Stop Young Moonkin from having Moonfire

DELETE FROM `smart_scripts` WHERE `entryOrGuid`=10159 AND `source_type`=0;
UPDATE `creature_template` SET `AIName`='' WHERE  `entry`=10159;
