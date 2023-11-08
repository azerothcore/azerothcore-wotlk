-- assign correct spell to 'Unlit Torches' to remove AOE circle on item use
UPDATE `item_template` SET `spellid_1` = 46747 WHERE (`entry` = 34833);
