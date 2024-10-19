-- Looting the 3 keys is annoying as a group, since the stones appear ready to loot but
-- only allow looting after a while after the previous pickup
-- Objects: Burning Key, Cresting Key & Thundering Key from Stones of Binding

UPDATE `gameobject_template` SET `Data2` = 0 WHERE `entry` IN (2689,2690,2691);
