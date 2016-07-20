-- Dire Maul
DELETE FROM pickpocketing_loot_template WHERE entry=11441; -- Generic Dire Maul loot
INSERT INTO pickpocketing_loot_template VALUES (11441, 5428, 20, 1, 0, 1, 1);
INSERT INTO pickpocketing_loot_template VALUES (11441, 16885, 50, 1, 0, 1, 1);
INSERT INTO pickpocketing_loot_template VALUES (11441, 8952, 15, 1, 0, 1, 1);
INSERT INTO pickpocketing_loot_template VALUES (11441, 8950, 15, 1, 0, 1, 1);
INSERT INTO pickpocketing_loot_template VALUES (11441, 3928, 5, 1, 0, 1, 1);
INSERT INTO pickpocketing_loot_template VALUES (11441, 7910, 2, 1, 0, 1, 1);
DELETE FROM pickpocketing_loot_template WHERE entry IN(11444, 11445, 11448, 11450);
UPDATE creature_template SET pickpocketloot=11441 WHERE entry IN(11441, 11444, 11445, 11448, 11450);

-- Blackrock Spire
DELETE FROM pickpocketing_loot_template WHERE entry=9818; -- Generic Blackrock Spire loot
INSERT INTO pickpocketing_loot_template VALUES (9818, 5428, 20, 1, 0, 1, 1);
INSERT INTO pickpocketing_loot_template VALUES (9818, 16885, 50, 1, 0, 1, 1);
INSERT INTO pickpocketing_loot_template VALUES (9818, 8952, 15, 1, 0, 1, 1);
INSERT INTO pickpocketing_loot_template VALUES (9818, 8950, 15, 1, 0, 1, 1);
INSERT INTO pickpocketing_loot_template VALUES (9818, 3928, 5, 1, 0, 1, 1);
INSERT INTO pickpocketing_loot_template VALUES (9818, 7910, 2, 1, 0, 1, 1);
DELETE FROM pickpocketing_loot_template WHERE entry IN(10316, 10319, 10762, 10742, 9819);
UPDATE creature_template SET pickpocketloot=9818 WHERE entry IN(10316, 10319, 10762, 10742, 9818, 9819);
