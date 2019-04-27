INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1555929516205604900');

-- Coilskar defender updated flag to Only Swim and remove extra flag
UPDATE `creature_template` SET `unit_flags`=32768, `flags_extra`=0 WHERE `entry`=19762;
