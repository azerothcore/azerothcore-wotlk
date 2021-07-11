INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626005635187112400');

-- set npc Deputy Feldon hostile against horde player
UPDATE `creature_template` SET `flags_extra` = 32768 WHERE (`entry` = 1070);
