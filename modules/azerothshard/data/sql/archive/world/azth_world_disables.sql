# fix for TOC and mmaps
REPLACE INTO disables VALUES (7, 650, 0, '', '', 'Mmaps - Trial of the Champion');
REPLACE INTO disables VALUES (7, 649, 0, '', '', 'Mmaps - Trial of the Crusader');

-- disabled sota
-- DELETE FROM disables WHERE sourceType = 3 AND disables.entry = 9;
-- INSERT INTO disables (sourceType, entry, flags, params_0, params_1, comment) VALUES (3, 9, 0, '', '', 'Strand of the Ancients (SOTA) - Battleground');
