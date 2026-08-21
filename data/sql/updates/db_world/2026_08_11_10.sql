-- DB update 2026_08_11_09 -> 2026_08_11_10
--
-- Spell focus radius is no longer halved by the core, so the inflated values that compensated for
-- that go back to their sniffed radius.
UPDATE `gameobject_template` SET `Data1` = 50 WHERE `entry` = 20919; -- Tuber Node
UPDATE `gameobject_template` SET `Data1` = 50 WHERE `entry` = 184643; -- Void Conduit Spell Focus
UPDATE `gameobject_template` SET `Data1` = 50 WHERE `entry` = 184750; -- Unguarded Summoning Site
UPDATE `gameobject_template` SET `Data1` = 5 WHERE `entry` = 185144; -- Bleeding Hollow Forge Spell Focus
UPDATE `gameobject_template` SET `Data1` = 50 WHERE `entry` = 190033; -- Alystros the Verdant Keeper Spell Focus
UPDATE `gameobject_template` SET `Data1` = 5 WHERE `entry` = 190224; -- Scourge Mummy Fire
UPDATE `gameobject_template` SET `Data1` = 10 WHERE `entry` = 190731; -- Scourgewagon
UPDATE `gameobject_template` SET `Data1` = 5 WHERE `entry` = 192011; -- Thane Ufrang the Mighty's Spell Focus
