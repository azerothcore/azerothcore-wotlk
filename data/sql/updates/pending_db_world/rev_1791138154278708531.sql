--
-- Random property group 462 (cloth chest/robe, item level 34-36) carries twelve
-- properties from earlier tiers on top of its own 24. They are the only rows in
-- the group below 1%, all on the same 0.74, and they push the group to 107.34,
-- which makes the rows past the 100 mark unreachable in GetItemEnchantMod().
DELETE FROM `item_enchantment_template` WHERE `entry` = 462 AND `ench` IN (5, 25, 26, 94, 112, 133, 152, 174, 175, 176, 177, 178);
