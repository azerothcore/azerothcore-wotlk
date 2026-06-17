-- Mimiron chest entries (194789/194956/194957/194958) have chest.consumable (data3) = 0,
-- which causes the chest to restock loot indefinitely after being opened.
-- Set data3 = 1 so the chest is consumed (deleted) once fully looted.
UPDATE `gameobject_template` SET `data3` = 1 WHERE `entry` IN (194789, 194956, 194957, 194958);
