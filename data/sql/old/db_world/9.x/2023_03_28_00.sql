-- DB update 2023_03_27_03 -> 2023_03_28_00
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 512 WHERE `entry` IN (37955, 38434, 38435, 38436);
