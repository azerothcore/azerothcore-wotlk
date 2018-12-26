INSERT INTO version_db_world (`sql_rev`) VALUES ('1520902066724046200');
DELETE FROM `playercreateinfo_spell` WHERE `Spell`=33388 AND `racemask`=0 AND `classmask`=32;
INSERT INTO `playercreateinfo_spell` (`racemask`, `classmask`, `Spell`, `Note`) VALUES (0, 32, 33388, 'Apprentice Riding');
