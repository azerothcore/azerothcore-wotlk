
-- Stormforged War Golem (29380), Fix Skinning
UPDATE creature_template SET skinloot=29380 WHERE entry=29380;
DELETE FROM skinning_loot_template WHERE entry=29380;
INSERT INTO skinning_loot_template VALUES (29380, 39681, 4, 1, 1, 2, 4);
INSERT INTO skinning_loot_template VALUES (29380, 39682, 0.5, 1, 1, 1, 1);
INSERT INTO skinning_loot_template VALUES (29380, 39690, 9, 1, 1, 1, 3);
INSERT INTO skinning_loot_template VALUES (29380, 41337, 44, 1, 1, 1, 3);
INSERT INTO skinning_loot_template VALUES (29380, 41338, 42, 1, 1, 1, 3);
INSERT INTO skinning_loot_template VALUES (29380, 49050, 0.5, 1, 1, 1, 1);
