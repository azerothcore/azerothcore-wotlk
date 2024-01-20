-- DB update 2023_09_24_02 -> 2023_09_25_00
--
-- fix Malchezaar event door not being interactable with players
UPDATE `gameobject_template_addon` SET `flags` = `flags`|16 WHERE `entry` = 185134;
