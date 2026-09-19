--
-- Ignis the Furnace Master: give the smaller raid the lower Brittle threshold
-- Intentional departure from client data, which pairs the two spells the other way around
-- Issue: azerothcore/azerothcore-wotlk#27640
DELETE FROM `spelldifficulty_dbc` WHERE `ID` = 361;
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`, `DifficultySpellID_3`, `DifficultySpellID_4`) VALUES
(361, 67114, 62382, 0, 0); -- 10m = 67114 (3000), 25m = 62382 (5000)
