-- DB update 2023_03_04_13 -> 2023_03_04_14
-- In Shadow Labyrinth and Sethekk Halls, bosses should drop 2 Spirit Shards per kill
UPDATE `creature_loot_template` SET `MinCount`=2, `MaxCount`=2 WHERE `Item`=28558 AND `Entry` IN (20636, 20637, 20653, 20657, 20690, 20706, 23035, 18732, 18473, 18667, 18708);
-- Yor
UPDATE `creature_loot_template` SET `MinCount`=1, `MaxCount`=1 WHERE `Item`=28558 AND `Entry`=22930;
