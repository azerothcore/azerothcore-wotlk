-- DB update 2022_11_12_09 -> 2022_11_12_10
-- Remove bleed immunity from Twilight Elementalist
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`&~18432 WHERE `entry` = 4814;
