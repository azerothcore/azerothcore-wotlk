-- DB update 2023_04_02_06 -> 2023_04_02_07
--
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`|46284631 WHERE (`entry` IN (20866, 21614, 20898, 21598));
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`|652689279 WHERE (`entry` IN (20870, 21626, 20912, 21601));
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`|37882897 WHERE (`entry` IN (20875, 21604));
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`|3089, `flags_extra`=`flags_extra`|256 WHERE (`entry` IN (20883, 21615));
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`|16405, `flags_extra`=`flags_extra`|256 WHERE (`entry` IN (20869, 21586));
