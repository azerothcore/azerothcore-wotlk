INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1615506284007051682');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=3204;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(3204,8329,0,"Sapper Explode");

