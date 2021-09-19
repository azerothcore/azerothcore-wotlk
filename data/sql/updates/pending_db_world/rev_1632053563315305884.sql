INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632053563315305884');

-- Deletes Elixir of Demonslaying drop from 7 mobs, that shouldn't drop the item
DELETE FROM `creature_loot_template` WHERE `Item` = 9224 AND `Entry` IN (2647, 5988, 8598, 8912, 9240, 10469, 11738);
