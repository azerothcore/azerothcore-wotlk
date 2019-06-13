INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1560252813861928400');

-- Increases the health pool of Malygos's platform to 1500000 from 100
UPDATE `gameobject_template` SET `Data0`='1500000' WHERE  `entry`=193070; -- Malygos Platform no longer collapses upon taking siege damage.
