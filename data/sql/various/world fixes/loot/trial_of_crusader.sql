-- EMBLEMS:

-- Icehowl + Onyxia, Jaraxxus, Twin Valkyr, Anub'arak
UPDATE creature_loot_template SET item=47241 where entry IN(34797, 35447, 35448, 35449, 10184, 36538, 34780, 35216, 35268, 35269, 34497, 35350, 35351, 35352, 34496, 35347, 35348, 35349, 34564, 34566, 35615, 35616) AND item IN(40752, 40753, 45624, 49426);

-- Faction Champions
UPDATE gameobject_loot_template SET item=47241 WHERE entry IN(27335,27498,27503,27356) AND item IN(40752,40753,45624,49426);

-- anub chest
UPDATE gameobject_loot_template SET item=47241 WHERE entry IN(195671,
195672,
195670,
195669,
195668,
195667,
195666,
195665
) AND item IN(40752,40753,45624,49426);

-- Anubarak loot (25 HC)
UPDATE creature_loot_template SET maxcount=4 WHERE entry=35616 AND item IN(1,2) AND mincountOrRef IN(-34338, -34345);


-- -- trophy of the crusade (47242)
-- DELETE FROM gameobject_loot_template WHERE entry IN(195667,195672,195668,195665,195666,195669,195670,195671) AND item=47242;
-- DELETE FROM reference_loot_template WHERE entry IN(1956670,1956720,1956680,1956650,1956660,1956690,1956700,1956710);
-- INSERT INTO gameobject_loot_template VALUES(195667, 47242, 100, 1, 1, -1956670, 2);
-- INSERT INTO gameobject_loot_template VALUES(195672, 47242, 100, 1, 1, -1956670, 2);
-- INSERT INTO gameobject_loot_template VALUES(195668, 47242, 100, 1, 1, -1956670, 2);
-- INSERT INTO gameobject_loot_template VALUES(195665, 47242, 100, 1, 1, -1956670, 4);
-- INSERT INTO gameobject_loot_template VALUES(195666, 47242, 100, 1, 1, -1956670, 4);
-- INSERT INTO gameobject_loot_template VALUES(195669, 47242, 100, 1, 1, -1956670, 4);
-- INSERT INTO gameobject_loot_template VALUES(195670, 47242, 100, 1, 1, -1956670, 4);
-- INSERT INTO gameobject_loot_template VALUES(195671, 47242, 100, 1, 1, -1956670, 2);

-- -- INSERT INTO gameobject_loot_template VALUES(195667, 47242, 100, 1, 1, -1956670, 2);
-- -- INSERT INTO gameobject_loot_template VALUES(195672, 47242, 100, 1, 1, -1956720, 2);
-- -- INSERT INTO gameobject_loot_template VALUES(195668, 47242, 100, 1, 1, -1956680, 2);
-- -- INSERT INTO gameobject_loot_template VALUES(195665, 47242, 100, 1, 1, -1956650, 4);
-- -- INSERT INTO gameobject_loot_template VALUES(195666, 47242, 100, 1, 1, -1956660, 4);
-- -- INSERT INTO gameobject_loot_template VALUES(195669, 47242, 100, 1, 1, -1956690, 4);
-- -- INSERT INTO gameobject_loot_template VALUES(195670, 47242, 100, 1, 1, -1956700, 4);
-- -- INSERT INTO gameobject_loot_template VALUES(195671, 47242, 100, 1, 1, -1956710, 2);
-- INSERT INTO reference_loot_template VALUES(1956670, 47242, 100, 1, 1, 1, 1);
