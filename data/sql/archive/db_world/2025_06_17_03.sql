-- DB update 2025_06_17_02 -> 2025_06_17_03
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` | 646135679 WHERE `entry` IN (24722,25552);
