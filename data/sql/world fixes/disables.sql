
DELETE FROM disables WHERE sourceType=0 AND entry=56863; -- spell Become Stormhoof
UPDATE event_scripts SET datalong2=900000 WHERE id=13256 AND command=10;

-- Disable GO LOS
-- Gameobject Cage (188678), needed for Blighted Last Rites (12206)
REPLACE INTO disables VALUES(7, 188678, 0, '', '', '');

-- Gameobject Keg (185206, 185213, 185214), needed for The Smallest Creatures (10720)
REPLACE INTO disables VALUES(7, 185206, 0, '', '', '');
REPLACE INTO disables VALUES(7, 185213, 0, '', '', '');
REPLACE INTO disables VALUES(7, 185214, 0, '', '', '');

-- Gameobject Brewfest Kegs (186183, 186184, 186185, 186186, 186187)
REPLACE INTO disables VALUES(7, 186183, 0, '', '', '');
REPLACE INTO disables VALUES(7, 186184, 0, '', '', '');
REPLACE INTO disables VALUES(7, 186185, 0, '', '', '');
REPLACE INTO disables VALUES(7, 186186, 0, '', '', '');
REPLACE INTO disables VALUES(7, 186187, 0, '', '', '');

-- Spell focus (185215, old 300118), needed for Teleport This! (10857)
DELETE FROM disables WHERE sourceType=7 AND entry=300118;
REPLACE INTO disables VALUES(7, 185215, 0, '', '', '');

-- Deprecated quests
REPLACE INTO disables VALUES(1, 10901, 0, '', '', "The Cudgel of Kar'desh, TBC");
DELETE FROM creature_queststarter WHERE quest=10901;
DELETE FROM creature_questender WHERE quest=10901;
REPLACE INTO disables VALUES(1, 10888, 0, '', '', "Trial of the Naaru: Magtheridon, TBC");
DELETE FROM creature_queststarter WHERE quest=10888; -- Trial of the Naaru: Magtheridon (tbc version)

-- Freeze fix? Traveler's Tundra Mammoth
DELETE FROM disables WHERE sourceType=0 AND entry IN(61425, 61447);
INSERT INTO disables VALUES(0, 61425, 6, '', '', 'Traveler\'s Tundra Mammoth');
INSERT INTO disables VALUES(0, 61447, 6, '', '', 'Traveler\'s Tundra Mammoth');
