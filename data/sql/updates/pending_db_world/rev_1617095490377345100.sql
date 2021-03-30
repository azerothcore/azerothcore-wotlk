INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617095490377345100');

UPDATE `creature_template` SET `unit_flags`=`unit_flags` & ~32768 WHERE `entry` IN (2338,2339,2192);
