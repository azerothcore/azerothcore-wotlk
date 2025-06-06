-- DB update 2023_11_20_05 -> 2023_11_20_06
--
UPDATE `gameobject_template_addon` SET `flags` = `flags`|16 WHERE `entry` IN (184203, 184204, 184205);
