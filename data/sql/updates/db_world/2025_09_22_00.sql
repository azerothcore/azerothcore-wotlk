-- DB update 2025_09_20_06 -> 2025_09_22_00
-- Savage Gladiator's Bonegrinder, Decapitator, Greatsword, Pike (+156 Attack Power)
UPDATE `item_template` SET `stat_type4` = 38, `stat_value4` = 156 WHERE `entry` IN (42295, 42294, 42297, 42296);

-- Savage Gladiator's Left Render, Right Ripper, Shanker, Mutilator (+66 Attack Power)
UPDATE `item_template` SET `stat_type4` = 38, `stat_value4` = 66 WHERE `entry` IN (42219, 42218, 42216, 42215);

-- Savage Gladiator's Heavy Crossbow, Longbow, Rifle (+48 Attack Power)
UPDATE `item_template` SET `stat_type4` = 38, `stat_value4` = 48 WHERE `entry` IN (42446, 42445, 42447);

-- Savage Gladiator's Spellblade (+355 Spell Power)
UPDATE `item_template` SET `stat_type5` = 45, `stat_value5` = 355 WHERE `entry` = 42343;

-- Savage Gladiator's Gavel (+355 Spell Power, +14 mp5)
UPDATE `item_template` SET `stat_type4` = 45, `stat_value4` = 355, `stat_type5` = 43, `stat_value5` = 14 WHERE `entry` = 42344;

-- Savage Gladiator's Piercing Touch (+28 Spell Power, +20 Spell Pen, Fire damage)
UPDATE `item_template` SET `dmg_min1` = 318, `dmg_max1` = 591, `delay` = 1900, `stat_type4` = 45, `stat_value4` = 28, `stat_type5` = 47, `stat_value5` = 20, `dmg_type1` = 2 WHERE `entry` = 42517;

-- Savage Gladiator's Touch of Defeat (+28 Spell Power, Fire damage)
UPDATE `item_template` SET `dmg_min1` = 318, `dmg_max1` = 591, `delay` = 1900, `stat_type5` = 45, `stat_value5` = 28, `dmg_type1` = 2 WHERE `entry` = 42448;

-- Savage Gladiator's baton of light
UPDATE `item_template` SET `dmg_min1` = 318, `dmg_max1` = 591, `delay` = 1900, `dmg_type1` = 2 WHERE `entry` = 42511;

-- Savage Gladiator's Barrier (+50 Spell Power)
UPDATE `item_template` SET `stat_type5` = 45, `stat_value5` = 50 WHERE `entry` = 42557;

-- Savage Gladiator's Redoubt (+50 Spell Power, +15 mp5)
UPDATE `item_template` SET `stat_type4` = 45, `stat_value4` = 50, `stat_type5` = 43, `stat_value5` = 15 WHERE `entry` = 42568;

-- Savage Gladiator's Libram of Justice (Missing Spell ID 60648)
UPDATE `item_template` SET `spellid_1` = 60648, `spelltrigger_1` = 1 WHERE `entry` = 42612;

-- Savage Gladiator's Sigil of Strife (Missing Spell ID 60675)
UPDATE `item_template` SET `spellid_1` = 60675, `spelltrigger_1` = 1 WHERE `entry` = 42618;

-- Hateful Gladiator's Baton of Light, Piercing Touch, Touch of Defeat (350–651 Fire damage, 1.90 speed, Fire school)
UPDATE `item_template` SET `dmg_min1` = 350, `dmg_max1` = 651, `delay` = 1900, `dmg_type1` = 2 WHERE `entry` IN (42512, 42518, 42501);

-- Hateful Gladiator's Redoubt (+18 mp5)
UPDATE `item_template` SET `stat_type5` = 43, `stat_value5` = 18 WHERE `entry` = 42569;
