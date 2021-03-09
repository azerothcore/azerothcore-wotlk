INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1615313723387834900');

UPDATE `creature_addon` SET `auras`='' WHERE `guid` IN (
/* Anub'Rekhan */ 127814,
/* Gluth */ 127782,
/* Venom Stalkers */ 127868, 127869, 127870, 127871);

