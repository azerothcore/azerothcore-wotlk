INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633603500355887481');

-- Deletes Tactical Task Briefing IX from Rex Ashil
DELETE FROM `creature_loot_template` WHERE `Entry` = 14475 AND `Item` = 20944;

