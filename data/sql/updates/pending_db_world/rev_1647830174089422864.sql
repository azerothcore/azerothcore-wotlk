INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647830174089422864');

-- Trial of the Crusider - NPC_DARK_ESSENCE
UPDATE `creature_template` SET `npcflag` = 1 WHERE `entry` = 34567;
-- Trial of the Crusider - NPC_LIGHT_ESSENCE
UPDATE `creature_template` SET `npcflag` = 1 WHERE `entry` = 34568;
