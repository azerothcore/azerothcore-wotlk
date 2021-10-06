INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633501534792643595');

-- Change the spawn time of Incendosaur from 500 seconds (9 minutes) to 60 seconds (1 minute)
UPDATE `creature` SET `spawntimesecs` = 60 WHERE (`id` = 9318) AND (`guid` IN (5874 , 5876, 5878, 5879, 5883, 5899 ,5901, 5902, 5904, 5905, 5906, 5907, 5911));

