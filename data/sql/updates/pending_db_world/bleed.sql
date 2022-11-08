-- Remove bleed immunity from Twilight Elementalist
UPDATE `creature_template` SET `mechanic_immune_mask`=645998431 WHERE `entry` = 4814;
