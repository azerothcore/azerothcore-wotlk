INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624754774083089600');

DELETE FROM `spell_proc_event` WHERE `entry` = 71761;
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(71761, 0, 3, 0, 1048576, 0, 0, 3, 0, 0, 0);
