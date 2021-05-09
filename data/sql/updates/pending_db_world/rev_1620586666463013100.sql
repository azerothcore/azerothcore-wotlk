INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620586666463013100');

-- Imp - Felhunter - Voidwalker - Succubus --
UPDATE `creature_template` SET `InhabitType` = 3 WHERE `entry` IN (416, 417, 1860, 1863);
