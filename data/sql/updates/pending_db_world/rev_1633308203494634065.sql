INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633308203494634065');

-- Remove Civilian flag from summoned Emerald Dragon Whelp
UPDATE `creature_template` SET `flags_extra`=`flags_extra`&~(2) WHERE `entry` = 8776;

