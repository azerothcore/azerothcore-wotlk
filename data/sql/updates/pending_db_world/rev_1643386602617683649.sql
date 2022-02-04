INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643386602617683649');
-- Fixes Paladins Lawbringer's 8 set bonus
DELETE FROM `spell_proc_event` WHERE `entry`=21747;
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(21747, 0, 10, 0, 0, 0, 20, 0, 20, 0, 50000);
