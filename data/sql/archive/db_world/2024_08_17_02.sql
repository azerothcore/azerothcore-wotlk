-- DB update 2024_08_17_01 -> 2024_08_17_02
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`&~2048 WHERE `entry` = 22952;
