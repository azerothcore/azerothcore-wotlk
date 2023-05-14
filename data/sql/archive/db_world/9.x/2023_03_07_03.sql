-- DB update 2023_03_07_02 -> 2023_03_07_03
-- Lord Azrethoc - path with equiped melee weapon.
UPDATE `creature_addon` SET `bytes2` = 1 WHERE `guid` = 29062 AND `path_id` = 290620;
