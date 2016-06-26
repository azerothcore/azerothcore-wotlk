
-- Midsummer
DELETE FROM creature_queststarter WHERE quest IN(11970, 11971);
DELETE FROM game_event_creature_quest WHERE quest IN(11970, 11971);
-- Ally
INSERT INTO game_event_creature_quest VALUES(1, 18927, 11970);
INSERT INTO game_event_creature_quest VALUES(1, 19148, 11970);
INSERT INTO game_event_creature_quest VALUES(1, 19171, 11970);
INSERT INTO game_event_creature_quest VALUES(1, 19172, 11970);
INSERT INTO game_event_creature_quest VALUES(1, 19173, 11970);
-- Horde
INSERT INTO game_event_creature_quest VALUES(1, 19169, 11971);
INSERT INTO game_event_creature_quest VALUES(1, 19175, 11971);
INSERT INTO game_event_creature_quest VALUES(1, 19176, 11971);
INSERT INTO game_event_creature_quest VALUES(1, 19177, 11971);
INSERT INTO game_event_creature_quest VALUES(1, 19178, 11971);

-- Noblegarden
DELETE FROM creature_queststarter WHERE quest IN(13484, 13483);
DELETE FROM game_event_creature_quest WHERE quest IN(13484, 13483);
-- Ally
INSERT INTO game_event_creature_quest VALUES(9, 18927, 13484);
INSERT INTO game_event_creature_quest VALUES(9, 19148, 13484);
INSERT INTO game_event_creature_quest VALUES(9, 19171, 13484);
INSERT INTO game_event_creature_quest VALUES(9, 19172, 13484);
INSERT INTO game_event_creature_quest VALUES(9, 19173, 13484);
-- Horde
INSERT INTO game_event_creature_quest VALUES(9, 19169, 13483);
INSERT INTO game_event_creature_quest VALUES(9, 19175, 13483);
INSERT INTO game_event_creature_quest VALUES(9, 19176, 13483);
INSERT INTO game_event_creature_quest VALUES(9, 19177, 13483);
INSERT INTO game_event_creature_quest VALUES(9, 19178, 13483);

-- Hallow's End
DELETE FROM creature_queststarter WHERE quest IN(11356, 11357);
DELETE FROM game_event_creature_quest WHERE quest IN(11356, 11357);
-- Ally
INSERT INTO game_event_creature_quest VALUES(12, 18927, 11356);
INSERT INTO game_event_creature_quest VALUES(12, 19148, 11356);
INSERT INTO game_event_creature_quest VALUES(12, 19171, 11356);
INSERT INTO game_event_creature_quest VALUES(12, 19172, 11356);
INSERT INTO game_event_creature_quest VALUES(12, 19173, 11356);
-- Horde
INSERT INTO game_event_creature_quest VALUES(12, 19169, 11357);
INSERT INTO game_event_creature_quest VALUES(12, 19175, 11357);
INSERT INTO game_event_creature_quest VALUES(12, 19176, 11357);
INSERT INTO game_event_creature_quest VALUES(12, 19177, 11357);
INSERT INTO game_event_creature_quest VALUES(12, 19178, 11357);

-- Brewfest
DELETE FROM creature_queststarter WHERE quest IN(11441, 11446);
DELETE FROM game_event_creature_quest WHERE quest IN(11441, 11446);
-- Ally
INSERT INTO game_event_creature_quest VALUES(24, 18927, 11441);
INSERT INTO game_event_creature_quest VALUES(24, 19148, 11441);
INSERT INTO game_event_creature_quest VALUES(24, 19171, 11441);
INSERT INTO game_event_creature_quest VALUES(24, 19172, 11441);
INSERT INTO game_event_creature_quest VALUES(24, 19173, 11441);
-- Horde
INSERT INTO game_event_creature_quest VALUES(24, 19169, 11446);
INSERT INTO game_event_creature_quest VALUES(24, 19175, 11446);
INSERT INTO game_event_creature_quest VALUES(24, 19176, 11446);
INSERT INTO game_event_creature_quest VALUES(24, 19177, 11446);
INSERT INTO game_event_creature_quest VALUES(24, 19178, 11446);

-- Pilgrim's Bounty
DELETE FROM creature_queststarter WHERE quest IN(14022, 14036);
DELETE FROM game_event_creature_quest WHERE quest IN(14022, 14036);
-- Ally
INSERT INTO game_event_creature_quest VALUES(26, 18927, 14022);
INSERT INTO game_event_creature_quest VALUES(26, 19148, 14022);
INSERT INTO game_event_creature_quest VALUES(26, 19171, 14022);
INSERT INTO game_event_creature_quest VALUES(26, 19172, 14022);
INSERT INTO game_event_creature_quest VALUES(26, 19173, 14022);
-- Horde
INSERT INTO game_event_creature_quest VALUES(26, 19169, 14036);
INSERT INTO game_event_creature_quest VALUES(26, 19175, 14036);
INSERT INTO game_event_creature_quest VALUES(26, 19176, 14036);
INSERT INTO game_event_creature_quest VALUES(26, 19177, 14036);
INSERT INTO game_event_creature_quest VALUES(26, 19178, 14036);



