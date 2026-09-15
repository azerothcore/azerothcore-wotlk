--
-- Ignis the Furnace Master: swap which Brittle version Iron Constructs get per raid size

-- Intentional departure from client data, requested in issue #27640: the smaller raid should have
-- the lower damage requirement. Keep ID 361 so the client's entry is replaced instead of ending up
-- next to a competing one.
DELETE FROM `spelldifficulty_dbc` WHERE `ID` = 361;
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`, `DifficultySpellID_3`, `DifficultySpellID_4`) VALUES
(361, 67114, 62382, 0, 0); -- Brittle: 10m = 67114 (3000), 25m = 62382 (5000)
