-- DB update 2023_11_15_00 -> 2023_11_15_01
--
UPDATE `gameobject_template_addon` SET `flags` = `flags`|16 WHERE `entry` IN (184274, 184280);
