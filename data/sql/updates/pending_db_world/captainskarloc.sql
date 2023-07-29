--
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`&~(4194304|33554432) WHERE `entry` IN (17862, 20521);
