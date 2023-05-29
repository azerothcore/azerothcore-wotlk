-- DB update 2022_06_13_01 -> 2022_06_13_02

UPDATE `creature_template` SET `ScriptName`='npc_chained_spirit', `speed_run`=0.4, `unit_flags`=`unit_flags`|33554432 WHERE `entry`=15117;

