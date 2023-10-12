-- DB update 2023_06_07_00 -> 2023_06_07_01
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|256|4194304 WHERE `entry` IN (17839, 20744, 21140, 22172, 21104, 21148, 22170, 22171);
