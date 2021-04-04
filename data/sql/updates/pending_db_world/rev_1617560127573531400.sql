INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617560127573531400');

-- Pirate's Footlocker
UPDATE `item_loot_template` SET `Chance`=10 WHERE `Entry`=9276 AND `Item`=9249; -- was 21.6%

-- Southsea Swashbuckler
UPDATE `creature_loot_template` SET `Chance`=0.02 WHERE `Entry`=7858 AND `Item`=9249; -- was 100%

