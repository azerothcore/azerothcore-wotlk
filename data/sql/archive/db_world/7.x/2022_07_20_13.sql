-- DB update 2022_07_20_12 -> 2022_07_20_13
-- fix Slim Pickings quest
UPDATE `creature_template` SET `npcflag`=`npcflag`|1 WHERE `entry` = 26809;
