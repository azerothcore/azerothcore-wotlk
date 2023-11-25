-- DB update 2023_11_08_06 -> 2023_11_08_07
-- assign correct spell to 'Unlit Torches' to remove AOE circle on item use
UPDATE `item_template` SET `spellid_1` = 46747 WHERE (`entry` = 34833);
