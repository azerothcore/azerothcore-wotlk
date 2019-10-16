INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1570139487119757170');

DELETE FROM `spell_area` WHERE `area` = 4812 AND `quest_start` = 0 AND `aura_spell` = 0 AND (`racemask` = 690 OR `racemask` = 1101) AND `gender` = 2;
