
-- Stormwind Stockades
REPLACE INTO instance_encounters VALUES(540, 0, 1663, 0, 'Dextren Ward');
REPLACE INTO instance_encounters VALUES(539, 0, 1716, 12, 'Bazil Thredd');

-- Blackrock Depths enterance fix for LFG
REPLACE INTO lfg_entrances VALUES(30, 'Blackrock Depths - Prison', 458.32, 26.52, -70.67, 4.95);
REPLACE INTO lfg_entrances VALUES(276, 'Blackrock Depths - Upper City', 872.42, -232.77, -43.752, 0.54);

-- Gnomeregan enterance fix for LFG
REPLACE INTO lfg_entrances VALUES(14, 'Gnomeregan', -332.22, -2.28, -150.86, 2.77);

-- Uldaman enterance fix for LFG
REPLACE INTO lfg_entrances VALUES(22, 'Uldaman', -226.8, 49.09, -46.03, 1.39);

-- Caverns of Time: Escape from Durnholde
UPDATE access_requirement SET level_min=64 WHERE mapId=560 AND difficulty=0;

-- Botanica / Mechanar
UPDATE access_requirement SET level_min=67 WHERE mapId IN(553, 554) AND difficulty=0;

-- Lower Blackrock Spire enterance fix for LFG
REPLACE INTO lfg_entrances VALUES(32, 'Lower Blackrock Spire', 78.5083, -225.044, 49.839, 5.1);

-- Missing DF Special flags...
UPDATE quest_template SET SpecialFlags=SpecialFlags|0x8 WHERE Id IN(24789, 24791, 24923);
