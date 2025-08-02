-- Fix invalid banner name
UPDATE `gameobject_template` SET `name` = 'Alliance Banner' WHERE (`entry` = 192269 AND `name` = 'Horde Banner');
