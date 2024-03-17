-- DB update 2022_08_27_06 -> 2022_08_27_07
--

DELETE FROM `creature_loot_template` WHERE `item` IN (19813,19814,19815,19816,19817,19818,19819,19820,19821);

UPDATE `creature_template` SET `lootid`=0 WHERE `entry` IN (
15146, -- Mad Voidwalker
15117, -- Chained Spirit
15112, -- Brain Wash Totem
15041, -- Spawn of Mar'li
14988, -- Ohgan
14987, -- Powerful Healing Ward
14986, -- Shade of Jin'do
14965, -- Frenzied Bloodseeker Bat
14826, -- Sacrificed Troll
14122, -- Massive Geyser
11347); -- Zealot Lor'Khan

