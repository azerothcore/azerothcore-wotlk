-- fix `Chasing the Moonstone` quest
UPDATE `creature_template` SET `npcflag`=`npcflag` | 1 WHERE `entry` = 23002
