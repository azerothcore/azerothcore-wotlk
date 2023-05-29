-- DB update 2022_05_03_00 -> 2022_05_03_01
--
UPDATE `gameobject_template_addon` SET `flags` = `flags` |16 WHERE `entry` = 179116;
