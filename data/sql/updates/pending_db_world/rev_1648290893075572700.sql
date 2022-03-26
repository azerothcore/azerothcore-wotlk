INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648290893075572700');

UPDATE `creature_template` SET `npcflag`=16777216 WHERE `entry`=34072;
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`=34072;
INSERT INTO `npc_spellclick_spells` VALUES
(34072,51347,3,0);
