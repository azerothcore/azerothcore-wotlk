-- DB update 2022_06_26_05 -> 2022_06_27_00
-- fix Woodlands Walker gossip
UPDATE `creature_template` SET `npcflag`=`npcflag` |1 WHERE `entry` = 26421;
