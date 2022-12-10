-- DB update 2022_10_11_03 -> 2022_10_11_04
--
UPDATE `creature_template_addon` SET `bytes2` = 1 WHERE `entry` IN (15275, 15276);
