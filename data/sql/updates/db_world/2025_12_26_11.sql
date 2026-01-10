-- DB update 2025_12_26_10 -> 2025_12_26_11
-- Delete item "Compendium of the Fallen" from the gameobject (book) "Rituals of Power",
DELETE FROM `gameobject_loot_template` WHERE `Entry` = 4584 AND `Item` = 5535;
