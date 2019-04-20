INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1555723394137575000');

-- Update razorgore movement
UPDATE `world`.`creature_template` SET `MovementType`='0' WHERE  `entry`=12435;


-- 45537