-- DB update 2022_06_18_09 -> 2022_06_18_10
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`&~(16384) WHERE `entry` IN  (12265, 12101, 12100, 12076, 11665, 11667, 11669, 11666, 11668, 12099);
