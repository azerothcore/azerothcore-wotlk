INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631942187339544702');

-- Deletes Icecap from all NPC loot tables except Spellmaw's
DELETE FROM `creature_loot_template` WHERE `item` = 13467 AND `comment` LIKE '%Icecap%' AND `Entry` <> 10662;

