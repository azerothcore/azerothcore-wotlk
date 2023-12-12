--
UPDATE `creature_template` set `mechanic_immune_mask`=`mechanic_immune_mask`&~(64|1024) WHERE `entry` = 22056;
