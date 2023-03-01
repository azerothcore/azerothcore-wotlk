-- Delete hack fix
UPDATE `gameobject_template` SET `Data1` = 0 WHERE (`entry` = 182583);

DELETE FROM `gameobject_loot_template` WHERE `Entry` = 19414;
