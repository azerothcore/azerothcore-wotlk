
-- Npcs missing skinloot
UPDATE creature_template SET skinloot=70205 WHERE entry IN(30277, 30278, 31104, 30276); -- ahn'kahet
UPDATE creature_template SET skinloot=70205 WHERE entry IN(31450, 31442, 31443, 31449); -- ahn'kahet heroic

UPDATE creature_template SET skinloot=70210 WHERE entry IN(27635, 27633, 27636); -- oculus
UPDATE creature_template SET skinloot=70210 WHERE entry IN(30901, 30904, 30902); -- oculus heroic


UPDATE creature_template SET skinloot=70212 WHERE entry IN(30762, 31678); -- uk heroic





-- Crystal Wyrm (31393)
UPDATE creature_template SET skinloot=70210 WHERE entry=31393;
