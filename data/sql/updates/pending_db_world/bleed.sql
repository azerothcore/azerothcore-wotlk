-- Remove bleed immunity from Twilight Elementalist
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`&~18432 WHERE `entry` = 4814;
