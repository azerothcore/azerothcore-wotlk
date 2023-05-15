--
-- fix Malchezaar event door not being interactable with players
UPDATE `gameobject_template_addon` SET `flags` = `flags`|16 WHERE `entry` = 185134;
