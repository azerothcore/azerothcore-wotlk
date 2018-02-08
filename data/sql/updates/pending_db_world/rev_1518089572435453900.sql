INSERT INTO version_db_world (`sql_rev`) VALUES ('1518089572435453900');

-- The eggs should not be clickable
UPDATE `gameobject_template` SET `faction`='14' WHERE  `entry`=177807;

-- Grethok the controller should shout "Intruders have breached the hatchery.." when engaged,
UPDATE `smart_scripts` SET `event_type`='4' WHERE  `entryorguid`=12557 AND `source_type`=0 AND `id`=4 AND `link`=0;
