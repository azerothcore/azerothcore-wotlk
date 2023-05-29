-- DB update 2022_11_01_01 -> 2022_11_01_02

UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`&~(128) WHERE (entry = 6109);
