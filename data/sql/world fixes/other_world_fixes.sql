
-- ----------------------------------------------
-- MISC
-- ----------------------------------------------
-- Wrong Inn entry (Dun Morogh, Kharanos)
DELETE FROM areatrigger_tavern WHERE ID=710;

-- Fishing template, Missing zone (undercity)
REPLACE INTO skill_fishing_base_level VALUES (1497, -20);

-- Fishing template, Wintergrasp
REPLACE INTO skill_fishing_base_level VALUES (4197, 430);

-- [npc] Soridormi (19935) fix underground waypoints
UPDATE waypoint_data SET position_z=-210.28 WHERE id=234530 AND point=10;
UPDATE waypoint_data SET position_z=-209.50 WHERE id=234530 AND point=11;

-- An Unusual Patron (9457)
-- The Altar of Naias (26731)
-- fix summoning many npc's
DELETE FROM event_scripts where id=10554;
INSERT INTO event_scripts VALUES (10554, 0, 10, 17207, 3000000, 1, -12150.4, 918.29, 1.2, 0.44);



-- ----------------------------------------------
-- POOLS
-- ----------------------------------------------
-- Quest Pools, Oracle Soo-Nee
DELETE FROM pool_quest WHERE entry IN(12735, 12736, 12737, 12726);
INSERT INTO pool_quest VALUES(12735, 380, 'A Cleansing Song');
INSERT INTO pool_quest VALUES(12736, 380, 'Song of Reflection');
INSERT INTO pool_quest VALUES(12737, 380, 'Song of Fecundity');
INSERT INTO pool_quest VALUES(12726, 380, 'Song of Wind and Water');
DELETE FROM pool_template WHERE description='Oracle Soo-Nee dailies';
REPLACE INTO pool_template VALUES(380, 1, 'Oracle Soo-Nee dailies');

-- Quest Pools, Rejek
DELETE FROM pool_quest WHERE entry IN(12732, 12758, 12734, 12741);
INSERT INTO pool_quest VALUES(12732, 381, 'The Heartblood''s Strength');
INSERT INTO pool_quest VALUES(12758, 381, 'A Hero''s Headgear');
INSERT INTO pool_quest VALUES(12734, 381, 'Rejek: First Blood');
INSERT INTO pool_quest VALUES(12741, 381, 'Strength of the Tempest');
DELETE FROM pool_template WHERE description='Rejek dailies';
REPLACE INTO pool_template VALUES(381, 1, 'Rejek dailies');

-- Quest Pools, Oracle Soo-Dow
DELETE FROM pool_quest WHERE entry IN(12761, 12762, 12705);
INSERT INTO pool_quest VALUES(12761, 382, 'A Cleansing Song');
INSERT INTO pool_quest VALUES(12762, 382, 'Song of Reflection');
INSERT INTO pool_quest VALUES(12705, 382, 'Song of Fecundity');
DELETE FROM pool_template WHERE description='Oracle Soo-Dow dailies';
REPLACE INTO pool_template VALUES(382, 1, 'Oracle Soo-Dow dailies');

-- Quest Pools, Troll Patrol
DELETE FROM pool_quest WHERE entry IN(12501, 12563, 12587);
INSERT INTO pool_quest VALUES(12501, 386, 'Troll Patrol');
INSERT INTO pool_quest VALUES(12563, 386, 'Troll Patrol');
INSERT INTO pool_quest VALUES(12587, 386, 'Troll Patrol');
DELETE FROM pool_template WHERE description='Troll Patrol dailies';
REPLACE INTO pool_template VALUES(386, 1, 'Troll Patrol dailies');



-- Clouds
UPDATE pool_template SET max_limit=8 WHERE entry IN(4997, 4998, 4996, 4993, 4994, 4995);
